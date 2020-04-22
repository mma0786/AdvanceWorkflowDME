table 60073 "Payroll Skill Level"
{
    DrillDownPageID = "Payroll Skill Level";
    LookupPageID = "Payroll Skill Level";

    fields
    {
        field(1; "Level ID"; Code[20])
        {
        }
        field(2; Description; Text[100])
        {
        }
        field(3; Rating; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "Level ID")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

