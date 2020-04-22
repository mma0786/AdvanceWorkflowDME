page 60229 "Sector List"
{
    Caption = 'Sector List';
    CardPageID = "Sector Card";
    ModifyAllowed = false;
    PageType = List;
    SourceTable = Sector;
    UsageCategory = Lists;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Sector ID"; "Sector ID")
                {
                    ApplicationArea = All;
                }
                field("Sector Name"; "Sector Name")
                {
                    ApplicationArea = All;
                }
                field("Country/Region Code"; "Country/Region Code")
                {
                    ApplicationArea = All;
                }
                field(Currency; Currency)
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

