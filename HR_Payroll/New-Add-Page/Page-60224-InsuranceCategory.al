page 60224 "Insurance Category"
{
    PageType = List;
    SourceTable = "Insurance Category";
    UsageCategory = Lists;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Insurance Category Code"; "Insurance Category Code")
                {
                    ApplicationArea = All;
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                }
                field(Active; Active)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}

