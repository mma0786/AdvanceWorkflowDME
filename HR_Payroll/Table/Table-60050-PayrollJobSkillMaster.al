table 60050 "Payroll Job Skill Master"
{
    DrillDownPageID = "Payroll Job Skills";
    LookupPageID = "Payroll Job Skills";

    fields
    {
        field(1; "Skill ID"; Code[20])
        {
            Caption = 'Skill';
        }
        field(2; Description; Text[100])
        {
        }
        field(3; "Skill Type"; Code[20])
        {
        }
        field(4; Rating; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "Skill ID")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

