codeunit 60017 "Cac Dates"
{
    // version LT_Payroll


    trigger OnRun();
    var
        RecordLink: Record "Record Link";
        RecordRef: RecordRef;
        Emp: Record Employee;
        RecordId: RecordID;
        RecordLink2: Record "Record Link";
        EmployeeInterimAccrualLines: Record "Employee Interim Accurals";
    begin
        /*
        EmployeeInterimAccrualLines.RESET;
        EmployeeInterimAccrualLines.SETRANGE("Accrual ID",'ACC000013');
        EmployeeInterimAccrualLines.SETRANGE("Worker ID",'EMP-00096');
        EmployeeInterimAccrualLines.SETRANGE("Start Date",120120D,123120D);
        IF EmployeeInterimAccrualLines.FINDFIRST THEN
           MESSAGE('%1',EmployeeInterimAccrualLines.COUNT);
        */
        MESSAGE('%1', CALCDATE('-CM+' + FORMAT(24) + 'M', 20190101D));
        /*
        Emp.RESET;
        Emp.SETRANGE("No.",'EMP-00044');
        IF Emp.FINDFIRST THEN
           RecordId := Emp.RECORDID;
        
        RecordLink.RESET;
        RecordLink.SETRANGE("Record ID",RecordId);
        IF RecordLink.FINDFIRST THEN BEGIN
           Emp.RESET;
           Emp.SETRANGE("No.",'EMP-00045');
           Emp.FINDFIRST;
           RecordLink2.INIT;
           RecordLink2."Link ID" := 0;
           RecordLink2."Record ID" := Emp.RECORDID;
           RecordLink2.URL1 := RecordLink.URL1;
           RecordLink2.Description := RecordLink.Description;
           RecordLink2.Created := CURRENTDATETIME;
           RecordLink2."User ID" := USERID;
           RecordLink2.INSERT;
        
        END;
        */
        /*
        ActualStartDate := 070120D;
        //ActualEndDate := TODAY;
        
        PeriodStartDate := CALCDATE('CM+1D',ActualStartDate);
        PeriodEndDate := CALCDATE('CM',CALCDATE('CM+1D',ActualStartDate));
        
        
        MESSAGE('%1',PeriodStartDate);
        MESSAGE('%1',PeriodEndDate);
        */
        /*
        //Item."No." := '1100';
        Item.RESET;
        Item.FIND('<=>') ;
        MESSAGE(Text0001,Item."No.",Item.Description,Item."Unit Price");
        */
        //ELSE
        //MESSAGE(Text0002);


        /*
        AccountingPeriod.RESET;
        AccountingPeriod.SETRANGE("New Fiscal Year",TRUE);
        AccountingPeriod."Starting Date" := 082717D;
        IF AccountingPeriod.FIND('=<') THEN BEGIN
           MESSAGE('%1',AccountingPeriod."Starting Date");
        END
        ELSE BEGIN
          AccountingPeriod.RESET;
          IF AccountingPeriod.FINDFIRST THEN
            MESSAGE('%1',AccountingPeriod."Starting Date");
        END;
        */
        /*
        AccountingPeriod.RESET;
        AccountingPeriod.SETRANGE("New Fiscal Year",TRUE);
        AccountingPeriod."Starting Date" := WORKDATE;
        AccountingPeriod.FIND('=<');
        MESSAGE('%1',AccountingPeriod."Starting Date");
        */
        /*
        ResultContainer := '200,000';
        MESSAGE('%1',DELCHR(ResultContainer,'=',','));
        */
        /*
        
        
        BirthDate := DATE2DMY(ActualStartDate,1);
        BirthMonth := DATE2DMY(ActualStartDate,2);
        BirthYear := DATE2DMY(ActualStartDate,3);
        
        CurrentDate := DATE2DMY(ActualEndDate,1);
        CurrentMonth := DATE2DMY(ActualEndDate,2);
        CurrentYear := DATE2DMY(ActualEndDate,3);
        
        IF ActualEndDate <> 0D THEN
          MESSAGE('%1',(CALCDATE('-CY',ActualEndDate)))
        
        */


        /*
        StartDate := 050519D;
        NoOfPeriods := 5;
        ActualStartDate := 042919D;
        MESSAGE('%1',StartDate-ActualStartDate);
        IF (StartDate-ActualStartDate) > NoOfPeriods THEN
              MESSAGE('You can apply leave only after %1 ',CALCDATE('-'+FORMAT(NoOfPeriods)+'D',StartDate));
        
        ActualStartDate := CALCDATE('-CD',StartDate);
        ActualEndDate := CALCDATE('-CD-1D+'+FORMAT(NoOfPeriods)+'D',StartDate);
        MESSAGE('Month Start Date %1',ActualStartDate);
        MESSAGE('Month End Date %1',ActualEndDate);
        
        Period.RESET;
        Period.SETRANGE("Period Type",Period."Period Type"::Date);
        Period.SETRANGE("Period Start",ActualStartDate,ActualEndDate);
        IF Period.FINDFIRST THEN
          REPEAT
             MESSAGE('Period Start Date %1, Period End Date %2',Period."Period Start",CALCDATE('CD',Period."Period Start"));
            UNTIL Period.NEXT=0;
            */

        /*
        NameDataTypeSubtypeLength
        LineRecRecordTable50009
           LineRec.RESET;
           LineRec.SETCURRENTKEY("Employee ID",Date,"From Time","To Time");
           LineRec.SETRANGE("Employee ID",'EMP-00009');
           LineRec.SETRANGE(Date,080119D);
           LineRec.SETFILTER("From Time",'<=%1',210000T);
           LineRec.SETFILTER("To Time",'>=%1',220000T);
           IF LineRec.FINDFIRST THEN
             ERROR('Request Time Overlaps. Please select Valid Time %1',LineRec."Pre-Approved OT Request ID");
             */
        /*
          EmployeeWorkCalendar.RESET;
          EmployeeWorkCalendar.SETRANGE("Employee Code",'EMP-00009');
          EmployeeWorkCalendar.SETRANGE("Trans Date",080119D);
          IF EmployeeWorkCalendar.FINDFIRST THEN BEGIN
             WorkCalendarLineRec.RESET;
             WorkCalendarLineRec.SETRANGE("Calendar ID",EmployeeWorkCalendar."Calander id");
             WorkCalendarLineRec.SETRANGE("Trans Date",EmployeeWorkCalendar."Trans Date");
             WorkCalendarLineRec.SETFILTER("From Time",'<%1',170000T);
             WorkCalendarLineRec.SETFILTER("To Time",'>%1',170000T); // Murali bro code
             IF WorkCalendarLineRec.FINDFIRST THEN
                ERROR('From Time should not fall between Working hours('+ FORMAT(WorkCalendarLineRec."From Time") + ' & ' + FORMAT(WorkCalendarLineRec."To Time")+')' );
        
             WorkCalendarLineRec.RESET;
             WorkCalendarLineRec.SETRANGE("Calendar ID",EmployeeWorkCalendar."Calander id");
             WorkCalendarLineRec.SETRANGE("Trans Date",EmployeeWorkCalendar."Trans Date");
             WorkCalendarLineRec.SETFILTER("From Time",'<%1',190000T);
             WorkCalendarLineRec.SETFILTER("To Time",'>%1',190000T); // Murali bro code
             IF WorkCalendarLineRec.FINDFIRST THEN
                ERROR('To Time should not fall between Working hours('+ FORMAT(WorkCalendarLineRec."From Time") + ' & ' + FORMAT(WorkCalendarLineRec."To Time")+')' );
         END;
        */


        //MESSAGE('%1',TEstReport.STRREPLACE('[BA]','[','('));

        //MESSAGE('%1',TEstReport.STRREPLACE(TEstReport.STRREPLACE('[BA]','[','('),']',')'));

    end;

    var
        Item: Record Item;
        StartDate: Date;
        ActualStartDate: Date;
        ActualEndDate: Date;
        Period: Record Date;
        NoOfPeriods: Integer;
        StartTime: Time;
        EndTime: Time;
        WorkCalendarLineRec: Record "Work Calendar Date Line";
        EmployeeWorkCalendar: Record EmployeeWorkDate_GCC;
        /////// TEstReport: Report "Generate Payroll Statements";
        ResultContainer: Text;
        CurrentYear: Integer;
        CurrentMonth: Integer;
        CurrentDate: Integer;
        BirthDate: Integer;
        BirthMonth: Integer;
        BirthYear: Integer;
        AccountingPeriod: Record "Accounting Period";
        Text0001: Label 'Item No. %1.\Description: %2. Price: $%3.';
        Text0002: Label 'The item was not found.';
        PeriodStartDate: Date;
        PeriodEndDate: Date;
}

