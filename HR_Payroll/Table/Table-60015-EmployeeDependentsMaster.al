table 60015 "Employee Dependents Master"
{
    // P_2 - Added Field Full Name

    Caption = 'Employee Dependents Master';
    LookupPageID = "Employee Dependent List MS1";

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';

            trigger OnValidate()
            begin
                OnEdit;
                if "No." <> xRec."No." then begin
                    HrSetup.GET;
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "Employee ID"; Code[20])
        {
            Caption = 'Employee ID';
            TableRelation = Employee;

            trigger OnValidate()
            begin
                OnEdit;
                if EmployeeRec.GET("Employee ID") then
                    "Employee Name" := EmployeeRec.FullName;
            end;
        }
        field(3; "Employee Name"; Text[50])
        {
            Caption = 'Employee Name';

            trigger OnValidate()
            begin
                OnEdit;
                CreateModifiedData(CurrFieldNo, Rec."Employee Name", xRec."Employee Name");
            end;
        }
        field(4; "Dependent First Name"; Text[50])
        {
            Caption = 'Dependent First Name';

            trigger OnValidate()
            begin
                OnEdit;
                CreateModifiedData(CurrFieldNo, Rec."Dependent First Name", xRec."Dependent First Name");
                ValidateFullName;
            end;
        }
        field(5; "Dependent Middle Name"; Text[50])
        {
            Caption = 'Dependent Middle Name';

            trigger OnValidate()
            begin
                OnEdit;
                CreateModifiedData(CurrFieldNo, Rec."Dependent Middle Name", xRec."Dependent Middle Name");
                ValidateFullName;
            end;
        }
        field(6; "Dependent Last Name"; Text[50])
        {
            Caption = 'Dependent Last Name';

            trigger OnValidate()
            begin
                OnEdit;
                CreateModifiedData(CurrFieldNo, Rec."Dependent Last Name", xRec."Dependent Last Name");
                ValidateFullName;
            end;
        }
        field(7; "Dependent Name in Arabic"; Text[50])
        {
            Caption = 'Dependent Name in Arabic';

            trigger OnValidate()
            begin
                OnEdit;
                CreateModifiedData(CurrFieldNo, Rec."Dependent Name in Arabic", xRec."Dependent Name in Arabic");
            end;
        }
        field(8; "Name in Passport in English"; Text[250])
        {
            Caption = 'Name in Passport in English';

            trigger OnValidate()
            begin
                OnEdit;
                CreateModifiedData(CurrFieldNo, Rec."Name in Passport in English", xRec."Name in Passport in English");
            end;
        }
        field(9; Relationship; Option)
        {
            Caption = 'Relationship';
            OptionCaption = ' ,Child,Domestic Partner,Spouse,Ex-Spouse,Family Contact,Other Contact,Parent,Sibling';
            OptionMembers = " ",Child,"Domestic Partner",Spouse,"Ex-Spouse","Family Contact","Other Contact",Parent,Sibling;

            trigger OnValidate()
            var
                AdvancePayrollSetup: Record "Advance Payroll Setup";
            begin
                OnEdit;
                CreateModifiedData(CurrFieldNo, FORMAT(Rec.Relationship), FORMAT(xRec.Relationship));

                if Relationship = Relationship::Spouse then begin
                    AdvancePayrollSetup.GET;
                    AdvancePayrollSetup.TESTFIELD("Default Marital Status Spouse");
                    "Marital Status" := AdvancePayrollSetup."Default Marital Status Spouse";

                end
                else
                    "Marital Status" := '';
            end;
        }
        field(10; Gender; Option)
        {
            Caption = 'Gender';
            OptionCaption = ' ,Male,Female';
            OptionMembers = " ",Male,Female;

            trigger OnValidate()
            begin
                OnEdit;
                CreateModifiedData(CurrFieldNo, FORMAT(Rec.Gender), FORMAT(xRec.Gender));
            end;
        }
        field(11; Nationality; Code[20])
        {
            Caption = 'Nationality';
            TableRelation = "Country/Region";

            trigger OnValidate()
            begin
                OnEdit;

                if CountryRec.GET(Nationality) then
                    Nationality := CountryRec.Name;

                CreateModifiedData(CurrFieldNo, FORMAT(Rec.Nationality), FORMAT(xRec.Nationality));
            end;
        }
        field(12; "Date of Birth"; Date)
        {
            Caption = 'Date of Birth';

            trigger OnValidate()
            begin
                OnEdit;

                if "Date of Birth" > TODAY then
                    ERROR('Date of Birth should be before Today ');
                CreateModifiedData(CurrFieldNo, FORMAT(Rec."Date of Birth"), FORMAT(xRec."Date of Birth"));
            end;
        }
        field(13; "Marital Status"; Text[30])
        {
            Caption = 'Marital Status';
            TableRelation = "Marital Status";

            trigger OnValidate()
            begin
                OnEdit;
                CreateModifiedData(CurrFieldNo, FORMAT(Rec."Marital Status"), FORMAT(xRec."Marital Status"));
            end;
        }
        field(14; "Child with Special needs"; Boolean)
        {
            Caption = 'Child with Special needs';

            trigger OnValidate()
            begin
                OnEdit;
                CreateModifiedData(CurrFieldNo, FORMAT(Rec."Child with Special needs"), FORMAT(xRec."Child with Special needs"));
            end;
        }
        field(15; "Child Educational Level"; Option)
        {
            Caption = 'Child Educational Level';
            OptionCaption = ' ,Elementary,Secondary,University';
            OptionMembers = " ",Elementary,Secondary,University;

            trigger OnValidate()
            begin
                OnEdit;
                CreateModifiedData(CurrFieldNo, FORMAT(Rec."Child Educational Level"), FORMAT(xRec."Child Educational Level"));
            end;
        }
        field(16; "Is Emergency Contact"; Boolean)
        {
            Caption = 'Is Emergency Contact';

            trigger OnValidate()
            begin
                OnEdit;
                CreateModifiedData(CurrFieldNo, FORMAT(Rec."Is Emergency Contact"), FORMAT(xRec."Is Emergency Contact"));
            end;
        }
        field(17; "Full Time Student"; Boolean)
        {
            Caption = 'Full Time Student';

            trigger OnValidate()
            begin
                OnEdit;
                CreateModifiedData(CurrFieldNo, FORMAT(Rec."Full Time Student"), FORMAT(xRec."Full Time Student"));
            end;
        }
        field(18; "Workflow Status"; Option)
        {
            Caption = 'Workflow Status';
            OptionCaption = 'Open,Send for Approval,Approved';
            OptionMembers = Open,"Pending Approval",Released;

            trigger OnValidate()
            begin
                // // // // if "Workflow Status" = "Workflow Status"::Released then begin
                // // // //     ModifiedListRec.RESET;
                // // // //     ModifiedListRec.SETRANGE("Document No", Rec."No.");
                // // // //     ModifiedListRec.SETRANGE("Table No.", 50004);
                // // // //     IF ModifiedListRec.FINDSET THEN BEGIN
                // // // //         REPEAT
                // // // //             ModifiedListRec.DELETE;
                // // // //         UNTIL ModifiedListRec.NEXT = 0;
                // // // //         "Workflow Status" := "Workflow Status"::Open;
                // // // //     END;
                // // // // end; /*ELSE IF "Workflow Status" = "Workflow Status"::Open THEN BEGIN
                // // // //   ModifiedListRec.RESET;
                // // // //   ModifiedListRec.SETRANGE("Document No",Rec."No.");
                // // // //   ModifiedListRec.SETRANGE("Table No.",50004);
                // // // //   IF ModifiedListRec.FINDSET  THEN*/
                // // // // if "Workflow Status" = "Workflow Status"::Released then
                // // // //     Status := Status::Active
                // // // // else
                // // // //     Status := Status::Inactive;

            end;
        }
        field(19; "Dependent Contact No."; Integer)
        {
            Caption = 'Dependent Contact No.';

            trigger OnValidate()
            begin
                OnEdit;
                CreateModifiedData(CurrFieldNo, FORMAT(Rec."Dependent Contact No."), FORMAT(xRec."Dependent Contact No."));
            end;
        }
        field(20; "Dependent Contact Type"; Option)
        {
            Caption = 'Dependent Contact Type';
            OptionCaption = ' ,Mobile,Mobile & E-Mail';
            OptionMembers = " ",Mobile,"Mobile & E-Mail";

            trigger OnValidate()
            begin
                OnEdit;
                CreateModifiedData(CurrFieldNo, FORMAT(Rec."Dependent Contact Type"), FORMAT(xRec."Dependent Contact Type"));
            end;
        }
        field(21; "Primary Contact"; Boolean)
        {
            Caption = 'Primary Contact';

            trigger OnValidate()
            begin
                OnEdit;
                CreateModifiedData(CurrFieldNo, FORMAT(Rec."Primary Contact"), FORMAT(xRec."Primary Contact"));
            end;
        }
        field(22; Address; Text[250])
        {
            Caption = 'Address';

            trigger OnValidate()
            begin
                OnEdit;
                CreateModifiedData(CurrFieldNo, Rec.Address, xRec.Address);
            end;
        }
        field(23; "Address 2"; Text[250])
        {
            Caption = 'Address 2';

            trigger OnValidate()
            begin
                OnEdit;
                CreateModifiedData(CurrFieldNo, Rec."Address 2", xRec."Address 2");
            end;
        }
        field(24; PostCode; Code[20])
        {
            Caption = 'PostCode';
            TableRelation = "Post Code";

            trigger OnValidate()
            begin
                OnEdit;

                PostCodeRec.SETRANGE(Code, PostCode);
                if PostCodeRec.FINDFIRST then begin
                    City := PostCodeRec.City;
                    if CountryRec.GET(PostCodeRec."Country/Region Code") then
                        "Country Region code" := CountryRec.Name;
                end;

                if PostCode = '' then begin
                    CLEAR(City);
                    CLEAR("Country Region code");
                end;
                CreateModifiedData(CurrFieldNo, Rec.PostCode, xRec.PostCode);
            end;
        }
        field(25; City; Text[30])
        {
            Caption = 'City';

            trigger OnValidate()
            begin
                OnEdit;

                if City = '' then
                    CLEAR(PostCode);
                CreateModifiedData(CurrFieldNo, Rec.City, xRec.City);
            end;
        }
        field(26; "Country Region code"; Code[20])
        {
            Caption = 'Country Region code';

            trigger OnValidate()
            begin
                OnEdit;
                CreateModifiedData(CurrFieldNo, Rec."Country Region code", xRec."Country Region code");
            end;
        }
        field(27; "Private Phone Number"; Integer)
        {
            Caption = 'Private Phone Number';

            trigger OnValidate()
            begin
                OnEdit;
                CreateModifiedData(CurrFieldNo, FORMAT(Rec."Private Phone Number"), FORMAT(xRec."Private Phone Number"));
            end;
        }
        field(28; "Direct Phone Number"; Integer)
        {
            Caption = 'Direct Phone Number';

            trigger OnValidate()
            begin
                OnEdit;
                CreateModifiedData(CurrFieldNo, FORMAT(Rec."Direct Phone Number"), FORMAT(xRec."Direct Phone Number"));
            end;
        }
        field(29; "Private Email"; Text[30])
        {
            Caption = 'Private Email';

            trigger OnValidate()
            begin
                OnEdit;
                CreateModifiedData(CurrFieldNo, Rec."Private Email", xRec."Private Email");
            end;
        }
        field(30; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            TableRelation = "No. Series";

            trigger OnValidate()
            begin
                OnEdit;
            end;
        }
        field(31; "Personal Title"; Option)
        {
            Caption = 'Personal Title';
            OptionCaption = 'Mr.,Ms.,Mrs.,Miss.';
            OptionMembers = Mr,Ms,Mrs,Miss;
        }
        field(32; Status; Option)
        {
            OptionCaption = 'Inactive,Active';
            OptionMembers = Inactive,Active;

            trigger OnValidate()
            begin
                OnEdit;
                CreateModifiedData(CurrFieldNo, FORMAT(Rec.Status), FORMAT(xRec.Status));
            end;
        }
        field(33; "Full Name"; Text[250])
        {
            Description = 'P_2';
        }
        field(34; "Religion"; Code[20])
        {
            TableRelation = "Payroll Religion";
            trigger OnValidate()
            var
                ReliginRec: Record "Payroll Religion";
            begin
                if (Religion = '') and (xRec.Religion <> Rec.Religion) then
                    Clear("Religion Desciption");

                ReliginRec.Reset();
                if ReliginRec.Get(Religion) then
                    "Religion Desciption" := ReliginRec.Description;

            end;
        }
        field(35; "Religion Desciption"; Text[120])
        {
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "No.", "Employee ID")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "No.", "Dependent First Name", "Dependent Last Name")
        {
        }
    }

    trigger OnDelete()
    begin
        OnEdit;

        EduClimbeRec.RESET;
        EduClimbeRec.SETRANGE("Dependent ID", Rec."No.");
        if EduClimbeRec.FINDFIRST then
            ERROR(Error001);
    end;

    trigger OnInsert()
    begin
        INITINSERT();
        ValidateFullName;
    end;

    trigger OnRename()
    begin
        OnEdit;
    end;

    var
        HrSetup: Record "Human Resources Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        EmployeeRec: Record Employee;
        PostCodeRec: Record "Post Code";
        gField: Record "Field";
        CountryRec: Record "Country/Region";
        EduClimbeRec: Record "Educational Claim Lines LT";
        Error001: Label 'Record cannot be Deleted.';

    local procedure INITINSERT()
    begin
        HrSetup.RESET();
        HrSetup.GET();
        HrSetup.TESTFIELD("Dependent Request");
        if "No." = '' then begin
            NoSeriesMgt.InitSeries(HrSetup."Dependent Request", xRec."No. Series", TODAY, "No.", "No. Series");
        end;
    end;

    local procedure OnEdit()
    begin
        /*IF "Workflow Status" = "Workflow Status"::"Pending Approval" THEN
          ERROR('Workflow Status should be Open or Approved');
          */
        VALIDATE("Workflow Status", "Workflow Status"::Released);

    end;

    procedure CreateModifiedData(CurrfieldNumber: Integer; CurrentValue: Text; PrevValue: Text)
    begin
        /*
        IF "Workflow Status" = "Workflow Status"::Released THEN BEGIN
          ModifiedList.INIT;
          ModifiedList."Document No" := "No.";
          ModifiedList."Line No." := 0;
          ModifiedList."Field No." := CurrfieldNumber;
          ModifiedList."Before Modified Value" := PrevValue;
          ModifiedList."After Modified Value" := CurrentValue;
          ModifiedList."Table No." := DATABASE::"Employee Dependents Master";
          gField.RESET;
          gField.SETRANGE(TableNo,ModifiedList."Table No.");
          gField.SETRANGE("No.",CurrfieldNumber);
          gField.FINDFIRST;
          ModifiedList."Field Name" := gField.FieldName;
          ModifiedList.INSERT;
        END;
        */

    end;

    local procedure ValidateFullName()
    begin
        "Full Name" := "Dependent First Name" + ' ' + "Dependent Middle Name" + ' ' + "Dependent Last Name"
    end;


    procedure FullName(): Text[250]
    begin
        if "Dependent Middle Name" = '' then
            exit("Dependent First Name" + ' ' + "Dependent Last Name");

        exit("Dependent First Name" + ' ' + "Dependent Middle Name" + ' ' + "Dependent Last Name");
    end;
}

