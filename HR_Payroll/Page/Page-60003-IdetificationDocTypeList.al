page 60003 "Idetification DocType List"
{
    Caption = 'Identification Type Master';
    UsageCategory = Lists;
    ApplicationArea = All;
    PageType = List;
    SourceTable = "Identification Doc Type Master";
    SourceTableView = SORTING(Code)
                      ORDER(Ascending);

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Code)
                {
                    ApplicationArea = All;
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                }
                field("Maintain Document Type"; "Maintain Document Type")
                {
                    ApplicationArea = All;
                }
                field("Required For Visa Request"; "Required For Visa Request")
                {
                    ApplicationArea = All;
                }
            }
        }
    }


}

