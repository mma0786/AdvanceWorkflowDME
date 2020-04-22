page 60213 "Bank Master"
{
    PageType = List;
    SourceTable = "Bank Master";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Bank Code"; "Bank Code")
                {
                    ApplicationArea = ALL;
                }
                field("Bank Name"; "Bank Name")
                {
                    ApplicationArea = ALL;
                }
                field("Bank Name in Arabic"; "Bank Name in Arabic")
                {
                    ApplicationArea = ALL;
                }
            }
        }
    }

    actions
    {
    }
}

