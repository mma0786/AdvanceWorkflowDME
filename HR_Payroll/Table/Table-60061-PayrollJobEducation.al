table 60061 "Payroll Job Education"
{
    DrillDownPageID = "Payroll Job Education";
    LookupPageID = "Payroll Job Education";

    fields
    {
        field(1; "Education Code"; Code[20])
        {
        }
        field(2; Description; Text[100])
        {
        }
        field(3; "Education Level"; Code[20])
        {
            TableRelation = "Education Level Master";
        }
        field(4; "Education Stream"; Code[20])
        {
            TableRelation = "Education Stream";
        }
    }

    keys
    {
        key(Key1; "Education Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

