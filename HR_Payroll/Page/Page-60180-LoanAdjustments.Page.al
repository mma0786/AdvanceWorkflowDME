page 60180 "Loan Adjustments"
{
    CardPageID = "Loan Adjustment";
    Caption = 'Loan Adjustment';
    Editable = false;
    PageType = List;
    RefreshOnActivate = true;
    SourceTable = "Loan Adjustment Header";
    SourceTableView = SORTING("Loan Adjustment ID") ORDER(Ascending);
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Loan Adjustment ID"; "Loan Adjustment ID")
                {
                    ApplicationArea = All;
                }
                field("Employee ID"; "Employee ID")
                {
                    ApplicationArea = All;
                }
                field("Employee Name"; "Employee Name")
                {
                    ApplicationArea = All;
                }
                field("Adjustment Type"; "Adjustment Type")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Loan ID"; "Loan ID")
                {
                    ApplicationArea = All;
                }
                field("Loan Description"; "Loan Description")
                {
                    ApplicationArea = All;
                }
                field("Workflow Status"; "Workflow Status")
                {
                    ApplicationArea = All;
                }
                field("Loan Request ID"; "Loan Request ID")
                {
                    ApplicationArea = All;
                }
            }
        }
    }


}

