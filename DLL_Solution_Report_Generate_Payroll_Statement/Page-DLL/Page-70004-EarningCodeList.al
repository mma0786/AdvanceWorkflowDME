page 70004 "Earning Code List"
{
    PageType = List;
    SourceTable = "Emp. Earning Code  List Table";
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
                field(EECList__Paycomponentcode; EECList__Paycomponentcode)
                {
                    ApplicationArea = All;
                }
                field(EECList__UnitFormula; EECList__UnitFormula)
                {
                    ApplicationArea = All;
                }
                field(EECList__Formulaforattendance; EECList__Formulaforattendance)
                {
                    ApplicationArea = All;
                }
                field(EECList__Formulafordays; EECList__Formulafordays)
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

    actions
    {
    }
}

