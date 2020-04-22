table 60051 "Payroll Job Title"
{
    // Commented By Avinash
    DrillDownPageID = "Payroll Job Title";
    LookupPageID = "Payroll Job Title";
    // Commented By Avinash
    fields
    {
        field(1; "Job Title"; Code[20])
        {
        }
        field(2; Description; Text[100])
        {
        }
    }

    keys
    {
        key(Key1; "Job Title")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

