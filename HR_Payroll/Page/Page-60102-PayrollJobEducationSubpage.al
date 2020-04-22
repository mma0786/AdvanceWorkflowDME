page 60102 "Payroll Job Education Subpage"
{
    AutoSplitKey = true;
    Caption = 'Education';
    DelayedInsert = true;
    MultipleNewLines = true;
    PageType = ListPart;
    SourceTable = "Payroll Job Education Line";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Education; Education)
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

