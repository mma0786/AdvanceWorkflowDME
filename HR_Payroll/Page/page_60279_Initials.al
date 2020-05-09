page 60279 Initials
{
    PageType = List;
    SourceTable = Initials;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Initials Code"; "Initials Code")
                {
                    ApplicationArea = all;
                }
                field(Initials; Initials)
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

