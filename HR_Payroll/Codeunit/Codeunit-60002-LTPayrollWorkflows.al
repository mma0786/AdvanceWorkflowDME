codeunit 60002 "LT Payroll Workflows"
{
    // version LT_Payroll


    trigger OnRun();
    begin
        CalculateComponents(Worker, gFromDate, gToDate, gRecordInsertList, gPayrollStatementEmployeeTrans_GCC, gPayrollStatementEmployee_GCC, gPayrollTransactionType_GCC, gPayrollStatementCalcType_GCC);
    end;

    var
        ////  LevHREvaluation : DotNet "'LevhrEvaluation, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null'.APIClientConsole.HrmPlus" RUNONCLIENT;
        Worker: Record Employee;
        gFromDate: Date;
        gToDate: Date;
        gRecordInsertList: Integer;
        gPayrollStatementEmployeeTrans_GCC: Record "Payroll Statement Emp Trans.";
        gPayrollStatementEmployee_GCC: Record "Payroll Statement Employee";
        gPayrollTransactionType_GCC: Record "Payroll Statement Lines";
        gPayrollStatementCalcType_GCC: Integer;
        ///////////  LevHREvaluation2 : DotNet "'LevhrEvaluation, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null'.APIClientConsole.HrmPlus" RUNONCLIENT;
        ResultContainer: array[2] of Text;
        PayCycle: Record "Pay Cycles";
        PayPeriods: Record "Pay Periods";
    //////////// ParameterTable : DotNet "'System.Data, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Data.DataTable";

    procedure CalculateComponents(HcmWorkerRecId: Record Employee; FromDate: Date; ToDate: Date; RecordInsertList: Integer; PayrollStatementEmployeeTrans_GCC: Record "Payroll Statement Emp Trans."; PayrollStatementEmployee_GCC: Record "Payroll Statement Employee"; PayrollTransactionType_GCC: Record "Payroll Statement Lines"; PayrollStatementCalcType_GCC: Integer);
    var
        // // // ParameterTable : DotNet "'System.Data, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Data.DataTable";
        // // // PayComponentTable : DotNet "'System.Data, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Data.DataTable";
        // // // BenefitTable : DotNet "'System.Data, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Data.DataTable";
        // // // ResultTable : DotNet "'System.Data, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Data.DataTable";
        TotalRows: Integer;
        i: Integer;
        j: Integer;
        // // ResultDataRow: DotNet "'System.Data, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Data.DataRow";
        // // ResultRowCollection: DotNet "'System.Data, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Data.DataRowCollection";
        HasError: Boolean;
        ErrorString: Text;
        ErrorLog: Record "Payroll Error Log";
    begin
        // // // LevHREvaluation := LevHREvaluation.HrmPlus;
        // // // ParameterTable := ParameterTable.DataTable;
        // // // PayComponentTable := PayComponentTable.DataTable;
        // // // BenefitTable := BenefitTable.DataTable;

        // // // GetParameterKeyValues(ParameterTable, PayrollStatementEmployee_GCC.Worker, FromDate, ToDate);

        // // // ResultTable := LevHREvaluation.PageInIt(ParameterTable, PayComponentTable, BenefitTable);
        // // // ResultRowCollection := ResultTable.Rows;
        // // // TotalRows := ResultRowCollection.Count;
        // // // MESSAGE('%1', TotalRows);
        // // // for i := 0 to TotalRows - 1 do begin
        // // //     ResultDataRow := ResultRowCollection.Item(i);

        // // // end;
    end;

    // // // procedure GetParameterKeyValues(var ParameterTable: DotNet "'System.Data, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Data.DataTable"; EmployeeEarningCodeGroup: Code[20]; _fromDate: Date; _toDate: Date);
    // // // var
    // // //     _ParameterTable: DotNet "'System.Data, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Data.DataTable";
    // // //     PayrollFormulaKeyWords: Record "Payroll Formula";
    // // //     PayrollParameterHelper: Integer;
    // // //     Column: DotNet "'System.Data, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Data.DataColumn";
    // // //     ColumnCollection: DotNet "'System.Data, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Data.DataColumnCollection";
    // // //     Row: DotNet "'System.Data, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Data.DataRow";
    // // //     RowCollection: DotNet "'System.Data, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Data.DataRowCollection";
    // // //     EmployeeLeaveTypes: Record "HCM Leave Types Wrkr";
    // // //     EmployeeBenefits: Record "HCM Benefit Wrkr";
    // // //     PayrollWorkerPositionEarningCode: Code[20];
    // // //     EmployeeEarning: Code[20];
    // // // begin
    // // //     _ParameterTable := _ParameterTable.DataTable('Table1');
    // // //     ColumnCollection := _ParameterTable.Columns();
    // // //     RowCollection := _ParameterTable.Rows();

    // // //     Column := Column.DataColumn;
    // // //     Column.ColumnName := 'Key ID';
    // // //     _ParameterTable.Columns.Add(Column);

    // // //     Column := Column.DataColumn;
    // // //     Column.ColumnName := 'Key Value';
    // // //     _ParameterTable.Columns.Add(Column);

    // // //     Column := Column.DataColumn;
    // // //     Column.ColumnName := 'Data Type';
    // // //     _ParameterTable.Columns.Add(Column);


    // // //     PayrollFormulaKeyWords.RESET;
    // // //     PayrollFormulaKeyWords.SETRANGE("Formula Key Type", PayrollFormulaKeyWords."Formula Key Type"::Parameter);
    // // //     if PayrollFormulaKeyWords.FINDFIRST then
    // // //         repeat
    // // //             GetParameterKey(PayrollFormulaKeyWords."Formula Key");
    // // //             Row := _ParameterTable.NewRow();
    // // //             Row.Item(0, PayrollFormulaKeyWords."Formula Key");
    // // //             Row.Item(1, ResultContainer[1]);
    // // //             Row.Item(2, ResultContainer[2]);
    // // //             _ParameterTable.Rows.Add(Row);
    // // //         until PayrollFormulaKeyWords.NEXT = 0;

    // // //     PayrollFormulaKeyWords.RESET;
    // // //     PayrollFormulaKeyWords.SETRANGE("Formula Key Type", PayrollFormulaKeyWords."Formula Key Type"::Custom);
    // // //     if PayrollFormulaKeyWords.FINDFIRST then
    // // //         repeat
    // // //             Row := _ParameterTable.NewRow();
    // // //             Row.Item(0, PayrollFormulaKeyWords."Formula Key");
    // // //             Row.Item(1, ResultContainer[1]);
    // // //             Row.Item(2, ResultContainer[2]);
    // // //             _ParameterTable.Rows.Add(Row);
    // // //         until PayrollFormulaKeyWords.NEXT = 0;
    // // // end;

    procedure GetPayComponents(EmployeeEarningCodeGroup: Code[20]; _fromDate: Date; _toDate: Date);
    begin
    end;

    procedure GetBenefitComponents(EmployeeEarningCodeGroup: Code[20]; _fromDate: Date; _toDate: Date);
    begin
    end;

    procedure GetParameterKey(_FormulaKey: Code[100]);
    var
        PayrollFormulaKeyWord: Codeunit "Formula Keyword";
    begin
        case _FormulaKey of
            'P_PeriodEndDate':
                begin
                    ResultContainer[1] := FORMAT(PayrollFormulaKeyWord.P_PeriodEndDate(Worker."No.", '', 0));
                    ResultContainer[2] := '#DateDataType';
                end;
        end;
    end;

    //event ParameterTable(sender : Variant;e : DotNet "'System.Data, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Data.DataColumnChangeEventArgs");
    //begin
    /*
    */
    //end;

    //event ParameterTable(sender : Variant;e : DotNet "'System.Data, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Data.DataColumnChangeEventArgs");
    //begin
    /*
    */
    //end;

    //event ParameterTable(sender : Variant;e : DotNet "'mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.EventArgs");
    //begin
    /*
    */
    //end;

    //event ParameterTable(sender : Variant;e : DotNet "'System.Data, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Data.DataRowChangeEventArgs");
    //begin
    /*
    */
    //end;

    //event ParameterTable(sender : Variant;e : DotNet "'System.Data, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Data.DataRowChangeEventArgs");
    //begin
    /*
    */
    //end;

    //event ParameterTable(sender : Variant;e : DotNet "'System.Data, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Data.DataRowChangeEventArgs");
    //begin
    /*
    */
    //end;

    //event ParameterTable(sender : Variant;e : DotNet "'System.Data, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Data.DataRowChangeEventArgs");
    //begin
    /*
    */
    //end;

    //event ParameterTable(sender : Variant;e : DotNet "'System.Data, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Data.DataTableClearEventArgs");
    //begin
    /*
    */
    //end;

    //event ParameterTable(sender : Variant;e : DotNet "'System.Data, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Data.DataTableClearEventArgs");
    //begin
    /*
    */
    //end;

    //event ParameterTable(sender : Variant;e : DotNet "'System.Data, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Data.DataTableNewRowEventArgs");
    //begin
    /*
    */
    //end;

    //event ParameterTable(sender : Variant;e : DotNet "'mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.EventArgs");
    //begin
    /*
    */
    //end;
}

