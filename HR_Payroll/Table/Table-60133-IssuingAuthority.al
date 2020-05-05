table 60133 "Issuing Authority"
{
    LookupPageId = "Issuing Authority List";
    DrillDownPageId = "Issuing Authority List";

    fields
    {
        field(1; "Code"; Code[20])
        {
        }
        field(2; Description; Text[150])
        {
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
        key(Key2; Description)
        {

        }

    }

    fieldgroups
    {
    }
}

