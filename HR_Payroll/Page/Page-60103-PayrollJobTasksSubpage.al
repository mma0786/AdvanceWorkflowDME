page 60103 "Payroll Job Tasks Subpage"
{
    AutoSplitKey = true;
    Caption = 'Tasks';
    DelayedInsert = true;
    MultipleNewLines = true;
    PageType = ListPart;
    SourceTable = "Payroll Job Task Line";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Job Task"; "Job Task")
                {
                    ApplicationArea = All;
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                }
                field(Notes; Notes)
                {
                    ApplicationArea = All;
                }
            }
        }
    }


}

