page 60145 "FS Benefit Ledger"
{
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "FS - Earning Code";
    SourceTableView = WHERE("Earning Code" = CONST('EOS'),
                            "Earning Code Amount" = FILTER(<> 0));
    ApplicationArea = All;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Earning Code"; "Earning Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Earning Description"; "Earning Description")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Earning Code Amount"; "Earning Code Amount")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
            }
        }
    }


}

