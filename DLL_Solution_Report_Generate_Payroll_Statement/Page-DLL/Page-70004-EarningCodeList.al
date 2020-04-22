page 70004 "Earning Code List"
{
    PageType = List;
    SourceTable = "Emp. Earning Code  List Table";
    UsageCategory = Lists;
    ApplicationArea = All;
    DeleteAllowed = false;
    ModifyAllowed = false;
    InsertAllowed = false;

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
                field(EECList__Paycomponentcode; EECList__Paycomponentcode)
                {
                    ApplicationArea = All;
                }
                field(EECList__UnitFormulaTxt; EECList__UnitFormulaTxt)
                {
                    ApplicationArea = All;
                }
                field(EECList__FormulaforattendanceTxt; EECList__FormulaforattendanceTxt)
                {
                    ApplicationArea = All;
                }
                field(EECList__FormulafordaysTxt; EECList__FormulafordaysTxt)
                {
                    ApplicationArea = All;
                }
                field(EECList__Paycomponenttype; EECList__Paycomponenttype)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    var
        EECList__FormulafordaysTxt: Text;
        EECList__FormulaforattendanceTxt: Text;
        EECList__UnitFormulaTxt: Text;

    trigger
    OnAfterGetRecord()
    var
    begin
        EECList__FormulafordaysTxt := GETEECList__Formulafordays();

        EECList__FormulaforattendanceTxt := GETEECList__Formulaforattendance();

        EECList__UnitFormulaTxt := GETFormulaEECList__UnitFormula();

        Message('%1    %2    %3', EECList__FormulafordaysTxt, EECList__FormulaforattendanceTxt, EECList__UnitFormulaTxt);
    end;
}

