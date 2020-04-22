table 60049 "Cancel Leave Request"
{

    fields
    {
        field(1; "Leave Request ID"; Code[20])
        {

        }
        field(2; "Personnel Number"; Code[20])
        {
            TableRelation = Employee;
        }
        field(3; "Employee Name"; Text[100])
        {
        }
        field(4; "Leave Type"; Code[20])
        {
            TableRelation = "HCM Leave Types Wrkr"."Leave Type Id" WHERE(Worker = FIELD("Personnel Number"),
                                                                          "Earning Code Group" = FIELD("Earning Code Group"));
        }
        field(5; "Short Name"; Code[20])
        {
        }
        field(6; Description; Text[100])
        {
        }
        field(7; "Start Date"; Date)
        {
        }
        field(9; "Leave Start Day Type"; Option)
        {
            OptionCaption = 'Full Day,First Half,Second Half';
            OptionMembers = "Full Day","First Half","Second Half";
        }
        field(10; "End Date"; Date)
        {
        }
        field(12; "Leave End Day Type"; Option)
        {
            OptionCaption = 'Full Day,First Half';
            OptionMembers = "Full Day","First Half";
        }
        field(14; "Leave Days"; Decimal)
        {
            Editable = false;
        }
        field(15; "Leave Remarks"; Text[100])
        {
        }
        field(16; RecID; RecordId)

        { }

        field(17; "Submission Date"; Date)
        {
        }
        field(18; "Workflow Status"; Option)
        {
            OptionCaption = 'Not Submitted,Submitted,Approved,Cancelled,Rejected,Open,Pending For Approval';
            OptionMembers = "Not Submitted",Submitted,Approved,Cancelled,Rejected,Open,"Pending For Approval";
        }
        field(19; Posted; Boolean)
        {
        }
        field(20; "Leave Cancelled"; Boolean)
        {
        }
        field(22; "Created By"; Code[50])
        {
        }
        field(23; "Created Date Time"; DateTime)
        {
        }
        field(26; "Net Leave Days"; Decimal)
        {
        }
        field(27; "Created Date"; Date)
        {
        }
        field(28; "Earning Code Group"; Code[20])
        {
        }
        field(30; "Cancel Remarks"; Text[250])
        {
        }
        field(31; "Cancel Leave Posted"; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; "Leave Request ID")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        TESTFIELD("Workflow Status", "Workflow Status"::Open);
    end;

    trigger OnInsert()
    begin

        RecID := RecordId;
        "Created By" := USERID;
        "Created Date Time" := CURRENTDATETIME;
        "Workflow Status" := "Workflow Status"::Open;
    end;

    var
        Employee: Record Employee;
        LeaveType: Record "HCM Leave Types";
        EmployeeWorkDate_GCC: Record EmployeeWorkDate_GCC;

    // Commented By Avinash [Scope('Internal')]
    procedure SubmitLeaveCancel(var CancelLeave: Record "Cancel Leave Request")
    begin
    end;

    // Commented By Avinash [Scope('Internal')]
    procedure PostLeaveCancel(var CancelLeave: Record "Cancel Leave Request")
    var
    // Commented By Avinash AccrualCompCalc: Codeunit "Accrual Component Calculate";
    begin
        Employee.GET("Personnel Number");
        UpdateEmployeeWorkDate;
        // Commented By Avinash
        // AccrualCompCalc.ValidateAccrualLeaves("Personnel Number", "Leave Type", "Start Date", "End Date", "Earning Code Group", LeaveType."Accrual ID", "Leave Days");
        // AccrualCompCalc.OnAfterValidateAccrualLeaves("Personnel Number", "Start Date", "Leave Type", "Earning Code Group");
        // Commented By Avinash
        "Leave Cancelled" := true;
        MODIFY;
    end;

    // Commented By Avinash [Scope('Internal')]
    procedure UpdateEmployeeWorkDate()
    var
        Leave: Record "HCM Leave Types";
    begin
        TESTFIELD("Personnel Number");

        Leave.RESET;
        Leave.SETRANGE("Is System Defined", true);
        if Leave.FINDFIRST then begin
            EmployeeWorkDate_GCC.RESET;
            EmployeeWorkDate_GCC.SETRANGE("Employee Code", "Personnel Number");
            EmployeeWorkDate_GCC.SETRANGE("Trans Date", "Start Date", "End Date");
            if EmployeeWorkDate_GCC.FINDFIRST then
                repeat
                    if "Start Date" = EmployeeWorkDate_GCC."Trans Date" then begin
                        if "Leave Start Day Type" = "Leave Start Day Type"::"First Half" then
                            EmployeeWorkDate_GCC."First Half Leave Type" := Leave."Leave Type Id"
                        else
                            if "Leave Start Day Type" = "Leave Start Day Type"::"Second Half" then
                                EmployeeWorkDate_GCC."Second Half Leave Type" := Leave."Leave Type Id"
                            else
                                if "Leave Start Day Type" = "Leave Start Day Type"::"Full Day" then begin
                                    EmployeeWorkDate_GCC."First Half Leave Type" := Leave."Leave Type Id";
                                    EmployeeWorkDate_GCC."Second Half Leave Type" := Leave."Leave Type Id";
                                end;
                    end;

                    if "End Date" = EmployeeWorkDate_GCC."Trans Date" then begin
                        if "Leave End Day Type" = "Leave End Day Type"::"First Half" then
                            EmployeeWorkDate_GCC."First Half Leave Type" := Leave."Leave Type Id"
                        else
                            if "Leave End Day Type" = "Leave End Day Type"::"Full Day" then begin
                                EmployeeWorkDate_GCC."First Half Leave Type" := Leave."Leave Type Id";
                                EmployeeWorkDate_GCC."Second Half Leave Type" := Leave."Leave Type Id";
                            end;
                    end;

                    if ("Start Date" <> EmployeeWorkDate_GCC."Trans Date") or ("End Date" <> EmployeeWorkDate_GCC."Trans Date") then begin
                        EmployeeWorkDate_GCC."First Half Leave Type" := Leave."Leave Type Id";
                        EmployeeWorkDate_GCC."Second Half Leave Type" := Leave."Leave Type Id";
                    end;
                    EmployeeWorkDate_GCC.MODIFY;
                until EmployeeWorkDate_GCC.NEXT = 0;
        end;
    end;

    // Commented By Avinash [Scope('Internal')]
    procedure Reopen(Rec: Record "Cancel Leave Request")
    begin
        with Rec do begin
            if "Workflow Status" = "Workflow Status"::Open then
                exit;
            "Workflow Status" := "Workflow Status"::Open;
        end;
    end;
}

