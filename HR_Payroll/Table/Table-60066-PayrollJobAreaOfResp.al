table 60066 "Payroll Job Area Of Resp."
{
    DrillDownPageID = "Payroll Job Area of Resp.";
    LookupPageID = "Payroll Job Area of Resp.";

    fields
    {
        field(1; "Area of Responsibility"; Code[20])
        {
        }
        field(2; Description; Text[100])
        {
        }
        field(3; Notes; Text[250])
        {
        }
    }

    keys
    {
        key(Key1; "Area of Responsibility")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

