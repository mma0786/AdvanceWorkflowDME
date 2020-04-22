page 70005 "Benefit List"
{
    PageType = List;
    SourceTable = "Emp. Benefits List Table";
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
                field(EBList__Benefitcode; EBList__Benefitcode)
                {
                    ApplicationArea = All;
                }
                field(EBList__UnitFormula; EBList__UnitFormula)
                {
                    ApplicationArea = All;
                }
                field(EBList__ValueFormula; EBList__ValueFormula)
                {
                    ApplicationArea = All;
                }
                field(EBList__EncashmentFormula; EBList__EncashmentFormula)
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

