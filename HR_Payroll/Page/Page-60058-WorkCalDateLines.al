page 60058 "Work Cal Date Lines"
{
    AutoSplitKey = true;
    PageType = ListPart;
    SourceTable = "Work Calendar Date Line";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Calendar ID"; "Calendar ID")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Trans Date"; "Trans Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("From Time"; "From Time")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("To Time"; "To Time")
                {
                    ApplicationArea = All;
                }
                field(Hours; Hours)
                {
                    ApplicationArea = All;
                }
            }
        }
    }


}

