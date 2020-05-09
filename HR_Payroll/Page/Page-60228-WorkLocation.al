page 60228 "Work Location"
{
    PageType = List;
    SourceTable = "Work Location";
    UsageCategory = Lists;
    ApplicationArea = All;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Work Location Code"; "Work Location Code")
                {
                    ApplicationArea = All;
                }
                field("Work Location Name"; "Work Location Name")
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

