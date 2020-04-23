report 70001 "Generate Payroll Statement DLL"
{
    // version LT_Payroll

    ProcessingOnly = true;

    dataset
    {
        dataitem(Employee; Employee)
        {

            RequestFilterFields = "No.";

            trigger OnAfterGetRecord();
            begin

                //Progress Bar
                Counter += 1;
                Window.UPDATE(1, ROUND(Counter / TotalRecords * 10000, 1));
                //Progress Bar
                //>>>Commented till Live for process testing

                if (Employee."Joining Date" >= NORMALDATE(PayrollStatement."Pay Period End Date")) then begin
                    PayrollErrorLog.INIT;
                    PayrollErrorLog."Entry No." := 0;
                    PayrollErrorLog."Payroll Statement ID" := PayrollStatement."Payroll Statement ID";
                    PayrollErrorLog."HCM Worker" := Employee."No.";
                    PayrollErrorLog.Error := 'Employee Joining Date is not valid in the current period';
                    PayrollErrorLog.INSERT;
                    CurrReport.SKIP;
                end;
                if Employee."Termination Date" <> 0D then begin
                    if (Employee."Termination Date" <= PayrollStatement."Pay Period Start Date") then begin
                        PayrollErrorLog.INIT;
                        PayrollErrorLog."Entry No." := 0;
                        PayrollErrorLog."Payroll Statement ID" := PayrollStatement."Payroll Statement ID";
                        PayrollErrorLog."HCM Worker" := Employee."No.";
                        PayrollErrorLog.Error := 'Employee Termination Date is not valid in the current period';
                        PayrollErrorLog.INSERT;
                        CurrReport.SKIP;
                    end;
                    if (Employee."Hold Payment from Date" <= PayrollStatement."Pay Period Start Date") then begin
                        PayrollErrorLog.INIT;
                        PayrollErrorLog."Entry No." := 0;
                        PayrollErrorLog."Payroll Statement ID" := PayrollStatement."Payroll Statement ID";
                        PayrollErrorLog."HCM Worker" := Employee."No.";
                        PayrollErrorLog.Error := 'Employee payroll is in hold for current period';
                        PayrollErrorLog.INSERT;
                        CurrReport.SKIP;
                    end;
                end;
                PositionWorkerAssignment.RESET;
                PositionWorkerAssignment.SETCURRENTKEY(Worker, "Effective Start Date", "Effective End Date");
                PositionWorkerAssignment.SETRANGE(Worker, Employee."No.");
                PositionWorkerAssignment.SETFILTER("Effective Start Date", '<=%1', NORMALDATE(PayrollStatement."Pay Period End Date"));
                PositionWorkerAssignment.SETFILTER("Effective End Date", '>=%1|%2', NORMALDATE(PayrollStatement."Pay Period End Date"), 0D);
                if PositionWorkerAssignment.FINDFIRST then begin
                    if PayrollPosition.GET(PositionWorkerAssignment."Position ID") then begin
                        if PayrollPosition."Pay Cycle" <> PayrollStatement."Pay Cycle" then begin
                            /*
                            PayrollErrorLog.INIT;
                            PayrollErrorLog."Entry No." := 0;
                            PayrollErrorLog."Payroll Statement ID" := PayrollStatement."Payroll Statement ID";
                            PayrollErrorLog."HCM Worker" := Employee."No.";
                            PayrollErrorLog.Error := 'Payroll Statement Pay Cycle is different from employee assigned position pay cycle';
                            PayrollErrorLog.INSERT;
                            */
                            CurrReport.SKIP;
                        end;
                    end
                    else begin
                        PayrollErrorLog.INIT;
                        PayrollErrorLog."Entry No." := 0;
                        PayrollErrorLog."Payroll Statement ID" := PayrollStatement."Payroll Statement ID";
                        PayrollErrorLog."HCM Worker" := Employee."No.";
                        PayrollErrorLog.Error := 'Payroll Position doesnot exist';
                        PayrollErrorLog.INSERT;
                        CurrReport.SKIP;
                    end;
                    PayPeriods.RESET;
                    PayPeriods.SETCURRENTKEY("Pay Cycle", "Period Start Date");
                    PayPeriods.SETRANGE("Pay Cycle", PayrollPosition."Pay Cycle");
                    PayPeriods.SETRANGE("Period Start Date", PayrollStatement."Pay Period Start Date", NORMALDATE(PayrollStatement."Pay Period End Date"));
                    //PayPeriods.SETRANGE("Period End Date",PayrollStatement."Pay Period Start Date",NORMALDATE(PayrollStatement."Pay Period End Date"));
                    if not PayPeriods.FINDFIRST then begin
                        PayrollErrorLog.INIT;
                        PayrollErrorLog."Entry No." := 0;
                        PayrollErrorLog."Payroll Statement ID" := PayrollStatement."Payroll Statement ID";
                        PayrollErrorLog."HCM Worker" := Employee."No.";
                        PayrollErrorLog.Error := 'There is no active Pay Periods for this employee';
                        PayrollErrorLog.INSERT;
                        CurrReport.SKIP;
                    end;
                end
                else begin
                    PayrollErrorLog.INIT;
                    PayrollErrorLog."Entry No." := 0;
                    PayrollErrorLog."Payroll Statement ID" := PayrollStatement."Payroll Statement ID";
                    PayrollErrorLog."HCM Worker" := Employee."No.";
                    PayrollErrorLog.Error := 'There is no active Position assigned for this employee';
                    PayrollErrorLog.INSERT;
                    CurrReport.SKIP;
                    CurrReport.SKIP;
                end;
                PayrollStatementEmployee.RESET;
                PayrollStatementEmployee.SETCURRENTKEY(Worker, "Payroll Period RecID");
                PayrollStatementEmployee.SETRANGE(Worker, Employee."No.");
                PayrollStatementEmployee.SETRANGE("Payroll Period RecID", PayrollStatement."Payroll Period RecID");
                //PayrollStatementEmployee.SETRANGE(Status,PayrollStatementEmployee.Status::Posted,PayrollStatementEmployee.Status::Posted);
                if PayrollStatementEmployee.FINDFIRST then begin
                    PayrollErrorLog.INIT;
                    PayrollErrorLog."Entry No." := 0;
                    PayrollErrorLog."Payroll Statement ID" := PayrollStatement."Payroll Statement ID";
                    PayrollErrorLog."HCM Worker" := Employee."No.";
                    PayrollErrorLog.Error := 'Payroll Statement exist for this employee for the Period';
                    PayrollErrorLog.INSERT;
                    CurrReport.SKIP;
                end;

                if (Employee."Joining Date" < PayrollStatement."Pay Period Start Date") then begin
                    PayrollStatementEmployee.RESET;
                    PayrollStatementEmployee.SETCURRENTKEY(Worker, "Payroll Period RecID");
                    PayrollStatementEmployee.SETRANGE(Worker, Employee."No.");
                    if PayrollStatementEmployee.FINDFIRST then begin
                        PayrollStatementEmployee.RESET;
                        PayrollStatementEmployee.SETRANGE("Pay Period Start Date", CALCDATE('-CM', PayrollStatement."Pay Period Start Date" - 1));
                        //PayrollStatementEmployee.SETRANGE(Status,PayrollStatementEmployee.Status::Posted,PayrollStatementEmployee.Status::Posted);
                        if not PayrollStatementEmployee.FINDFIRST then begin
                            PayrollErrorLog.INIT;
                            PayrollErrorLog."Entry No." := 0;
                            PayrollErrorLog."Payroll Statement ID" := PayrollStatement."Payroll Statement ID";
                            PayrollErrorLog."HCM Worker" := Employee."No.";
                            PayrollErrorLog.Error := 'Pay Statement not created for this employee for the previous Period';
                            PayrollErrorLog.INSERT;
                            CurrReport.SKIP;
                        end;
                    end;
                end;


                FullandFinalCalculation.RESET;
                FullandFinalCalculation.SETRANGE("Employee No.", Employee."No.");
                FullandFinalCalculation.SETRANGE("Pay Period Start Date", PayrollStatement."Pay Period Start Date");
                FullandFinalCalculation.SETRANGE(Calculated, true);
                if FullandFinalCalculation.FINDFIRST then begin
                    PayrollErrorLog.INIT;
                    PayrollErrorLog."Entry No." := 0;
                    PayrollErrorLog."Payroll Statement ID" := PayrollStatement."Payroll Statement ID";
                    PayrollErrorLog."HCM Worker" := Employee."No.";
                    PayrollErrorLog.Error := 'Final Statement is created for this employee for the Period';
                    PayrollErrorLog.INSERT;
                    CurrReport.SKIP;
                end;

                PayrollStatementEmployee.RESET;
                PayrollStatementEmployee.SETCURRENTKEY(Worker, "Pay Period Start Date", Status);
                PayrollStatementEmployee.SETRANGE(Worker, Employee."No.");
                PayrollStatementEmployee.SETRANGE("Pay Period Start Date", CALCDATE('-CM', NORMALDATE(PayrollStatement."Pay Period End Date") + 1));
                PayrollStatementEmployee.SETRANGE(Status, PayrollStatementEmployee.Status::Posted, PayrollStatementEmployee.Status::Posted);
                if PayrollStatementEmployee.FINDFIRST then begin
                    PayrollErrorLog.INIT;
                    PayrollErrorLog."Entry No." := 0;
                    PayrollErrorLog."Payroll Statement ID" := PayrollStatement."Payroll Statement ID";
                    PayrollErrorLog."HCM Worker" := Employee."No.";
                    PayrollErrorLog.Error := 'Payroll Generated for ' + FORMAT(DATE2DMY(CALCDATE('-CM', NORMALDATE(PayrollStatement."Pay Period End Date") + 1), 2)) + ' Month, You cannot process back dated entry';
                    PayrollErrorLog.INSERT;
                    CurrReport.SKIP;
                end;


                EmployeeWorkDate.RESET;
                EmployeeWorkDate.SETCURRENTKEY("Employee Code", "Trans Date");
                EmployeeWorkDate.SETRANGE("Employee Code", Employee."No.");
                EmployeeWorkDate.SETRANGE("Trans Date", PayrollStatement."Pay Period Start Date", NORMALDATE(PayrollStatement."Pay Period End Date"));
                if not EmployeeWorkDate.FINDFIRST then begin
                    PayrollErrorLog.INIT;
                    PayrollErrorLog."Entry No." := 0;
                    PayrollErrorLog."Payroll Statement ID" := PayrollStatement."Payroll Statement ID";
                    PayrollErrorLog."HCM Worker" := Employee."No.";
                    PayrollErrorLog.Error := 'Employee Work Calendar is not created for this employee for the Period';
                    PayrollErrorLog.INSERT;
                    CurrReport.SKIP;
                end;

                EmployeeEarningCodeGroup.RESET;
                EmployeeEarningCodeGroup.SETCURRENTKEY("Employee Code", "Valid From", "Valid To");
                EmployeeEarningCodeGroup.SETRANGE("Employee Code", Employee."No.");
                EmployeeEarningCodeGroup.SETFILTER("Valid From", '<=%1', NORMALDATE(PayrollStatement."Pay Period End Date"));
                EmployeeEarningCodeGroup.SETFILTER("Valid To", '>=%1|%2', NORMALDATE(PayrollStatement."Pay Period End Date"), 0D);
                if EmployeeEarningCodeGroup.FINDFIRST then begin
                    if EmployeeEarningCodeGroup.Currency = '' then begin
                        PayrollErrorLog.INIT;
                        PayrollErrorLog."Entry No." := 0;
                        PayrollErrorLog."Payroll Statement ID" := PayrollStatement."Payroll Statement ID";
                        PayrollErrorLog."HCM Worker" := Employee."No.";
                        PayrollErrorLog.Error := 'There is no currency defined for the employee Earning Code Group';
                        PayrollErrorLog.INSERT;
                        CurrReport.SKIP;
                    end;
                end
                else begin
                    PayrollErrorLog.INIT;
                    PayrollErrorLog."Entry No." := 0;
                    PayrollErrorLog."Payroll Statement ID" := PayrollStatement."Payroll Statement ID";
                    PayrollErrorLog."HCM Worker" := Employee."No.";
                    PayrollErrorLog.Error := 'There is no active Earning Code Group defined for the employee in this Period';
                    PayrollErrorLog.INSERT;
                    CurrReport.SKIP;
                end;


                CLEAR(PositionWorkerAssignment);
                CLEAR(PayrollPosition);
                CLEAR(PayPeriods);
                CLEAR(PayrollStatementEmployee);
                CLEAR(FullandFinalCalculation);
                CLEAR(EmployeeWorkDate);
                CLEAR(EmployeeEarningCodeGroup);

                //>>>Commented till Live for process testing
                CreatePayrollStatementEmployees(Employee."No.", PayrollStatement);

            end;

            trigger OnPostDataItem();
            begin
                //Progress Bar
                Window.CLOSE;
                //Progress Bar
            end;

            trigger OnPreDataItem();
            begin
                //Instantiate;

                PayrollErrorLog.RESET;
                PayrollErrorLog.SETCURRENTKEY("Payroll Statement ID");
                PayrollErrorLog.SETRANGE("Payroll Statement ID", PayrollStatement."Payroll Statement ID");
                PayrollErrorLog.DELETEALL;


                //Progress Bar
                CLEAR(Counter);
                Window.OPEN(
                        'Processing Data' +
                        '@1@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@');
                TotalRecords := Employee.COUNT;
                //Progress Bar
            end;
        }
    }



    var
        PayrollStatement: Record "Payroll Statement";
        PayrollStatementEmployee: Record "Payroll Statement Employee";
        RecEmployee: Record Employee;
        PayrollStatementLines: Record "Payroll Statement Lines";
        PayrollStatementLines2: Record "Payroll Statement Lines";
        PayrollStatementTransLines: Record "Payroll Statement Emp Trans.";
        PositionWorkerAssignment: Record "Payroll Job Pos. Worker Assign";
        PayrollPosition: Record "Payroll Position";
        PayPeriods: Record "Pay Periods";
        EmployeeEarningCodeGroup: Record "Employee Earning Code Groups";
        EmployeeEarningCodes: Record "Payroll Earning Code Wrkr";
        EmployeeLeaveTypes: Record "HCM Leave Types Wrkr";
        EmployeeBenefits: Record "HCM Benefit Wrkr";
        PayrollStatementTransLines2: Record "Payroll Statement Emp Trans.";
        LevHREvaluation: DotNet LevHREvaluation; //"'LevhrEvaluation, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null'.APIClientConsole.HrmPlus" RUNONCLIENT;
        ResultContainer: array[2] of Text;
        EmployeeWorkDate: Record EmployeeWorkDate_GCC;
        TempDataTable: Record "Temp Datatable Data";
        HCMEmployeeBenefits_GCC: Record "HCM Benefit Wrkr";
        _PayrollStatementEmployee: Record "Payroll Statement Employee";
        _PayrollStatementLines: Record "Payroll Statement Lines";
        PayrollErrorLog: Record "Payroll Error Log";
        FullandFinalCalculation: Record "Full and Final Calculation";
        Window: Dialog;
        Counter: Integer;
        TotalRecords: Integer;

    procedure SetValues(l_PayrollStatement: Record "Payroll Statement");
    begin
        PayrollStatement := l_PayrollStatement;
    end;

    local procedure CreatePayrollStatementEmployees(EmployeeCode: Code[20]; RecPayrollStatement: Record "Payroll Statement");
    var
        "============STOP=======Pay Component Till here=====================": InStream;
        //PayComponentTable: DotNet PayComponentTable;//"'System.Data, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Data.DataTable";

        PayComponentColumn: DotNet PayComponentColumn;//"'System.Data, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Data.DataColumn";
        PayComponentColumnCollection: DotNet PayComponentColumnCollection;//"'System.Data, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Data.DataColumnCollection";
        PayComponentRow: DotNet PayComponentRow; //"'System.Data, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Data.DataRow";
        PayComponentRowCollection: DotNet PayComponentRowCollection; // "'System.Data, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Data.DataRowCollection";
        "============START=======Pay Component Till here=====================": InStream;

        FormulaForPackage: Text;
        FormulaForAttendance: Text;
        FormulaForDays: Text;
        ResultTable: DotNet ResultTable;// "'System.Data, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Data.DataTable";
        RowResultData: DotNet RowResultData;//"'System.Data, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Data.DataRow";
        ParameterTable: DotNet ParameterTable;//"'System.Data, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Data.DataTable";
        ParameterColumn: DotNet ParameterColumn;//"'System.Data, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Data.DataColumn";
        ParameterColumnCollection: DotNet ParameterColumnCollection;// "'System.Data, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Data.DataColumnCollection";
        ParameterRow: DotNet ParameterRow;//"'System.Data, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Data.DataRow";
        ParameterRowCollection: DotNet ParameterRowCollection;//"'System.Data, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Data.DataRowCollection";
        BenefitTable: DotNet BenefitTable;//"'System.Data, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Data.DataTable";
        BenefitColumn: DotNet BenefitColumn;// "'System.Data, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Data.DataColumn";
        BenefitColumnCollection: DotNet BenefitColumnCollection;//"'System.Data, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Data.DataColumnCollection";
        BenefitRow: DotNet BenefitRow;// "'System.Data, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Data.DataRow";
        BenefitRowCollection: DotNet BenefitRowCollection;// "'System.Data, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Data.DataRowCollection";
        dotNetDataRow: DotNet dotNetDataRow;///"'System.Data, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Data.DataRow";
        Value: Variant;
        PayrollFormulaKeyWords: Record "Payroll Formula";
        EmployeeLeaveTypes: Record "HCM Leave Types Wrkr";
        EmployeeBenefits: Record "HCM Benefit Wrkr";
        NoOfFirstHalfDays: Decimal;
        NoOfSecondHalfDays: Decimal;
        NoOfDays: Decimal;
        UnitFormula: Text;
        AmountCalcFormula: Text;
        EncashmentFormula: Text;
        i: Integer;
        Totals: Decimal;
        BenefitAdjustJournalHeader: Record "Benefit Adjmt. Journal header";
        BenefitAdjustJournalLine: Record "Benefit Adjmt. Journal Lines";
        openingBalanceBenefit: Decimal;
        ValueResult: Variant;
        EmployeeLoans: Record "HCM Loan Table GCC Wrkr";
        LoanInstallmentGeneration: Record "Loan Installment Generation";
        LoanSetup: Record "Loan Type Setup";
        PayrollAdjHeader: Record "Payroll Adjmt. Journal header";
        PayrollAdjLines: Record "Payroll Adjmt. Journal Lines";
        PayrollStatement3: Record "Payroll Statement";
        "##=============================BC DLL============================##": Integer;

        PayComponentEECistTableRecL: Record "Emp. Earning Code  List Table";

        ParamListDataTableRecL: Record "ParamList Data Table";
        EmpBenefitsListTableRecL: Record "Emp. Benefits List Table";
        EmpResultTableRecL: Record "Emp. Result Table";

        ReturnJsonStringTxtL: Text;
        ReturnJsonResponse: Text;
    // // PayComponentRowCollection: Record "Emp. Result Table";
    // // BenefitRowCollection: Record "Emp. Result Table";
    begin
        // Start  @BC DLL 
        PayComponentEECistTableRecL.Reset();
        if PayComponentEECistTableRecL.FindSet() then
            PayComponentEECistTableRecL.DeleteAll();
        // Stop @BC DLL

        with RecPayrollStatement do begin
            RecEmployee.GET(EmployeeCode);
            EmployeeEarningCodeGroup.RESET;
            EmployeeEarningCodeGroup.SETCURRENTKEY("Employee Code", "Valid From", "Valid To");
            EmployeeEarningCodeGroup.SETRANGE("Employee Code", RecEmployee."No.");
            EmployeeEarningCodeGroup.SETFILTER("Valid From", '<=%1', RecPayrollStatement."Pay Period End Date");
            EmployeeEarningCodeGroup.SETFILTER("Valid To", '>=%1|%2', RecPayrollStatement."Pay Period End Date", 0D);
            if EmployeeEarningCodeGroup.FINDFIRST then begin
                PayrollStatementEmployee.INIT;
                PayrollStatementEmployee."Payroll Statement ID" := RecPayrollStatement."Payroll Statement ID";
                PayrollStatementEmployee."Payroll Pay Cycle" := RecPayrollStatement."Pay Cycle";
                PayrollStatementEmployee."Payroll Pay Period" := RecPayrollStatement."Pay Period";
                PayrollStatementEmployee.Worker := EmployeeCode;
                PayrollStatementEmployee.INSERT;
                PayrollStatementEmployee."Pay Period Start Date" := RecPayrollStatement."Pay Period Start Date";
                PayrollStatementEmployee."Pay Period End Date" := RecPayrollStatement."Pay Period End Date";
                PayrollStatementEmployee."Payroll Year" := DATE2DMY(RecPayrollStatement."Pay Period Start Date", 3);
                PayrollStatementEmployee."Payroll Month" := FORMAT(RecPayrollStatement."Pay Period Start Date", 0, '<Month Text>');
                PayrollStatementEmployee.Status := RecPayrollStatement.Status;
                PayrollStatementEmployee."Employee Name" := RecEmployee."First Name" + ' ' + RecEmployee."Last Name";
                PayrollStatementEmployee."Pay Period Start Date" := RecPayrollStatement."Pay Period Start Date";
                PayrollStatementEmployee."Pay Period End Date" := RecPayrollStatement."Pay Period End Date";
                PayrollStatementEmployee."Paid Status" := PayrollStatementEmployee."Paid Status"::Unpaid;
                PayrollStatementEmployee."Payroll Period RecID" := RecPayrollStatement."Payroll Period RecID";
                PayrollStatementEmployee.MODIFY;
                if not PayrollStatementEmployee.ISEMPTY then begin
                    PayrollStatement3.GET(RecPayrollStatement."Payroll Statement ID");
                    PayrollStatement3.Status := PayrollStatement3.Status::Draft;
                    PayrollStatement3.MODIFY;
                    //Initialize System Data Variables
                    //ParameterTable.Clear;
                    //PayComponentTable.Clear;
                    //BenefitTable.Clear;
                    //Initialize System Data Variables
                    //Parameter Table and columns
                    TempDataTable.DELETEALL;
                    ParameterTable := ParameterTable.DataTable('Table1');
                    ParameterColumnCollection := ParameterTable.Columns;
                    ParameterRowCollection := ParameterTable.Rows;

                    ParameterColumn := ParameterColumn.DataColumn;
                    ParameterColumn.ColumnName := 'Key ID';
                    ParameterTable.Columns.Add(ParameterColumn);

                    ParameterColumn := ParameterColumn.DataColumn;
                    ParameterColumn.ColumnName := 'Key Value';
                    ParameterTable.Columns.Add(ParameterColumn);

                    ParameterColumn := ParameterColumn.DataColumn;
                    ParameterColumn.ColumnName := 'Data Type';
                    ParameterTable.Columns.Add(ParameterColumn);
                    //--->>> Parameter Formulas
                    PayrollFormulaKeyWords.RESET;
                    PayrollFormulaKeyWords.SETCURRENTKEY("Formula Key Type");
                    PayrollFormulaKeyWords.SETRANGE("Formula Key Type", PayrollFormulaKeyWords."Formula Key Type"::Parameter);
                    if PayrollFormulaKeyWords.FINDFIRST then
                        repeat
                            CLEAR(ResultContainer);
                            GetParameterKey(PayrollFormulaKeyWords."Formula Key", PayrollStatementEmployee);
                            ParameterRow := ParameterTable.NewRow();
                            ParameterRow.Item(0, PayrollFormulaKeyWords."Formula Key");
                            if STRPOS(ResultContainer[1], ',') <> 0 then
                                ParameterRow.Item(1, DELCHR(ResultContainer[1], '=', ','))
                            else
                                ParameterRow.Item(1, ResultContainer[1]);
                            ParameterRow.Item(2, ResultContainer[2]);
                            ParameterTable.Rows.Add(ParameterRow);
                            //Temp Data
                            TempDataTable.INIT;
                            TempDataTable."Entry No." := 0;
                            TempDataTable."Parameter ID" := PayrollFormulaKeyWords."Formula Key";
                            TempDataTable."Parameter Value" := FORMAT(ResultContainer[1]);
                            TempDataTable."Parameter Datatype" := FORMAT(ResultContainer[2]);
                            TempDataTable.INSERT;
                        //Temp Data
                        until PayrollFormulaKeyWords.NEXT = 0;
                    //<<<--- Parameter Formulas

                    //--->>> Employee Leave Type
                    EmployeeLeaveTypes.RESET;
                    EmployeeLeaveTypes.SETCURRENTKEY("Earning Code Group", Worker);
                    EmployeeLeaveTypes.SETRANGE("Earning Code Group", EmployeeEarningCodeGroup."Earning Code Group");
                    EmployeeLeaveTypes.SETRANGE(Worker, RecEmployee."No.");
                    //EmployeeLeaveTypes.SETRANGE("Earning Code",'BS');
                    if EmployeeLeaveTypes.FINDSET then
                        repeat
                            PayrollFormulaKeyWords.RESET;
                            PayrollFormulaKeyWords.SETCURRENTKEY("Short Name", "Formula Key Type");
                            PayrollFormulaKeyWords.SETRANGE("Short Name", EmployeeLeaveTypes."Short Name");
                            PayrollFormulaKeyWords.SETRANGE("Formula Key Type", PayrollFormulaKeyWords."Formula Key Type"::"Leave Type");
                            if PayrollFormulaKeyWords.FINDFIRST then
                                repeat
                                    NoOfDays := 0;
                                    NoOfFirstHalfDays := 0;
                                    NoOfSecondHalfDays := 0;
                                    case
                                    PayrollFormulaKeyWords."Formula Key" of
                                        'AC_' + PayrollFormulaKeyWords."Short Name":
                                            begin
                                                if not ((EmployeeLeaveTypes."Exc Public Holidays") and (EmployeeLeaveTypes."Exc Week Offs")) then begin
                                                    EmployeeWorkDate.RESET;
                                                    EmployeeWorkDate.SETCURRENTKEY("Employee Code", "First Half Leave Type", "Trans Date");
                                                    EmployeeWorkDate.SETRANGE("Employee Code", RecEmployee."No.");
                                                    EmployeeWorkDate.SETRANGE("First Half Leave Type", EmployeeLeaveTypes."Short Name");
                                                    EmployeeWorkDate.SETRANGE("Trans Date", PayrollStatementEmployee."Pay Period Start Date", PayrollStatementEmployee."Pay Period End Date");
                                                    if EmployeeWorkDate.FINDFIRST then
                                                        NoOfFirstHalfDays := EmployeeWorkDate.COUNT;

                                                    EmployeeWorkDate.RESET;
                                                    EmployeeWorkDate.SETCURRENTKEY("Employee Code", "Second Half Leave Type", "Trans Date");
                                                    EmployeeWorkDate.SETRANGE("Employee Code", RecEmployee."No.");
                                                    EmployeeWorkDate.SETRANGE("Second Half Leave Type", EmployeeLeaveTypes."Short Name");
                                                    EmployeeWorkDate.SETRANGE("Trans Date", PayrollStatementEmployee."Pay Period Start Date", PayrollStatementEmployee."Pay Period End Date");
                                                    if EmployeeWorkDate.FINDFIRST then
                                                        NoOfSecondHalfDays := EmployeeWorkDate.COUNT;
                                                end
                                                else
                                                    if (EmployeeLeaveTypes."Exc Public Holidays") and (EmployeeLeaveTypes."Exc Week Offs") then begin
                                                        EmployeeWorkDate.RESET;
                                                        EmployeeWorkDate.SETCURRENTKEY("Employee Code", "First Half Leave Type", "Calculation Type", "Trans Date");
                                                        EmployeeWorkDate.SETRANGE("Employee Code", RecEmployee."No.");
                                                        EmployeeWorkDate.SETRANGE("First Half Leave Type", EmployeeLeaveTypes."Short Name");
                                                        EmployeeWorkDate.SETRANGE("Calculation Type", EmployeeWorkDate."Calculation Type"::"Working Day");
                                                        EmployeeWorkDate.SETRANGE("Trans Date", PayrollStatementEmployee."Pay Period Start Date", PayrollStatementEmployee."Pay Period End Date");
                                                        if EmployeeWorkDate.FINDFIRST then
                                                            NoOfFirstHalfDays := EmployeeWorkDate.COUNT;

                                                        EmployeeWorkDate.RESET;
                                                        EmployeeWorkDate.SETCURRENTKEY("Employee Code", "Second Half Leave Type", "Calculation Type", "Trans Date");
                                                        EmployeeWorkDate.SETRANGE("Employee Code", RecEmployee."No.");
                                                        EmployeeWorkDate.SETRANGE("Second Half Leave Type", EmployeeLeaveTypes."Short Name");
                                                        EmployeeWorkDate.SETRANGE("Calculation Type", EmployeeWorkDate."Calculation Type"::"Working Day");
                                                        EmployeeWorkDate.SETRANGE("Trans Date", PayrollStatementEmployee."Pay Period Start Date", PayrollStatementEmployee."Pay Period End Date");
                                                        if EmployeeWorkDate.FINDFIRST then
                                                            NoOfSecondHalfDays := EmployeeWorkDate.COUNT;
                                                    end
                                            end;
                                        'AC_' + PayrollFormulaKeyWords."Short Name" + '_ESD':
                                            begin
                                                NoOfDays := EmployeeLeaveTypes."Entitlement Days";
                                            end;
                                        'AC_' + PayrollFormulaKeyWords."Short Name" + '_TD':
                                            begin
                                                if not ((EmployeeLeaveTypes."Exc Public Holidays") and (EmployeeLeaveTypes."Exc Week Offs")) then begin
                                                    EmployeeWorkDate.RESET;
                                                    EmployeeWorkDate.SETCURRENTKEY("Employee Code", "First Half Leave Type", "Trans Date");
                                                    EmployeeWorkDate.SETRANGE("Employee Code", RecEmployee."No.");
                                                    EmployeeWorkDate.SETRANGE("First Half Leave Type", EmployeeLeaveTypes."Short Name");
                                                    EmployeeWorkDate.SETRANGE("Trans Date", RecEmployee."Joining Date", PayrollStatementEmployee."Pay Period End Date");
                                                    if EmployeeWorkDate.FINDFIRST then
                                                        NoOfFirstHalfDays := EmployeeWorkDate.COUNT;

                                                    EmployeeWorkDate.RESET;
                                                    EmployeeWorkDate.SETCURRENTKEY("Employee Code", "Second Half Leave Type", "Trans Date");
                                                    EmployeeWorkDate.SETRANGE("Employee Code", RecEmployee."No.");
                                                    EmployeeWorkDate.SETRANGE("Second Half Leave Type", EmployeeLeaveTypes."Short Name");
                                                    EmployeeWorkDate.SETRANGE("Trans Date", RecEmployee."Joining Date", PayrollStatementEmployee."Pay Period End Date");
                                                    if EmployeeWorkDate.FINDFIRST then
                                                        NoOfSecondHalfDays := EmployeeWorkDate.COUNT;
                                                end
                                                else
                                                    if (EmployeeLeaveTypes."Exc Public Holidays") and (EmployeeLeaveTypes."Exc Week Offs") then begin
                                                        EmployeeWorkDate.RESET;
                                                        EmployeeWorkDate.SETCURRENTKEY("Employee Code", "First Half Leave Type", "Calculation Type", "Trans Date");
                                                        EmployeeWorkDate.SETRANGE("Employee Code", RecEmployee."No.");
                                                        EmployeeWorkDate.SETRANGE("First Half Leave Type", EmployeeLeaveTypes."Short Name");
                                                        EmployeeWorkDate.SETRANGE("Calculation Type", EmployeeWorkDate."Calculation Type"::"Working Day");
                                                        EmployeeWorkDate.SETRANGE("Trans Date", RecEmployee."Joining Date", PayrollStatementEmployee."Pay Period End Date");
                                                        if EmployeeWorkDate.FINDFIRST then
                                                            NoOfFirstHalfDays := EmployeeWorkDate.COUNT;

                                                        EmployeeWorkDate.RESET;
                                                        EmployeeWorkDate.SETCURRENTKEY("Employee Code", "Second Half Leave Type", "Calculation Type", "Trans Date");
                                                        EmployeeWorkDate.SETRANGE("Employee Code", RecEmployee."No.");
                                                        EmployeeWorkDate.SETRANGE("Second Half Leave Type", EmployeeLeaveTypes."Short Name");
                                                        EmployeeWorkDate.SETRANGE("Calculation Type", EmployeeWorkDate."Calculation Type"::"Working Day");
                                                        EmployeeWorkDate.SETRANGE("Trans Date", RecEmployee."Joining Date", PayrollStatementEmployee."Pay Period End Date");
                                                        if EmployeeWorkDate.FINDFIRST then
                                                            NoOfSecondHalfDays := EmployeeWorkDate.COUNT;
                                                    end
                                            end;
                                        'AC_' + PayrollFormulaKeyWords."Short Name" + '_TDFY':
                                            begin
                                                EmployeeWorkDate.RESET;
                                                EmployeeWorkDate.SETCURRENTKEY("Employee Code", "First Half Leave Type", "Calculation Type", "Trans Date");
                                                EmployeeWorkDate.SETRANGE("Employee Code", RecEmployee."No.");
                                                EmployeeWorkDate.SETRANGE("First Half Leave Type", EmployeeLeaveTypes."Short Name");
                                                EmployeeWorkDate.SETRANGE("Trans Date", CALCDATE('-CY', NORMALDATE(PayrollStatementEmployee."Pay Period End Date")), CALCDATE('CY', NORMALDATE(PayrollStatementEmployee."Pay Period End Date")));
                                                if EmployeeWorkDate.FINDFIRST then
                                                    NoOfFirstHalfDays := EmployeeWorkDate.COUNT;

                                                EmployeeWorkDate.RESET;
                                                EmployeeWorkDate.SETCURRENTKEY("Employee Code", "Second Half Leave Type", "Calculation Type", "Trans Date");
                                                EmployeeWorkDate.SETRANGE("Employee Code", RecEmployee."No.");
                                                EmployeeWorkDate.SETRANGE("Second Half Leave Type", EmployeeLeaveTypes."Short Name");
                                                EmployeeWorkDate.SETRANGE("Trans Date", CALCDATE('-CY', NORMALDATE(PayrollStatementEmployee."Pay Period End Date")), CALCDATE('CY', NORMALDATE(PayrollStatementEmployee."Pay Period End Date")));
                                                if EmployeeWorkDate.FINDFIRST then
                                                    NoOfSecondHalfDays := EmployeeWorkDate.COUNT;
                                            end;
                                        'AC_' + PayrollFormulaKeyWords."Short Name" + '_TDY':
                                            begin
                                                EmployeeWorkDate.RESET;
                                                EmployeeWorkDate.SETCURRENTKEY("Employee Code", "First Half Leave Type", "Calculation Type", "Trans Date");
                                                EmployeeWorkDate.SETRANGE("Employee Code", RecEmployee."No.");
                                                EmployeeWorkDate.SETRANGE("First Half Leave Type", EmployeeLeaveTypes."Short Name");
                                                EmployeeWorkDate.SETRANGE("Trans Date", CALCDATE('-CY', NORMALDATE(PayrollStatementEmployee."Pay Period End Date")), CALCDATE('CY', NORMALDATE(PayrollStatementEmployee."Pay Period End Date")));
                                                if EmployeeWorkDate.FINDFIRST then
                                                    NoOfFirstHalfDays := EmployeeWorkDate.COUNT;

                                                EmployeeWorkDate.RESET;
                                                EmployeeWorkDate.SETCURRENTKEY("Employee Code", "Second Half Leave Type", "Calculation Type", "Trans Date");
                                                EmployeeWorkDate.SETRANGE("Employee Code", RecEmployee."No.");
                                                EmployeeWorkDate.SETRANGE("Second Half Leave Type", EmployeeLeaveTypes."Short Name");
                                                EmployeeWorkDate.SETRANGE("Trans Date", CALCDATE('-CY', NORMALDATE(PayrollStatementEmployee."Pay Period End Date")), CALCDATE('CY', NORMALDATE(PayrollStatementEmployee."Pay Period End Date")));
                                                if EmployeeWorkDate.FINDFIRST then
                                                    NoOfSecondHalfDays := EmployeeWorkDate.COUNT;
                                            end;
                                        'AC_' + PayrollFormulaKeyWords."Short Name" + '_EJYC':
                                            begin
                                            end;
                                    end;
                                    if NoOfDays = 0 then
                                        NoOfDays := (NoOfFirstHalfDays + NoOfSecondHalfDays) / 2;
                                    //Insert Parameter Row for Employee Leaves
                                    ParameterRow := ParameterTable.NewRow();
                                    ParameterRow.Item('Key ID', PayrollFormulaKeyWords."Formula Key");
                                    if STRPOS(FORMAT(NoOfDays), ',') <> 0 then
                                        ParameterRow.Item('Key Value', DELCHR(FORMAT(NoOfDays), '=', ','))
                                    else
                                        ParameterRow.Item('Key Value', NoOfDays);
                                    ParameterRow.Item('Data Type', '#NumericDataType');
                                    ParameterTable.Rows.Add(ParameterRow);
                                    //Insert Parameter Row for Employee Leaves
                                    //Temp Data
                                    TempDataTable.INIT;
                                    TempDataTable."Entry No." := 0;
                                    TempDataTable."Parameter ID" := PayrollFormulaKeyWords."Formula Key";
                                    TempDataTable."Parameter Value" := FORMAT(NoOfDays);
                                    TempDataTable."Parameter Datatype" := '#NumericDataType';
                                    TempDataTable.INSERT;
                                //Temp Data
                                until PayrollFormulaKeyWords.NEXT = 0;

                        until EmployeeLeaveTypes.NEXT = 0;

                    //--->>> Custom Formulas
                    PayrollFormulaKeyWords.RESET;
                    PayrollFormulaKeyWords.SETCURRENTKEY("Formula Key Type");
                    PayrollFormulaKeyWords.SETRANGE("Formula Key Type", PayrollFormulaKeyWords."Formula Key Type"::Custom);
                    if PayrollFormulaKeyWords.FINDFIRST then
                        repeat
                            //GetParameterKey(PayrollFormulaKeyWords."Formula Key",PayrollStatementEmployee);
                            ParameterRow := ParameterTable.NewRow();
                            ParameterRow.Item(0, PayrollFormulaKeyWords."Formula Key");
                            ParameterRow.Item(1, PayrollFormulaKeyWords.Formula);
                            ParameterRow.Item(2, '#FormulaDataType');
                            ParameterTable.Rows.Add(ParameterRow);
                            //Temp Data
                            TempDataTable.INIT;
                            TempDataTable."Entry No." := 0;
                            TempDataTable."Parameter ID" := PayrollFormulaKeyWords."Formula Key";
                            TempDataTable."Parameter Value" := PayrollFormulaKeyWords.Formula;
                            TempDataTable."Parameter Datatype" := '#FormulaDataType';
                            TempDataTable.INSERT;
                        //Temp Data
                        until PayrollFormulaKeyWords.NEXT = 0;
                    //<<<--- Custom Formulas

                    BenefitTable := BenefitTable.DataTable('Table3');
                    BenefitColumnCollection := BenefitTable.Columns;
                    BenefitRowCollection := BenefitTable.Rows;

                    BenefitColumn := BenefitColumn.DataColumn;
                    BenefitColumn.ColumnName := 'Benefit Code';
                    BenefitTable.Columns.Add(BenefitColumn);

                    BenefitColumn := BenefitColumn.DataColumn;
                    BenefitColumn.ColumnName := 'Unit Formula';
                    BenefitTable.Columns.Add(BenefitColumn);

                    BenefitColumn := BenefitColumn.DataColumn;
                    BenefitColumn.ColumnName := 'Value Formula';
                    BenefitTable.Columns.Add(BenefitColumn);

                    BenefitColumn := BenefitColumn.DataColumn;
                    BenefitColumn.ColumnName := 'Encashment Formula';
                    BenefitTable.Columns.Add(BenefitColumn);

                    EmployeeBenefits.RESET;
                    EmployeeBenefits.SETCURRENTKEY("Earning Code Group", Worker, Active);
                    EmployeeBenefits.SETRANGE("Earning Code Group", EmployeeEarningCodeGroup."Earning Code Group");
                    EmployeeBenefits.SETRANGE(Worker, RecEmployee."No.");
                    EmployeeBenefits.SETRANGE(Active, true);
                    //EmployeeBenefits.SETRANGE("Earning Code",'BS');
                    if EmployeeBenefits.FINDSET then
                        repeat
                            UnitFormula := STRREPLACE(EmployeeBenefits.GetFormulaForUnitCalc, '[', '([');
                            UnitFormula := STRREPLACE(UnitFormula, ']', '])');

                            AmountCalcFormula := STRREPLACE(EmployeeBenefits.GetFormulaForAmountCalc, '[', '([');
                            AmountCalcFormula := STRREPLACE(AmountCalcFormula, ']', '])');

                            EncashmentFormula := STRREPLACE(EmployeeBenefits.GetFormulaForEncashmentFormula, '[', '([');
                            EncashmentFormula := STRREPLACE(EncashmentFormula, ']', '])');

                            //BenefitTable.Rows.Clear();
                            BenefitRow := BenefitTable.NewRow();
                            BenefitRow.Item('Benefit Code', EmployeeBenefits."Short Name");
                            BenefitRow.Item('Unit Formula', UnitFormula);
                            BenefitRow.Item('Value Formula', AmountCalcFormula);
                            BenefitRow.Item('Encashment Formula', EncashmentFormula);
                            BenefitTable.Rows.Add(BenefitRow);
                            //Temp Data
                            TempDataTable.INIT;
                            TempDataTable."Entry No." := 0;
                            TempDataTable."Benefit Code" := EmployeeBenefits."Short Name";
                            TempDataTable."Unit Formula" := UnitFormula;
                            TempDataTable."Value Formula" := AmountCalcFormula;
                            TempDataTable."Encashment Formula" := EncashmentFormula;
                            TempDataTable.INSERT;
                            //Temp Data
                            PayrollFormulaKeyWords.RESET;
                            PayrollFormulaKeyWords.SETCURRENTKEY("Short Name", "Formula Key Type");
                            PayrollFormulaKeyWords.SETRANGE("Short Name", EmployeeBenefits."Short Name");
                            PayrollFormulaKeyWords.SETRANGE("Formula Key Type", PayrollFormulaKeyWords."Formula Key Type"::Benefit);
                            if PayrollFormulaKeyWords.FINDFIRST then
                                repeat
                                    CLEAR(ResultContainer);
                                    CLEAR(openingBalanceBenefit);
                                    case
                                        PayrollFormulaKeyWords."Formula Key" of
                                        'BA_ADJ_' + PayrollFormulaKeyWords."Short Name":    //Sum of all posted and non included benefit amounts in same pay period
                                            begin
                                                BenefitAdjustJournalHeader.RESET;
                                                BenefitAdjustJournalHeader.SETCURRENTKEY("Pay Period Start", "Pay Period End", Posted);
                                                BenefitAdjustJournalHeader.SETFILTER("Pay Period Start", '>=%1', PayrollStatementEmployee."Pay Period Start Date");
                                                BenefitAdjustJournalHeader.SETFILTER("Pay Period End", '<=%1', PayrollStatementEmployee."Pay Period End Date");
                                                BenefitAdjustJournalHeader.SETRANGE(Posted, true);
                                                if BenefitAdjustJournalHeader.FINDFIRST then
                                                    repeat
                                                        BenefitAdjustJournalLine.RESET;
                                                        BenefitAdjustJournalLine.SETCURRENTKEY("Journal No.", "Employee Code", Benefit);
                                                        BenefitAdjustJournalLine.SETRANGE("Journal No.", BenefitAdjustJournalHeader."Journal No.");
                                                        BenefitAdjustJournalLine.SETRANGE("Employee Code", PayrollStatementEmployee.Worker);
                                                        BenefitAdjustJournalLine.SETRANGE(Benefit, EmployeeBenefits."Benefit Id");
                                                        if BenefitAdjustJournalLine.FINDSET then
                                                            repeat
                                                                openingBalanceBenefit += BenefitAdjustJournalLine.Amount;
                                                            until BenefitAdjustJournalLine.NEXT = 0;
                                                    until BenefitAdjustJournalHeader.NEXT = 0;
                                                ResultContainer[1] := FORMAT(openingBalanceBenefit);
                                                ResultContainer[2] := '#NumericDataType';

                                            end;
                                        'BA_ADJ_OB_' + PayrollFormulaKeyWords."Short Name":               //Sum of all posted and non included benefit amounts Prev pay period
                                            begin
                                                BenefitAdjustJournalHeader.RESET;
                                                BenefitAdjustJournalHeader.SETCURRENTKEY("Pay Period Start", "Pay Period End", Posted);
                                                BenefitAdjustJournalHeader.SETFILTER("Pay Period Start", '<%1', PayrollStatementEmployee."Pay Period Start Date");
                                                BenefitAdjustJournalHeader.SETRANGE(Posted, true);
                                                if BenefitAdjustJournalHeader.FINDFIRST then
                                                    repeat
                                                        BenefitAdjustJournalLine.RESET;
                                                        BenefitAdjustJournalLine.SETCURRENTKEY("Journal No.", "Employee Code", Benefit);
                                                        BenefitAdjustJournalLine.SETRANGE("Journal No.", BenefitAdjustJournalHeader."Journal No.");
                                                        BenefitAdjustJournalLine.SETRANGE("Employee Code", PayrollStatementEmployee.Worker);
                                                        BenefitAdjustJournalLine.SETRANGE(Benefit, EmployeeBenefits."Benefit Id");
                                                        if BenefitAdjustJournalLine.FINDSET then
                                                            repeat
                                                                openingBalanceBenefit += BenefitAdjustJournalLine.Amount;
                                                            until BenefitAdjustJournalLine.NEXT = 0;
                                                    until BenefitAdjustJournalHeader.NEXT = 0;
                                                ResultContainer[1] := FORMAT(openingBalanceBenefit);
                                                ResultContainer[2] := '#NumericDataType';
                                            end;
                                        'BA_OB_' + PayrollFormulaKeyWords."Short Name":
                                            begin
                                                _PayrollStatementEmployee.RESET;
                                                _PayrollStatementEmployee.SETRANGE(Worker, PayrollStatementEmployee.Worker);
                                                //_PayrollStatementEmployee.SETRANGE(Status,_PayrollStatementEmployee.Status::Created,_PayrollStatementEmployee.Status::Posted);
                                                _PayrollStatementEmployee.SETFILTER("Pay Period End Date", '<%1', PayrollStatementEmployee."Pay Period Start Date");
                                                if _PayrollStatementEmployee.FINDFIRST then
                                                    repeat
                                                        _PayrollStatementLines.RESET;
                                                        _PayrollStatementLines.SETRANGE("Payroll Statement ID", _PayrollStatementEmployee."Payroll Statement ID");
                                                        _PayrollStatementLines.SETRANGE("Payroll Statment Employee", _PayrollStatementEmployee.Worker);
                                                        _PayrollStatementLines.SETRANGE("Benefit Short Name", EmployeeBenefits."Short Name");
                                                        if _PayrollStatementLines.FINDSET then
                                                            repeat
                                                                openingBalanceBenefit += _PayrollStatementLines."Benefit Amount";
                                                            until _PayrollStatementLines.NEXT = 0;
                                                    until _PayrollStatementEmployee.NEXT = 0;
                                                ResultContainer[1] := FORMAT(openingBalanceBenefit);
                                                ResultContainer[2] := '#NumericDataType';
                                            end;
                                        'BE_' + PayrollFormulaKeyWords."Short Name":                //Benefit maximum units allowed for
                                            begin
                                                HCMEmployeeBenefits_GCC.RESET;
                                                HCMEmployeeBenefits_GCC.SETRANGE(Worker, PayrollStatementEmployee.Worker);
                                                HCMEmployeeBenefits_GCC.SETRANGE("Short Name", EmployeeBenefits."Short Name");
                                                HCMEmployeeBenefits_GCC.SETRANGE("Earning Code Group", EmployeeEarningCodeGroup."Earning Code Group");
                                                if HCMEmployeeBenefits_GCC.FINDFIRST then begin
                                                    ResultContainer[1] := FORMAT(HCMEmployeeBenefits_GCC."Max Units");
                                                    ResultContainer[2] := '#NumericDataType';
                                                end;
                                            end;
                                        'BE_' + PayrollFormulaKeyWords."Short Name" + '_SERVICEDAYS':        //Benefit entitlement service days for
                                            begin
                                                HCMEmployeeBenefits_GCC.RESET;
                                                HCMEmployeeBenefits_GCC.SETRANGE(Worker, PayrollStatementEmployee.Worker);
                                                HCMEmployeeBenefits_GCC.SETRANGE("Short Name", EmployeeBenefits."Short Name");
                                                HCMEmployeeBenefits_GCC.SETRANGE("Earning Code Group", EmployeeEarningCodeGroup."Earning Code Group");
                                                if HCMEmployeeBenefits_GCC.FINDFIRST then begin
                                                    ResultContainer[1] := FORMAT(HCMEmployeeBenefits_GCC."Benefit Entitlement Days");
                                                    ResultContainer[2] := '#NumericDataType';
                                                end;
                                            end;
                                        'BLTA_' + PayrollFormulaKeyWords."Short Name" + '_ADULTS':           //Total number of adults eligible for LTA
                                            begin

                                            end;
                                        'BLTA_' + PayrollFormulaKeyWords."Short Name" + '_CHILDREN':        //Total number of Children eligible for LTA
                                            begin

                                            end;
                                        'BLTA_' + PayrollFormulaKeyWords."Short Name" + '_INFANTS':        //Total number of Infants eligible for LTA
                                            begin

                                            end;
                                        'BU_ADJ_' + PayrollFormulaKeyWords."Short Name":                //Sum of all posted and non included benefit units in same pay period
                                            begin
                                                BenefitAdjustJournalHeader.RESET;
                                                BenefitAdjustJournalHeader.SETFILTER("Pay Period Start", '>=%1', PayrollStatementEmployee."Pay Period Start Date");
                                                BenefitAdjustJournalHeader.SETFILTER("Pay Period End", '<=%1', PayrollStatementEmployee."Pay Period End Date");
                                                BenefitAdjustJournalHeader.SETRANGE(Posted, true);
                                                if BenefitAdjustJournalHeader.FINDFIRST then
                                                    repeat
                                                        BenefitAdjustJournalLine.RESET;
                                                        BenefitAdjustJournalLine.SETRANGE("Journal No.", BenefitAdjustJournalHeader."Journal No.");
                                                        BenefitAdjustJournalLine.SETRANGE("Employee Code", PayrollStatementEmployee.Worker);
                                                        BenefitAdjustJournalLine.SETRANGE(Benefit, EmployeeBenefits."Benefit Id");
                                                        if BenefitAdjustJournalLine.FINDSET then
                                                            repeat
                                                                openingBalanceBenefit += BenefitAdjustJournalLine."Calculation Units";
                                                            until BenefitAdjustJournalLine.NEXT = 0;
                                                    until BenefitAdjustJournalHeader.NEXT = 0;
                                                ResultContainer[1] := FORMAT(openingBalanceBenefit);
                                                ResultContainer[2] := '#NumericDataType';
                                            end;
                                        'BU_ADJ_OB_' + PayrollFormulaKeyWords."Short Name":                //Sum of all posted and non included benefit units of Prev Period
                                            begin
                                                BenefitAdjustJournalHeader.RESET;
                                                BenefitAdjustJournalHeader.SETFILTER("Pay Period Start", '<%1', PayrollStatementEmployee."Pay Period Start Date");
                                                BenefitAdjustJournalHeader.SETRANGE(Posted, true);
                                                if BenefitAdjustJournalHeader.FINDFIRST then
                                                    repeat
                                                        BenefitAdjustJournalLine.RESET;
                                                        BenefitAdjustJournalLine.SETRANGE("Journal No.", BenefitAdjustJournalHeader."Journal No.");
                                                        BenefitAdjustJournalLine.SETRANGE("Employee Code", PayrollStatementEmployee.Worker);
                                                        BenefitAdjustJournalLine.SETRANGE(Benefit, EmployeeBenefits."Benefit Id");
                                                        if BenefitAdjustJournalLine.FINDSET then
                                                            repeat
                                                                openingBalanceBenefit += BenefitAdjustJournalLine."Calculation Units";
                                                            until BenefitAdjustJournalLine.NEXT = 0;
                                                    until BenefitAdjustJournalHeader.NEXT = 0;
                                                ResultContainer[1] := FORMAT(openingBalanceBenefit);
                                                ResultContainer[2] := '#NumericDataType';
                                            end;
                                        'BU_OB_' + PayrollFormulaKeyWords."Short Name":           //Benefit opening balance units for
                                            begin
                                                _PayrollStatementEmployee.RESET;
                                                _PayrollStatementEmployee.SETRANGE(Worker, PayrollStatementEmployee.Worker);
                                                //_PayrollStatementEmployee.SETRANGE(Status,_PayrollStatementEmployee.Status::Created,_PayrollStatementEmployee.Status::Posted);
                                                _PayrollStatementEmployee.SETFILTER("Pay Period End Date", '<%1', PayrollStatementEmployee."Pay Period Start Date");
                                                if _PayrollStatementEmployee.FINDFIRST then
                                                    repeat
                                                        _PayrollStatementLines.RESET;
                                                        _PayrollStatementLines.SETRANGE("Payroll Statement ID", _PayrollStatementEmployee."Payroll Statement ID");
                                                        _PayrollStatementLines.SETRANGE("Payroll Statment Employee", _PayrollStatementEmployee.Worker);
                                                        _PayrollStatementLines.SETRANGE("Benefit Short Name", EmployeeBenefits."Short Name");
                                                        if _PayrollStatementLines.FINDSET then
                                                            repeat
                                                                openingBalanceBenefit += _PayrollStatementLines."Calculation Units";
                                                            until _PayrollStatementLines.NEXT = 0;
                                                    until _PayrollStatementEmployee.NEXT = 0;
                                                ResultContainer[1] := FORMAT(openingBalanceBenefit);
                                                ResultContainer[2] := '#NumericDataType';
                                            end;
                                    end;
                                    //Insert Parameter Row for Employee Leaves
                                    ParameterRow := ParameterTable.NewRow();
                                    ParameterRow.Item('Key ID', PayrollFormulaKeyWords."Formula Key");
                                    if STRPOS(FORMAT(NoOfDays), ',') <> 0 then
                                        ParameterRow.Item('Key Value', DELCHR(FORMAT(NoOfDays), '=', ','))
                                    else
                                        ParameterRow.Item('Key Value', openingBalanceBenefit);
                                    ParameterRow.Item('Data Type', '#NumericDataType');
                                    ParameterTable.Rows.Add(ParameterRow);
                                    //Insert Parameter Row for Employee Leaves
                                    //Temp Data
                                    TempDataTable.INIT;
                                    TempDataTable."Entry No." := 0;
                                    TempDataTable."Parameter ID" := PayrollFormulaKeyWords."Formula Key";
                                    TempDataTable."Parameter Value" := FORMAT(openingBalanceBenefit);
                                    TempDataTable."Parameter Datatype" := '#NumericDataType';
                                    TempDataTable.INSERT;
                                //Temp Data

                                until PayrollFormulaKeyWords.NEXT = 0;
                        until EmployeeBenefits.NEXT = 0;
                    //Benefit Table and columns
                    //Paycomponent Table and columns
                    // Start @BC DLL

                    // PayComponentTable := PayComponentTable.DataTable('Table2');                    
                    // PayComponentColumnCollection := PayComponentTable.Columns;
                    // PayComponentRowCollection := PayComponentTable.Rows;
                    // PayComponentColumn := PayComponentColumn.DataColumn;
                    // PayComponentColumn.ColumnName := 'Paycomponentcode';
                    // PayComponentTable.Columns.Add(PayComponentColumn);
                    // PayComponentColumn := PayComponentColumn.DataColumn;
                    // PayComponentColumn.ColumnName := 'UnitFormula';
                    // PayComponentTable.Columns.Add(PayComponentColumn);
                    // PayComponentColumn := PayComponentColumn.DataColumn;
                    // PayComponentColumn.ColumnName := 'Formulaforattendance';
                    // PayComponentTable.Columns.Add(PayComponentColumn);
                    // PayComponentColumn := PayComponentColumn.DataColumn;
                    // PayComponentColumn.ColumnName := 'Formulafordays';
                    // PayComponentTable.Columns.Add(PayComponentColumn);
                    // PayComponentColumn := PayComponentColumn.DataColumn;
                    // PayComponentColumn.ColumnName := 'Paycomponenttype';
                    // PayComponentTable.Columns.Add(PayComponentColumn);

                    //Paycomponent Table and columns
                    // Stop @BC DLL

                    EmployeeEarningCodes.RESET;
                    EmployeeEarningCodes.SETRANGE("Earning Code Group", EmployeeEarningCodeGroup."Earning Code Group");
                    EmployeeEarningCodes.SETRANGE(Worker, RecEmployee."No.");
                    //EmployeeEarningCodes.SETRANGE("Earning Code",'BS');
                    if EmployeeEarningCodes.FINDSET then
                        repeat
                            FormulaForPackage := STRREPLACE(EmployeeEarningCodes."Formula For Package", '[', '([');
                            FormulaForPackage := STRREPLACE(FormulaForPackage, ']', '])');

                            FormulaForAttendance := STRREPLACE(EmployeeEarningCodes.GetFormulaForAttendance, '[', '([');
                            FormulaForAttendance := STRREPLACE(FormulaForAttendance, ']', '])');

                            FormulaForDays := STRREPLACE(EmployeeEarningCodes."Formula For Days", '[', '([');
                            FormulaForDays := STRREPLACE(FormulaForDays, ']', '])');
                            //LT
                            if EmployeeEarningCodes."Package Calc Type" = EmployeeEarningCodes."Package Calc Type"::Amount then begin
                                FormulaForPackage := FORMAT(EmployeeEarningCodes."Package Amount");
                                if STRPOS(FormulaForPackage, ',') <> 0 then
                                    FormulaForPackage := DELCHR(FormulaForPackage, '=', ',');
                            end
                            else begin
                                FormulaForPackage := FORMAT((EmployeeEarningCodeGroup."Gross Salary") * (EmployeeEarningCodes."Package Percentage" / 100));
                                if STRPOS(FormulaForPackage, ',') <> 0 then
                                    FormulaForPackage := DELCHR(FormulaForPackage, '=', ',');
                            end;
                            //LT
                            //Insert System Data Rows
                            // Start @BC DLL 22.04.2020 
                            // @Pay Component or Earning Code value inserting into Temp Table as per DLL Solution                         

                            // // PayComponentRow := PayComponentTable.NewRow();
                            // // PayComponentRow.Item('Paycomponentcode', EmployeeEarningCodes."Short Name");
                            // // PayComponentRow.Item('UnitFormula', FormulaForPackage);
                            // // PayComponentRow.Item('Formulaforattendance', FormulaForAttendance);
                            // // PayComponentRow.Item('Formulafordays', FormulaForDays);
                            // // PayComponentRow.Item('Paycomponenttype', EmployeeEarningCodes."Pay Component Type");
                            // // PayComponentTable.Rows.Add(PayComponentRow);                            
                            PayComponentEECistTableRecL.Init();
                            PayComponentEECistTableRecL."Entry No." := 0;
                            PayComponentEECistTableRecL.Insert();
                            PayComponentEECistTableRecL.EECList__Paycomponentcode := EmployeeEarningCodes."Short Name";
                            PayComponentEECistTableRecL.SETFormulaEECList__UnitFormula_Code(FormulaForPackage, PayComponentEECistTableRecL."Entry No.");
                            PayComponentEECistTableRecL.SETEECList__Formulaforattendance_Code(FormulaForAttendance, PayComponentEECistTableRecL."Entry No.");
                            PayComponentEECistTableRecL.SETEECList__Formulafordays_Code(FormulaForDays, PayComponentEECistTableRecL."Entry No.");
                            PayComponentEECistTableRecL.EECList__Paycomponenttype := Format(EmployeeEarningCodes."Pay Component Type");
                            PayComponentEECistTableRecL.Modify();
                            // Stop @BC DLL


                            //Temp Data
                            TempDataTable.INIT;
                            TempDataTable."Entry No." := 0;
                            TempDataTable."Paycomponent Code" := EmployeeEarningCodes."Short Name";
                            TempDataTable."PayComp Unit Formula" := COPYSTR(FormulaForPackage, 1, 250);
                            TempDataTable."Formula For Attendance" := COPYSTR(FormulaForAttendance, 1, 250);
                            TempDataTable."Formula for Days" := COPYSTR(FormulaForDays, 1, 250);
                            TempDataTable."Paycomponent Type" := FORMAT(EmployeeEarningCodes."Pay Component Type");
                            TempDataTable.INSERT;
                        //Temp Data

                        //Insert System Data Rows
                        // Start @BC DLL Avinash
                        // // // LevHREvaluation := LevHREvaluation.HrmPlus;
                        // // // ResultTable := ResultTable.DataTable;
                        // // // ResultTable := LevHREvaluation.PageInIt(ParameterTable, PayComponentTable, BenefitTable);
                        // Stop @BC DLL Avinash

                        // Start @BC DLL
                        //PayComponentRowCollection := ResultTable.Rows;
                        // Stop @BC DLL
                        /*
                        for i := 0 to PayComponentRowCollection.Count - 1 do begin
                            //Temp Data
                            dotNetDataRow := ResultTable.Rows.Item(i);
                            TempDataTable.INIT;
                            TempDataTable."Entry No." := 0;
                            TempDataTable.INSERT;
                            TempDataTable."Result Formula Type" := dotNetDataRow.Item(0);
                            TempDataTable."Result Base Code" := dotNetDataRow.Item(1);
                            TempDataTable."Result Fornula ID1" := dotNetDataRow.Item(2);
                            TempDataTable.Result1 := dotNetDataRow.Item(3);
                            TempDataTable."Result Fornula ID2" := dotNetDataRow.Item(4);
                            TempDataTable.Result2 := dotNetDataRow.Item(5);
                            TempDataTable."Result Fornula ID3" := dotNetDataRow.Item(6);
                            TempDataTable.Result3 := dotNetDataRow.Item(7);
                            TempDataTable.SetFormulaForErrorLog(dotNetDataRow.Item(8));
                            TempDataTable.MODIFY;
                            //Temp Data
                            if (FORMAT(dotNetDataRow.Item(0)) = 'P') and (FORMAT(dotNetDataRow.Item(1)) = EmployeeEarningCodes."Earning Code") then begin
                                dotNetDataRow := ResultTable.Rows.Item(i);
                                PayrollStatementTransLines2.RESET;
                                PayrollStatementTransLines2.SETRANGE("Payroll Statement ID", RecPayrollStatement."Payroll Statement ID");
                                PayrollStatementTransLines2.SETRANGE("Payroll Statment Employee", RecEmployee."No.");
                                if PayrollStatementTransLines2.FINDLAST then;
                                PayrollStatementTransLines.INIT;
                                PayrollStatementTransLines."Payroll Statement ID" := RecPayrollStatement."Payroll Statement ID";
                                PayrollStatementTransLines."Payroll Statment Employee" := RecEmployee."No.";
                                PayrollStatementTransLines."Line No." := PayrollStatementTransLines2."Line No." + 10000;
                                PayrollStatementTransLines.INSERT;
                                PayrollStatementTransLines.Voucher := PayrollStatementEmployee.Voucher;
                                PayrollStatementTransLines.Worker := PayrollStatementEmployee.Worker;
                                PayrollStatementTransLines."Employee Name" := PayrollStatementEmployee."Employee Name";
                                PayrollStatementTransLines."Payroll Pay Cycle" := PayrollStatementEmployee."Payroll Pay Cycle";
                                PayrollStatementTransLines."Payroll Pay Period" := PayrollStatementEmployee."Payroll Pay Period";
                                PayrollStatementTransLines."Payroll Month" := PayrollStatementEmployee."Payroll Month";
                                PayrollStatementTransLines."Payroll Year" := PayrollStatementEmployee."Payroll Year";
                                PayrollStatementTransLines."Currency Code" := PayrollStatementEmployee."Currency Code";
                                PayrollStatementTransLines."Earning Code Type" := PayrollStatementTransLines."Earning Code Type"::"Pay Component";
                                PayrollStatementTransLines."Earniing Code Short Name" := EmployeeEarningCodes."Short Name";
                                PayrollStatementTransLines."Payroll Earning Code" := EmployeeEarningCodes."Earning Code";
                                PayrollStatementTransLines."Payroll Earning Code Desc" := EmployeeEarningCodes.Description;
                                Value := dotNetDataRow.Item(3);
                                EVALUATE(PayrollStatementTransLines."Calculation Units", Value);
                                Value := dotNetDataRow.Item(5);
                                EVALUATE(PayrollStatementTransLines."Earning Code Amount", Value);
                                Value := dotNetDataRow.Item(7);
                                EVALUATE(PayrollStatementTransLines."Per Unit Amount", Value);
                                PayrollStatementTransLines.MODIFY;
                            end;
                        end;
                        */ // Avinash commneted
                        until EmployeeEarningCodes.NEXT = 0;


                    EmployeeBenefits.RESET;
                    EmployeeBenefits.SETRANGE("Earning Code Group", EmployeeEarningCodeGroup."Earning Code Group");
                    EmployeeBenefits.SETRANGE(Worker, RecEmployee."No.");
                    EmployeeBenefits.SETRANGE(Active, true);
                    //EmployeeBenefits.SETRANGE("Earning Code",'BS');
                    if EmployeeBenefits.FINDSET then
                        repeat
                            //LevHREvaluation := LevHREvaluation.HrmPlus;
                            //CLEAR(ResultTable);
                            //ResultTable := ResultTable.DataTable;
                            //ResultTable := LevHREvaluation.PageInIt(ParameterTable,PayComponentTable,BenefitTable);
                            BenefitRowCollection := ResultTable.Rows;
                            for i := 0 to BenefitRowCollection.Count - 1 do begin
                                //Temp Data
                                dotNetDataRow := ResultTable.Rows.Item(i);

                                //Temp Data

                                if (FORMAT(dotNetDataRow.Item(0)) = 'B') and (FORMAT(dotNetDataRow.Item(1)) = EmployeeBenefits."Short Name") then begin
                                    TempDataTable.INIT;
                                    TempDataTable."Entry No." := 0;
                                    TempDataTable.INSERT;
                                    TempDataTable."Result Formula Type" := dotNetDataRow.Item(0);
                                    TempDataTable."Result Base Code" := dotNetDataRow.Item(1);
                                    TempDataTable."Result Fornula ID1" := dotNetDataRow.Item(2);
                                    TempDataTable.Result1 := dotNetDataRow.Item(3);
                                    TempDataTable."Result Fornula ID2" := dotNetDataRow.Item(4);
                                    TempDataTable.Result2 := dotNetDataRow.Item(5);
                                    TempDataTable."Result Fornula ID3" := dotNetDataRow.Item(6);
                                    TempDataTable.Result3 := dotNetDataRow.Item(7);
                                    TempDataTable.SetFormulaForErrorLog(dotNetDataRow.Item(8));
                                    TempDataTable.MODIFY;
                                    //dotNetDataRow := ResultTable.Rows.Item(i);
                                    PayrollStatementTransLines2.RESET;
                                    PayrollStatementTransLines2.SETRANGE("Payroll Statement ID", RecPayrollStatement."Payroll Statement ID");
                                    PayrollStatementTransLines2.SETRANGE("Payroll Statment Employee", RecEmployee."No.");
                                    if PayrollStatementTransLines2.FINDLAST then;
                                    PayrollStatementTransLines.INIT;
                                    PayrollStatementTransLines."Payroll Statement ID" := RecPayrollStatement."Payroll Statement ID";
                                    PayrollStatementTransLines."Payroll Statment Employee" := RecEmployee."No.";
                                    PayrollStatementTransLines."Line No." := PayrollStatementTransLines2."Line No." + 10000;
                                    PayrollStatementTransLines.INSERT;
                                    PayrollStatementTransLines.Voucher := PayrollStatementEmployee.Voucher;
                                    PayrollStatementTransLines.Worker := PayrollStatementEmployee.Worker;
                                    PayrollStatementTransLines."Employee Name" := PayrollStatementEmployee."Employee Name";
                                    PayrollStatementTransLines."Payroll Pay Cycle" := PayrollStatementEmployee."Payroll Pay Cycle";
                                    PayrollStatementTransLines."Payroll Pay Period" := PayrollStatementEmployee."Payroll Pay Period";
                                    PayrollStatementTransLines."Payroll Month" := PayrollStatementEmployee."Payroll Month";
                                    PayrollStatementTransLines."Payroll Year" := PayrollStatementEmployee."Payroll Year";
                                    PayrollStatementTransLines."Earning Code Type" := PayrollStatementTransLines."Earning Code Type"::Benefit;
                                    PayrollStatementTransLines."Currency Code" := PayrollStatementEmployee."Currency Code";
                                    PayrollStatementTransLines."Benefit Short Name" := EmployeeBenefits."Short Name";
                                    PayrollStatementTransLines."Benefit Code" := EmployeeBenefits."Benefit Id";
                                    PayrollStatementTransLines."Benefit Description" := EmployeeBenefits.Description;
                                    Value := dotNetDataRow.Item(3);
                                    EVALUATE(PayrollStatementTransLines."Calculation Units", Value);
                                    Value := dotNetDataRow.Item(5);
                                    EVALUATE(PayrollStatementTransLines."Benefit Amount", Value);
                                    Value := dotNetDataRow.Item(7);
                                    EVALUATE(PayrollStatementTransLines."Per Unit Amount", Value);
                                    PayrollStatementTransLines.MODIFY;
                                end;
                            end;
                        until EmployeeBenefits.NEXT = 0;
                    //Employee Loans
                    EmployeeLoans.RESET;
                    EmployeeLoans.SETRANGE("Earning Code Group", EmployeeEarningCodeGroup."Earning Code Group");
                    EmployeeLoans.SETRANGE(Worker, PayrollStatementEmployee.Worker);
                    if EmployeeLoans.FINDFIRST then
                        repeat
                            LoanInstallmentGeneration.RESET;
                            LoanInstallmentGeneration.SETRANGE("Employee ID", EmployeeLoans.Worker);
                            LoanInstallmentGeneration.SETRANGE("Installament Date", PayrollStatement."Pay Period Start Date", PayrollStatement."Pay Period End Date");
                            LoanInstallmentGeneration.SETRANGE(Loan, EmployeeLoans."Loan Code");
                            if LoanInstallmentGeneration.FINDFIRST then
                                repeat
                                    LoanSetup.GET(LoanInstallmentGeneration.Loan);
                                    LoanSetup.TESTFIELD("Earning Code for Principal");
                                    CreatePayrollStatementTransLinesPrinicipal(PayrollStatement, PayrollStatementEmployee, LoanSetup, LoanInstallmentGeneration);
                                    CreatePayrollStatementTransLinesInterest(PayrollStatement, PayrollStatementEmployee, LoanSetup, LoanInstallmentGeneration);
                                until LoanInstallmentGeneration.NEXT = 0;
                        until EmployeeLoans.NEXT = 0;
                    //Employee Loans
                    //Payroll Adjustment Journals
                    PayrollAdjHeader.RESET;
                    PayrollAdjHeader.SETRANGE("Pay Cycle", PayrollStatement."Pay Cycle");
                    PayrollAdjHeader.SETRANGE("Pay Period Start", PayrollStatement."Pay Period Start Date");
                    PayrollAdjHeader.SETRANGE("Pay Period End", PayrollStatement."Pay Period End Date");
                    PayrollAdjHeader.SETRANGE(Posted, true);
                    if PayrollAdjHeader.FINDFIRST then
                        repeat
                            PayrollAdjLines.RESET;
                            PayrollAdjLines.SETRANGE("Journal No.", PayrollAdjHeader."Journal No.");
                            PayrollAdjLines.SETRANGE("Employee Code", PayrollStatementEmployee.Worker);
                            if PayrollAdjLines.FINDFIRST then
                                repeat
                                    CreatePayrollStatementTransPayAdj(PayrollStatement, PayrollStatementEmployee, PayrollAdjLines);
                                until PayrollAdjLines.NEXT = 0;
                        until PayrollAdjHeader.NEXT = 0;
                    //Payroll Adjustment Journals
                end;
                CreatePayrollStatementLines(PayrollStatement, PayrollStatementEmployee);
            end;
        end;

    end;

    local procedure CreatePayrollStatementLines(_RecPayrollStatement: Record "Payroll Statement"; _RecPayrollStatementEmployee: Record "Payroll Statement Employee");
    var
        PayrollStatementTransQuery: Query "Payroll Statement Trans.";
    begin
        with _RecPayrollStatement do begin
            with _RecPayrollStatementEmployee do begin
                CLEAR(PayrollStatementTransQuery);
                PayrollStatementTransQuery.SETRANGE(PayrollStatementTransQuery.Payroll_Statement_ID, _RecPayrollStatement."Payroll Statement ID");
                PayrollStatementTransQuery.SETRANGE(PayrollStatementTransQuery.Payroll_Statment_Employee, _RecPayrollStatementEmployee.Worker);
                PayrollStatementTransQuery.SETFILTER(PayrollStatementTransQuery.Sum_Earning_Code_Amount, '<>%1', 0);
                PayrollStatementTransQuery.OPEN;
                while PayrollStatementTransQuery.READ do begin
                    PayrollStatementLines2.RESET;
                    PayrollStatementLines2.SETRANGE("Payroll Statement ID", _RecPayrollStatement."Payroll Statement ID");
                    PayrollStatementLines2.SETRANGE("Payroll Statment Employee", _RecPayrollStatementEmployee.Worker);
                    if PayrollStatementLines2.FINDLAST then;
                    PayrollStatementLines.INIT;
                    PayrollStatementLines."Payroll Statement ID" := PayrollStatementTransQuery.Payroll_Statement_ID;
                    PayrollStatementLines."Payroll Statment Employee" := PayrollStatementTransQuery.Worker;
                    PayrollStatementLines."Line No." := PayrollStatementLines2."Line No." + 10000;
                    PayrollStatementLines.INSERT;
                    PayrollStatementLines."Payroll Pay Cycle" := _RecPayrollStatementEmployee."Payroll Pay Cycle";
                    PayrollStatementLines."Payroll Pay Period" := _RecPayrollStatementEmployee."Payroll Pay Period";
                    PayrollStatementLines."Payroll Month" := _RecPayrollStatementEmployee."Payroll Month";
                    PayrollStatementLines."Payroll Year" := _RecPayrollStatementEmployee."Payroll Year";
                    PayrollStatementLines.Worker := _RecPayrollStatementEmployee.Worker;
                    PayrollStatementLines."Employee Name" := _RecPayrollStatementEmployee."Employee Name";
                    PayrollStatementLines."Payroll Earning Code" := PayrollStatementTransQuery.Payroll_Earning_Code;
                    PayrollStatementLines."Payroll Earning Code Desc" := PayrollStatementTransQuery.Payroll_Earning_Code_Desc;
                    PayrollStatementLines."Earning Code Type" := PayrollStatementTransQuery.Earning_Code_Type;
                    PayrollStatementLines."Earning Code Calc Sub Type" := PayrollStatementTransQuery.Earning_Code_Calc_Sub_Type;
                    PayrollStatementLines."Earning Code Calc Class" := PayrollStatementTransQuery.Earning_Code_Calc_Class;
                    PayrollStatementLines."Earning Code Arabic Name" := PayrollStatementTransQuery.Earning_Code_Arabic_Name;
                    PayrollStatementLines."Earniing Code Short Name" := PayrollStatementTransQuery.Earniing_Code_Short_Name;
                    PayrollStatementLines."Earning Code Amount" := PayrollStatementTransQuery.Sum_Earning_Code_Amount;
                    PayrollStatementLines."Calculation Units" := PayrollStatementTransQuery.Sum_Calculation_Units;
                    PayrollStatementLines.MODIFY;
                end;
                PayrollStatementTransQuery.CLOSE;
                CLEAR(PayrollStatementTransQuery);
                PayrollStatementTransQuery.SETRANGE(PayrollStatementTransQuery.Payroll_Statement_ID, _RecPayrollStatement."Payroll Statement ID");
                PayrollStatementTransQuery.SETRANGE(PayrollStatementTransQuery.Payroll_Statment_Employee, _RecPayrollStatementEmployee.Worker);
                PayrollStatementTransQuery.SETFILTER(PayrollStatementTransQuery.Sum_Benefit_Amount, '<>%1', 0);
                PayrollStatementTransQuery.OPEN;
                while PayrollStatementTransQuery.READ do begin
                    PayrollStatementLines2.RESET;
                    PayrollStatementLines2.SETRANGE("Payroll Statement ID", _RecPayrollStatement."Payroll Statement ID");
                    PayrollStatementLines2.SETRANGE("Payroll Statment Employee", _RecPayrollStatementEmployee.Worker);
                    if PayrollStatementLines2.FINDLAST then;
                    PayrollStatementLines.INIT;
                    PayrollStatementLines."Payroll Statement ID" := PayrollStatementTransQuery.Payroll_Statement_ID;
                    PayrollStatementLines."Payroll Statment Employee" := PayrollStatementTransQuery.Worker;
                    PayrollStatementLines."Line No." := PayrollStatementLines2."Line No." + 10000;
                    PayrollStatementLines.INSERT;
                    PayrollStatementLines."Payroll Pay Cycle" := _RecPayrollStatementEmployee."Payroll Pay Cycle";
                    PayrollStatementLines."Payroll Pay Period" := _RecPayrollStatementEmployee."Payroll Pay Period";
                    PayrollStatementLines."Payroll Month" := _RecPayrollStatementEmployee."Payroll Month";
                    PayrollStatementLines."Payroll Year" := _RecPayrollStatementEmployee."Payroll Year";
                    PayrollStatementLines.Worker := _RecPayrollStatementEmployee.Worker;
                    PayrollStatementLines."Earning Code Type" := PayrollStatementTransQuery.Earning_Code_Type;
                    PayrollStatementLines."Employee Name" := _RecPayrollStatementEmployee."Employee Name";
                    PayrollStatementLines."Calculation Units" := PayrollStatementTransQuery.Sum_Calculation_Units;
                    PayrollStatementLines."Benefit Code" := PayrollStatementTransQuery.Benefit_Code;
                    PayrollStatementLines."Benefit Description" := PayrollStatementTransQuery.Benefit_Description;
                    PayrollStatementLines."Benefit Short Name" := PayrollStatementTransQuery.Benefit_Short_Name;
                    PayrollStatementLines."Benenfit Arabic Name" := PayrollStatementTransQuery.Benenfit_Arabic_Name;
                    PayrollStatementLines."Benefit Amount" := PayrollStatementTransQuery.Sum_Benefit_Amount;
                    PayrollStatementLines."Benefit Encashment Amount" := PayrollStatementTransQuery.Sum_Benefit_Encashment_Amount;
                    PayrollStatementLines.MODIFY;
                end;
                PayrollStatementTransQuery.CLOSE;

                CLEAR(PayrollStatementTransQuery);
                PayrollStatementTransQuery.SETRANGE(PayrollStatementTransQuery.Payroll_Statement_ID, _RecPayrollStatement."Payroll Statement ID");
                PayrollStatementTransQuery.SETRANGE(PayrollStatementTransQuery.Payroll_Statment_Employee, _RecPayrollStatementEmployee.Worker);
                PayrollStatementTransQuery.SETRANGE(PayrollStatementTransQuery.Sum_Earning_Code_Amount, 0);
                PayrollStatementTransQuery.SETRANGE(PayrollStatementTransQuery.Sum_Benefit_Amount, 0);
                PayrollStatementTransQuery.SETFILTER(PayrollStatementTransQuery.Sum_Calculation_Units, '<>%1', 0);
                PayrollStatementTransQuery.OPEN;
                while PayrollStatementTransQuery.READ do begin
                    PayrollStatementLines2.RESET;
                    PayrollStatementLines2.SETRANGE("Payroll Statement ID", _RecPayrollStatement."Payroll Statement ID");
                    PayrollStatementLines2.SETRANGE("Payroll Statment Employee", _RecPayrollStatementEmployee.Worker);
                    if PayrollStatementLines2.FINDLAST then;
                    PayrollStatementLines.INIT;
                    PayrollStatementLines."Payroll Statement ID" := PayrollStatementTransQuery.Payroll_Statement_ID;
                    PayrollStatementLines."Payroll Statment Employee" := PayrollStatementTransQuery.Worker;
                    PayrollStatementLines."Line No." := PayrollStatementLines2."Line No." + 10000;
                    PayrollStatementLines.INSERT;
                    PayrollStatementLines."Payroll Pay Cycle" := _RecPayrollStatementEmployee."Payroll Pay Cycle";
                    PayrollStatementLines."Payroll Pay Period" := _RecPayrollStatementEmployee."Payroll Pay Period";
                    PayrollStatementLines."Payroll Month" := _RecPayrollStatementEmployee."Payroll Month";
                    PayrollStatementLines."Payroll Year" := _RecPayrollStatementEmployee."Payroll Year";
                    PayrollStatementLines.Worker := _RecPayrollStatementEmployee.Worker;
                    PayrollStatementLines."Employee Name" := _RecPayrollStatementEmployee."Employee Name";
                    PayrollStatementLines."Calculation Units" := PayrollStatementTransQuery.Sum_Calculation_Units;
                    if PayrollStatementTransQuery.Payroll_Earning_Code <> '' then begin
                        PayrollStatementLines."Payroll Earning Code" := PayrollStatementTransQuery.Payroll_Earning_Code;
                        PayrollStatementLines."Payroll Earning Code Desc" := PayrollStatementTransQuery.Payroll_Earning_Code_Desc;
                        PayrollStatementLines."Earning Code Type" := PayrollStatementTransQuery.Earning_Code_Type;
                        PayrollStatementLines."Earning Code Calc Sub Type" := PayrollStatementTransQuery.Earning_Code_Calc_Sub_Type;
                        PayrollStatementLines."Earning Code Calc Class" := PayrollStatementTransQuery.Earning_Code_Calc_Class;
                        PayrollStatementLines."Earning Code Arabic Name" := PayrollStatementTransQuery.Earning_Code_Arabic_Name;
                        PayrollStatementLines."Earniing Code Short Name" := PayrollStatementTransQuery.Earniing_Code_Short_Name;
                        PayrollStatementLines."Earning Code Amount" := PayrollStatementTransQuery.Sum_Earning_Code_Amount;
                    end
                    else
                        if PayrollStatementTransQuery.Benefit_Code <> '' then begin
                            PayrollStatementLines."Earning Code Type" := PayrollStatementTransQuery.Earning_Code_Type;
                            PayrollStatementLines."Benefit Code" := PayrollStatementTransQuery.Benefit_Code;
                            PayrollStatementLines."Benefit Description" := PayrollStatementTransQuery.Benefit_Description;
                            PayrollStatementLines."Benefit Short Name" := PayrollStatementTransQuery.Benefit_Short_Name;
                            PayrollStatementLines."Benenfit Arabic Name" := PayrollStatementTransQuery.Benenfit_Arabic_Name;
                            PayrollStatementLines."Benefit Amount" := PayrollStatementTransQuery.Sum_Benefit_Amount;
                            PayrollStatementLines."Benefit Encashment Amount" := PayrollStatementTransQuery.Sum_Benefit_Encashment_Amount;
                        end;
                    PayrollStatementLines.MODIFY;
                end;
                PayrollStatementTransQuery.CLOSE;
            end;
        end;
    end;

    procedure CreatePayrollStatementTransLinesPrinicipal(_RecPayrollStatement: Record "Payroll Statement"; _RecPayrollStatementEmployee: Record "Payroll Statement Employee"; _LoanTypeSetup: Record "Loan Type Setup"; _LoanInstallmentGeneration: Record "Loan Installment Generation");
    var
        EarningCode: Record "Payroll Earning Code";
    begin
        with _RecPayrollStatement do begin
            with _RecPayrollStatementEmployee do begin
                EarningCode.GET(_LoanTypeSetup."Earning Code for Principal");
                PayrollStatementTransLines2.RESET;
                PayrollStatementTransLines2.SETRANGE("Payroll Statement ID", _RecPayrollStatement."Payroll Statement ID");
                PayrollStatementTransLines2.SETRANGE("Payroll Statment Employee", RecEmployee."No.");
                if PayrollStatementTransLines2.FINDLAST then;
                PayrollStatementTransLines.INIT;
                PayrollStatementTransLines."Payroll Statement ID" := _RecPayrollStatement."Payroll Statement ID";
                PayrollStatementTransLines."Payroll Statment Employee" := _RecPayrollStatementEmployee.Worker;
                PayrollStatementTransLines."Line No." := PayrollStatementTransLines2."Line No." + 10000;
                PayrollStatementTransLines.INSERT;
                PayrollStatementTransLines.Voucher := _RecPayrollStatementEmployee.Voucher;
                PayrollStatementTransLines.Worker := _RecPayrollStatementEmployee.Worker;
                PayrollStatementTransLines."Employee Name" := _RecPayrollStatementEmployee."Employee Name";
                PayrollStatementTransLines."Payroll Pay Cycle" := _RecPayrollStatementEmployee."Payroll Pay Cycle";
                PayrollStatementTransLines."Payroll Pay Period" := _RecPayrollStatementEmployee."Payroll Pay Period";
                PayrollStatementTransLines."Payroll Month" := _RecPayrollStatementEmployee."Payroll Month";
                PayrollStatementTransLines."Payroll Year" := _RecPayrollStatementEmployee."Payroll Year";
                PayrollStatementTransLines."Currency Code" := _RecPayrollStatementEmployee."Currency Code";
                PayrollStatementTransLines."Earniing Code Short Name" := EarningCode."Short Name";
                PayrollStatementTransLines."Earning Code Type" := PayrollStatementTransLines."Earning Code Type"::Loan;
                PayrollStatementTransLines."Payroll Earning Code" := EarningCode."Earning Code";
                PayrollStatementTransLines."Payroll Earning Code Desc" := EarningCode.Description;
                PayrollStatementTransLines."Calculation Units" := 1;
                PayrollStatementTransLines."Earning Code Amount" := _LoanInstallmentGeneration."Principal Installment Amount" * -1;
                PayrollStatementTransLines."Per Unit Amount" := 0;
                PayrollStatementTransLines.MODIFY;
            end;
        end;
    end;

    procedure STRREPLACE(String: Text; Old: Text; New: Text) NewString: Text;
    var
        Pos: Integer;
        DotNetString: DotNet DotNetString;//"'mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.String";
    begin
        /*
        Pos := STRPOS(String, Old);
        WHILE Pos <> 0 DO
        BEGIN
           NewString += DELSTR(String,Pos) + New;
           String := COPYSTR(String, Pos, STRLEN(Old));
        //String := INSSTR(String, New, Pos);
           Pos := STRPOS(String, Old);
        END;
        NewString += String;
        */
        DotNetString := String;
        DotNetString := DotNetString.Replace(Old, New);
        NewString := FORMAT(DotNetString);
        exit(NewString);

    end;

    procedure GetParameterKey(_FormulaKey: Code[100]; l_PayrollStatementEmployee: Record "Payroll Statement Employee");
    var
        PayrollFormulaKeyWord: Codeunit "Formula Keyword";
        Employee: Record Employee;
    begin
        case _FormulaKey of
            'P_PERIODENDDATE':
                begin
                    ResultContainer[1] := FORMAT(PayrollFormulaKeyWord.P_PeriodEndDate(PayrollStatementEmployee.Worker, l_PayrollStatementEmployee."Payroll Pay Cycle", l_PayrollStatementEmployee."Payroll Period RecID"));
                    ResultContainer[2] := '#DateDataType';
                end;
            'P_PERIODENDDATEMONTH':
                begin
                    ResultContainer[1] := FORMAT(PayrollFormulaKeyWord.P_PeriodEndDateMonth(PayrollStatementEmployee.Worker, l_PayrollStatementEmployee."Payroll Pay Cycle", l_PayrollStatementEmployee."Payroll Period RecID"));
                    ResultContainer[2] := '#NumericDataType';
                end;
            // // 'P_EMPLOYEEJOINDATEMONTH':
            // //     begin
            // //         ResultContainer[1] := FORMAT(PayrollFormulaKeyWord.P_EmployeeJoinDateMonth(PayrollStatementEmployee.Worker));
            // //         ResultContainer[2] := '#NumericDataType';
            // //     end;
            // // 'P_EMPLOYEEJOINDATEYEAR':
            // //     begin
            // //         ResultContainer[1] := FORMAT(PayrollFormulaKeyWord.P_EmployeeJoinDateYear(PayrollStatementEmployee.Worker));
            // //         ResultContainer[2] := '#NumericDataType';
            // //     end;
            'P_PERIODENDDATEYEAR':
                begin
                    ResultContainer[1] := FORMAT(PayrollFormulaKeyWord.P_PeriodEndDateYear(PayrollStatementEmployee.Worker, l_PayrollStatementEmployee."Payroll Pay Cycle", l_PayrollStatementEmployee."Payroll Period RecID"));
                    ResultContainer[2] := '#NumericDataType';
                end;
            'P_PERIODSTARTDATE':
                begin
                    ResultContainer[1] := FORMAT(PayrollFormulaKeyWord.P_PeriodStartDate(PayrollStatementEmployee.Worker, l_PayrollStatementEmployee."Payroll Pay Cycle", l_PayrollStatementEmployee."Payroll Period RecID"));
                    ResultContainer[2] := '#DateDataType';
                end;
            'P_PERIODSTARTDATEMONTH':
                begin
                    ResultContainer[1] := FORMAT(PayrollFormulaKeyWord.P_PeriodStartDateMonth(PayrollStatementEmployee.Worker, l_PayrollStatementEmployee."Payroll Pay Cycle", l_PayrollStatementEmployee."Payroll Period RecID"));
                    ResultContainer[2] := '#NumericDataType';
                end;
            'P_PERIODSTARTDATEYEAR':
                begin
                    ResultContainer[1] := FORMAT(PayrollFormulaKeyWord.P_PeriodStartDateYear(PayrollStatementEmployee.Worker, l_PayrollStatementEmployee."Payroll Pay Cycle", l_PayrollStatementEmployee."Payroll Period RecID"));
                    ResultContainer[2] := '#NumericDataType';
                end;
            'P_PROBATIONENDDATE':
                begin
                    ResultContainer[1] := FORMAT(PayrollFormulaKeyWord.P_ProbationEndDate(PayrollStatementEmployee.Worker));
                    ResultContainer[2] := '#DateDataType';
                end;
            'P_PROBATIONSTARTDATE':
                begin
                    ResultContainer[1] := FORMAT(PayrollFormulaKeyWord.P_ProbationStartDate(PayrollStatementEmployee.Worker));
                    ResultContainer[2] := '#DateDataType';
                end;
            'P_ANNUALSALARY':
                begin
                    ResultContainer[1] := FORMAT(PayrollFormulaKeyWord.P_AnnualSalary(PayrollStatementEmployee.Worker, PayrollStatementEmployee."Pay Period Start Date", PayrollStatementEmployee."Pay Period End Date"));
                    ResultContainer[2] := '#NumericDataType';
                end;
            'P_SERVICEDAYS':
                begin
                    ResultContainer[1] := FORMAT(PayrollFormulaKeyWord.P_ServiceDays(PayrollStatementEmployee.Worker, NORMALDATE(PayrollStatementEmployee."Pay Period End Date")));
                    ResultContainer[2] := '#NumericDataType';
                end;
            'P_DAYSINPAYCYCLEPERIOD':
                begin
                    ResultContainer[1] := FORMAT(PayrollFormulaKeyWord.P_DaysInPayCyclePeriod(PayrollStatementEmployee.Worker, PayrollStatementEmployee."Pay Period Start Date", PayrollStatementEmployee."Pay Period End Date"));
                    ResultContainer[2] := '#NumericDataType';
                end;
            'P_CALENDARYEARDAYS':
                begin
                    ResultContainer[1] := FORMAT(PayrollFormulaKeyWord.P_CalendarYearDays(PayrollStatementEmployee."Pay Period Start Date", PayrollStatementEmployee."Pay Period End Date"));
                    ResultContainer[2] := '#NumericDataType';
                end;
            'P_COLR':
                begin
                    ResultContainer[1] := FORMAT(PayrollFormulaKeyWord.P_COLR(PayrollStatementEmployee.Worker, PayrollStatementEmployee."Pay Period Start Date", PayrollStatementEmployee."Pay Period End Date"));
                    ResultContainer[2] := '#NumericDataType';
                end;
            'P_CHILDCOUNT':
                begin
                    ResultContainer[1] := FORMAT(PayrollFormulaKeyWord.P_ChildCount(PayrollStatementEmployee.Worker));
                    ResultContainer[2] := '#NumericDataType';
                end;
            'P_SPOUSECOUNT':
                begin
                    ResultContainer[1] := FORMAT(PayrollFormulaKeyWord.P_SpouseCount(PayrollStatementEmployee.Worker));
                    ResultContainer[2] := '#NumericDataType';
                end;
            'P_EMPLOYEEMARITALSTATUS':
                begin
                    ResultContainer[1] := FORMAT(PayrollFormulaKeyWord.P_EmployeeMaritalStatus(PayrollStatementEmployee.Worker));
                    ResultContainer[2] := '#TextDataType';
                end;
            'P_COUNTOFFEMALEMARRIEDCHILD':
                begin
                    ResultContainer[1] := FORMAT(PayrollFormulaKeyWord.P_CountOfFemaleMarriedChild(PayrollStatementEmployee.Worker));
                    ResultContainer[2] := '#NumericDataType';
                end;
            'P_DAYSINPERIOD':
                begin
                    Employee.GET(PayrollStatementEmployee.Worker);

                    ResultContainer[1] := FORMAT(PayrollFormulaKeyWord.P_DaysInPeriod(PayrollStatementEmployee.Worker, PayrollStatementEmployee."Pay Period Start Date", PayrollStatementEmployee."Pay Period End Date"));
                    ResultContainer[2] := '#NumericDataType';
                end;
            'P_EMPLOYEEJOINDATEMONTH':
                begin
                    ResultContainer[1] := FORMAT(PayrollFormulaKeyWord.P_EmployeeJoinDateMonth(PayrollStatementEmployee.Worker));
                    ResultContainer[2] := '#NumericDataType';
                end;
            'P_EMPLOYEEJOINDATEYEAR':
                begin
                    ResultContainer[1] := FORMAT(PayrollFormulaKeyWord.P_EmployeeJoinDateYear(PayrollStatementEmployee.Worker));
                    ResultContainer[2] := '#NumericDataType';
                end;
            'P_PERIODACCRUEDUNITS':
                begin
                    ResultContainer[1] := FORMAT(PayrollFormulaKeyWord.P_PeriodAccruedUnits(PayrollStatementEmployee.Worker, PayrollStatementEmployee."Pay Period Start Date", PayrollStatementEmployee."Pay Period End Date"));
                    ResultContainer[2] := '#NumericDataType';
                end;
            'P_TOTALABSENCEHOURS':
                begin
                    ResultContainer[1] := FORMAT(PayrollFormulaKeyWord.P_TotalAbsenceHours(PayrollStatementEmployee.Worker, PayrollStatementEmployee."Pay Period Start Date", PayrollStatementEmployee."Pay Period End Date"));
                    ResultContainer[2] := '#NumericDataType';
                end;
            'P_PERMISSIBLEABHRS':
                begin
                    ResultContainer[1] := FORMAT(PayrollFormulaKeyWord.P_PermissibleABHrs);
                    ResultContainer[2] := '#NumericDataType';
                end;
            'P_SERVICEYEARS':
                begin
                    ResultContainer[1] := FORMAT(PayrollFormulaKeyWord.P_SERVICEYEARS(PayrollStatementEmployee.Worker, NORMALDATE(PayrollStatementEmployee."Pay Period End Date")));
                    ResultContainer[2] := '#NumericDataType';
                end;
            'P_SEPARATIONDATE':
                begin
                    ResultContainer[1] := FORMAT(PayrollFormulaKeyWord.P_SeparationDate(PayrollStatementEmployee.Worker));
                    ResultContainer[2] := '#DateDataType';
                end;
            'P_SEPARATIONMONTH':
                begin
                    ResultContainer[1] := FORMAT(PayrollFormulaKeyWord.P_SeparationMonth(PayrollStatementEmployee.Worker));
                    ResultContainer[2] := '#NumericDataType';
                end;
            'P_UNSATISFACTORY_PERF_SERYRS':
                begin
                    ResultContainer[1] := FORMAT(PayrollFormulaKeyWord.P_UNSATISFACTORY_PERF_SERYRS(PayrollStatementEmployee.Worker));
                    ResultContainer[2] := '#NumericDataType';
                end;
            //P_SeparationReason
            'P_SEPARATIONREASON':
                begin
                    ResultContainer[1] := FORMAT(PayrollFormulaKeyWord.P_SeparationReason(PayrollStatementEmployee.Worker));
                    ResultContainer[2] := '#NumericDataType';
                end;
            // Avinash 18.04.2020
            'P_EMPLOYEENATIONALITY':
                begin
                    ResultContainer[1] := FORMAT(PayrollFormulaKeyWord.P_EMPLOYEENATIONALITY(PayrollStatementEmployee.Worker));
                    ResultContainer[2] := '#TextDataType';
                    // Message('Emp NAt. Code %1', ResultContainer[1]);
                end;
        // Avinash 18.04.2020
        end;
    end;

    procedure CreatePayrollStatementTransLinesInterest(_RecPayrollStatement: Record "Payroll Statement"; _RecPayrollStatementEmployee: Record "Payroll Statement Employee"; _LoanTypeSetup: Record "Loan Type Setup"; _LoanInstallmentGeneration: Record "Loan Installment Generation");
    var
        EarningCode: Record "Payroll Earning Code";
    begin
        with _RecPayrollStatement do begin
            with _RecPayrollStatementEmployee do begin
                if EarningCode.GET(_LoanTypeSetup."Earning Code for Interest") then begin
                    PayrollStatementTransLines2.RESET;
                    PayrollStatementTransLines2.SETRANGE("Payroll Statement ID", _RecPayrollStatement."Payroll Statement ID");
                    PayrollStatementTransLines2.SETRANGE("Payroll Statment Employee", RecEmployee."No.");
                    if PayrollStatementTransLines2.FINDLAST then;
                    PayrollStatementTransLines.INIT;
                    PayrollStatementTransLines."Payroll Statement ID" := _RecPayrollStatement."Payroll Statement ID";
                    PayrollStatementTransLines."Payroll Statment Employee" := _RecPayrollStatementEmployee.Worker;
                    PayrollStatementTransLines."Line No." := PayrollStatementTransLines2."Line No." + 10000;
                    PayrollStatementTransLines.INSERT;
                    PayrollStatementTransLines.Voucher := _RecPayrollStatementEmployee.Voucher;
                    PayrollStatementTransLines.Worker := _RecPayrollStatementEmployee.Worker;
                    PayrollStatementTransLines."Employee Name" := _RecPayrollStatementEmployee."Employee Name";
                    PayrollStatementTransLines."Payroll Pay Cycle" := _RecPayrollStatementEmployee."Payroll Pay Cycle";
                    PayrollStatementTransLines."Payroll Pay Period" := _RecPayrollStatementEmployee."Payroll Pay Period";
                    PayrollStatementTransLines."Payroll Month" := _RecPayrollStatementEmployee."Payroll Month";
                    PayrollStatementTransLines."Payroll Year" := _RecPayrollStatementEmployee."Payroll Year";
                    PayrollStatementTransLines."Currency Code" := _RecPayrollStatementEmployee."Currency Code";
                    PayrollStatementTransLines."Earning Code Type" := PayrollStatementTransLines."Earning Code Type"::Loan;
                    PayrollStatementTransLines."Earniing Code Short Name" := EarningCode."Short Name";
                    PayrollStatementTransLines."Payroll Earning Code" := EarningCode."Earning Code";
                    PayrollStatementTransLines."Payroll Earning Code Desc" := EarningCode.Description;
                    PayrollStatementTransLines."Calculation Units" := 1;
                    PayrollStatementTransLines."Earning Code Amount" := (_LoanInstallmentGeneration."Interest Installment Amount") * -1;
                    PayrollStatementTransLines."Per Unit Amount" := 0;
                    PayrollStatementTransLines.MODIFY;
                end;
            end;
        end;
    end;

    procedure CreatePayrollStatementTransPayAdj(_RecPayrollStatement: Record "Payroll Statement"; _RecPayrollStatementEmployee: Record "Payroll Statement Employee"; _PayrollAdjLines: Record "Payroll Adjmt. Journal Lines");
    var
        EarningCode: Record "Payroll Earning Code";
    begin
        with _RecPayrollStatement do begin
            with _RecPayrollStatementEmployee do begin
                EarningCode.GET(_PayrollAdjLines."Earning Code");
                PayrollStatementTransLines2.RESET;
                PayrollStatementTransLines2.SETRANGE("Payroll Statement ID", _RecPayrollStatement."Payroll Statement ID");
                PayrollStatementTransLines2.SETRANGE("Payroll Statment Employee", RecEmployee."No.");
                if PayrollStatementTransLines2.FINDLAST then;
                PayrollStatementTransLines.INIT;
                PayrollStatementTransLines."Payroll Statement ID" := _RecPayrollStatement."Payroll Statement ID";
                PayrollStatementTransLines."Payroll Statment Employee" := _RecPayrollStatementEmployee.Worker;
                PayrollStatementTransLines."Line No." := PayrollStatementTransLines2."Line No." + 10000;
                PayrollStatementTransLines.INSERT;
                PayrollStatementTransLines.Voucher := _RecPayrollStatementEmployee.Voucher;
                PayrollStatementTransLines.Worker := _RecPayrollStatementEmployee.Worker;
                PayrollStatementTransLines."Employee Name" := _RecPayrollStatementEmployee."Employee Name";
                PayrollStatementTransLines."Payroll Pay Cycle" := _RecPayrollStatementEmployee."Payroll Pay Cycle";
                PayrollStatementTransLines."Payroll Pay Period" := _RecPayrollStatementEmployee."Payroll Pay Period";
                PayrollStatementTransLines."Payroll Month" := _RecPayrollStatementEmployee."Payroll Month";
                PayrollStatementTransLines."Payroll Year" := _RecPayrollStatementEmployee."Payroll Year";
                PayrollStatementTransLines."Currency Code" := _RecPayrollStatementEmployee."Currency Code";
                PayrollStatementTransLines."Earning Code Type" := PayrollStatementTransLines."Earning Code Type"::"Pay Component";
                PayrollStatementTransLines."Earniing Code Short Name" := EarningCode."Short Name";
                PayrollStatementTransLines."Payroll Earning Code" := EarningCode."Earning Code";
                PayrollStatementTransLines."Payroll Earning Code Desc" := EarningCode.Description;
                PayrollStatementTransLines."Calculation Units" := 1;
                PayrollStatementTransLines."Earning Code Amount" := _PayrollAdjLines.Amount;
                PayrollStatementTransLines."Per Unit Amount" := 0;
                PayrollStatementTransLines.MODIFY;
            end;
        end;
    end;

    procedure Instantiate();
    begin
        CLEAR(PayrollStatement);
        CLEAR(PayrollStatementEmployee);
        CLEAR(RecEmployee);
        CLEAR(PayrollStatementLines);
        CLEAR(PayrollStatementLines2);
        CLEAR(PayrollStatementTransLines);
        CLEAR(PositionWorkerAssignment);
        CLEAR(PayrollPosition);
        CLEAR(PayPeriods);
        CLEAR(EmployeeEarningCodeGroup);
        CLEAR(EmployeeEarningCodes);
        CLEAR(EmployeeLeaveTypes);
        CLEAR(EmployeeBenefits);
        CLEAR(PayrollStatementTransLines2);
        CLEAR(ResultContainer);
        CLEAR(EmployeeWorkDate);
        CLEAR(TempDataTable);
        CLEAR(HCMEmployeeBenefits_GCC);
        CLEAR(_PayrollStatementEmployee);
        CLEAR(_PayrollStatementLines);
        CLEAR(PayrollErrorLog);
        CLEAR(FullandFinalCalculation);
        CLEAR(Window);
        CLEAR(Counter);
        CLEAR(TotalRecords);
    end;
}

