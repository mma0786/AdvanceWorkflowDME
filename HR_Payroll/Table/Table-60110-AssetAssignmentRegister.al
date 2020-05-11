table 60110 "Asset Assignment Register"
{
    Caption = 'Asset Assignment Register';
    //DataPerCompany = true;
    LookupPageID = "Asset Assignment Register_List";

    fields
    {
        field(1; "Transaction Type"; Option)
        {
            Caption = 'Transaction Type';
            OptionCaption = 'Issue,Return';
            OptionMembers = Issue,Return;

            trigger OnValidate()
            begin
                if ("Transaction Type" <> "Transaction Type"::Issue) then
                    "Issue Document No." := '';

                IF "Transaction Type" = "Transaction Type"::Return THEN
                    Status := Status::Returned
                ELSE
                    Status := Status::Issued;

            end;
        }
        field(2; "Document Date"; Date)
        {
            Caption = 'Document Date';

            trigger OnValidate()
            begin
                if ("Issue Date" <> 0D) and ("Transaction Type" = "Transaction Type"::Issue) then begin
                    if "Issue Date" < "Document Date" then
                        ERROR('Document date should not be greater than Issue Date');
                end;
            end;
        }
        field(3; "Issue Date"; Date)
        {
            Caption = 'Issue Date';

            trigger OnValidate()
            begin
                AllowEditDelet;
                RecID := RECORDID;//
                if "Issued Till" <> 0D then begin
                    if ("Issue Date" > "Issued Till") then
                        ERROR('Issued till date cannot be before date of Issue Date');
                end;

                if "Issue Date" <> 0D then begin
                    if "Issue Date" < "Document Date" then
                        ERROR('Issue Date cannot be before Document Date');
                end;
            end;
        }
        field(4; "Posting Date"; Date)
        {
            Caption = 'Posting Date';

            trigger OnValidate()
            begin
                AllowEditDelet;
            end;
        }
        field(5; "Issue Document No."; Code[20])
        {
            Caption = 'Issue Document No.';

            trigger OnValidate()
            begin
                AllowEditDelet;
                if "Transaction Type" = "Transaction Type"::Issue then begin
                    if "Issue Document No." <> xRec."Issue Document No." then begin
                        FA_SetupRec.GET;
                        "No. Series Issue" := '';
                    end;
                end;
            end;
        }
        field(6; "Posted Issue Document No"; Code[20])
        {
            Caption = 'Posted Issue Document No';
            TableRelation = "No. Series";
        }
        field(7; "FA No"; Code[20])
        {
            Caption = 'FA No';
            //The property 'ValidateTableRelation' can only be set if the property 'TableRelation' is set
            //ValidateTableRelation = false;

            trigger OnValidate()
            begin
                AllowEditDelet;

                if FixedAssetRec.GET("FA No") then begin
                    "FA Description" := FixedAssetRec.Description;
                    FixedAssetRec.TESTFIELD("Responsible Employee");
                    "Asset Owner" := FixedAssetRec."Responsible Employee";
                    EmployeeRec.RESET;
                    if EmployeeRec.GET("Asset Owner") then
                        "Asset Owner Name" := EmployeeRec.FullName;
                end;


                if CompInfo.GET then
                    "Company Name" := CompInfo.Name;
                if "FA No" = '' then begin
                    CLEAR("FA Description");
                    CLEAR("Asset Owner");
                    CLEAR("Company Name");
                end;
            end;
        }
        field(8; "Return Date"; Date)
        {

            trigger OnValidate()
            begin
                if "Issued Till" <> 0D then begin
                    if ("Issue Date" < "Return Date") then
                        ERROR('Return date cannot be before date of Issue Date');
                end;
                if ("Issue Date" > "Return Date") then
                    ERROR('Return date cannot be before date of Issue Date');

                if "Transaction Type" = "Transaction Type"::Return then
                    if "Return Date" < "Return Document Date" then
                        ERROR('Return date should not be less than Document date')
            end;
        }
        field(9; "Asset Custody Type"; Option)
        {
            Caption = 'Asset Custody Type';
            OptionCaption = 'Department,Employee';
            OptionMembers = Department,Employee;

            trigger OnValidate()
            begin
                AllowEditDelet;
                if xRec."Asset Custody Type" <> "Asset Custody Type" then begin
                    "Issue to/Return by" := '';
                    Name := '';
                end;
            end;
        }
        field(10; "Issue to/Return by"; Code[20])
        {
            Caption = 'Issue to/Return by';
            Description = 'Department to be added';
            TableRelation = IF ("Asset Custody Type" = FILTER(Employee)) Employee."No." WHERE(Status = FILTER(Active))
            ELSE
            "Payroll Department"."Department ID";

            trigger OnValidate()
            begin
                AllowEditDelet;
                if EmployeeRec.GET("Issue to/Return by") then
                    Name := EmployeeRec.FullName;

                if DepartmentRec.GET("Issue to/Return by") then
                    Name := DepartmentRec.Description;

                if "Issue to/Return by" = '' then
                    CLEAR(Name);
            end;
        }
        field(11; Name; Text[50])
        {
            Caption = 'Name';
            Description = 'Department to be added';
        }
        field(12; "Issued Till"; Date)
        {
            Caption = 'Issued Till';

            trigger OnValidate()
            begin
                AllowEditDelet;
                if ("Issue Date" <> 0D) and ("Issued Till" < "Issue Date") then
                    ERROR('Issued till date cannot be before date of Issue Date');
            end;
        }
        field(13; "Asset Owner"; Code[20])
        {
            Caption = 'ID';
            TableRelation = "Fixed Asset"."Responsible Employee" WHERE("No." = FIELD("FA No"));
        }
        field(14; "Company Name"; Code[50])
        {
            Caption = 'Company Name';
            //The property 'ValidateTableRelation' can only be set if the property 'TableRelation' is set
            //ValidateTableRelation = false;
        }
        field(15; "Return Document No."; Code[20])
        {
            Caption = 'Return Document No.';

            trigger OnValidate()
            begin
                AllowEditDelet;

                if "Transaction Type" = "Transaction Type"::Return then begin
                    if "Return Document No." <> xRec."Return Document No." then begin
                        FA_SetupRec.GET;
                        "No. Series Issue" := '';
                    end;
                end
            end;
        }
        field(16; "Asset Owner Employee"; Code[20])
        {
            Caption = 'Asset Owner on Return';
        }
        field(17; "Posted Return Document No"; Code[20])
        {
            Caption = 'Posted Return Document No';
        }
        field(18; "Return Document Date"; Date)
        {
            Caption = 'Return Document Date';

            trigger OnValidate()
            begin
                /*IF "Transaction Type" = "Transaction Type"::Return THEN BEGIN
                  IF "Posted Issue Document No" <> xRec."Posted Issue Document No" THEN BEGIN
                    FA_SetupRec.GET;
                    "Posted Issue Document No" := '';
                  END;
                END;*/
                if "Transaction Type" = "Transaction Type"::Return then begin
                    if "Return Date" < "Return Document Date" then
                        ERROR('Document date should not be greater than Return Date');
                end;

            end;
        }
        field(20; Status; Option)
        {
            Caption = 'Status';
            OptionCaption = ''''',Issued,Returned';
            OptionMembers = "''",Issued,Returned;
        }
        field(21; "No. Series Issue"; Code[20])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(22; "FA Description"; Text[50])
        {
        }
        field(24; "WorkFlow Status"; Option)
        {
            Caption = 'WorkFlow Status';
            Editable = true;
            // OptionCaption = 'Open,Approved,Send for Approval,Rejected';
            // OptionMembers = Open,Released,"Pending Approval",Rejected;
            OptionCaption = 'Open,Pending For Approval,Released,Rejected';
            OptionMembers = Open,"Pending For Approval",Released,Rejected;
        }
        field(25; Posted; Boolean)
        {
            Editable = false;
        }
        field(26; RecID; RecordID)
        {
        }
        field(27; "Issue Document Reference"; Code[20])
        {
            TableRelation = "Asset Assignment Register"."Issue Document No." WHERE("Issue to/Return by" = FIELD("Issue to/Return by"),
                                                                                    "Transaction Type" = FILTER(Issue),
                                                                                    Posted = FILTER(true),
                                                                                    "Return posted" = FILTER(false),
                                                                                    Status = FILTER(Issued));

            trigger OnValidate()
            begin
                AssetAssRegRec.RESET;
                AssetAssRegRec.SETRANGE("Issue Document Reference", "Issue Document Reference");
                if AssetAssRegRec.FINDFIRST then begin
                    if AssetAssRegRec."WorkFlow Status" <> AssetAssRegRec."WorkFlow Status"::Open then
                        ERROR('Asset Return Request is Process %1', AssetAssRegRec."Return Document No.");
                end;
            end;
        }
        field(28; "Asset Owner Name"; Text[35])
        {
            Caption = 'Asset Owner';
        }
        field(29; "Return posted"; Boolean)
        {
        }
        field(30; "Sub Department"; Code[20])
        {
            Caption = 'Sub Department';
            TableRelation = "Sub Department"."Sub Department ID" WHERE("Department ID" = FIELD("Issue to/Return by"));

            trigger OnValidate()
            begin
                SubDepRec.RESET;
                SubDepRec.SETRANGE("Department ID", "Issue to/Return by");
                SubDepRec.SETRANGE("Sub Department ID", "Sub Department");
                if SubDepRec.FINDFIRST then
                    "Sub Department Name" := SubDepRec.Description;
            end;
        }
        field(31; "Sub Department Name"; Text[35])
        {
            Caption = 'Sub Department Name';
            Enabled = false;
        }
    }

    keys
    {
        key(Key1; "Issue Document No.", "Posted Issue Document No", "Return Document No.", "Posted Return Document No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        TESTFIELD("WorkFlow Status", "WorkFlow Status"::Open);
    end;

    trigger OnInsert()
    begin
        INITINSERT();
        RecID := RECORDID;

        //Status := Status::'';
    end;

    trigger OnModify()
    begin
        INITINSERT();
    end;

    var
        NoSeriesMgt: Codeunit NoSeriesManagement;
        HasInvtSetup: Boolean;
        FA_SetupRec: Record "FA Setup";
        SelectNoSeriesAllowed: Boolean;
        EmployeeRec: Record Employee;
        FixedAssetRec: Record "Fixed Asset";
        AssetAssRegRec: Record "Asset Assignment Register";
        FA_Setup: Record "FA Setup";
        CompInfo: Record "Company Information";
        DepartmentRec: Record "Payroll Department";
        SubDepRec: Record "Sub Department";

    local procedure INITINSERT()
    begin
        if "Transaction Type" = "Transaction Type"::Issue then begin
            FA_SetupRec.RESET();
            FA_SetupRec.GET();
            if "Issue Document No." = '' then begin
                NoSeriesMgt.InitSeries(FA_SetupRec."Issue Document No.", xRec."Issue Document No.", TODAY(), "Issue Document No.", FA_SetupRec."Issue Document No.")
            end;
        end;

        if "Transaction Type" = "Transaction Type"::Return then begin
            FA_SetupRec.RESET();
            FA_SetupRec.GET();
            if "Return Document No." = '' then begin
                NoSeriesMgt.InitSeries(FA_SetupRec."Return Document No.", xRec."Return Document No.", TODAY(), "Return Document No.", FA_SetupRec."Return Document No.")
            end;
        end;
    end;

    local procedure INITINSERT2()
    begin
    end;

    // [Scope('Internal')]
    procedure AssistEdit(OldAAR: Record "Asset Assignment Register"): Boolean
    var
        Cust: Record Customer;
    begin
        if "Transaction Type" = "Transaction Type"::Issue then begin
            with AssetAssRegRec do begin
                AssetAssRegRec := Rec;
                FA_Setup.GET;
                FA_Setup.TESTFIELD("Issue Document No.");
                if NoSeriesMgt.SelectSeries(FA_Setup."Issue Document No.", OldAAR."No. Series Issue", "No. Series Issue") then begin
                    NoSeriesMgt.SetSeries("Issue Document No.");
                    Rec := AssetAssRegRec;
                    exit(true);
                end;
            end;
        end;

        if "Transaction Type" = "Transaction Type"::Return then begin
            with AssetAssRegRec do begin
                AssetAssRegRec := Rec;
                FA_Setup.GET;
                FA_Setup.TESTFIELD("Return Document No.");
                if NoSeriesMgt.SelectSeries(FA_Setup."Return Document No.", OldAAR."No. Series Issue", "No. Series Issue") then begin
                    NoSeriesMgt.SetSeries("Return Document No.");
                    Rec := AssetAssRegRec;
                    exit(true);
                end;
            end;
        end;
    end;

    //[Scope('Internal')]
    procedure AllowEditDelet()
    var
        Rec1: Record "Asset Assignment Register";
    begin
        if "WorkFlow Status" <> Rec1."WorkFlow Status"::Open then
            ERROR('Status should be open');
    end;
}

