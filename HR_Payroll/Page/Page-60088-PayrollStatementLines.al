page 60088 "Payroll Statement Lines"
{
    AutoSplitKey = true;
    PageType = ListPart;
    SourceTable = "Payroll Statement Lines";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Payroll Statement ID"; "Payroll Statement ID")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field(Worker; Worker)
                {
                    ApplicationArea = All;
                }
                field("Employee Name"; "Employee Name")
                {
                    ApplicationArea = All;
                }
                field("Payroll Statment Employee"; "Payroll Statment Employee")
                {
                    ApplicationArea = All;
                }
                field("Line No."; "Line No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Payroll Pay Cycle"; "Payroll Pay Cycle")
                {
                    ApplicationArea = All;
                }
                field("Payroll Pay Period"; "Payroll Pay Period")
                {
                    ApplicationArea = All;
                }
                field("Payroll Year"; "Payroll Year")
                {
                    ApplicationArea = All;
                }
                field("Payroll Month"; "Payroll Month")
                {
                    ApplicationArea = All;
                }
                field(Voucher; Voucher)
                {
                    ApplicationArea = All;
                }
                field("Payroll Earning Code"; "Payroll Earning Code")
                {
                    ApplicationArea = All;
                }
                field("Payroll Earning Code Desc"; "Payroll Earning Code Desc")
                {
                    ApplicationArea = All;
                }
                field("Earning Code Type"; "Earning Code Type")
                {
                    ApplicationArea = All;
                }
                field("Earning Code Calc Sub Type"; "Earning Code Calc Sub Type")
                {
                    ApplicationArea = All;
                }
                field("Earning Code Calc Class"; "Earning Code Calc Class")
                {
                    ApplicationArea = All;
                }
                field("Earniing Code Short Name"; "Earniing Code Short Name")
                {
                    ApplicationArea = All;
                }
                field("Earning Code Arabic Name"; "Earning Code Arabic Name")
                {
                    ApplicationArea = All;
                }
                field("Benefit Code"; "Benefit Code")
                {
                    ApplicationArea = All;
                }
                field("Benefit Description"; "Benefit Description")
                {
                    ApplicationArea = All;
                }
                field("Benefit Short Name"; "Benefit Short Name")
                {
                }
                field("Benenfit Arabic Name"; "Benenfit Arabic Name")
                {
                    ApplicationArea = All;
                }
                field("Calculation Units"; "Calculation Units")
                {
                    ApplicationArea = All;
                }
                field("Per Unit Amount"; "Per Unit Amount")
                {
                    ApplicationArea = All;
                }
                field("Earning Code Amount"; "Earning Code Amount")
                {
                    ApplicationArea = All;
                }
                field("Benefit Amount"; "Benefit Amount")
                {
                    ApplicationArea = All;
                }
                field(Remarks; Remarks)
                {
                    ApplicationArea = All;
                }
                field("Calculation Basis Type"; "Calculation Basis Type")
                {
                    ApplicationArea = All;
                }
                field("Fin Accural Required"; "Fin Accural Required")
                {
                    ApplicationArea = All;
                }
                field("Default Dimension"; "Default Dimension")
                {
                    ApplicationArea = All;
                }
                field("Payroll Transaction Type"; "Payroll Transaction Type")
                {
                    ApplicationArea = All;
                }
                field("Benefit Encashment Amount"; "Benefit Encashment Amount")
                {
                    ApplicationArea = All;
                }
                field(Pension; Pension)
                {
                    ApplicationArea = All;
                }
                field("Suspend Payroll"; "Suspend Payroll")
                {
                    ApplicationArea = All;
                }
                field("Temporary Payroll Hold"; "Temporary Payroll Hold")
                {
                    ApplicationArea = All;
                }
                field("Currency Code"; "Currency Code")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}

