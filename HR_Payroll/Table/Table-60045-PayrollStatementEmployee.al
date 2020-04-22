table 60045 "Payroll Statement Employee"
{

    fields
    {
        field(1; "Payroll Statement ID"; Code[20])
        {
            TableRelation = "Payroll Statement";
        }
        field(2; "Payroll Pay Cycle"; Code[20])
        {
        }
        field(3; "Payroll Pay Period"; Code[20])
        {
        }
        field(4; "Payroll Year"; Integer)
        {
        }
        field(5; "Payroll Month"; Code[20])
        {
        }
        field(6; Status; Option)
        {
            OptionCaption = 'Draft,Open,Confirmed,Posted,Processing,Cancelled';
            OptionMembers = Draft,Open,Created,Posted,Processing,Cancelled;
        }
        field(7; Worker; Code[20])
        {
            TableRelation = Employee;
        }
        field(8; "Employee Name"; Text[100])
        {
        }
        field(9; Voucher; Code[20])
        {
        }
        field(10; "Currency Code"; Code[20])
        {
        }
        field(11; "Pay Period Start Date"; Date)
        {
        }
        field(12; "Pay Period End Date"; Date)
        {
        }
        field(13; "Paid Status"; Option)
        {
            OptionCaption = 'Paid,Unpaid';
            OptionMembers = Paid,Unpaid;
        }
        field(100; "Payroll Period RecID"; Integer)
        {
        }
    }

    keys
    {
        key(Key1; "Payroll Statement ID", "Payroll Pay Cycle", "Payroll Pay Period", Worker)
        {
            Clustered = true;
        }
        key(Key2; Worker, "Payroll Period RecID")
        {
        }
        key(Key3; Worker, "Pay Period Start Date", Status)
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        PayrollStatement.RESET;
        PayrollStatement.SETRANGE("Payroll Statement ID", Rec."Payroll Statement ID");
        if PayrollStatement.FINDFIRST then begin
            PayrollStatement.TESTFIELD("Workflow Status", PayrollStatement."Workflow Status"::Open);
        end;

        PayrollStatementTransLines.RESET;
        PayrollStatementTransLines.SETRANGE("Payroll Statement ID", Rec."Payroll Statement ID");
        PayrollStatementTransLines.SETRANGE("Payroll Statment Employee", Rec.Worker);
        PayrollStatementTransLines.DELETEALL;

        PayrollStatementLines.RESET;
        PayrollStatementLines.SETRANGE("Payroll Statement ID", Rec."Payroll Statement ID");
        PayrollStatementLines.SETRANGE("Payroll Statment Employee", Rec.Worker);
        PayrollStatementLines.DELETEALL;

        PayrollErrorLog.RESET;
        PayrollErrorLog.SETRANGE("Payroll Statement ID", Rec."Payroll Statement ID");
        PayrollErrorLog.DELETEALL;
    end;

    var
        PayrollStatementTransLines: Record "Payroll Statement Emp Trans.";
        PayrollStatementLines: Record "Payroll Statement Lines";
        PayrollStatement: Record "Payroll Statement";
        PayrollErrorLog: Record "Payroll Error Log";
}

