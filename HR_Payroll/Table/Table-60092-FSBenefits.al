table 60092 "FS Benefits"
{

    fields
    {
        field(1; "Employee No."; Code[20])
        {
        }
        field(2; "Employee Name"; Text[100])
        {
        }
        field(3; "Benefit Code"; Code[20])
        {
        }
        field(4; "Benefit Description"; Text[100])
        {
        }
        field(5; "Ben. Earning Code"; Code[20])
        {
        }
        field(6; "Ben. Earning Description"; Text[100])
        {
        }
        field(7; "Transaction Type"; Option)
        {
            OptionCaption = 'Normal,Arrears,FS Current Payroll,FS Accrued,Benefit Claims';
            OptionMembers = Normal,Arrears,"FS Current Payroll","FS Accrued","Benefit Claims";
        }
        field(8; "Calculation Unit"; Decimal)
        {
        }
        field(9; "Benefit Amount"; Decimal)
        {
        }
        field(10; "Payable Amount"; Decimal)
        {
        }
        field(11; Currency; Code[20])
        {
        }
        field(12; "Suspend Payroll"; Boolean)
        {
        }
        field(13; "Earning Code Group"; Code[20])
        {
        }
        field(20; "Journal ID"; Code[20])
        {
        }
        field(21; "Payroll Period RecID"; Integer)
        {
        }
    }

    keys
    {
        key(Key1; "Journal ID", "Employee No.", "Benefit Code", "Payroll Period RecID")
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

