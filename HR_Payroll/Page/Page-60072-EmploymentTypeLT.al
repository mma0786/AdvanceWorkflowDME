page 60072 "Employment Type LT"
{
    PageType = List;
    SourceTable = "Employment Type";
    SourceTableView = SORTING("Employment Type ID", "Employment Type")
                      ORDER(Ascending);
    UsageCategory = Administration;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Employment Type ID"; "Employment Type ID")
                {
                    ApplicationArea = All;
                }
                field("Employment Type"; "Employment Type")
                {
                    Caption = 'Employment Type';
                    ApplicationArea = All;
                }
            }
        }
    }


}

