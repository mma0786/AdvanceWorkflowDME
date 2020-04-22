page 60120 "Payroll Skill Level"
{
    PageType = List;
    SourceTable = "Payroll Skill Level";
    ApplicationArea = All;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Level ID"; "Level ID")
                {
                    ApplicationArea = All;
                }
                field(Description; Description)
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

