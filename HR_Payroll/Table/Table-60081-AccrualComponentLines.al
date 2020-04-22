table 60081 "Accrual Component Lines"
{

    fields
    {
        field(1; "Accrual ID"; Code[20])
        {
            TableRelation = "Accrual Components";
        }
        field(2; "Line No."; Integer)
        {
        }
        field(3; "Interval Month Start"; Integer)
        {

            trigger OnValidate()
            begin
                if "Interval Month Start" <> 0 then begin
                    AccrualComponents.GET("Accrual ID");
                    if AccrualComponents."Months Ahead Calculate" < "Interval Month Start" then
                        ERROR('You cannot enter intervals more than %1', AccrualComponents."Months Ahead Calculate");
                end;
            end;
        }
        field(4; "Interval Month End"; Integer)
        {
        }
        field(5; "Accrual Units Per Month"; Decimal)
        {
        }
        field(6; "Opening Additional Accural"; Decimal)
        {
        }
        field(7; "Max Carry Forward"; Decimal)
        {
        }
        field(8; "CarryForward Lapse After Month"; Decimal)
        {
        }
        field(9; "Repeat After Months"; Decimal)
        {
        }
        field(10; "Avail Allow Till"; Option)
        {
            OptionCaption = 'Accrual Till Date,End of Period';
            OptionMembers = "Accrual Till Date","End of Period";
        }
    }

    keys
    {
        key(Key1; "Accrual ID", "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        AccrualComponents: Record "Accrual Components";
}

