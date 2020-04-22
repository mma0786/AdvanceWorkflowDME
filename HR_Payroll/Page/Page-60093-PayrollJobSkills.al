page 60093 "Payroll Job Skills"
{
    PageType = List;
    SourceTable = "Payroll Job Skill Master";
    UsageCategory = Lists;
    ApplicationArea = All;


    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Skill ID"; "Skill ID")
                {
                    ApplicationArea = All;
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                }
                field("Skill Type"; "Skill Type")
                {
                    ApplicationArea = All;
                }
                field(Rating; Rating)
                {
                    ApplicationArea = All;
                }
            }
        }
    }


}

