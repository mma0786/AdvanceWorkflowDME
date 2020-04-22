codeunit 60010 "Test CU"
{
    // version LT_Payroll


    trigger OnRun();
    begin
        /*
        a := a + 1 ;
        MESSAGE('%1',a);
        */
        /*
          PositionWorkerAssignment.RESET;
          PositionWorkerAssignment.SETRANGE(Worker,'EMP-00152');
          PositionWorkerAssignment.SETFILTER("Effective Start Date",'<=%1',043019D);
          PositionWorkerAssignment.SETFILTER("Effective End Date",'>=%1|%2',043019D,0D);
          IF PositionWorkerAssignment.FINDFIRST THEN
             MESSAGE('%1',PositionWorkerAssignment."Position ID")
          ELSE
             MESSAGE('2');
             */
        
        /*
        IF Employee.FINDFIRST THEN
        REPEAT
           Employee."Seperation Reason" := '';
           Employee.MODIFY;
        UNTIL Employee.NEXT =0;
        */
        PayrollEarningCodeWrkr.RESET;
        MESSAGE('Done');

    end;

    var
        a : Integer;
        b : Integer;
        PositionWorkerAssignment : Record "Payroll Job Pos. Worker Assign";
        Employee : Record Employee;
        PayrollEarningCodeWrkr : Record "Payroll Earning Code Wrkr";
}

