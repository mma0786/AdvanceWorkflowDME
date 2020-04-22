codeunit 60006 "Create Accrual Interim Line"
{
    // version LT_Payroll


    trigger OnRun();
    var
        CarryEmployeeInterimAccrualLines : Record "Employee Interim Accurals";
        AccrualComponentsEmployee : Record "Accrual Components Employee";
    begin
        if WORKDATE = CALCDATE('-CM',WORKDATE) then begin
           PeriodStartDate := CALCDATE('-CM',WORKDATE);
           PeriodEndDate := CALCDATE('CM',WORKDATE);
           Employee.RESET;
        //   Employee.SETRANGE("No.",'EMP-00049');
           if Employee.FINDFIRST then
              repeat
               EmployeeInterimAccrualLines3.RESET;
               EmployeeInterimAccrualLines3.SETRANGE("Worker ID",Employee."No.");
               EmployeeInterimAccrualLines3.SETRANGE("Start Date",PeriodStartDate);
               if not EmployeeInterimAccrualLines3.FINDFIRST then begin
                   EmployeeInterimAccrualLines2.RESET;
                   EmployeeInterimAccrualLines2.SETCURRENTKEY(Month,"Seq No");
                   EmployeeInterimAccrualLines2.SETRANGE("Worker ID",Employee."No.");
                   if EmployeeInterimAccrualLines2.FINDLAST then begin
                      CLEAR(PeriodStartDate);
                      CLEAR(PeriodEndDate);
                      PeriodStartDate := CALCDATE('CM+1D',EmployeeInterimAccrualLines2."Start Date");
                      PeriodEndDate := CALCDATE('CM',CALCDATE('CM+1D',EmployeeInterimAccrualLines2."Start Date"));
                      Period.RESET;
                      Period.SETCURRENTKEY("Period Type","Period Start");
                      Period.SETRANGE("Period Type",Period."Period Type"::Month);
                      Period.SETRANGE("Period Start",PeriodStartDate,PeriodEndDate);
                      if Period.FINDFIRST then begin
                        EmployeeInterimAccrualLines.INIT;
                        EmployeeInterimAccrualLines."Accrual ID" := EmployeeInterimAccrualLines2."Accrual ID";
                        EmployeeInterimAccrualLines."Line No." := EmployeeInterimAccrualLines2."Line No."+10000;
                        EmployeeInterimAccrualLines."Worker ID" := Employee."No.";
                        EmployeeInterimAccrualLines."Seq No" := EmployeeInterimAccrualLines2."Seq No"+1;
                        EmployeeInterimAccrualLines.Month := EmployeeInterimAccrualLines2.Month + 1;
                        EmployeeInterimAccrualLines."Start Date" := Period."Period Start";
                        EmployeeInterimAccrualLines."End Date" := Period."Period End";
                        EmployeeInterimAccrualLines."Accrual Interval Basis Date" := EmployeeInterimAccrualLines2."Accrual Interval Basis Date";
                        EmployeeInterimAccrualLines."Accrual Basis Date" := EmployeeInterimAccrualLines2."Accrual Basis Date";
                        EmployeeInterimAccrualLines."Monthly Accrual Units" := EmployeeInterimAccrualLines2."Monthly Accrual Units";
                        EmployeeInterimAccrualLines."Max Carryforward" := EmployeeInterimAccrualLines2."Max Carryforward";
                        EmployeeInterimAccrualLines."Adjustment Units" := EmployeeInterimAccrualLines2."Adjustment Units";
                        if EmployeeInterimAccrualLines.INSERT then begin
                           AccrualComponentsEmployee.RESET;
                           AccrualComponentsEmployee.SETRANGE("Accrual ID",EmployeeInterimAccrualLines."Accrual ID");
                           AccrualComponentsEmployee.SETRANGE("Worker ID",EmployeeInterimAccrualLines."Worker ID");
                           if AccrualComponentsEmployee.FINDFIRST then begin
                              CarryEmployeeInterimAccrualLines.RESET;
                              CarryEmployeeInterimAccrualLines.SETRANGE("Accrual ID",EmployeeInterimAccrualLines2."Accrual ID");
                              CarryEmployeeInterimAccrualLines.SETRANGE("Worker ID",Employee."No.");
                              CarryEmployeeInterimAccrualLines.SETRANGE("Carryforward Month",true);
                              if CarryEmployeeInterimAccrualLines.FINDFIRST then begin
                                if (Period."Period Start" = CALCDATE('-CM+'+FORMAT(AccrualComponentsEmployee."Roll Over Period")+'M',CarryEmployeeInterimAccrualLines."Start Date")) then begin
                                    EmployeeInterimAccrualLines."Carryforward Month" := true;
                                    if EmployeeInterimAccrualLines2."Closing Balance" > AccrualComponentsEmployee."Max Carry Forward" then
                                        EmployeeInterimAccrualLines."Carryforward Deduction" := AccrualComponentsEmployee."Max Carry Forward"
                                                                                              - EmployeeInterimAccrualLines2."Closing Balance";


                                end;
                              end
                              else begin
                                if (Period."Period Start" = CALCDATE('-CM+'+FORMAT(AccrualComponentsEmployee."Roll Over Period")+'M',AccrualComponentsEmployee."Accrual Basis Date")) then begin
                                    EmployeeInterimAccrualLines."Carryforward Month" := true;
                                    if EmployeeInterimAccrualLines2."Closing Balance" > AccrualComponentsEmployee."Max Carry Forward" then
                                        EmployeeInterimAccrualLines."Carryforward Deduction" := AccrualComponentsEmployee."Max Carry Forward"
                                                                                              - EmployeeInterimAccrualLines2."Closing Balance";


                                end;
                              end;
                              EmployeeInterimAccrualLines."Opening Balance Unit" := EmployeeInterimAccrualLines2."Closing Balance";
                              EmployeeInterimAccrualLines."Closing Balance" := (EmployeeInterimAccrualLines."Opening Balance Unit"
                                                                          + EmployeeInterimAccrualLines."Carryforward Deduction"
                                                                          + EmployeeInterimAccrualLines."Monthly Accrual Units"
                                                                          + EmployeeInterimAccrualLines."Adjustment Units")
                                                                          - EmployeeInterimAccrualLines."Leaves Consumed Units";
                              EmployeeInterimAccrualLines.MODIFY;
                             end;
                          end;
                      end;
                   end;
              end;
            until Employee.NEXT =0;
        end;
    end;

    var
        Employee : Record Employee;
        EmployeeInterimAccrualLines : Record "Employee Interim Accurals";
        EmployeeInterimAccrualLines2 : Record "Employee Interim Accurals";
        PeriodStartDate : Date;
        PeriodEndDate : Date;
        Period : Record Date;
        EmployeeInterimAccrualLines3 : Record "Employee Interim Accurals";
}

