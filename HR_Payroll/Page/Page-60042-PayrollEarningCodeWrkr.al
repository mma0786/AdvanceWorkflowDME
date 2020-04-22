page 60042 "Payroll Earning Code Wrkr"
{
    PageType = Card;
    SourceTable = "Payroll Earning Code Wrkr";
    UsageCategory = Documents;
    ApplicationArea = All;


    layout
    {
        area(content)
        {
            group(General)
            {
                field(Worker; Worker)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Earning Code Group"; "Earning Code Group")
                {
                    ApplicationArea = All;
                }
                field("Earning Code"; "Earning Code")
                {
                    ApplicationArea = All;
                    Editable = "Earning Code" = '';
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
                }
            }
            group("Pay Component")
            {
                grid(Control36)
                {
                    group(Control35)
                    {
                        field("Formula For Package"; "Formula For Package")
                        {
                            ApplicationArea = All;
                            Editable = EditFormula;
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
                            Editable = EditFormula;
                            MultiLine = true;
                            Width = 500;
                        }
                        field("Package Calc Type"; "Package Calc Type")
                        {
                            ApplicationArea = All;

                            trigger OnValidate()
                            begin

                                IF "Package Calc Type" = "Package Calc Type"::Amount THEN BEGIN
                                    EditPackageCalcAmount := TRUE;
                                    EditPackageCalcPerc := FALSE;
                                    "Package Percentage" := 0;
                                END
                                ELSE BEGIN
                                    EditPackageCalcAmount := FALSE;
                                    EditPackageCalcPerc := TRUE;
                                    "Package Amount" := 0;
                                END;


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
        // SETFILTER("Valid From" , '<=%1', WORKDATE);
        // SETFILTER("Valid To" , '>%1|%2', WORKDATE, 0D);

        SetFormulaEditable;
    end;

    var
        EditFormula: Boolean;
        EditUnitofMeasure: Boolean;
        EditEarningCodeType: Boolean;
        EditEarningCalcClass: Boolean;
        EditCostofLiving: Boolean;
        EditPackageCalcAmount: Boolean;
        EditPackageCalcPerc: Boolean;
        FormulaForAttendance: Text;
        EarningCodeGroup: Record "Earning Code Groups";

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


        EarningCodeGroup.RESET;
        EarningCodeGroup.SETRANGE("Earning Code Group", Rec."Earning Code Group");
        if EarningCodeGroup.FINDFIRST then begin
            if EarningCodeGroup."Edit Service Package" then
                EditPackageCalcAmount := true
            else
                EditPackageCalcAmount := false;
        end;
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

