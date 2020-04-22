table 60124 "Time Attendance"
{

    fields
    {
        field(1; "Entry No."; Integer)
        {
            AutoIncrement = true;
        }
        field(2; "Employee ID"; Code[20])
        {
            TableRelation = Employee;

            trigger OnValidate()
            begin
                if Employee.GET("Employee ID") then
                    if Employee.Status <> Employee.Status::Active then
                        ERROR(Text50004, "Employee ID");

                if "Employee ID" <> '' then
                    if Employee.GET("Employee ID") then
                        Name := Employee."First Name" + '' + Employee."Last Name";
            end;
        }
        field(3; Name; Text[150])
        {
            Editable = false;
        }
        field(4; Date; Date)
        {

            trigger OnValidate()
            begin
                if Employee.GET("Employee ID") then begin

                    if (Date < Employee."Joining Date") then
                        ERROR(Text50003, "Employee ID", Date);

                    if Employee."Termination Date" <> 0D then
                        if (Date > Employee."Termination Date") then
                            ERROR(Text50003, "Employee ID", Date);

                end;
                //same day entry not allowed
                CalcForSameDayCheckIn;

                LeaveRequestHeader.SETRANGE("Personnel Number", "Employee ID");
                LeaveRequestHeader.SETFILTER("Start Date", '<=%1', Date);
                LeaveRequestHeader.SETFILTER("End Date", '>%1', Date);
                if LeaveRequestHeader.FINDFIRST then
                    ERROR(Text50006, "Employee ID", LeaveRequestHeader."Start Date", LeaveRequestHeader."End Date");

                EmployeeWorkDate_GCC.RESET;
                EmployeeWorkDate_GCC.SETRANGE("Employee Code", "Employee ID");
                EmployeeWorkDate_GCC.SETRANGE("Trans Date", Date);
                if EmployeeWorkDate_GCC.FINDFIRST then
                    "Day Type" := EmployeeWorkDate_GCC."Calculation Type";
            end;
        }
        field(5; "Day Type"; Option)
        {
            Description = 'Changed OptionString';
            Editable = false;
            OptionCaption = 'Working Day,Weekly Off,Public Holiday';
            OptionMembers = "Working Day","Weekly Off","Public Holiday";

            trigger OnValidate()
            begin
                CheckMandatoryFields;
            end;
        }
        field(6; "Start Time"; Time)
        {

            trigger OnValidate()
            begin

                CheckMandatoryFields;
                CheckSameDayCheckin;
                if "Start Time" = 000000T then begin
                    "End Time" := 000000T;
                    "Normal Hrs" := 0;
                    "Absent Hours" := 0;
                    "Overtime Hrs" := 0;
                end;
                if "End Time" <> 000000T then
                    VALIDATE("End Time");
            end;
        }
        field(7; "End Time"; Time)
        {

            trigger OnValidate()
            begin
                //Total Hours
                NormalHs := 0;
                if "End Time" <> xRec."End Time" then begin
                    "Normal Hrs" := 0;
                    "Absent Hours" := 0;
                    "Overtime Hrs" := 0;
                end;
                CLEAR(TotHrs);
                //Same day entry is not allowed
                CalcForSameDayCheckIn;

                StartTime := FORMAT("Start Time", 8, '<Hours24,2>:<Minutes,2>:<Seconds,2>');
                EndTime := FORMAT("End Time", 8, '<Hours24,2>:<Minutes,2>:<Seconds,2>');
                if EndTime < StartTime then
                    ERROR(Text50007, "End Time", "Start Time");

                "Total Hours" := (((("End Time" - "Start Time") / 1000) / 60) / 60);

                EmpErnCodGpRec.RESET;
                EmpErnCodGpRec.SETRANGE("Employee Code", "Employee ID");
                EmpErnCodGpRec.SETRANGE("Valid To", 0D);
                if EmpErnCodGpRec.FINDFIRST then begin
                    //EmpErnCodGpRec.Calander
                    WorkCalendarLineRec.RESET;
                    WorkCalendarLineRec.SETRANGE("Calendar ID", EmpErnCodGpRec.Calander);
                    WorkCalendarLineRec.SETRANGE("Trans Date", Date);
                    if WorkCalendarLineRec.FINDSET then begin
                        repeat
                            TotHrs += WorkCalendarLineRec.Hours;
                        until WorkCalendarLineRec.NEXT = 0;
                    end;
                end;
                "Normal Hrs" := TotHrs;
                HrsWorked := ABS("Normal Hrs" - "Total Hours");
                if "Day Type" = "Day Type"::"Working Day" then begin
                    if TotHrs < "Total Hours" then
                        "Overtime Hrs" := HrsWorked
                    else
                        "Absent Hours" := HrsWorked;
                end else begin
                    "Overtime Hrs" := "Total Hours";
                    "Normal Hrs" := 0;
                end
                /* commented by sathish
                
                WorkCalendar.RESET;
                IF WorkCalendar.FINDFIRST THEN BEGIN
                   WorkCalendarDateLine.RESET;
                   WorkCalendarDateLine.SETCURRENTKEY("Calendar ID","Trans Date","Line No.");
                   WorkCalendarDateLine.SETRANGE("Calendar ID",WorkCalendar."Calendar ID");
                   WorkCalendarDateLine.SETRANGE("Trans Date",Date);
                   WorkCalendarDateLine.CALCSUMS(Hours);
                   NormalHs:=WorkCalendarDateLine.Hours;
                   IF "Total Hours" >= WorkCalendarDateLine.Hours THEN
                       "Normal Hrs":= WorkCalendarDateLine.Hours
                   ELSE
                     "Normal Hrs":="Total Hours";
                   IF "Total Hours"<TotHrs THEN
                     "Absent Hours":=WorkCalendarDateLine.Hours-"Total Hours"
                   ELSE
                   "Absent Hours":=0;
                   IF "Total Hours">TotHrs THEN
                     "Overtime Hrs":="Total Hours"-"Normal Hrs"
                   ELSE
                    "Overtime Hrs":=0;
                END;*/

                // commented while implementing Total Hours Column as per requirement.
                /*
                CalcNormalHours;
                CalcOvertimeHours;
                
                StartTime := FORMAT("Start Time",8,'<Hours24,2>:<Minutes,2>:<Seconds,2>');
                EndTime := FORMAT("End Time",8,'<Hours24,2>:<Minutes,2>:<Seconds,2>');
                
                IF EndTime < StartTime THEN
                    ERROR(Text50007,"End Time","Start Time");
                
                CheckMandatoryFields;
                
                WorkCalendar.RESET;
                IF WorkCalendar.FINDFIRST THEN BEGIN
                   WorkCalendarDateLine.RESET;
                   WorkCalendarDateLine.SETCURRENTKEY("Calendar ID","Trans Date","Line No.");
                   WorkCalendarDateLine.SETRANGE("Calendar ID",WorkCalendar."Calendar ID");
                   WorkCalendarDateLine.SETRANGE("Trans Date",Date);
                   WorkCalendarDateLine.CALCSUMS(Hours);
                   IF WorkCalendarDateLine.Hours <> 0 THEN
                      IF "Normal Hrs" < WorkCalendarDateLine.Hours THEN
                         "Absent Hours" :=  WorkCalendarDateLine.Hours - "Normal Hrs";
                END;
                */

            end;
        }
        field(8; "Normal Hrs"; Decimal)
        {
            MaxValue = 24;

            trigger OnValidate()
            begin

                CheckMandatoryFields;
            end;
        }
        field(9; "Overtime Hrs"; Decimal)
        {
            MaxValue = 24;
            MinValue = 0;

            trigger OnValidate()
            begin
                CheckMandatoryFields;

                if "Overtime Hrs" <> 0 then
                    if ("Overtime Hrs" + "Normal Hrs") > 24 then
                        ERROR(Text50001);
            end;
        }
        field(10; "Project Id"; Code[20])
        {

            trigger OnValidate()
            begin
                CheckMandatoryFields;
            end;
        }
        field(11; "Overtime Approval Status"; Option)
        {
            Editable = false;
            OptionCaption = 'Not Approved,Not Required,Pre-Approved,Approved';
            OptionMembers = "Not Approved","Not Required","Pre-Approved",Approved;

            trigger OnValidate()
            begin
                CheckMandatoryFields;
            end;
        }
        field(12; Confirmed; Boolean)
        {
            Editable = false;

            trigger OnValidate()
            begin
                CheckMandatoryFields;
            end;
        }
        field(13; Remarks; Text[250])
        {
        }
        field(14; "Indoor Check-in"; Option)
        {
            OptionCaption = ' ,Gate 1,Gate 2,Gate 3,Gate 4,Gate 5';
            OptionMembers = " ","Gate 1","Gate 2","Gate 3","Gate 4","Gate 5";
        }
        field(15; "Outdoor Check-out"; Option)
        {
            OptionCaption = ' ,Gate 1,Gate 2,Gate 3,Gate 4,Gate 5';
            OptionMembers = " ","Gate 1","Gate 2","Gate 3","Gate 4","Gate 5";
        }
        field(16; "Error Log"; BLOB)
        {
        }
        field(17; "Absent Hours"; Decimal)
        {
        }
        field(18; "Total Hours"; Decimal)
        {
        }
        field(19; "Worked Hours"; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "Employee ID", Date)
        {
            Clustered = true;
        }
        key(Key2; Date, "Employee ID", Confirmed)
        {
            SumIndexFields = "Absent Hours";
        }
    }

    fieldgroups
    {
    }

    var
        Employee: Record Employee;
        Text50001: Label 'Total Working hours can not exceed 24 Hours';
        Text50002: Label 'Employee ID %1 have already punched out at %2 %3';
        EmployeeWorkDate_GCC: Record EmployeeWorkDate_GCC;
        Text50003: Label 'Employee %1 is not active on %2 date';
        Text50004: Label 'Status of employee %1 is not active';
        LeaveRequestHeader: Record "Leave Request Header";
        Text50006: Label 'Employee %1 is on Active Leave from %1 to %2';
        StartTime: Text;
        Text50007: Label 'End Time %1 is less than Start Time %2';
        EndTime: Text;
        WorkCalendarDateLine: Record "Work Calendar Date Line";
        Workinghours: Integer;
        WorkCalendarDateLine1: Record "Work Calendar Date Line";
        NormalDuration: Duration;
        OvertimeDuration: Duration;
        StandardDuration: Duration;
        WorkingDuration: Duration;
        WorkCalendar: Record "Work Calendar Header";
        TotaHrs: Decimal;
        NormalHs: Decimal;
        Text50008: Label 'There is already an entry exists for the same day.';
        EmpErnCodGpRec: Record "Employee Earning Code Groups";
        WorkCalendarLineRec: Record "Work Calendar Date Line";
        TotHrs: Decimal;
        HrsWorked: Decimal;

    local procedure CheckMandatoryFields()
    begin
        TESTFIELD("Employee ID");
        TESTFIELD(Date);
    end;

    local procedure CheckSameDayCheckin()
    var
        TimeAttendance: Record "Time Attendance";
    begin
        TimeAttendance.RESET;
        TimeAttendance.SETCURRENTKEY("Employee ID", Date, "Start Time");
        TimeAttendance.SETRANGE("Employee ID", "Employee ID");
        TimeAttendance.SETRANGE(Date, Date);
        TimeAttendance.SETASCENDING("Start Time", true);
        if TimeAttendance.FIND('-') then
            repeat
                if TimeAttendance."Start Time" < "Start Time" then begin
                    if TimeAttendance."End Time" > "Start Time" then
                        ERROR(Text50002, TimeAttendance."Employee ID", TimeAttendance.Date, TimeAttendance."End Time");
                end;

            until TimeAttendance.NEXT = 0;
    end;

    //[Scope('Internal')]
    procedure CalcNormalHours()
    begin
        CLEAR(NormalDuration);

        EmployeeWorkDate_GCC.SETRANGE("Employee Code", "Employee ID");
        EmployeeWorkDate_GCC.SETRANGE("Trans Date", Date);
        ;
        if EmployeeWorkDate_GCC.FINDFIRST then begin
            WorkCalendarDateLine.SETRANGE("Calendar ID", EmployeeWorkDate_GCC."Calander id");
            WorkCalendarDateLine.SETRANGE("Trans Date", EmployeeWorkDate_GCC."Trans Date");
            if WorkCalendarDateLine.FINDFIRST then begin
                WorkCalendarDateLine1.SETRANGE("Calendar ID", EmployeeWorkDate_GCC."Calander id");
                WorkCalendarDateLine1.SETRANGE("Trans Date", EmployeeWorkDate_GCC."Trans Date");
                if WorkCalendarDateLine1.FINDLAST then;


                if ("Start Time" <= WorkCalendarDateLine."From Time") then begin
                    NormalDuration := "End Time" - WorkCalendarDateLine."From Time";
                    "Normal Hrs" := ((NormalDuration / 1000) / 60) / 60;
                end;


                if ("Start Time" >= WorkCalendarDateLine."From Time") then begin
                    NormalDuration := "End Time" - "Start Time";
                    "Normal Hrs" := ((NormalDuration / 1000) / 60) / 60;
                end;


            end;
        end;
    end;

    //[Scope('Internal')]
    procedure CalcOvertimeHours()
    begin
        CLEAR(WorkingDuration);
        CLEAR(OvertimeDuration);
        CLEAR(StandardDuration);


        EmployeeWorkDate_GCC.SETRANGE("Employee Code", "Employee ID");
        EmployeeWorkDate_GCC.SETRANGE("Trans Date", Date);
        ;
        if EmployeeWorkDate_GCC.FINDFIRST then begin
            WorkCalendarDateLine.SETRANGE("Calendar ID", EmployeeWorkDate_GCC."Calander id");
            WorkCalendarDateLine.SETRANGE("Trans Date", EmployeeWorkDate_GCC."Trans Date");
            if WorkCalendarDateLine.FINDFIRST then begin
                WorkCalendarDateLine1.SETRANGE("Calendar ID", EmployeeWorkDate_GCC."Calander id");
                WorkCalendarDateLine1.SETRANGE("Trans Date", EmployeeWorkDate_GCC."Trans Date");
                if WorkCalendarDateLine1.FINDLAST then;

                StandardDuration := WorkCalendarDateLine1."To Time" - WorkCalendarDateLine."From Time";

                if ("Start Time" <= WorkCalendarDateLine."From Time")
                   then begin
                    WorkingDuration := "End Time" - WorkCalendarDateLine."From Time";

                    if WorkingDuration >= StandardDuration then
                        OvertimeDuration := WorkingDuration - StandardDuration;


                    if OvertimeDuration > 0 then
                        "Overtime Hrs" := ((OvertimeDuration / 1000) / 60) / 60
                    else
                        "Overtime Hrs" := 0;

                end;


                if ("Start Time" >= WorkCalendarDateLine."From Time") then begin
                    WorkingDuration := "End Time" - "Start Time";

                    if WorkingDuration >= StandardDuration then
                        OvertimeDuration := WorkingDuration - StandardDuration;


                    if OvertimeDuration > 0 then
                        "Overtime Hrs" := ((OvertimeDuration / 1000) / 60) / 60
                    else
                        "Overtime Hrs" := 0;

                end;


            end;
        end;
    end;

    local procedure CalcForSameDayCheckIn()
    var
        TimeAttendance: Record "Time Attendance";
    begin
        TimeAttendance.RESET;
        TimeAttendance.SETCURRENTKEY("Employee ID", Date, "Start Time");
        TimeAttendance.SETRANGE("Employee ID", "Employee ID");
        TimeAttendance.SETRANGE(Date, Date);
        TimeAttendance.SETASCENDING("Start Time", true);
        if TimeAttendance.FINDFIRST then
            ERROR(Text50008);
    end;
}

