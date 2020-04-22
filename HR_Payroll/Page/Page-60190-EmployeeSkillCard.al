page 60190 "Employee Skill Card"
{
    InsertAllowed = false;
    PageType = Card;
    SourceTable = "Payroll Job Skill Line";
    UsageCategory = Administration;
    // ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Emp ID"; "Emp ID")
                {
                    ApplicationArea = All;
                }
                field("Emp Full Name"; "Emp Full Name")
                {
                    ApplicationArea = All;
                }
                field(Skill; Skill)
                {
                    ApplicationArea = All;
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                }
                field(Level; Level)
                {
                    ApplicationArea = All;
                }
                field(Importance; Importance)
                {
                    ApplicationArea = All;
                }
            }
        }
    }


}

