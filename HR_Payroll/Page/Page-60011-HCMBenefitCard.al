page 60011 "HCM Benefit Card"
{
    PageType = Document;
    SourceTable = "HCM Benefit";
    UsageCategory = Documents;
    // ApplicationArea = All;


    layout
    {
        area(content)
        {
            group(General)
            {
                field("Benefit Id"; "Benefit Id")
                {
                    ApplicationArea = All;
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                }
                field("Arabic Name"; "Arabic Name")
                {
                    ApplicationArea = All;
                }
                field("Short Name"; "Short Name")
                {
                    ApplicationArea = All;
                    Editable = "Short Name" = '';
                }
            }
            group("Advance Setup")
            {
                field("Benefit Type"; "Benefit Type")
                {
                    ApplicationArea = All;
                }
                field("Earning Code"; "Earning Code")
                {
                    ApplicationArea = All;
                }
                field("Fin Accrual Required"; "Fin Accrual Required")
                {
                    ApplicationArea = All;
                }
                field("Max Units"; "Max Units")
                {
                    ApplicationArea = All;
                }
                field("Benefit Accrual Frequency"; "Benefit Accrual Frequency")
                {
                    ApplicationArea = All;
                }
                field("Allow Encashment"; "Allow Encashment")
                {
                    ApplicationArea = All;
                }
                field(Active; Active)
                {
                    ApplicationArea = All;
                }
                field("Adjust in Salary Grade Change"; "Adjust in Salary Grade Change")
                {
                    ApplicationArea = All;
                }
                field("Calculate in Final Period of F&F"; "Calculate in Final Period ofFF")
                {
                    ApplicationArea = All;
                }
            }
            group(Formula)
            {
                grid(Control27)
                {
                    Caption = '';
                    group(Control11)
                    {
                        Caption = '';
                        field("Unit Calc Formula"; UnitCalcFormula)
                        {
                            ApplicationArea = All;
                            MultiLine = true;
                            Width = 500;

                            trigger OnValidate()
                            begin
                                SetFormulaForUnitCalc(UnitCalcFormula);
                            end;
                        }
                        field("Amount Calc Formula"; AmountCalcFormula)
                        {
                            ApplicationArea = All;
                            MultiLine = true;
                            Width = 500;

                            trigger OnValidate()
                            begin
                                SetFormulaForAmountCalc(AmountCalcFormula);
                            end;
                        }
                        field("Encashment Formula"; EncashmentFormula)
                        {
                            ApplicationArea = All;
                            MultiLine = true;
                            Width = 500;

                            trigger OnValidate()
                            begin
                                SetFormulaForEncashmentFormula(EncashmentFormula);
                            end;
                        }
                    }
                }
            }
            group("Accounting Setup")
            {
                group("Main Account")
                {
                    field("Main Account Type"; "Main Account Type")
                    {
                        ApplicationArea = All;
                    }
                    field("Main Account No."; "Main Account No.")
                    {
                        ApplicationArea = All;
                    }
                }
                group("Offset Account")
                {
                    field("Offset Account Type"; "Offset Account Type")
                    {
                        ApplicationArea = All;
                    }
                    field("Offset Account No."; "Offset Account No.")
                    {
                        ApplicationArea = All;
                    }
                }
            }
        }
    }



    trigger OnAfterGetRecord()
    begin
        UnitCalcFormula := GetFormulaForUnitCalc;
        AmountCalcFormula := GetFormulaForAmountCalc;
        EncashmentFormula := GetFormulaForEncashmentFormula;
    end;

    trigger OnClosePage()
    begin
        //commented By Avinash  ValidateMandatoryFields;
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        //commented By Avinash   ValidateMandatoryFields;
    end;

    var
        UnitCalcFormula: Text;
        AmountCalcFormula: Text;
        EncashmentFormula: Text;

    //commented By Avinash  [Scope('Internal')]
    procedure ValidateMandatoryFields()
    begin
        if "Benefit Id" <> '' then begin
            TESTFIELD("Short Name");
        end;
    end;
}

