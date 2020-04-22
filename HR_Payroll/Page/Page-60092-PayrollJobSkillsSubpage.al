page 60092 "Payroll Job Skills Subpage"
{
    AutoSplitKey = true;
    Caption = 'Skills';
    DelayedInsert = true;
    PageType = ListPart;
    SourceTable = "Payroll Job Skill Line";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Skill; Skill)
                {
                    ApplicationArea = All;
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                }
                field(Level; Level)
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

