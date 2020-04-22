page 60038 "HCM Benefit ErnGrp Card"
{
    PageType = Card;
    SourceTable = "HCM Benefit ErnGrp";
    UsageCategory = Documents;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Earning Code Group"; "Earning Code Group")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Benefit Id"; "Benefit Id")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        CurrPage.UPDATE;
                    end;
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
                grid(Control25)
                {
                    group(Control24)
                    {
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

    var
        UnitCalcFormula: Text;
        AmountCalcFormula: Text;
        EncashmentFormula: Text;
}

