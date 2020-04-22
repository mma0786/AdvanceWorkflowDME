table 60054 "Payroll Job Task"
{
    DrillDownPageID = "Payroll Job Tasks";
    LookupPageID = "Payroll Job Tasks";

    fields
    {
        field(1; "Job Task ID"; Code[20])
        {
        }
        field(2; Description; Text[100])
        {
        }
        field(3; Note; Text[250])
        {
        }
    }

    keys
    {
        key(Key1; "Job Task ID")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

