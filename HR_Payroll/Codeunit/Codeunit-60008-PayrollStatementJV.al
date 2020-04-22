codeunit 60008 "Payroll Statement JV"
{
    // version LT_Payroll


    trigger OnRun();
    begin
        if StatementID <> '' then begin
            AdvPayrollSetup.GET;
            GenJournalBatch.RESET;
            GenJournalBatch.SETRANGE("Journal Template Name", AdvPayrollSetup."Journal Template Name");
            GenJournalBatch.SETRANGE(Name, AdvPayrollSetup."Journal Batch Name");
            if GenJournalBatch.FINDFIRST then
                DocNo := NoSeriesManagement.GetNextNo(GenJournalBatch."No. Series", TODAY, true);
            PayrollStatementEmployee.RESET;
            PayrollStatementEmployee.SETRANGE("Payroll Statement ID", StatementID);
            if PayrollStatementEmployee.FINDSET then begin
                repeat
                    Employee.RESET;
                    Employee.SETRANGE("No.", PayrollStatementEmployee.Worker);
                    if Employee.FINDFIRST then begin
                        // // // PayrollStatementJV.SETTABLEVIEW(Employee);
                        // // // PayrollStatementJV.SetValues(DocNo, PayrollStatementEmployee."Payroll Statement ID");
                        // // // PayrollStatementJV.RUN;
                    end;
                until PayrollStatementEmployee.NEXT = 0;
            end;
        end;
        MESSAGE('Journal Created SuccessFully ');
    end;

    var
        StatementID: Code[20];
        PayrollStatementEmployee: Record "Payroll Statement Employee";
        //// PayrollStatementJV : Report "Payroll Statement JV";
        Employee: Record Employee;
        AdvPayrollSetup: Record "Advance Payroll Setup";
        GenJournalBatch: Record "Gen. Journal Batch";
        DocNo: Code[20];
        NoSeriesManagement: Codeunit NoSeriesManagement;

    procedure SetValue(l_StatementID: Code[20]);
    begin
        StatementID := l_StatementID;
    end;
}

