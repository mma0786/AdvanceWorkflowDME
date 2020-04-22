page 60115 "Payroll Job Inactive Positions"
{
    CardPageID = "Payroll Job Position Card";
    PageType = List;
    SourceTable = "Payroll Position";
    UsageCategory = Lists;
    ApplicationArea = All;


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


}

