page 60137 "Interim Accruals Workers Subpg"
{
    AutoSplitKey = true;
    DelayedInsert = true;
    MultipleNewLines = true;
    PageType = ListPart;
    SourceTable = "Employee Interim Accurals";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Month; Month)
                {
                    ApplicationArea = All;
                }
                field("Start Date"; "Start Date")
                {
                    ApplicationArea = All;
                }
                field("End Date"; "End Date")
                {
                    ApplicationArea = All;
                }
                field("Opening Balance Unit"; "Opening Balance Unit")
                {
                    ApplicationArea = All;
                }
                field("Opening Balance Amount"; "Opening Balance Amount")
                {
                    ApplicationArea = All;
                }
                field("Carryforward Deduction"; "Carryforward Deduction")
                {
                    ApplicationArea = All;
                }
                field("Monthly Accrual Units"; "Monthly Accrual Units")
                {
                    ApplicationArea = All;
                }
                field("Monthly Accrual Amount"; "Monthly Accrual Amount")
                {
                    ApplicationArea = All;
                }
                field("Adjustment Units"; "Adjustment Units")
                {
                    ApplicationArea = All;
                }
                field("Adjustment Amount"; "Adjustment Amount")
                {
                    ApplicationArea = All;
                }
                field("Leaves Consumed Units"; "Leaves Consumed Units")
                {
                    ApplicationArea = All;
                }
                field("Leaves Consumed Amount"; "Leaves Consumed Amount")
                {
                    ApplicationArea = All;
                }
                field("Carryforward Month"; "Carryforward Month")
                {
                    ApplicationArea = All;
                }
                field("Closing Balance"; "Closing Balance")
                {
                    ApplicationArea = All;
                }
                field("Closing Balance Amount"; "Closing Balance Amount")
                {
                    ApplicationArea = All;
                }
            }
        }
    }


}

