page 60032 "Payroll Earning Code ErnGrp"
{
    PageType = Card;
    SourceTable = "Payroll Earning Code ErnGrp";
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
                field("Earning Code"; "Earning Code")
                {
                    ApplicationArea = All;
                    Editable = "Earning Code" = '';

                    trigger OnValidate()
                    begin
                        CurrPage.UPDATE;
                    end;
                }
                field("Short Name"; "Short Name")
                {
                    ApplicationArea = All;
                    Editable = "Short Name" = '';
                }
                field("Unit Of Measure"; "Unit Of Measure")
                {
                    ApplicationArea = All;
                    Editable = EditUnitofMeasure;

                    trigger OnValidate()
                    begin
                        if "Unit Of Measure" = "Unit Of Measure"::" " then
                            EditUnitofMeasure := true
                        else
                            EditUnitofMeasure := false;
                    end;
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                }
                field("Arabic name"; "Arabic name")
                {
                    ApplicationArea = All;
                }
            }
            group("Adavanced Setup")
            {
                field("Pay Component Type"; "Pay Component Type")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        SetFormulaEditable;
                    end;
                }
                field("Cost of Living Rate"; "Cost of Living Rate")
                {
                    ApplicationArea = All;
                    Editable = EditCostofLiving;
                }
                field("Earning Code Type"; "Earning Code Type")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        SetFormulaEditable
                    end;
                }
                field("Earning Code Calc Subtype"; "Earning Code Calc Subtype")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        SetFormulaEditable;
                    end;
                }
                field("Earning Code Calc Class"; "Earning Code Calc Class")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        SetFormulaEditable
                    end;
                }
                field("Minimum Value"; "Minimum Value")
                {
                    ApplicationArea = All;
                }
                field("Maximum Value"; "Maximum Value")
                {
                    ApplicationArea = All;
                }
                field("WPS Type"; WPSType)
                {
                    ApplicationArea = All;
                }
                field(Active; Active)
                {
                    ApplicationArea = All;
                }
                field("FF Adjustment Required"; "FF Adjustment Required")
                {
                    ApplicationArea = All;
                }
                field(IsSysComponent; IsSysComponent)
                {
                    ApplicationArea = All;
                }
                field("Fin Accrual Required"; "Fin Accrual Required")
                {
                    ApplicationArea = All;
                }
                field("Calc Accrual"; "Calc Accrual")
                {
                    ApplicationArea = All;
                }
                field("Calc. Payroll Adj."; "Calc. Payroll Adj.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
            group("Pay Component")
            {
                Editable = EditFormula;
                grid(Control39)
                {
                    group(Control38)
                    {
                        field("Formula For Package"; "Formula For Package")
                        {
                            ApplicationArea = All;
                            MultiLine = true;
                            Visible = false;
                            Width = 500;
                        }
                        field("Formula For Attendance"; FormulaForAttendance)
                        {
                            ApplicationArea = All;
                            MultiLine = true;
                            Width = 500;

                            trigger OnValidate()
                            begin
                                SetFormulaForAttendance(FormulaForAttendance);
                            end;
                        }
                        field("Formula For Days"; "Formula For Days")
                        {
                            ApplicationArea = All;
                            MultiLine = true;
                            Width = 500;
                        }
                        field("Package Calc Type"; "Package Calc Type")
                        {
                            ApplicationArea = All;

                            trigger OnValidate()
                            begin
                                if "Package Calc Type" = "Package Calc Type"::Amount then begin
                                    EditPackageCalcAmount := true;
                                    EditPackageCalcPerc := false;
                                    "Package Percentage" := 0;
                                end
                                else begin
                                    EditPackageCalcAmount := false;
                                    EditPackageCalcPerc := true;
                                    "Package Amount" := 0;
                                end;
                            end;
                        }
                    }
                }
                field("Package Amount"; "Package Amount")
                {
                    ApplicationArea = All;
                    Editable = EditPackageCalcAmount;
                }
                field("Package Percentage"; "Package Percentage")
                {
                    ApplicationArea = All;
                    Editable = EditPackageCalcPerc;
                }
                field(Type; Type)
                {
                    ApplicationArea = All;
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
        SetFormulaEditable;
        FormulaForAttendance := GetFormulaForAttendance;
    end;

    trigger OnOpenPage()
    begin
        SetFormulaEditable
    end;

    var
        [InDataSet]
        EditFormula: Boolean;
        [InDataSet]
        EditUnitofMeasure: Boolean;
        [InDataSet]
        EditEarningCodeType: Boolean;
        [InDataSet]
        EditEarningCalcClass: Boolean;
        [InDataSet]
        EditCostofLiving: Boolean;
        [InDataSet]
        EditPackageCalcAmount: Boolean;
        [InDataSet]
        EditPackageCalcPerc: Boolean;
        FormulaForAttendance: Text;

    //commented By Avinash  [Scope('Internal')]
    procedure SetFormulaEditable()
    begin
        if "Earning Code Calc Subtype" = "Earning Code Calc Subtype"::Fixed then
            EditFormula := true
        else
            EditFormula := false;

        if "Unit Of Measure" = "Unit Of Measure"::" " then
            EditUnitofMeasure := true
        else
            EditUnitofMeasure := false;

        if "Pay Component Type" = "Pay Component Type"::"Cost of Living" then
            EditCostofLiving := true
        else
            EditCostofLiving := false;
    end;

    //commented By Avinash  [Scope('Internal')]
    procedure ValidateMandotoryFields()
    begin
        if "Earning Code" <> '' then begin
            TESTFIELD("Short Name");
            TESTFIELD(Description);
        end;
        if "Unit Of Measure" = "Unit Of Measure"::" " then
            ERROR('Please select Unit of Measure before closing the page');

        if "Earning Code Calc Class" = "Earning Code Calc Class"::" " then
            ERROR('Please select Earning Code Calculation Class closing the page');

        if "Earning Code Calc Subtype" = "Earning Code Calc Subtype"::" " then
            ERROR('Please select Earning Code Calculation subtype closing the page');

        if "Earning Code Type" = "Earning Code Type"::" " then
            ERROR('Please select Earning code type before closing the page');
    end;
}

