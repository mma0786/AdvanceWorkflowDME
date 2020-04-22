page 60196 "Import Time Attendance"
{
    DelayedInsert = true;
    PageType = List;
    RefreshOnActivate = true;
    SourceTable = "Time Attendance - Details";
    ApplicationArea = All;
    UsageCategory = Lists;
    Caption = 'Import Time Attendance List';
    /// commented By Avinash
    SourceTableView = SORTING("Employee ID")
                      ORDER(Ascending)
                      WHERE(Confirmed = FILTER(false));
    //commented By Avinash

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Employee ID"; "Employee ID")
                {
                    ApplicationArea = All;
                }
                field("Employee Full Name"; "Employee Full Name")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Date; "Check -In Date")
                {
                    ApplicationArea = All;
                }
                field("Start Time"; "Check -In Time")
                {
                    Editable = Editablebool;
                    ApplicationArea = All;
                }
                field("End Time"; "Check -Out Time")
                {
                    Editable = Editablebool;
                    ApplicationArea = All;
                }
                field("Total Working Hrs"; "Total Working Hrs")
                {
                    Editable = false;
                }
                field("Day Type"; "Day Type")
                {
                    ApplicationArea = All;
                }
                field("Normal Hrs"; "Normal Hrs")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Working Hrs"; "Working Hrs")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Absent Hrs"; "Absent Hrs")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Overtime Hrs"; "Overtime Hrs")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Gate In"; "Gate In")
                {
                    ApplicationArea = All;
                }
                field("Gate Out"; "Gate Out")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Make Header")
            {
                Image = Confirm;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                ApplicationArea = All;
                trigger OnAction()
                begin
                    DeleteUnconfirm;
                    CheckSameDayCheckin;
                    UpdateTimeAttendance;

                    //UpdateConfirm;
                end;
            }
            action("Import Attendance")
            {
                Image = Import;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = All;
                trigger OnAction()
                var

                    ImportTimeDtailsXmlport: XmlPort "Import Time Details";
                begin
                    TimeAttendanceDetails.SETRANGE(Confirmed, false);
                    if TimeAttendanceDetails.FINDSET then
                        TimeAttendanceDetails.DELETEALL;
                    COMMIT;
                    // ImportTimeDtailsXmlport.Run();
                    XMLPORT.RUN(65020, true, true);
                end;
            }
            action("Export Attendance Details")
            {
                Image = Export;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = All;
                RunObject = XMLport "Export Attendance Details Temp";
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        EditableFun;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        TimeAttendance.SETRANGE("Employee ID", "Employee ID");
        TimeAttendance.SETRANGE(Date, "Check -In Date");
        TimeAttendance.SETRANGE(Confirmed, true);
        if TimeAttendance.FINDFIRST then
            ERROR(Text50001);
    end;

    trigger OnOpenPage()
    begin
        Editablebool := true;
    end;

    var
        TimeAttendance: Record "Time Attendance";
        TimeAttendanceDetails: Record "Time Attendance - Details";
        TotalHrs: Decimal;
        WorkingHrs: Decimal;
        HrsWorked: Decimal;
        Editablebool: Boolean;
        Text50001: Label 'Cannot make changes since the details have already being confirmed !';
        TimeAttendanceDetails1: Record "Time Attendance - Details";
        OvertimeHrs: Decimal;
        EmployeeWorkDate_GCC: Record EmployeeWorkDate_GCC;

    local procedure UpdateTimeAttendance()
    begin
        TimeAttendanceDetails1.SETRANGE(Confirmed, false);
        if TimeAttendanceDetails1.FINDSET then begin


            TimeAttendance.SETRANGE("Employee ID", TimeAttendanceDetails1."Employee ID");
            TimeAttendance.SETRANGE(Confirmed, false);
            TimeAttendance.SETRANGE(Date, TimeAttendanceDetails1."Check -In Date");

            if not TimeAttendance.FINDFIRST then begin
                TimeAttendance."Employee ID" := TimeAttendanceDetails1."Employee ID";
                TimeAttendance.Name := TimeAttendanceDetails1."Employee Full Name";
                TimeAttendance.Date := TimeAttendanceDetails1."Check -In Date";

                EmployeeWorkDate_GCC.RESET;
                EmployeeWorkDate_GCC.SETRANGE("Employee Code", TimeAttendanceDetails1."Employee ID");
                EmployeeWorkDate_GCC.SETRANGE("Trans Date", TimeAttendanceDetails1."Check -In Date");
                if EmployeeWorkDate_GCC.FINDFIRST then
                    TimeAttendance."Day Type" := EmployeeWorkDate_GCC."Calculation Type";

                TimeAttendanceDetails.SETRANGE("Employee ID", TimeAttendanceDetails1."Employee ID");
                TimeAttendanceDetails.SETRANGE("Check -In Date", TimeAttendanceDetails1."Check -In Date");
                if TimeAttendanceDetails.FINDFIRST then;

                TimeAttendance."Start Time" := TimeAttendanceDetails."Check -In Time";
                TimeAttendance."Normal Hrs" := TimeAttendanceDetails."Normal Hrs";

                TimeAttendanceDetails.SETRANGE("Employee ID", TimeAttendanceDetails1."Employee ID");
                TimeAttendanceDetails.SETRANGE("Check -In Date", TimeAttendanceDetails1."Check -In Date");
                if TimeAttendanceDetails.FINDLAST then;

                TimeAttendance."End Time" := TimeAttendanceDetails."Check -Out Time";

                TotalHrs := 0;
                WorkingHrs := 0;
                HrsWorked := 0;
                OvertimeHrs := 0;

                TimeAttendanceDetails.SETRANGE("Employee ID", TimeAttendanceDetails1."Employee ID");
                TimeAttendanceDetails.SETRANGE("Check -In Date", TimeAttendanceDetails1."Check -In Date");
                TimeAttendanceDetails.SETFILTER(Confirmed, '%1', false);
                if TimeAttendanceDetails.FINDSET then
                    repeat
                        // TimeAttendanceDetails.Confirmed := TRUE;
                        //
                        TotalHrs := TotalHrs + TimeAttendanceDetails."Total Working Hrs";
                        WorkingHrs := WorkingHrs + TimeAttendanceDetails."Working Hrs";
                        OvertimeHrs := OvertimeHrs + TimeAttendanceDetails."Overtime Hrs";
                        TimeAttendanceDetails.RENAME(TimeAttendanceDetails."Employee ID", TimeAttendanceDetails."Check -In Date", TimeAttendanceDetails."Check -In Time", true);
                    until TimeAttendanceDetails.NEXT = 0;


                TimeAttendance."Total Hours" := TotalHrs;
                TimeAttendance."Worked Hours" := WorkingHrs;
                TimeAttendance."Absent Hours" := TimeAttendance."Normal Hrs" - TimeAttendance."Worked Hours";
                TimeAttendance."Overtime Hrs" := OvertimeHrs;

                /*
                       IF WorkingHrs < TimeAttendance."Normal Hrs" THEN
                          HrsWorked:= ABS(TimeAttendance."Normal Hrs" - TimeAttendance."Worked Hours");

                      IF TimeAttendanceDetails1."Day Type" = TimeAttendanceDetails1."Day Type"::"Working Day"  THEN BEGIN
                         IF TimeAttendance."Normal Hrs" < WorkingHrs THEN
                            TimeAttendance."Overtime Hrs" := WorkingHrs- TimeAttendance."Normal Hrs"
                         ELSE BEGIN

                            TimeAttendance."Absent Hours" := HrsWorked;
                        END;
                      END
                      ELSE BEGIN
                       TimeAttendance."Overtime Hrs" := TotalHrs;
                       TimeAttendance."Normal Hrs" := 0;
                       TimeAttendance."Absent Hours" :=0;
                      END;

                     IF TimeAttendance."Worked Hours" > TimeAttendance."Normal Hrs" THEN
                        TimeAttendance."Worked Hours" := TimeAttendance."Normal Hrs";

                */

                if TimeAttendanceDetails1."Day Type" <> TimeAttendanceDetails1."Day Type"::"Working Day" then begin
                    TimeAttendance."Overtime Hrs" := OvertimeHrs + WorkingHrs;
                    TimeAttendance."Absent Hours" := 0;
                    TimeAttendance."Worked Hours" := 0;
                end;
                TimeAttendance.Confirmed := false;
                TimeAttendance.INSERT;
                // TimeAttendanceDetails1.RENAME(TimeAttendanceDetails1."Employee ID",TimeAttendanceDetails1."Check -In Date",TimeAttendanceDetails1."Check -In Time",TRUE);

            end;
        end;
        //UNTIL TimeAttendanceDetails1.NEXT = 0;
        CurrPage.UPDATE;

    end;

    local procedure EditableFun()
    begin
        TimeAttendance.SETRANGE("Employee ID", "Employee ID");
        TimeAttendance.SETRANGE(Date, "Check -In Date");
        TimeAttendance.SETRANGE(Confirmed, true);
        if TimeAttendance.FINDFIRST then
            Editablebool := false;
    end;

    local procedure DeleteUnconfirm()
    begin
        TimeAttendance.SETRANGE("Employee ID", "Employee ID");
        TimeAttendance.SETRANGE(Date, "Check -In Date");
        TimeAttendance.SETRANGE(Confirmed, false);
        if TimeAttendance.FINDFIRST then begin
            TimeAttendanceDetails.SETRANGE("Employee ID", "Employee ID");
            TimeAttendanceDetails.SETRANGE("Check -In Date", "Check -In Date");
            TimeAttendanceDetails.SETRANGE(Confirmed, true);
            if TimeAttendanceDetails.FINDSET then
                TimeAttendanceDetails.DELETEALL;

            TimeAttendance.DELETEALL;

        end;
    end;

    local procedure UpdateConfirm()
    begin
        TimeAttendanceDetails.SETRANGE("Employee ID", "Employee ID");
        TimeAttendanceDetails.SETRANGE("Check -In Date", "Check -In Date");
        TimeAttendanceDetails.SETFILTER(Confirmed, '%1', false);
        if TimeAttendanceDetails.FINDSET then
            repeat
                TimeAttendanceDetails.Confirmed := true;
                TimeAttendanceDetails.MODIFY;
            until TimeAttendanceDetails.NEXT = 0;
    end;
}

