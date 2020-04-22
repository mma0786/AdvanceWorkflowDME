page 60192 "Employee Education Card"
{
    InsertAllowed = false;
    PageType = Card;
    SourceTable = "Payroll Job Education Line";
    ///UsageCategory = Administration;
    //ApplicationArea = All;

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
                field("Education Level"; "Education Level")
                {
                    ApplicationArea = All;
                }
                field(Education; Education)
                {
                    ApplicationArea = All;
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                }
                field("Grade Pass"; "Grade Pass")
                {
                    ApplicationArea = All;
                }
                field("Passing Year"; "Passing Year")
                {
                    ApplicationArea = All;
                }
                field(Importance; Importance)
                {
                    Visible = false;
                    ApplicationArea = All;
                }
            }
        }
    }


}

