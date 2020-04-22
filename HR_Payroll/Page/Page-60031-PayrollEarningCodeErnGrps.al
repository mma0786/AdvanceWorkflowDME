page 60031 "Payroll Earning Code ErnGrps"
{
    CardPageID = "Payroll Earning Code ErnGrp";
    Editable = false;
    PageType = List;
    SourceTable = "Payroll Earning Code ErnGrp";
    UsageCategory = Lists;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Earning Code Group"; "Earning Code Group")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Earning Code"; "Earning Code")
                {
                    ApplicationArea = All;
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                }
                field("Short Name"; "Short Name")
                {
                    ApplicationArea = All;
                }
                field("Pay Component Type"; "Pay Component Type")
                {
                    ApplicationArea = All;
                }
                field("Fin Accrual Required"; "Fin Accrual Required")
                {
                    ApplicationArea = All;
                }
                field("FF Adjustment Required"; "FF Adjustment Required")
                {
                    ApplicationArea = All;
                }
                field("Earning Code Calc Subtype"; "Earning Code Calc Subtype")
                {
                    ApplicationArea = All;
                }
                field("Earning Code Calc Class"; "Earning Code Calc Class")
                {
                    ApplicationArea = All;
                }
                field("Rounding Method"; "Rounding Method")
                {
                    ApplicationArea = All;
                }
                field("Decimal Rounding"; "Decimal Rounding")
                {
                    ApplicationArea = All;
                }
                field("Minimum Value"; "Minimum Value")
                {
                    ApplicationArea = All;
                }
                field("Maximum Value"; "Maximum Value")
                {
                    ApplicationArea = All;
                }
                field(IsSysComponent; IsSysComponent)
                {
                    ApplicationArea = All;
                }
                field("Formula For Package"; "Formula For Package")
                {
                    ApplicationArea = All;
                    MultiLine = true;
                    Width = 500;
                }
                field("Formula for Attendance"; FormulaForAttendance)
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
                field(Active; Active)
                {
                    ApplicationArea = All;
                }
                field(WPSType; WPSType)
                {
                    ApplicationArea = All;
                }
                field("Arabic name"; "Arabic name")
                {
                    ApplicationArea = All;
                }
            }
        }
    }



    trigger OnAfterGetRecord()
    begin
        FormulaForAttendance := GetFormulaForAttendance;
    end;

    var
        FormulaForAttendance: Text;
}

