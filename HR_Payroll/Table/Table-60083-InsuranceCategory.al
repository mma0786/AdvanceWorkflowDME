table 60083 "Insurance Category"
{

    LookupPageId = "Insurance Category";
    DrillDownPageId = "Insurance Category";
    fields
    {
        field(1; "Insurance Category Code"; Code[20])
        {
        }
        field(2; Description; Text[50])
        {
        }
        field(3; Active; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; "Insurance Category Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Insurance Category Code", Description, Active)
        {
        }
    }
}

