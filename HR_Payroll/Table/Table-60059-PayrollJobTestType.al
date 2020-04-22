table 60059 "Payroll Job Test Type"
{
    DrillDownPageID = "Payroll Job Tests";
    LookupPageID = "Payroll Job Tests";

    fields
    {
        field(1; "Test Type"; Code[20])
        {
        }
        field(2; Description; Text[100])
        {
        }
    }

    keys
    {
        key(Key1; "Test Type")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

