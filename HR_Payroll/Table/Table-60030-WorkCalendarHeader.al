table 60030 "Work Calendar Header"
{

    fields
    {
        field(1; "Calendar ID"; Code[20])
        {
        }
        field(2; Name; Text[100])
        {
        }
        field(3; "Alternative Calendar"; Code[20])
        {
            TableRelation = "Work Calendar Header";
        }
        field(4; "From Date"; Date)
        {
        }
        field(5; "To Date"; Date)
        {
        }
        field(6; "Work Time Template"; Code[20])
        {
            TableRelation = "Work Time Template";
        }
    }

    keys
    {
        key(Key1; "Calendar ID")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        WorkCalendarDateLine.RESET;
        WorkCalendarDateLine.SETRANGE("Calendar ID", Rec."Calendar ID");
        WorkCalendarDateLine.DELETEALL;

        WorkCalendarDate.RESET;
        WorkCalendarDate.SETRANGE("Calendar ID", Rec."Calendar ID");
        WorkCalendarDate.DELETEALL
    end;

    var
        PeriodStartDate: Date;
        WorkCalendarDate: Record "Work Calendar Date";
        WorkCalendarDateLine: Record "Work Calendar Date Line";

    //[Scope('Internal')]
    procedure CalculateDate()
    var
        WorkTimeTemplate: Record "Work Time Template";
        Period: Record Date;
        WorkTimeLine: Record "Work Time Line";
        WorkCalendarDate: Record "Work Calendar Date";
        WorkCalendarDateLine: Record "Work Calendar Date Line";
        LineNo: Integer;
        WorkCalendarDate2: Record "Work Calendar Date";
    begin
        TESTFIELD("From Date");
        TESTFIELD("To Date");
        TESTFIELD("Work Time Template");

        WorkTimeTemplate.GET(Rec."Work Time Template");

        WorkCalendarDate2.RESET;
        WorkCalendarDate2.SETRANGE("Calendar ID", Rec."Calendar ID");
        if WorkCalendarDate2.FINDLAST then;

        WorkCalendarDate.RESET;
        WorkCalendarDate.SETRANGE("Calendar ID", Rec."Calendar ID");
        if WorkCalendarDate.FINDFIRST then
            if WorkCalendarDate."Trans Date" > "From Date" then
                ERROR('Calendar exists from %1 to %2 date. From date must be %3', WorkCalendarDate."Trans Date", WorkCalendarDate2."Trans Date", WorkCalendarDate2."Trans Date" + 1);

        WorkCalendarDate.RESET;
        WorkCalendarDate.SETRANGE("Calendar ID", Rec."Calendar ID");
        WorkCalendarDate.SETRANGE("Trans Date", "To Date");
        if WorkCalendarDate.FINDFIRST then
            ERROR('Work Calendar date lines exist for %1 To Date', "To Date");


        WorkCalendarDate.RESET;
        WorkCalendarDate.SETRANGE("Calendar ID", Rec."Calendar ID");
        if WorkCalendarDate.FINDLAST then
            if WorkCalendarDate."Trans Date" >= "To Date" then
                ERROR('Work Calendar date lines exist for %1 To Date', "To Date");




        CLEAR(PeriodStartDate);
        WorkCalendarDate.RESET;
        WorkCalendarDate.SETRANGE("Calendar ID", Rec."Calendar ID");
        if WorkCalendarDate.FINDLAST then
            PeriodStartDate := WorkCalendarDate."Trans Date" + 1
        else
            PeriodStartDate := "From Date";

        /*
        WorkCalendarDateLine.RESET;
        WorkCalendarDateLine.SETRANGE("Calendar ID",Rec."Calendar ID");
        */

        Period.RESET;
        Period.SETCURRENTKEY("Period Type", "Period Start");
        Period.SETRANGE("Period Type", Period."Period Type"::Date);
        Period.SETRANGE("Period Start", PeriodStartDate, "To Date");
        if Period.FINDSET then begin
            repeat
                WorkTimeLine.RESET;
                WorkTimeLine.SETRANGE("Work Time ID", Rec."Work Time Template");
                WorkTimeLine.SETRANGE(Weekday, Period."Period No.");
                if WorkTimeLine.FINDFIRST then begin
                    WorkCalendarDate.INIT;
                    WorkCalendarDate."Calendar ID" := Rec."Calendar ID";
                    WorkCalendarDate."Trans Date" := Period."Period Start";
                    WorkCalendarDate.Name := Period."Period Name";
                    ///WorkCalendarDate."Calculation Type" := WorkTimeLine."Calculation Type";
                    case Period."Period No." of
                        1:
                            WorkCalendarDate."Calculation Type" := WorkTimeTemplate."Monday Calculation Type";
                        2:
                            WorkCalendarDate."Calculation Type" := WorkTimeTemplate."Tuesday Calculation Type";
                        3:
                            WorkCalendarDate."Calculation Type" := WorkTimeTemplate."Wednesday Calculation Type";
                        4:
                            WorkCalendarDate."Calculation Type" := WorkTimeTemplate."Thursday Calculation Type";
                        5:
                            WorkCalendarDate."Calculation Type" := WorkTimeTemplate."Friday Calculation Type";
                        6:
                            WorkCalendarDate."Calculation Type" := WorkTimeTemplate."Saturday Calculation Type";
                        7:
                            WorkCalendarDate."Calculation Type" := WorkTimeTemplate."Sunday Calculation Type";
                    end;

                    WorkCalendarDate.INSERT;
                    CLEAR(LineNo);
                    repeat
                        LineNo += 10000;
                        WorkCalendarDateLine.INIT;
                        WorkCalendarDateLine."Calendar ID" := Rec."Calendar ID";
                        WorkCalendarDateLine."Trans Date" := Period."Period Start";
                        WorkCalendarDateLine."Line No." := LineNo;
                        WorkCalendarDateLine."From Time" := WorkTimeLine."From Time";
                        WorkCalendarDateLine."To Time" := WorkTimeLine."To Time";
                        WorkCalendarDateLine.Hours := WorkTimeLine."No. Of Hours";
                        WorkCalendarDateLine."Shift Split" := WorkTimeLine."Shift Split";
                        WorkCalendarDateLine.INSERT;
                    until WorkTimeLine.NEXT = 0;
                end
                else begin
                    WorkCalendarDate.INIT;
                    WorkCalendarDate."Calendar ID" := Rec."Calendar ID";
                    WorkCalendarDate."Trans Date" := Period."Period Start";
                    WorkCalendarDate.Name := Period."Period Name";
                    case Period."Period No." of
                        1:
                            WorkCalendarDate."Calculation Type" := WorkTimeTemplate."Monday Calculation Type";
                        2:
                            WorkCalendarDate."Calculation Type" := WorkTimeTemplate."Tuesday Calculation Type";
                        3:
                            WorkCalendarDate."Calculation Type" := WorkTimeTemplate."Wednesday Calculation Type";
                        4:
                            WorkCalendarDate."Calculation Type" := WorkTimeTemplate."Thursday Calculation Type";
                        5:
                            WorkCalendarDate."Calculation Type" := WorkTimeTemplate."Friday Calculation Type";
                        6:
                            WorkCalendarDate."Calculation Type" := WorkTimeTemplate."Saturday Calculation Type";
                        7:
                            WorkCalendarDate."Calculation Type" := WorkTimeTemplate."Sunday Calculation Type";
                    end;
                    //WorkCalendarDate."Calculation Type" := WorkCalendarDate."Calculation Type"::"Weekly Off";
                    WorkCalendarDate.INSERT;
                end;
            until Period.NEXT = 0;
        end;

    end;


    procedure UpdateCalculationType()
    var
        EmployeeWorkDate_GCC: Record EmployeeWorkDate_GCC;
        WorkCalendarDate: Record "Work Calendar Date";
    begin
        WorkCalendarDate.RESET;
        WorkCalendarDate.SETRANGE("Calendar ID", Rec."Calendar ID");
        WorkCalendarDate.SETRANGE("Has Changed", true);
        if WorkCalendarDate.FINDSET then begin
            repeat
                EmployeeWorkDate_GCC.RESET;
                EmployeeWorkDate_GCC.SETRANGE("Trans Date", WorkCalendarDate."Trans Date");
                if EmployeeWorkDate_GCC.FINDFIRST then
                    repeat
                        EmployeeWorkDate_GCC."Calculation Type" := WorkCalendarDate."Calculation Type";
                        EmployeeWorkDate_GCC.Remarks := WorkCalendarDate.Remarks;
                        EmployeeWorkDate_GCC.MODIFY;
                    until EmployeeWorkDate_GCC.NEXT = 0;
                WorkCalendarDate."Has Changed" := false;
                WorkCalendarDate.MODIFY;
            until WorkCalendarDate.NEXT = 0;
        end;
    end;
}

