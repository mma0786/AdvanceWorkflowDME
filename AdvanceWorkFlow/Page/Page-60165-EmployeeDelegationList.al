page 60165 "Employee Delegation List"
{
    PageType = List;
    SourceTable = "Delegate - WFLT";
    UsageCategory = Administration;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Delegate No."; "Delegate No.")
                {
                    ApplicationArea = All;
                }
                field("Employee Code"; "Employee Code")
                {
                    ApplicationArea = All;
                }
                field("Employee ID"; "Employee ID")
                {
                    ApplicationArea = All;
                }
                field("Delegate To"; "Delegate To")
                {
                    ApplicationArea = All;
                }
                field("Delegate ID"; "Delegate ID")
                {
                    ApplicationArea = All;
                }
                field("To Date"; "To Date")
                {
                    ApplicationArea = All;
                }
                field("From Date"; "From Date")
                {
                    ApplicationArea = All;
                }
            }
        }
    }


}

