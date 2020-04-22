table 60046 "Payroll Statement Emp Trans."
{

    fields
    {
        field(1; "Payroll Statment Employee"; Code[20])
        {
        }
        field(2; "Line No."; Integer)
        {
        }
        field(3; "Payroll Statement ID"; Code[20])
        {
            TableRelation = "Payroll Statement";
        }
        field(4; "Payroll Pay Cycle"; Code[20])
        {
        }
        field(5; "Payroll Pay Period"; Code[20])
        {
        }
        field(6; "Payroll Year"; Integer)
        {
        }
        field(7; "Payroll Month"; Code[20])
        {
        }
        field(8; Worker; Code[20])
        {
            TableRelation = Employee;
        }
        field(9; "Employee Name"; Text[100])
        {
        }
        field(10; "From Date"; Date)
        {
        }
        field(11; "To Date"; Date)
        {
        }
        field(12; Voucher; Code[20])
        {
        }
        field(13; "Payroll Earning Code"; Code[20])
        {
        }
        field(14; "Payroll Earning Code Desc"; Text[100])
        {
        }
        field(15; "Earning Code Type"; Option)
        {
            OptionCaption = 'Pay Component,Benefit,Loan,Leave,Other';
            OptionMembers = "Pay Component",Benefit,Loan,Leave,Other;
        }
        field(16; "Earning Code Calc Sub Type"; Option)
        {
            OptionCaption = 'Fixed,Variable';
            OptionMembers = "Fixed",Variable;
        }
        field(17; "Earning Code Calc Class"; Option)
        {
            OptionCaption = 'Payroll,Non Payroll';
            OptionMembers = Payroll,"Non Payroll";
        }
        field(18; "Earniing Code Short Name"; Code[20])
        {
        }
        field(19; "Earning Code Arabic Name"; Code[20])
        {
        }
        field(20; "Benefit Code"; Code[20])
        {
        }
        field(21; "Benefit Description"; Text[100])
        {
        }
        field(22; "Benefit Short Name"; Text[100])
        {
        }
        field(23; "Benenfit Arabic Name"; Text[100])
        {
        }
        field(24; "Calculation Units"; Decimal)
        {
        }
        field(25; "Per Unit Amount"; Decimal)
        {
        }
        field(26; "Earning Code Amount"; Decimal)
        {
        }
        field(27; "Benefit Amount"; Decimal)
        {
        }
        field(28; Remarks; Text[100])
        {
        }
        field(29; "Calculation Basis Type"; Option)
        {
            OptionCaption = 'Days,Hours,Months';
            OptionMembers = Days,Hours,Months;
        }
        field(30; "Fin Accural Required"; Boolean)
        {
        }
        field(31; "Default Dimension"; Code[20])
        {
        }
        field(32; "Payroll Component Type"; Option)
        {
            OptionCaption = 'Pay Component,Benefit,Pay Adjustment,Benefit Adjustment,Loan,Other Adjustment';
            OptionMembers = "Pay Component",Benefit,"Pay Adjustment","Benefit Adjustment",Loan,"Other Adjustment";
        }
        field(33; RefRecID; Integer)
        {
        }
        field(34; "Payroll Transaction Type"; Option)
        {
            OptionCaption = 'Normal,Arrears,Final Settlement Current Payroll, Final Settlement Accrued,Benefit Claims';
            OptionMembers = Normal,Arrears,"Final Settlement Current Payroll"," Final Settlement Accrued","Benefit Claims";
        }
        field(35; "Benefit Encashment Amount"; Decimal)
        {
        }
        field(36; Pension; Option)
        {
            OptionCaption = 'None,Employee Contribution,Employer Contribution';
            OptionMembers = "None","Employee Contribution","Employer Contribution";
        }
        field(37; "Suspend Payroll"; Boolean)
        {
        }
        field(38; "Temporary Payroll Hold"; Boolean)
        {
        }
        field(39; "Currency Code"; Code[20])
        {
        }
        field(100; "Payroll Period RecID"; Integer)
        {
        }
    }

    keys
    {
        key(Key1; "Payroll Statement ID", "Payroll Statment Employee", "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

