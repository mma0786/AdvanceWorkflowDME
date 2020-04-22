table 60064 "Payroll Job Screening"
{
    DrillDownPageID = "Payroll Job Screening";
    LookupPageID = "Payroll Job Screening";

    fields
    {
        field(1; "Screening Type"; Code[20])
        {
        }
        field(2; Description; Text[100])
        {
        }
    }

    keys
    {
        key(Key1; "Screening Type")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

