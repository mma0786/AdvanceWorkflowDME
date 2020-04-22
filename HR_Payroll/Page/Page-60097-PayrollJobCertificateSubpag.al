page 60097 "Payroll Job Certificate Subpag"
{
    AutoSplitKey = true;
    Caption = 'Certificate';
    DelayedInsert = true;
    MultipleNewLines = true;
    PageType = ListPart;
    SourceTable = "Payroll Job Certificate Line";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Certficate Type"; "Certficate Type")
                {
                    ApplicationArea = All;
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                }
                field(Importance; Importance)
                {
                    ApplicationArea = All;
                }
            }
        }
    }


}

