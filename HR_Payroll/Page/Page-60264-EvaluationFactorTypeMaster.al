page 60264 "Evaluation Factor Type Master"
{
    PageType = List;
    SourceTable = "Evaluation Factor Type Master";
    UsageCategory = Lists;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Code)
                {
                    ApplicationArea = All;
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                }
                field("Defination of Skill"; "Defination of Skill")
                {
                    ApplicationArea = All;
                }
            }
        }
    }


}

