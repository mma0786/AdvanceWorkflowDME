table 60044 "Payroll Statement"
{

    fields
    {
        field(1; "Payroll Statement ID"; Code[20])
        {

            trigger OnValidate()
            begin
                GetPayrollSetup;
                if "Payroll Statement ID" = '' then
                    "Payroll Statement ID" := NoSeriesManagement.GetNextNo(AdvPayrollSetup."Payroll Statement No. Series", TODAY, true);
            end;
        }
        field(2; "Payroll Statement Description"; Text[200])
        {
        }
        field(3; "Pay Cycle"; Code[20])
        {
            TableRelation = "Pay Cycles";
        }
        field(4; "Pay Period"; Code[20])
        {
            TableRelation = "Pay Periods" WHERE("Pay Cycle" = FIELD("Pay Cycle"));
        }
        field(7; Status; Option)
        {
            OptionCaption = 'Open,Processing,Draft,Confirmed,Posted,Cancelled';
            OptionMembers = Open,Processing,Draft,Confirmed,Posted,Cancelled;
        }
        field(8; "Is Opening"; Boolean)
        {
        }
        field(11; "Created Date and Time"; DateTime)
        {
        }
        field(12; "Created By"; Code[30])
        {
        }
        field(13; "Workflow Status"; Option)
        {
            OptionCaption = 'Open,Pending Approval,Change Requested,Approved';
            OptionMembers = Open,"Pending Approval","Change Requested",Approved;
        }
        field(16; "Payment Status"; Option)
        {
            OptionCaption = 'Not Paid,Paid';
            OptionMembers = "Not Paid",Paid;
        }
        field(17; "Pay Period Start Date"; Date)
        {
        }
        field(18; "Pay Period End Date"; Date)
        {
        }
        field(19; "Statement Type"; Option)
        {
            OptionCaption = ' ,Payroll, Final Settlement';
            OptionMembers = " ",Payroll," Final Settlement";
        }
        field(20; "Last Run Date and Time"; DateTime)
        {
        }
        field(21; "Last Run User ID"; Text[50])
        {
            TableRelation = User."User Name";
        }
        field(22; "Payroll Period"; Text[250])
        {

            trigger OnLookup()
            begin
                PayPeriods.FILTERGROUP(2);
                PayPeriods.RESET;
                PayPeriods.SETRANGE("Pay Cycle", Rec."Pay Cycle");
                PayPeriods.FILTERGROUP(0);

                if PAGE.RUNMODAL(60071, PayPeriods) = ACTION::LookupOK then begin
                    VALIDATE("Pay Period", PayPeriods."Pay Cycle");
                    VALIDATE("Payroll Period", PayPeriods."Pay Cycle" + ': ' + FORMAT(PayPeriods."Period Start Date") + '-' + FORMAT(PayPeriods."Period End Date"));
                    VALIDATE("Pay Period Start Date", PayPeriods."Period Start Date");
                    VALIDATE("Pay Period End Date", PayPeriods."Period End Date");
                    VALIDATE("Payroll Period RecID", PayPeriods."Line No.");
                end;
            end;

            trigger OnValidate()
            begin
                if "Payroll Period" = '' then begin
                    "Pay Period Start Date" := 0D;
                    "Pay Period End Date" := 0D;
                    "Payroll Period" := '';
                    "Pay Period" := '';
                    "Payroll Period RecID" := 0;
                end;
            end;
        }
        field(100; "Payroll Period RecID"; Integer)
        {
        }
        field(101; Confirmed; Boolean)
        {
        }
        field(102; Posted; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; "Payroll Statement ID")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        if "Workflow Status" <> "Workflow Status"::Open then
            ERROR(DelErr);

        if Status <> Status::Open then
            ERROR(DelErr2);

        PayrollStatementEmployee.RESET;
        PayrollStatementEmployee.SETRANGE("Payroll Statement ID", Rec."Payroll Statement ID");
        PayrollStatementEmployee.DELETEALL;

        PayrollStatementTransLines.RESET;
        PayrollStatementTransLines.SETRANGE("Payroll Statement ID", Rec."Payroll Statement ID");
        PayrollStatementTransLines.DELETEALL;

        PayrollStatementLines.RESET;
        PayrollStatementLines.SETRANGE("Payroll Statement ID", Rec."Payroll Statement ID");
        PayrollStatementLines.DELETEALL;

        PayrollErrorLog.RESET;
        PayrollErrorLog.SETRANGE("Payroll Statement ID", Rec."Payroll Statement ID");
        PayrollErrorLog.DELETEALL;
    end;

    trigger OnInsert()
    begin
        GetPayrollSetup;
        if "Payroll Statement ID" = '' then
            "Payroll Statement ID" := NoSeriesManagement.GetNextNo(AdvPayrollSetup."Payroll Statement No. Series", TODAY, true);

        "Created By" := USERID;
        "Created Date and Time" := CREATEDATETIME(TODAY, TIME);
    end;

    var
        AdvPayrollSetup: Record "Advance Payroll Setup";
        NoSeriesManagement: Codeunit NoSeriesManagement;
        PayrollSetupGet: Boolean;
        PayCycle: Record "Pay Cycles";
        PayPeriods: Record "Pay Periods";
        PayrollStatementLines: Record "Payroll Statement Lines";
        PayrollStatementTransLines: Record "Payroll Statement Emp Trans.";
        PayrollStatementEmployee: Record "Payroll Statement Employee";
        DelErr: Label 'The WorkFlow Status should be Open';
        DelErr2: Label 'The Status Shold be Open';
        PayrollErrorLog: Record "Payroll Error Log";

    local procedure GetPayrollSetup()
    begin
        if not PayrollSetupGet then begin
            AdvPayrollSetup.GET;
            AdvPayrollSetup.TESTFIELD("Payroll Statement No. Series");
            PayrollSetupGet := true;
        end;
    end;


    procedure Reopen(var Rec: Record "Payroll Statement")
    begin
        with Rec do begin
            if "Workflow Status" = "Workflow Status"::Open then
                exit;
            "Workflow Status" := "Workflow Status"::Open;
        end;
    end;


    procedure ConfirmPayroll(var PayrollStatement: Record "Payroll Statement")
    var
        EmployeeEarningCodeGroup: Record "Employee Earning Code Groups";
        EmployeeLoans: Record "HCM Loan Table GCC Wrkr";
        LoanInstallmentGeneration: Record "Loan Installment Generation";
        LoanSetup: Record "Loan Type Setup";
    begin
        with PayrollStatement do begin
            PayrollStatement.Confirmed := true;
            PayrollStatement.Status := PayrollStatement.Status::Confirmed;
            PayrollStatement.MODIFY;
            PayrollStatementEmployee.RESET;
            PayrollStatementEmployee.SETRANGE("Payroll Statement ID", Rec."Payroll Statement ID");
            if PayrollStatementEmployee.FINDFIRST then
                repeat
                    EmployeeEarningCodeGroup.RESET;
                    EmployeeEarningCodeGroup.SETCURRENTKEY("Employee Code", "Valid From", "Valid To");
                    EmployeeEarningCodeGroup.SETRANGE("Employee Code", PayrollStatementEmployee.Worker);
                    EmployeeEarningCodeGroup.SETFILTER("Valid From", '<=%1', NORMALDATE(Rec."Pay Period End Date"));
                    EmployeeEarningCodeGroup.SETFILTER("Valid To", '>=%1|%2', NORMALDATE(Rec."Pay Period End Date"), 0D);
                    if EmployeeEarningCodeGroup.FINDFIRST then begin
                        EmployeeLoans.RESET;
                        EmployeeLoans.SETRANGE("Earning Code Group", EmployeeEarningCodeGroup."Earning Code Group");
                        EmployeeLoans.SETRANGE(Worker, PayrollStatementEmployee.Worker);
                        if EmployeeLoans.FINDFIRST then
                            repeat
                                LoanInstallmentGeneration.RESET;
                                LoanInstallmentGeneration.SETRANGE("Employee ID", EmployeeLoans.Worker);
                                LoanInstallmentGeneration.SETRANGE("Installament Date", PayrollStatement."Pay Period Start Date", NORMALDATE(PayrollStatement."Pay Period End Date"));
                                LoanInstallmentGeneration.SETRANGE(Loan, EmployeeLoans."Loan Code");
                                if LoanInstallmentGeneration.FINDFIRST then
                                    repeat
                                        LoanSetup.GET(LoanInstallmentGeneration.Loan);
                                        LoanSetup.TESTFIELD("Earning Code for Principal");
                                        LoanInstallmentGeneration.Status := LoanInstallmentGeneration.Status::Recovered;
                                        LoanInstallmentGeneration.MODIFY;
                                    until LoanInstallmentGeneration.NEXT = 0;
                            until EmployeeLoans.NEXT = 0;
                    end;
                until PayrollStatementEmployee.NEXT = 0;
        end;
    end;
}

