table 60136 "Short Leave Header"
{
    Caption = 'Short Leave Header';
    LookupPageID = "Short Leave Request List";

    fields
    {
        field(11; "Short Leave Request Id"; Code[20])
        {
            Caption = 'Short Leave Request ID';

            trigger OnValidate()
            begin
                IF "Short Leave Request Id" <> xRec."Short Leave Request Id" THEN BEGIN
                    HrSetupRec.GET;
                    "No. Series" := '';
                END;
            end;
        }
        field(12; "Request Date"; Date)
        {
            Caption = 'Request Date';
        }
        field(13; "Employee Id"; Code[20])
        {
            Caption = 'Employee ID';
            TableRelation = Employee;

            trigger OnValidate()
            var
                PayrollJobPosWorkerAssignRecL: Record "Payroll Job Pos. Worker Assign";
                PayrollPositionRecL: Record "Payroll Position";
            begin
                IF (xRec."Employee Id" <> Rec."Employee Id") OR ("Employee Id" = '') THEN BEGIN
                    CLEAR("Employee Name");
                    CLEAR("Line Manager");
                    CLEAR("Pay Month");
                    CLEAR("Pay Period");
                END;
                IF EmpRec.GET("Employee Id") THEN;
                "Employee Name" := EmpRec.FullName;
                "Line Manager" := EmpRec."Line manager";

                Rec2.RESET;
                Rec2.SETRANGE("Employee Id", "Employee Id");
                Rec2.SETRANGE(Posted, TRUE);
                Rec2.SETRANGE("Pay Period", "Pay Period");
                IF Rec2.FINDSET THEN BEGIN
                    REPEAT
                        //"Monthly Cummulative Hrs" += Rec2."Monthly Cummulative Hrs";
                        LineRecc.RESET;
                        LineRecc.SETRANGE("Short Leave Request Id", "Short Leave Request Id");
                        LineRecc.CALCSUMS("No Hours Requested");
                        "Monthly Cummulative Hrs" += LineRecc."No Hours Requested";
                    UNTIL Rec2.NEXT = 0;
                END;
                PayrollJobPosWorkerAssignRecL.RESET;
                PayrollJobPosWorkerAssignRecL.SETRANGE(Worker, "Employee Id");
                PayrollJobPosWorkerAssignRecL.SETRANGE("Is Primary Position", TRUE);
                IF PayrollJobPosWorkerAssignRecL.FINDFIRST THEN BEGIN
                    PayrollPositionRecL.RESET;
                    PayrollPositionRecL.SETRANGE("Position ID", PayrollJobPosWorkerAssignRecL."Position ID");
                    IF PayrollPositionRecL.FINDFIRST THEN
                        "Pay Month" := PayrollPositionRecL."Pay Cycle";
                END;

                IF "Employee Id" <> '' THEN BEGIN
                    RecHRSetup.GET;
                    "Permissible Short Leave Hrs" := RecHRSetup."Permissible Short Leave Hrs";
                    CLEAR(ShortLeaveLine);
                    ShortLeaveLine.SETRANGE("Employee Id", "Employee Id");
                    ShortLeaveLine.SETFILTER("Requesht Date", FORMAT(CALCDATE('<-CY>', WORKDATE)) + '..' + FORMAT(CALCDATE('<CY>', WORKDATE)));
                    ShortLeaveLine.CALCSUMS("No Hours Requested");
                    "Balance of Short Leave Hours" := RecHRSetup."Permissible Short Leave Hrs" - ShortLeaveLine."No Hours Requested";
                    CLEAR(ShortLeaveLine);
                    ShortLeaveLine.SETRANGE("Employee Id", "Employee Id");
                    ShortLeaveLine.SETFILTER("Requesht Date", FORMAT(CALCDATE('<-CY>', WORKDATE)) + '..' + FORMAT(CALCDATE('<CY>', WORKDATE)));
                    ShortLeaveLine.CALCSUMS("No Hours Requested");
                    "Total Acc. short leave hours" := ShortLeaveLine."No Hours Requested";
                END;
            end;
        }
        field(14; "Employee Name"; Text[50])
        {
            Caption = 'Employee Name';
        }
        field(15; "Line Manager"; Text[50])
        {
            Caption = 'Line Manager';
        }
        field(16; "Permissible Short Leave Hrs"; Integer)
        {
            Caption = 'Permissible Short Leave Hrs';
        }
        field(17; "Monthly Cummulative Hrs"; Integer)
        {
            Caption = 'Monthly Cummulative Hrs';
        }
        field(18; "Pay Period"; Code[20])
        {

            trigger OnLookup()
            begin
                PayPeriodsRec.RESET;
                PayPeriodsRec.SETRANGE("Pay Cycle", "Pay Month");
                PayPeriodsRec.SETRANGE(Status, PayPeriodsRec.Status::Open);
                IF PAGE.RUNMODAL(PAGE::"Pay Periods List", PayPeriodsRec) = ACTION::LookupOK THEN BEGIN
                    "Pay Period" := PayPeriodsRec.Month + ' ' + FORMAT(PayPeriodsRec.Year);
                    "Pay Period Start" := PayPeriodsRec."Period Start Date";
                    "Pay Period End" := PayPeriodsRec."Period End Date";
                END;
            end;

            trigger OnValidate()
            begin
                Rec2.RESET;
                Rec2.SETRANGE("Employee Id", "Employee Id");
                //Rec2.SETRANGE(Posted,TRUE);
                Rec2.SETRANGE("Pay Period", "Pay Period");
                IF Rec2.FINDSET THEN BEGIN
                    REPEAT
                        LineRecc.RESET;
                        LineRecc.SETRANGE("Short Leave Request Id", Rec2."Short Leave Request Id");
                        IF LineRecc.FINDFIRST THEN
                            "Monthly Cummulative Hrs" += LineRecc."No Hours Requested";
                    UNTIL Rec2.NEXT = 0;

                END;
            end;
        }
        field(19; "WorkFlow Status"; Option)
        {
            Caption = 'WorkFlow Status';
            Editable = false;
            OptionCaption = 'Open,Approved,Send for Approval,Rejected';
            OptionMembers = Open,Released,"Pending Approval",Rejected;
        }
        field(20; Posted; Boolean)
        {
            Caption = 'Posted';
        }
        field(21; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(22; "Pay Month"; Code[20])
        {
            Caption = 'Pay Cycle';
            Editable = false;
            TableRelation = "Pay Cycles";

            trigger OnLookup()
            begin

                IF PAGE.RUNMODAL(PAGE::"Pay Cycles", PrecayCycleRec) = ACTION::LookupOK THEN;
                "Pay Month" := PrecayCycleRec."Pay Cycle";
            end;
        }
        field(23; "Pay Period Start"; Date)
        {
        }
        field(24; "Pay Period End"; Date)
        {
        }
        field(25; "Notification Sent"; Boolean)
        {
        }
        field(26; User_ID; Code[20])
        {
        }
        field(27; "Balance of Short Leave Hours"; Decimal)
        {
        }
        field(28; "Total Acc. short leave hours"; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "Short Leave Request Id")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        IF Posted = TRUE THEN
            ERROR(DelErr);
    end;

    trigger OnInsert()
    begin
        INITINSERT;
        "Request Date" := TODAY;
        VALIDATE("WorkFlow Status", "WorkFlow Status"::Released);
        User_ID := USERID;
    end;

    var
        NoSeriesMgt: Codeunit "NoSeriesManagement";
        HasInvtSetup: Boolean;
        HrSetupRec: Record "Human Resources Setup";
        EmpRec: Record Employee;
        PrecayCycleRec: Record "Pay Cycles";
        PayPeriodsRec: Record "Pay Periods";
        LineRecc: Record "Short Leave Line";
        Rec2: Record "Short Leave Header";
        DelErr: Label 'Posted Requst Cannot be Deleted';
        RecHRSetup: Record "Human Resources Setup";
        ShortLeaveLine: Record "Short Leave Line";

    local procedure INITINSERT()
    var
        UserSetup: Record "User Setup";
    begin
        HrSetupRec.GET;
        IF "Short Leave Request Id" = '' THEN
            NoSeriesMgt.InitSeries(HrSetupRec."Short Leave Request Id", xRec."Short Leave Request Id", TODAY(), "Short Leave Request Id", HrSetupRec."Short Leave Request Id");
        "Permissible Short Leave Hrs" := HrSetupRec."Permissible Short Leave Hrs";
        IF CURRENTCLIENTTYPE = CLIENTTYPE::Web THEN BEGIN
            UserSetup.RESET;
            UserSetup.SETRANGE("User ID", USERID);
            IF UserSetup.FINDFIRST THEN BEGIN
                IF "Employee Id" = '' THEN
                    VALIDATE("Employee Id", UserSetup."Employee Id");
            END;
        END;
    end;

    local procedure wARNINGH()
    begin
    end;
}

