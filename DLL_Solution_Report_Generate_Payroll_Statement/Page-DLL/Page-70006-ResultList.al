page 70006 "Result List"
{
    PageType = List;
    SourceTable = "Emp. Result Table";
    UsageCategory = Lists;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Entry No."; "Entry No.")
                {
                    ApplicationArea = All;
                }
                field(FormulaType; FormulaType)
                {
                    ApplicationArea = All;
                }
                field(BaseCode; BaseCode)
                {
                    ApplicationArea = All;
                }
                field(FormulaID1; FormulaID1)
                {
                    ApplicationArea = All;
                }
                field(Result1; Result1)
                {
                    ApplicationArea = All;
                }
                field(FormulaID2; FormulaID2)
                {
                    ApplicationArea = All;
                }
                field(Result2; Result2)
                {
                    ApplicationArea = All;
                }
                field(FormulaID3; FormulaID3)
                {

                    ApplicationArea = All;
                }
                field(Result3; Result3)
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

