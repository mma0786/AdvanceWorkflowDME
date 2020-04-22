table 70100 "Employee Accural Amount"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Employee No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee;
            Editable = false;
        }
        field(21; "Employee Name"; Text[150])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(22; "Accued Units"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(23; "Accrued Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(24; "Sum of Earning Code"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(25; "Accured per day Amounts"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(26; "Updated By"; Code[150])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(27; "Updated Date/Time"; DateTime)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(28; "Procced"; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(29; "Calc. Formula"; Code[250])
        {
            DataClassification = ToBeClassified;
        }


    }

    keys
    {
        key(PK; "Employee No.")
        {
            Clustered = true;
        }
    }

    var
        myInt: Integer;

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}