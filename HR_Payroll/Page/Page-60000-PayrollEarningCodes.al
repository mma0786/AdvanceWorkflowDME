page 60000 "Payroll Earning Codes"
{
    CardPageID = "Payroll Earning Code";
    Editable = false;
    PageType = List;
    SourceTable = "Payroll Earning Code";
    UsageCategory = Documents;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Earning Code"; "Earning Code")
                {
                    ApplicationArea = All;
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                }
                field("Arabic name"; "Arabic name")
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
                field(Active; Active)
                {
                    ApplicationArea = All;
                }
                field("Formula For Package"; "Formula For Package")
                {
                    Visible = false;
                }
                field("Formula For Atttendance"; "Formula For Atttendance")
                {
                    Visible = false;
                }
                field(RefRecId; RefRecId)
                {
                    Visible = false;
                }
                field(RefTableId; RefTableId)
                {
                    Visible = false;
                }
                field("Formula For Days"; "Formula For Days")
                {
                    Visible = false;
                }
                field(WPSType; WPSType)
                {
                    Visible = false;
                }
                field("Short Name"; "Short Name")
                {
                    ApplicationArea = All;
                }
            }
        }
    }


}

