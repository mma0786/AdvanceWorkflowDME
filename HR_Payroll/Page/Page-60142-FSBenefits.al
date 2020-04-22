page 60142 "FS Benefits"
{
    PageType = ListPart;
    SourceTable = "FS Benefits";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Benefit Code"; "Benefit Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Benefit Description"; "Benefit Description")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Calculation Unit"; "Calculation Unit")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Benefit Amount"; "Benefit Amount")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        CurrPage.UPDATE;
                    end;
                }
                field("Payable Amount"; "Payable Amount")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
            }
        }
    }


}

