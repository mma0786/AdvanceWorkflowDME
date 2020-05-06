page 70022 "Emp. Benefits List FnFCalc"
{
    PageType = List;
    SourceTable = "Emp. Benefits List FnFCalc";
    UsageCategory = Lists;
    ApplicationArea = All;
    DeleteAllowed = false;
    ModifyAllowed = false;
    InsertAllowed = false;
    Caption = 'FnF Calc Emp. Benefits List';

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
                field(EBList__UnitFormulaTxt; EBList__UnitFormulaTxt)
                {
                    ApplicationArea = All;
                }
                field(EBList__ValueFormulaTxt; EBList__ValueFormulaTxt)
                {
                    ApplicationArea = All;
                }
                field(EBList__EncashmentFormulaTxt; EBList__EncashmentFormulaTxt)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    var
        EBList__UnitFormulaTxt: Text;
        EBList__ValueFormulaTxt: text;
        EBList__EncashmentFormulaTxt: Text;


    trigger OnAfterGetRecord()
    begin
        EBList__UnitFormulaTxt := GET_EBList__UnitFormula();
        EBList__ValueFormulaTxt := GET_EBList__ValueFormula();
        EBList__EncashmentFormulaTxt := GET_EBList__EncashmentFormula();

    end;
}

