page 60135 "Payroll Job Inactive Postions"
{
    Caption = 'Inactive Positions';
    CardPageID = "Payroll Job Position Card";
    InsertAllowed = false;
    PageType = List;
    SourceTable = "Payroll Position";
    SourceTableView = WHERE("Inactive Position" = CONST(true));
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Position ID"; "Position ID")
                {
                    ApplicationArea = All;
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                }
                field(Job; Job)
                {
                    ApplicationArea = All;
                }
                field(Title; Title)
                {
                    ApplicationArea = All;
                }
                field(Department; Department)
                {
                    ApplicationArea = All;
                }
                field("Reports to Position"; "Reports to Position")
                {
                    ApplicationArea = All;
                }
                field("Earning Code Group"; "Earning Code Group")
                {
                    ApplicationArea = All;
                }
            }
        }
    }



    var
        PayrollPosDuration: Record "Payroll Position Duration";
}

