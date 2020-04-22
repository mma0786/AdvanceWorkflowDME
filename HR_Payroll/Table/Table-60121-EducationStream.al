table 60121 "Education Stream"
{
    LookupPageID = "Education Stream";

    fields
    {
        field(1; "Stream Code"; Code[20])
        {
        }
        field(2; "Stream Description"; Text[100])
        {
        }
    }

    keys
    {
        key(Key1; "Stream Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

