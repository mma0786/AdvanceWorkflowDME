table 60097 "Leave Encashment"
{

    fields
    {
        field(1; "Journal ID"; Code[20])
        {
        }
        field(2; "Employee No."; Code[20])
        {
        }
        field(3; "Employee Name"; Text[100])
        {
        }
        field(4; "Leave Encashment Amount"; Decimal)
        {
        }
        field(5; "Leave Units"; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "Journal ID", "Employee No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

