page 60057 "Work Calendar Date"
{
    PageType = ListPart;
    SourceTable = "Work Calendar Date";

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
                field(Name; Name)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Alternative Calendar ID"; "Alternative Calendar ID")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Calculation Type"; "Calculation Type")
                {
                    ApplicationArea = All;
                }
                field(Remarks; Remarks)
                {
                    ApplicationArea = All;
                }
                field("Has Changed"; "Has Changed")
                {
                    Editable = false;
                    ApplicationArea = All;
                    Visible = false;
                }
            }
        }
    }


}

