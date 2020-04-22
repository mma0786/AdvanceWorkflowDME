page 60184 "Time Attendance"
{
    Caption = 'Time Attendance';
    DelayedInsert = true;
    PageType = List;
    SourceTable = "Time Attendance";
    SourceTableView = SORTING("Employee ID", Date)
                      ORDER(Ascending);
    // // // ApplicationArea = All;
    // // // UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("Employee ID"; "Employee ID")
                {
                    ApplicationArea = All;
                }
                field(Name; Name)
                {
                    ApplicationArea = All;
                }
                field(Date; Date)
                {
                    ApplicationArea = All;
                }
                field("Day Type"; "Day Type")
                {
                    ApplicationArea = All;
                }
                field("Start Time"; "Start Time")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        StartTime := FORMAT("Start Time", 8, '<Hours24,2>:<Minutes,2>:<Seconds,2>');
                    end;
                }
                field("End Time"; "End Time")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        EndTime := FORMAT("End Time", 8, '<Hours24,2>:<Minutes,2>:<Seconds,2>');
                    end;
                }
                field("Total Hours"; "Total Hours")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Normal Hours"; "Normal Hrs")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Absent Hours"; "Absent Hours")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Overtime Hrs"; "Overtime Hrs")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Project Id"; "Project Id")
                {
                    ApplicationArea = All;
                }
                field("Overtime Approval Status"; "Overtime Approval Status")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Indoor Check-in"; "Indoor Check-in")
                {
                    ApplicationArea = All;
                }
                field("Outdoor Check-out"; "Outdoor Check-out")
                {
                    ApplicationArea = All;
                }
                field(Confirmed; Confirmed)
                {
                    ApplicationArea = All;
                }
                field(Remarks; Remarks)
                {
                    Visible = false;
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Task)
            {
                Caption = 'Task';
                Image = Task;
                action(Confirm)
                {
                    Ellipsis = true;
                    Image = Confirm;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = All;
                    trigger OnAction()
                    begin
                        if CONFIRM(Text55016, true) then begin
                            /*
                            //CurrPage.SETSELECTIONFILTER(TimeAttendance);
                            TimeAttendance.SETRANGE(Confirmed,FALSE);
                            IF TimeAttendance.FINDSET THEN
                              REPEAT
                                 TimeAttendance.CalcNormalHours;
                                 TimeAttendance.CalcOvertimeHours;

                            //    CheckValidations;
                                {
                                IF TimeAttendance."Overtime Approval Status"<>TimeAttendance."Overtime Approval Status"::"Not Approved" THEN
                                BEGIN
                                  TimeAttendance.Confirmed:=TRUE;
                                  TimeAttendance.Remarks:='';
                                END ELSE
                                IF TimeAttendance."Overtime Approval Status"=TimeAttendance."Overtime Approval Status"::"Not Approved" THEN
                                BEGIN
                                  TimeAttendance.Remarks:= Text55015;
                                END;
                                }
                                TimeAttendance.Confirmed := TRUE;
                                TimeAttendance.MODIFY;
                              UNTIL TimeAttendance.NEXT=0;
                            END
                            ELSE
                            EXIT;
                            */

                            // usign set selection filter as per new requirement
                            CLEAR(TimeAttendance);
                            CurrPage.SETSELECTIONFILTER(TimeAttendance);
                            if TimeAttendance.FINDSET then
                                repeat
                                    if TimeAttendance.Confirmed = false then begin
                                        //commented By Avinash
                                        // // // TimeAttendance.CalcNormalHours;
                                        // // // TimeAttendance.CalcOvertimeHours;
                                        //commented By Avinash
                                        TimeAttendance.Confirmed := true;
                                        TimeAttendance.MODIFY;
                                    end;
                                until TimeAttendance.NEXT = 0;
                        end
                        else
                            exit;

                    end;
                }
                action("Export Template")
                {
                    Image = Export;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = All;
                    //commented By Avinash RunObject = XMLport "Export Attendance Template";
                }
                action("Import Attendance")
                {
                    Image = Import;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = All;
                    //commented By Avinash  RunObject = XMLport "Import Time Attend. Template";

                    trigger OnAction()
                    begin
                        CurrPage.UPDATE;
                    end;
                }
                action("Attendance Details")
                {
                    Image = LedgerEntries;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    ApplicationArea = All;
                    //commented By Avinash
                    // RunObject = Page "Time Attend. Details-Old";
                    // RunPageLink = Field1 = FIELD("Employee ID"),
                    //               Field3 = FIELD(Date);
                    // RunPageView = SORTING(Field1, Field3, Field4, Field5)
                    //               ORDER(Ascending);
                    //commented By Avinash
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        CALCFIELDS("Error Log");
        if "Error Log".HASVALUE then begin
            "Error Log".CREATEINSTREAM(INStr);
            INStr.READ(ErrorMessage);
        end;
        //Field sbould be non editable if the rec is confirmed
        if Rec.Confirmed then
            CurrPage.EDITABLE := false;
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        TESTFIELD(Confirmed, false);
    end;

    trigger OnModifyRecord(): Boolean
    begin
        TESTFIELD(Confirmed, false);
    end;

    trigger OnOpenPage()
    begin
        SETRANGE(Confirmed, false);
    end;

    var
        TimeAttendance: Record "Time Attendance";
        Text55015: Label 'Overtime is not approved';
        StartTime: Text;
        EndTime: Text;
        Text55016: Label 'Do you want to check Validation for all records ?';
        Employee: Record Employee;
        ErrorMessage: Text[250];
        INStr: InStream;
        Remarks: Text[250];
        StreamOut: OutStream;
        FileManagement: Codeunit "File Management";
        // LeaveRequestHeader: Record "Leave Request Header";
        EmployeeWorkDate_GCC: Record EmployeeWorkDate_GCC;
        Text0001: Label 'Employee Status is not active !';
        Text0002: Label 'Deletion is not allowed for confirmed record.';
        Text003: Label 'Modification is not allowed for confirmed record.';

    local procedure CheckValidations()
    begin
        TimeAttendance.SETRANGE(Confirmed, false);
        if TimeAttendance.FINDFIRST then begin

            if Employee.GET(TimeAttendance."Employee ID") then
                if Employee.Status <> Employee.Status::Active then
                    TimeAttendance.Remarks := TimeAttendance.Remarks + Text0001;


            StartTime := FORMAT(TimeAttendance."Start Time", 8, '<Hours24,2>:<Minutes,2>:<Seconds,2>');
            EndTime := FORMAT(TimeAttendance."End Time", 8, '<Hours24,2>:<Minutes,2>:<Seconds,2>');

            if StartTime > EndTime then
                TimeAttendance.Remarks := 'Start Time is greater than End Time';

            if Employee.GET("Employee ID") then begin

                if (TimeAttendance.Date < Employee."Joining Date") then
                    TimeAttendance.Remarks := TimeAttendance.Remarks + Text0001;


                if Employee."Termination Date" <> 0D then
                    if (TimeAttendance.Date > Employee."Termination Date") then
                        TimeAttendance.Remarks := TimeAttendance.Remarks + Text0001;
            end;

            // LeaveRequestHeader.SETRANGE("Personnel Number", TimeAttendance."Employee ID");
            // LeaveRequestHeader.SETFILTER("Start Date", '<=%1', TimeAttendance.Date);
            // LeaveRequestHeader.SETFILTER("End Date", '>%1', TimeAttendance.Date);
            // if LeaveRequestHeader.FINDFIRST then
            //     TimeAttendance.Remarks := TimeAttendance.Remarks + 'Employee is on Leave';


            EmployeeWorkDate_GCC.SETRANGE("Employee Code", TimeAttendance."Employee ID");
            EmployeeWorkDate_GCC.SETRANGE("Trans Date", TimeAttendance.Date);
            if EmployeeWorkDate_GCC.FINDFIRST then
                TimeAttendance."Day Type" := EmployeeWorkDate_GCC."Calculation Type";

            TimeAttendance.MODIFY;


        end;
    end;
}

