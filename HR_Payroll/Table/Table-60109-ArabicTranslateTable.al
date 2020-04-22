table 60109 "Arabic Translate Table"
{

    fields
    {
        field(1; "Eng Code"; Code[150])
        {
        }
        field(2; "Arabic Text"; Text[250])
        {
        }
    }

    keys
    {
        key(Key1; "Eng Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

