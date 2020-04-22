page 60086 "Payroll Statement Emp. List"
{
    Caption = 'Payroll Employees';
    PageType = ListPart;
    SourceTable = "Payroll Statement Employee";

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
                field("Payroll Pay Cycle"; "Payroll Pay Cycle")
                {
                    ApplicationArea = All;
                }
                field("Payroll Pay Period"; "Payroll Pay Period")
                {
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
                field("Payroll Year"; "Payroll Year")
                {
                    ApplicationArea = All;
                }
                field("Payroll Month"; "Payroll Month")
                {
                    ApplicationArea = All;
                }
                field(Status; Status)
                {
                    ApplicationArea = All;
                }
                field(Voucher; Voucher)
                {
                    ApplicationArea = All;
                }
                field("Currency Code"; "Currency Code")
                {
                    ApplicationArea = All;
                }
                field("Pay Period Start Date"; "Pay Period Start Date")
                {
                    ApplicationArea = All;
                }
                field("Pay Period End Date"; "Pay Period End Date")
                {
                    ApplicationArea = All;
                }
                field("Paid Status"; "Paid Status")
                {
                    ApplicationArea = All;
                }
            }
        }
    }


}

