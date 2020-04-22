table 60093 "FS Loans"
{

    fields
    {
        field(1; "Employee No."; Code[20])
        {
        }
        field(2; "Employee Name"; Text[100])
        {
        }
        field(3; "Loan Request ID"; Code[20])
        {
        }
        field(4; Loan; Code[20])
        {
        }
        field(5; "EMI Amount"; Decimal)
        {
        }
        field(6; "Interest Amount"; Decimal)
        {
        }
        field(7; "Installment Amount"; Decimal)
        {
        }
        field(8; Currency; Code[20])
        {
        }
        field(9; "Earning Code Group"; Code[20])
        {
        }
        field(10; "EmployeeEarning Code"; Code[20])
        {
        }
        field(20; "Journal ID"; Code[20])
        {
        }
        field(21; "Payroll Period RecID"; Integer)
        {
        }
        field(22; "Installment Date"; Date)
        {
        }
    }

    keys
    {
        key(Key1; "Journal ID", "Employee No.", Loan, "Payroll Period RecID", "EmployeeEarning Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        PayCycle: Record "Pay Cycles";
        PayPeriods: Record "Pay Periods";
        Employee: Record Employee;
        EmployeeEarningCodeGroups: Record "Employee Earning Code Groups";
}

