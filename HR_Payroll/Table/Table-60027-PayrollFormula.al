table 60027 "Payroll Formula"
{

    fields
    {
        field(1; "Formula Key"; Code[100])
        {
        }
        field(2; "Formula description"; Text[100])
        {
        }
        field(3; "Formula Key Type"; Option)
        {
            OptionCaption = 'Parameter,Pay Component,Benefit,Leave Type,Custom';
            OptionMembers = Parameter,"Pay Component",Benefit,"Leave Type",Custom;
        }
        field(4; Formula; Text[250])
        {
        }
        field(5; "Short Name"; Code[20])
        {
        }
    }

    keys
    {
        key(Key1; "Formula Key")
        {
            Clustered = true;
        }
        key(Key2; "Short Name")
        {
        }
        key(Key3; "Formula Key Type")
        {
        }
        key(Key4; "Short Name", "Formula Key Type")
        {
        }
    }

    fieldgroups
    {
    }
}

