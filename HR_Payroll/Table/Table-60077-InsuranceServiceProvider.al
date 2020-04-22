table 60077 "Insurance Service Provider"
{
    Caption = 'Insurance Service Provider';
    LookupPageId = "Insurance Servicec Prov. List";
    DrillDownPageId = "Insurance Servicec Prov. List";

    fields
    {
        field(1; "Insurance Provider Code"; Code[20])
        {
            Caption = 'Insurance Service Provider Code';
            Description = 'Insurance Service Provider Code';
        }
        field(2; "Insurance Service Provider"; Text[50])
        {
            Caption = 'Insurance Service Provider';
        }
        field(3; Address; Text[50])
        {
            Caption = 'Address';
        }
        field(4; "Contact Person"; Text[50])
        {
            Caption = 'Contact Person';
        }
        field(5; Email; Text[50])
        {
            Caption = 'Email';
        }
        field(6; Telephone; Text[50])
        {
            Caption = 'Telephone';
        }
        field(7; Website; Text[50])
        {
            Caption = 'Website';
        }
        field(8; Active; Boolean)
        {
            Caption = 'Active';
        }
        field(9; "Insurance Type"; Text[50])
        {
        }
    }

    keys
    {
        key(Key1; "Insurance Provider Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Insurance Provider Code", "Insurance Service Provider", Active)
        {
        }
    }
}

