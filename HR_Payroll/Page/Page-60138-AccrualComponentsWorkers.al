page 60138 "Accrual Components Workers-2" //commented By Avinash 
{
    CardPageID = "Accrual Component Emp. Card";
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    UsageCategory = Administration;
    ApplicationArea = All;
    PageType = List;
    SourceTable = "Accrual Components Employee";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Accrual ID"; "Accrual ID")
                {
                    ApplicationArea = All;
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                }
                field("Accrual Interval Basis"; "Accrual Interval Basis")
                {
                    ApplicationArea = All;
                }
                field("Accrual Frequency"; "Accrual Frequency")
                {
                    ApplicationArea = All;
                }
                field("Accrual Policy Enrollment"; "Accrual Policy Enrollment")
                {
                    ApplicationArea = All;
                }
                field("Accrual Award Date"; "Accrual Award Date")
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
            }
        }
    }


}

