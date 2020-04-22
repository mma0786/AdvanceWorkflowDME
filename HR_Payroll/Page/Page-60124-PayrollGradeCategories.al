page 60124 "Payroll Grade Categories"
{
    PageType = List;
    SourceTable = "Payroll Grade Category";
    ApplicationArea = All;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Grade Category ID"; "Grade Category ID")
                {
                    ApplicationArea = All;
                }
                field("Grade Category Description"; "Grade Category Description")
                {
                    ApplicationArea = All;
                }
            }
        }
    }


}

