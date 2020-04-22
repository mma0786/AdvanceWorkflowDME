table 60039 "Pay Periods"
{
    DrillDownPageID = "Pay Periods List";
    LookupPageID = "Pay Periods List";

    fields
    {
        field(1; "Pay Cycle"; Code[20])
        {
        }
        field(2; "Line No."; Integer)
        {
        }
        field(3; "Period Start Date"; Date)
        {
        }
        field(4; "Period End Date"; Date)
        {
        }
        field(6; Year; Integer)
        {
        }
        field(7; Month; Text[20])
        {
        }
        field(8; Status; Option)
        {
            OptionCaption = 'Open,Closed';
            OptionMembers = Open,Closed;
        }
    }

    keys
    {
        key(Key1; "Pay Cycle", "Line No.")
        {
            Clustered = true;
        }
        key(Key2; "Pay Cycle", "Period Start Date")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Pay Cycle", "Period Start Date", "Period End Date")
        {
        }
    }
}

