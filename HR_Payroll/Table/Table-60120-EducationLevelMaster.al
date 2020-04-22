table 60120 "Education Level Master"
{
    LookupPageID = "Education Level Master";

    fields
    {
        field(1; "Level Code"; Code[20])
        {
        }
        field(2; "Level Description"; Text[250])
        {
        }
    }

    keys
    {
        key(Key1; "Level Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

