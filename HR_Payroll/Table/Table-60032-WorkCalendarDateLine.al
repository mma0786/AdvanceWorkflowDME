table 60032 "Work Calendar Date Line"
{

    fields
    {
        field(1; "Calendar ID"; Code[20])
        {
        }
        field(2; "Trans Date"; Date)
        {
        }
        field(3; "From Time"; Time)
        {
        }
        field(4; "To Time"; Time)
        {

            trigger OnValidate()
            begin
                Hours := "To Time" - "From Time";
                Hours := Hours / 3600000;
            end;
        }
        field(5; "Line No."; Integer)
        {
        }
        field(6; Hours; Decimal)
        {
        }
        field(7; "Shift Split"; Option)
        {
            OptionCaption = ' ,First Half,Second Half';
            OptionMembers = " ","First Half","Second Half";
        }
    }

    keys
    {
        key(Key1; "Calendar ID", "Trans Date", "Line No.")
        {
            Clustered = true;
            SumIndexFields = Hours;
        }
    }

    fieldgroups
    {
    }

    var
        HrDec: Decimal;
}

