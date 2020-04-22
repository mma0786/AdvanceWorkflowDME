report 60015 "Update Increment Amount"
{
    // version LT_Payroll

    ProcessingOnly = true;
    UseRequestPage = false;

    dataset
    {
        dataitem("Integer"; "Integer")
        {
            DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));

            trigger OnAfterGetRecord();
            var
                LeaveTypes: Record "HCM Leave Types";
            begin
                /*              CLEAR(Counter);
                              Window.OPEN(
                                      'Processing Data' +
                                      '@1@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@');
                              PayrollIncrementSteps.RESET;
                              if PayrollIncrementSteps.FINDFIRST then
                                begin
                                  TotalRecords := PayrollIncrementSteps.COUNT;
                                    repeat
                                        Counter +=1 ;
                                        Window.UPDATE(1,ROUND(Counter/TotalRecords *10000,1));
                                        EarningCodeGroups.GET(PayrollIncrementSteps.Grade,PayrollIncrementSteps."Grade Category");
                                        Employee.RESET;
                                        Employee.SETRANGE("Earning Code Group",PayrollIncrementSteps.Grade);
                                        Employee.SETRANGE("Grade Category",PayrollIncrementSteps."Grade Category");
                                        Employee.SETRANGE("Increment step",FORMAT(PayrollIncrementSteps.Steps));
                                        if Employee.FINDFIRST then repeat
                                            PayrollEarningCodeWrkr.RESET;
                                            PayrollEarningCodeWrkr.SETRANGE(Worker,Employee."No.");
                                            PayrollEarningCodeWrkr.SETRANGE("Earning Code Group",PayrollIncrementSteps.Grade);
                                            if PayrollEarningCodeWrkr.FINDFIRST then begin
                                               repeat
                                                PayrollIncrementLine.RESET;
                                                PayrollIncrementLine.SETRANGE("Increment Line No.",PayrollIncrementSteps."Line No.");
                                                PayrollIncrementLine.SETRANGE(Grade,PayrollIncrementSteps.Grade);
                                                PayrollIncrementLine.SETRANGE("Earning Code",PayrollEarningCodeWrkr."Earning Code");
                                                if PayrollIncrementLine.FINDFIRST then
                                                  begin
                                                    if PayrollIncrementLine."Calculation Type" = PayrollIncrementLine."Calculation Type"::Amount then begin
                                                        PayrollEarningCodeWrkr."Package Calc Type" := PayrollEarningCodeWrkr."Package Calc Type"::Amount;
                                                        PayrollEarningCodeWrkr."Package Amount" := PayrollIncrementLine."Amount/Percentage";
                                                    end
                                                    else if PayrollIncrementLine."Calculation Type" = PayrollIncrementLine."Calculation Type"::Percentage then begin
                                                        PayrollEarningCodeWrkr."Package Calc Type" := PayrollEarningCodeWrkr."Package Calc Type"::Percentage;
                                                        PayrollEarningCodeWrkr."Package Amount" := PayrollIncrementLine."Amount/Percentage";
                                                    end;
                                                  end;
                                                  PayrollEarningCodeWrkr.MODIFY;
                                              until PayrollEarningCodeWrkr.NEXT =0;
                                            end;
                                        until Employee.NEXT =0;
                                  until PayrollIncrementSteps.NEXT=0;

                              end;*/
            end;

            trigger OnPostDataItem();
            begin
                Window.CLOSE;
                MESSAGE('Increment Amount Updated');
            end;

            trigger OnPreDataItem();
            var
                //PayrollIncrementSteps : Record "Payroll Increment Steps";
                IncrementStepValue: Option "Step-0","Step-1","Step-2","Step-3","Step-4","Step-5","Step-6","Step-7","Step-8","Step-9","Step-10","Step-11","Step-12","Step-13","Step-14","Step-15","Step-16","Step-17","Step-18","Step-19","Step-20","Step-21","Step-22","Step-23","Step-24","Step-25";
            begin
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }

        trigger OnQueryClosePage(CloseAction: Action): Boolean;
        begin
            if CloseAction in [ACTION::OK, ACTION::LookupOK] then begin
                if IncrementSteps = '' then
                    ERROR('Increment Step should not be blank');
                if gEmployeeEarningCodeGroup = '' then
                    ERROR('Earning Code Group Cannot be blank');
                if GradeCategory = '' then
                    ERROR('Grade Category should not be blank');
            end;
        end;
    }

    labels
    {
    }

    var
        EmpCode: Code[20];
        StartDateError: Label '"Effective Start Date can not be blank. "';
        EarningCodeGroups: Record "Earning Code Groups";
        CalnotDefined: Label '"Work Calendar is not defined for given date "';
        EmployeeEarngCodeGrp: Record "Employee Earning Code Groups";
        EmployeeEarningCodeGroup: Record "Employee Earning Code Groups";
        Window: Dialog;
        Counter: Integer;
        gEmployeeEarningCodeGroup: Code[20];
        IncrementSteps: Code[20];
        StepNumber: Integer;
        IncStepsError: Label '"Increment Steps should have a value "';
        GradeCategory: Code[50];
        TotalRecords: Integer;
        // PayrollIncrementSteps : Record "Payroll Increment Steps";
        PayrollEarningCodeWrkr: Record "Payroll Earning Code Wrkr";
        PayrollIncrementLine: Record "Payroll Increment Line";
        Employee: Record Employee;
}

