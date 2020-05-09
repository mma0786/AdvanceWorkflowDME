page 60278 "Region Master"
{
    PageType = List;
    SourceTable = Region;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Region Code"; "Region Code")
                {
                    ApplicationArea = all;
                }
                field("Region Name"; "Region Name")
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }
}

