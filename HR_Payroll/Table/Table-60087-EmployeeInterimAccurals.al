table 60087 "Employee Interim Accurals"
{

    fields
    {
        field(1; "Worker ID"; Code[20])
        {
            TableRelation = Employee;
        }
        field(2; "Line No."; Integer)
        {
        }
        field(3; Month; Integer)
        {
        }
        field(4; "Start Date"; Date)
        {
        }
        field(5; "End Date"; Date)
        {
        }
        field(6; "Opening Balance Unit"; Decimal)
        {
        }
        field(7; "Opening Balance Amount"; Decimal)
        {
        }
        field(8; "Carryforward Deduction"; Decimal)
        {
        }
        field(9; "Monthly Accrual Units"; Decimal)
        {
        }
        field(10; "Monthly Accrual Amount"; Decimal)
        {
        }
        field(11; "Adjustment Units"; Decimal)
        {
        }
        field(12; "Adjustment Amount"; Decimal)
        {
        }
        field(13; "Leaves Consumed Units"; Decimal)
        {
        }
        field(14; "Leaves Consumed Amount"; Decimal)
        {
        }
        field(15; "Closing Balance"; Decimal)
        {
        }
        field(16; "Carryforward Month"; Boolean)
        {
        }
        field(17; "Max Carryforward"; Decimal)
        {
        }
        field(18; "Accrual ID"; Code[20])
        {
            TableRelation = "Accrual Components";
        }
        field(19; "Accrual Basis Date"; Date)
        {
        }
        field(20; "Accrual Interval Basis Date"; Date)
        {
        }
        field(21; "Seq No"; Integer)
        {
        }
        field(22; "Closing Balance Amount"; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "Accrual ID", "Worker ID", "Line No.")
        {
            Clustered = true;
        }
        key(Key2; Month, "Seq No")
        {
        }
    }

    fieldgroups
    {
    }
}

