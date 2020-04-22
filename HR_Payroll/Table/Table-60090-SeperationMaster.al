table 60090 "Seperation Master"
{
    DrillDownPageID = "Seperation List";
    LookupPageID = "Seperation List";

    fields
    {
        field(1; "Seperation Code"; Code[20])
        {
        }
        field(2; "Seperation Reason"; Text[250])
        {
        }
        field(3; "Sepration Reason Code"; Integer)
        {
        }
    }

    keys
    {
        key(Key1; "Seperation Code", "Seperation Reason")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

