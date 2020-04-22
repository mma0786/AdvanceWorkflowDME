table 60095 "Payroll Error Log"
{

    fields
    {
        field(1; "Entry No."; Integer)
        {
            AutoIncrement = true;
        }
        field(2; "Payroll Statement ID"; Code[20])
        {
            TableRelation = "Payroll Statement";
        }
        field(3; "HCM Worker"; Code[20])
        {
            TableRelation = Employee;
        }
        field(4; Error; Text[250])
        {
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
        key(Key2; "Payroll Statement ID")
        {
        }
    }

    fieldgroups
    {
    }
}

