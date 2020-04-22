table 60017 "Employment Type"
{
    Caption = 'Employment Type';
    LookupPageID = "Employment Type";

    fields
    {
        field(1; "Employment Type ID"; Code[20])
        {
            Caption = 'Employnment Type ID';
        }
        field(2; "Employment Type"; Text[30])
        {
        }
    }

    keys
    {
        key(Key1; "Employment Type ID", "Employment Type")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(group; "Employment Type ID", "Employment Type")
        {
        }
    }
}

