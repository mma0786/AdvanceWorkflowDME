page 60100 "Payroll Job Tests Subpage"
{
    AutoSplitKey = true;
    Caption = 'Tests';
    DelayedInsert = true;
    MultipleNewLines = true;
    PageType = ListPart;
    SourceTable = "Payroll Job Test Line";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Test Type"; "Test Type")
                {
                    ApplicationArea = All;
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                }
            }
        }
    }


}

