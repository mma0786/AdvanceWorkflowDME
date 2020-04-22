page 60130 "Accrual Component List"
{
    Caption = 'Accrual Component List';
    CardPageID = "Accrual Component Card";
    PageType = List;
    SourceTable = "Accrual Components";
    UsageCategory = Administration;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Accrual ID"; "Accrual ID")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                }
                field("Months Ahead Calculate"; "Months Ahead Calculate")
                {
                    ApplicationArea = All;
                }
                field("Consumption Split by Month"; "Consumption Split by Month")
                {
                    ApplicationArea = All;
                }
                field("Accrual Interval Basis Date"; "Accrual Interval Basis Date")
                {
                    ApplicationArea = All;
                }
                field("Accrual Basis Date"; "Accrual Basis Date")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Interval Month Start"; "Interval Month Start")
                {
                    ApplicationArea = All;
                }
                field("Accrual Units Per Month"; "Accrual Units Per Month")
                {
                    ApplicationArea = All;
                }
                field("Opening Additional Accural"; "Opening Additional Accural")
                {
                    ApplicationArea = All;
                }
                field("Max Carry Forward"; "Max Carry Forward")
                {
                    ApplicationArea = All;
                }
                field("CarryForward Lapse After Month"; "CarryForward Lapse After Month")
                {
                    ApplicationArea = All;
                }
                field("Repeat After Months"; "Repeat After Months")
                {
                    ApplicationArea = All;
                }
                field("Avail Allow Till"; "Avail Allow Till")
                {
                    ApplicationArea = All;
                }
                field("Allow Negative"; "Allow Negative")
                {
                    ApplicationArea = All;
                }
            }
        }
    }


}

