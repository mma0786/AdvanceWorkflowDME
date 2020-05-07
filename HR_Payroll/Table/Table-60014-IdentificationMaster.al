table 60014 "Identification Master"
{
    Caption = 'Identification Master';

    fields
    {
        field(1; "Document Type"; Option)
        {
            Caption = 'Type';
            OptionCaption = ' ,Employee,Dependent';
            OptionMembers = " ",Employee,Dependent;
        }
        field(2; "No."; Code[20])
        {
            Caption = 'No.';
            NotBlank = true;

            trigger OnValidate()
            begin

                if "No." <> xRec."No." then begin
                    HrSetup.GET;
                    "No. Series" := '';
                end;
            end;
        }
        field(3; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
            TableRelation = Employee;

            trigger OnValidate()
            begin
                INITINSERT;
                if EmployeeRec.GET("Employee No.") then
                    "Document Type" := "Document Type"::Employee;
            end;
        }
        field(4; "Identification Type"; Code[20])
        {
            Caption = 'Identification Type';
            TableRelation = "Identification Doc Type Master";

            trigger OnValidate()
            begin
                INITINSERT;
                RecIdentType.RESET;
                if RecIdentType.GET("Identification Type") then
                    VALIDATE(Description, RecIdentType.Description);
            end;
        }
        field(5; Description; Text[20])
        {
            Caption = 'Description';
        }
        field(6; "Identification No."; Text[20])
        {
            Caption = 'Identification No.';

            trigger OnValidate()
            begin
                /*IdentificationMasterRec2.RESET;
                IdentificationMasterRec2.SETRANGE("Identification No.",Rec."Identification No.");
                IF IdentificationMasterRec2.FINDFIRST THEN;
                  ERROR('Identification No. Cannot be used');*/

                "Identification No." := UPPERCASE("Identification No.");

            end;
        }
        field(7; "Issuing Country"; Code[100])
        {
            Caption = 'Issuing Country';
            TableRelation = "Country/Region";

            trigger OnValidate()
            begin
                if CountryRec.GET("Issuing Country") then
                    "Issuing Country" := CountryRec.Name;
            end;
        }
        field(8; "Issue Date"; Date)
        {
            Caption = 'Issue Date';

            trigger OnValidate()
            var
                HIJIRIDATETEXT: Text;
                IdentificationMasterREcL: Record "Identification Master";

            begin
                //<LT>
                if ("Expiry Date" < "Issue Date") and ("Expiry Date" <> 0D) then
                    ERROR('Expiry Date cannot be less than Issue date');
                //</LT>

                // Start 09.03.2020
                IdentificationMasterREcL.RESET;
                IdentificationMasterREcL.SETRANGE("Document Type", IdentificationMasterREcL."Document Type"::Employee);
                IdentificationMasterREcL.SETRANGE("Identification Type", "Identification Type");
                IdentificationMasterREcL.SETRANGE("Employee No.", "Employee No.");
                IF IdentificationMasterREcL.FINDSET THEN BEGIN
                    REPEAT
                        IF ("Issue Date" <= IdentificationMasterREcL."Expiry Date") AND ("Issue Date" >= IdentificationMasterREcL."Issue Date") THEN
                            ERROR('Issue Date overlaps with the existing record.');
                    UNTIL IdentificationMasterREcL.NEXT = 0;
                END;

                IdentificationMasterREcL.RESET;
                IdentificationMasterREcL.SETRANGE("Document Type", IdentificationMasterREcL."Document Type"::Dependent);
                IdentificationMasterREcL.SETRANGE("Identification Type", "Identification Type");
                IdentificationMasterREcL.SETRANGE("Dependent No", "Dependent No");
                IF IdentificationMasterREcL.FINDSET THEN BEGIN
                    REPEAT
                        IF ("Issue Date" <= IdentificationMasterREcL."Expiry Date") AND ("Issue Date" >= IdentificationMasterREcL."Issue Date") THEN
                            ERROR('Issue Date overlaps with the existing record.');
                    UNTIL IdentificationMasterREcL.NEXT = 0;
                END;
                // Stop 09.03.2020

            end;
        }
        field(9; "Expiry Date"; Date)
        {
            Caption = 'Expiry Date';

            trigger OnValidate()
            var
                IdentificationMasterREcL: Record "Identification Master";
            begin
                //<LT>
                if "Expiry Date" < "Issue Date" then
                    ERROR('Expiry Date cannot be less than Issue date');
                //</LT>
                // Start 09.03.2020
                IdentificationMasterREcL.RESET;
                IdentificationMasterREcL.SETRANGE("Document Type", IdentificationMasterREcL."Document Type"::Employee);
                IdentificationMasterREcL.SETRANGE("Identification Type", "Identification Type");
                IdentificationMasterREcL.SETRANGE("Employee No.", "Employee No.");
                IF IdentificationMasterREcL.FINDSET THEN BEGIN
                    REPEAT
                        IF ("Expiry Date" >= IdentificationMasterREcL."Expiry Date") AND ("Expiry Date" <= IdentificationMasterREcL."Issue Date") THEN
                            ERROR('Expiry Date overlaps with the existing record.');
                    UNTIL IdentificationMasterREcL.NEXT = 0;
                END;

                IdentificationMasterREcL.RESET;
                IdentificationMasterREcL.SETRANGE("Document Type", IdentificationMasterREcL."Document Type"::Dependent);
                IdentificationMasterREcL.SETRANGE("Identification Type", "Identification Type");
                IdentificationMasterREcL.SETRANGE("Dependent No", "Dependent No");
                IF IdentificationMasterREcL.FINDSET THEN BEGIN
                    REPEAT
                        IF ("Expiry Date" >= IdentificationMasterREcL."Expiry Date") AND ("Expiry Date" <= IdentificationMasterREcL."Issue Date") THEN
                            ERROR('Expiry Date overlaps with the existing record.');
                    UNTIL IdentificationMasterREcL.NEXT = 0;
                END;
                // Stop 09.03.2020

            end;
        }
        field(10; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            TableRelation = "No. Series";
        }
        field(11; "Dependent No"; Code[20])
        {
            TableRelation = "Employee Dependents Master";

            trigger OnValidate()
            begin


                if "Dependent No" <> '' then
                    "Document Type" := "Document Type"::Dependent
            end;
        }
        field(12; "ID Document Type"; Option)
        {
            Caption = 'Document Type';
            OptionCaption = ' ,Regular,Diplomatic,VIP';
            OptionMembers = "''",Regular,Diplomatic,VIP;
        }
        field(13; WarningMsg; Text[35])
        {
        }
        field(14; "Issuing Authority"; Code[20])
        {
            TableRelation = "Issuing Authority";

            trigger OnValidate()
            var
                RecIssuAuthority: Record "Issuing Authority";
            begin
                RecIssuAuthority.SetRange(Code, "Issuing Authority");
                IF RecIssuAuthority.FINDFIRST THEN
                    "Issuing Authority Description" := RecIssuAuthority.Description;
            end;
        }
        field(15; "Issue Date (Hijiri)"; Text[30])
        {
            Editable = false;
        }
        field(16; "Expiry Date (Hijiri)"; Text[30])
        {
            Editable = false;
        }
        field(17; "Created From Doc. No."; Code[80])
        {
            Editable = false;
        }
        field(18; "Visa Type"; Option)
        {
            Description = 'PHASE - 2';
            OptionCaption = ' ,Work Visa,Family Visa,Hajj Visa,Visit Visa,Exit-Reentry Visa,Mission Visa';
            OptionMembers = " ","Work Visa","Family Visa","Hajj Visa","Visit Visa","Exit-Reentry Visa","Mission Visa";
        }
        field(19; "Active Document"; Boolean)
        {
            Description = 'PHASE - 2';
            Editable = true;

            trigger OnValidate()
            var
                UserSetupRecL: Record "User Setup";
                IdentificationMasterRecL: Record "Identification Master";
            begin
                //##################################
                IF "Document Type" = "Document Type"::Dependent THEN BEGIN
                    UserSetupRecL.RESET;
                    IF UserSetupRecL.GET(USERID) THEN BEGIN
                        IF "Active Document" THEN BEGIN
                            IdentificationMasterRecL.RESET;
                            IdentificationMasterRecL.SETRANGE("Dependent No", "Dependent No");
                            IdentificationMasterRecL.SETRANGE("Identification Type", "Identification Type");
                            IdentificationMasterRecL.SETRANGE("Active Document", TRUE);
                            IF IdentificationMasterRecL.FINDSET THEN BEGIN
                                IdentificationMasterRecL.MODIFYALL("Active Document", FALSE);
                            END;
                        END
                    END;
                END;

                IF "Document Type" = "Document Type"::Employee THEN BEGIN
                    UserSetupRecL.RESET;
                    IF UserSetupRecL.GET(USERID) THEN BEGIN
                        IF "Active Document" THEN BEGIN
                            IdentificationMasterRecL.RESET;
                            IdentificationMasterRecL.SETRANGE("Employee No.", "Employee No.");
                            IdentificationMasterRecL.SETRANGE("Identification Type", "Identification Type");
                            IdentificationMasterRecL.SETRANGE("Active Document", TRUE);
                            IF IdentificationMasterRecL.FINDSET THEN BEGIN
                                IdentificationMasterRecL.MODIFYALL("Active Document", FALSE);
                            END;
                        END;
                    END;
                END;

                IF "Active Document" THEN
                    MESSAGE(' %1 Document Activated Successfully.', "Identification Type");
                //##################################
            end;
        }

        //
        field(20; "Issuing Authority Description"; Text[150])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Issuing Authority";
            ValidateTableRelation = false;
            trigger OnValidate()
            var
                RecIssuAuthority: Record "Issuing Authority";
            begin
                Clear(RecIssuAuthority);
                RecIssuAuthority.SETFILTER(Code, "Issuing Authority Description");
                RecIssuAuthority.FINDFIRST;
                "Issuing Authority" := RecIssuAuthority.Code;
                "Issuing Authority Description" := RecIssuAuthority.Description;
            end;
        }
    }

    keys
    {
        key(Key1; "No.", "Employee No.", "Dependent No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        INITINSERT;
    end;

    var
        RecIdentType: Record "Identification Doc Type Master";
        HrSetup: Record "Human Resources Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        IdentificationMasterRec2: Record "Identification Master";
        EmployeeRec: Record Employee;
        IdNo: Code[20];
        CountryRec: Record "Country/Region";
        Error001: Label 'Please select the Identifiction Type.';
    // Commented By Avinash  [RunOnClient]
    // Commented By Avinash  Hijiri_Date_Converter_Dll_G: DotNet Class1;


    procedure INITINSERT()
    begin
        HrSetup.RESET();
        HrSetup.GET();
        if "No." = '' then
            "No." := NoSeriesMgt.GetNextNo(HrSetup."Employee Identification Nos.", Today, true);
        // NoSeriesMgt.InitSeries(HrSetup."Employee Identification Nos.", xRec."No. Series", TODAY, "No.", "No. Series");
    end;
}

