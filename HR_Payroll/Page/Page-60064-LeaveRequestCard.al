page 60064 "Leave Request Card"
{
    Caption = 'Leave Request';
    PageType = Card;
    SourceTable = "Leave Request Header";
    UsageCategory = Documents;
    // ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                Editable = ("Workflow Status" <> "Workflow Status"::Released) AND ("Workflow Status" <> "Workflow Status"::Rejected) AND ("Workflow Status" <> "Workflow Status"::"Pending For Approval");
                field("Leave Request ID"; "Leave Request ID")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Personnel Number"; "Personnel Number")
                {
                    Caption = 'Employee ID';
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field("Employee Name"; "Employee Name")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Leave Type"; "Leave Type")
                {
                    ShowMandatory = true;
                    ApplicationArea = All;
                    trigger OnValidate()
                    var
                        LeaveType: Record "HCM Leave Types Wrkr";

                    begin
                        Valid_IsCompensatoryLeave_LT;
                        LeaveType.SetRange(Worker, "Personnel Number");
                        LeaveType.SetRange("Leave Type Id", "Leave Type");
                        LeaveType.SetRange("Is Paternity Leave", true);
                        if LeaveType.FindFirst() then
                            IsperBool := true
                        else
                            IsperBool := false;


                    end;
                }
                field("Short Name"; "Short Name")
                {
                    Editable = false;
                    ApplicationArea = All;
                    Visible = false;
                }
                field(Description; Description)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Dependent ID"; "Dependent ID")
                {
                    ApplicationArea = All;
                    Editable = IsperBool;
                }
                field("Dependent Name"; "Dependent Name")
                {
                    ApplicationArea = All;
                }
                field("Start Date"; "Start Date")
                {
                    ShowMandatory = true;
                    ApplicationArea = All;
                    trigger OnValidate()
                    var
                        LeaveType: Record "HCM Leave Types Wrkr";
                    begin
                        Valid_IsCompensatoryLeave_LT;
                    end;
                }
                field("Leave Start Day Type"; "Leave Start Day Type")
                {
                    ApplicationArea = All;
                }
                field("End Date"; "End Date")
                {
                    ShowMandatory = true;
                    ApplicationArea = All;
                    trigger OnValidate()
                    var
                        LeaveType: Record "HCM Leave Types Wrkr";
                    begin
                        Valid_IsCompensatoryLeave_LT;
                    end;
                }
                // @Avinash 08.05.2020
                field("Compensatory Leave Date"; "Compensatory Leave Date")
                {
                    ApplicationArea = All;
                    Editable = CheckBoolG;
                    Style = Strong;
                    StyleExpr = true;


                }
                // @Avinash 08.05.2020
                //LT
                field("Entitlement Days"; "Entitlement Days")
                {
                    ApplicationArea = ALl;
                    Enabled = false;
                }
                field("Consumed Leaves"; "Consumed Leaves")
                {
                    ApplicationArea = All;
                    Enabled = false;
                }
                field("Leave Balance"; "Leave Balance")
                {
                    ApplicationArea = All;
                    Enabled = false;
                }
                //LT
                field("Leave End Day Type"; "Leave End Day Type")
                {
                    ApplicationArea = All;
                }
                field("Alternative Start Date"; "Alternative Start Date")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Leave Days"; "Leave Days")
                {
                    ApplicationArea = All;
                }
                field("Leave Remarks"; "Leave Remarks")
                {
                    ApplicationArea = All;
                }
                field("Alternative End Date"; "Alternative End Date")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field(LTA; LTA)
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Cover Resource"; "Cover Resource")
                {
                    ApplicationArea = All;
                }
                field("Submission Date"; "Submission Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Posted; Posted)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Leave Cancelled"; "Leave Cancelled")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Leave Planner ID"; "Leave Planner ID")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Created By"; "Created By")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Created Date Time"; "Created Date Time")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Workflow Status"; "Workflow Status")
                {
                    Editable = false;
                    ApplicationArea = All;
                }

                group("Resumption Details")
                {
                    Caption = 'Resumption Details';
                    field("Resumption Date"; "Resumption Date")
                    {
                        Editable = false;
                        ApplicationArea = All;
                    }
                    field("Resumption Type"; "Resumption Type")
                    {
                        Editable = false;
                        ApplicationArea = All;
                    }
                    field("Duty Resumption Request"; "Duty Resumption Request")
                    {
                        Editable = false;
                        ApplicationArea = All;
                    }
                    field("Net Leave Days"; "Net Leave Days")
                    {
                        Editable = false;
                        ApplicationArea = All;
                        Visible = false;
                    }
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("Request Approval")
            {
                Caption = 'Approvals';

                action("Send Approval Request")
                {
                    Caption = 'Send Approval Request';
                    Enabled = (NOT OpenApprovalEntriesExist) AND ("Workflow Status" = "Workflow Status"::Open);
                    Image = SendApprovalRequest;
                    ApplicationArea = All;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        WfInitCode: Codeunit InitCodeunit_Leave_Request;
                        AdvanceWorkflowCUL: Codeunit "Advance Workflow";
                    begin
                        TESTFIELD("Personnel Number");
                        TESTFIELD("Start Date");
                        TESTFIELD("End Date");
                        TESTFIELD(Posted, false);
                        // @Avinash 08.05.2020
                        if CheckBoolG then
                            TestField("Compensatory Leave Date");
                        CheckAttachmentsIfAfterdat;

                        // @Avinash 08.05.2020
                        // Start #Levtech WF
                        CancelAndDeleteApprovalEntryTrans_LT(Rec.RecordId);
                        // Stop #Levtech WF
                        TESTFIELD(Posted, false);
                        if not CONFIRM('Do you want to Submit the leave request?') then
                            exit;

                        if Rec."Leave Days" = 0 then
                            ERROR('Leave days cannot be zero');

                        SubmitLeave(Rec);
                        //LeaveRequestHeader.RESET;
                        if WfInitCode.Is_LeaveReq_Enabled(Rec) then begin
                            // Start #Levtech  WF
                            LoopOfSeq_LT("Personnel Number", "Leave Request ID");

                            // Stop #Levtech WF
                            WfInitCode.OnSend_LeaveReq_Approval(Rec);
                            // Start  21.04.2020 Advance Workflow
                            AdvanceWorkflowCUL.DeleteExtraLine_ApprovalEntry_LT(Rec.RecordId);
                            AdvanceWorkflowCUL.LeaveRequest_SwapApprovalUser_Advance_LT(Rec.RecordId);
                            AdvanceWorkflowCUL.DeleteExtraLine_ApprovalEntry_LT(Rec.RecordId);
                            // Stop 21.04.2020 Advance Workflow

                        end;
                    end;

                }

                action("Cancel Approval Request")
                {
                    Caption = 'Cancel Approval Request';
                    Enabled = CanCancelApprovalForRecord;
                    ApplicationArea = All;
                    Image = CancelApprovalRequest;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    var
                        INitWf: Codeunit InitCodeunit_Leave_Request;
                        DutyResumption: Record "Duty Resumption";
                    begin

                        CurrPage.SETSELECTIONFILTER(LeaveRequestHeader);
                        if LeaveRequestHeader.FINDFIRST then begin
                            if LeaveRequestHeader."Workflow Status" = LeaveRequestHeader."Workflow Status"::Released then
                                ERROR('You cannot cancel approved leaves');

                            DutyResumption.Reset();
                            DutyResumption.SetRange("Leave Request ID", "Leave Request ID");
                            if DutyResumption.FindFirst() then
                                if (DutyResumption."Workflow Status" = DutyResumption."Workflow Status"::"Pending Approval") or (DutyResumption."Workflow Status" = DutyResumption."Workflow Status"::Released) then
                                    Error('You cannot cancel approved leaves');

                            INitWf.OnCancel_LeaveReq_Approval(rec);
                            CancelAndDeleteApprovalEntryTrans_LT(Rec.RecordId);

                        end;
                    end;
                }
                action(Reopen)
                {
                    Enabled = ("Workflow Status" <> "Workflow Status"::Open) AND (NOT Posted);
                    Image = ReOpen;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;

                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        if Rec."Workflow Status" = Rec."Workflow Status"::"Pending For Approval" then
                            ERROR(Text001);

                        if "Workflow Status" = "Workflow Status"::Rejected then
                            ERROR('You Cannot reopen Cancelled Leave request');
                        TESTFIELD(Posted, false);
                        Reopen(Rec);
                    end;
                }
                action(Post)
                {
                    Caption = 'Post';
                    Enabled = EnableLeavePost;
                    ApplicationArea = All;
                    Image = Post;
                    PromotedOnly = true;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    var
                        LeaveRequestHeaderRecL: Record "Leave Request Header";
                    begin


                        if not CONFIRM('Do you want to post the leave request?') then
                            exit;

                        CurrPage.SETSELECTIONFILTER(LeaveRequestHeader);
                        if LeaveRequestHeader.FINDFIRST then begin
                            if LeaveRequestHeader."Leave Days" = 0 then
                                ERROR('Leave days cannot be zero');
                            LeaveRequestHeader.TESTFIELD("Workflow Status", "Workflow Status"::Released);
                            if LeaveRequestHeader.Posted then
                                ERROR('Leave request is already posted');
                            if not (LeaveRequestHeader."Workflow Status" = LeaveRequestHeader."Workflow Status"::Released) then
                                ERROR('Workflow Status must be Approved, Current value is %1', LeaveRequestHeader."Workflow Status");
                            PostLeave(LeaveRequestHeader);
                        end;
                    end;
                }
            }
            action("Swap USer")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                Image = SaveView;
                Visible = false;
                trigger OnAction()
                var
                    AdvanceWorkflowCUL: Codeunit "Advance Workflow";

                begin
                    AdvanceWorkflowCUL.LeaveRequest_SwapApprovalUser_Advance_LT(Rec.RecordId);
                end;

            }
            action("Check Postion")
            {
                Caption = 'Check Postion';
                ApplicationArea = All;
                Image = Check;
                Promoted = true;
                PromotedCategory = Process;
                Visible = false;
                PromotedOnly = true;

                trigger OnAction()
                begin
                    //MESSAGE(GetEmployeePostionEmployeeID_LT("Personnel Number"));
                    //LoopOfSeq_LT("Personnel Number","Leave Request ID");
                end;
            }

            // Avinash 14.04.2020
            action("Attachment")
            {
                ApplicationArea = All;
                Image = Attachments;
                Promoted = true;
                Caption = 'Attachment';
                PromotedCategory = Process;
                ToolTip = 'Add a file as an attachment. You can attach images as well as documents.';
                trigger
                OnAction()
                var
                    DocumentAttachmentDetails: Page "Document Attachment Details";
                    RecRef: RecordRef;
                begin
                    RecRef.GETTABLE(Rec);
                    DocumentAttachmentDetails.OpenForRecRef(RecRef);
                    DocumentAttachmentDetails.RUNMODAL;
                end;
            }
            // Avinash 14.04.2020

            group(Resumption)
            {
                Caption = 'Resumption';

                action("Dutys Resumption")
                {
                    Caption = 'Duty Resumption';
                    Image = Replan;
                    Promoted = true;
                    PromotedCategory = Process;
                    ApplicationArea = All;


                    trigger OnAction()
                    begin
                        //
                        TESTFIELD(Posted, true);
                        if Rec."Workflow Status" = Rec."Workflow Status"::Rejected then
                            ERROR('Leave Request is Cancelled, You cannot create duty resumption');
                        CreateDutyResumptionEntry;
                    end;
                }
                action("Duty Resumption")
                {
                    Caption = 'Duty Resumption';
                    Enabled = true;
                    Image = Replan;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    //PromotedOnly = true;
                    Visible = true;

                    trigger OnAction()
                    begin
                        //
                        TESTFIELD(Posted, true);
                        if Rec."Workflow Status" = Rec."Workflow Status"::Rejected then
                            ERROR('Leave Request is Cancelled, You cannot create duty resumption');
                        CreateDutyResumptionEntry;
                    end;
                }
                action("On Time Resumption")
                {
                    Caption = 'On Time Resumption';
                    ApplicationArea = All;
                    Image = Replan;
                    Promoted = true;
                    PromotedCategory = Process;
                    Visible = false;


                    trigger OnAction()
                    begin
                        //
                        if not CONFIRM('Do you want to Update On Time Resumption?') then
                            exit;

                        CurrPage.SETSELECTIONFILTER(LeaveRequestHeader);
                        //LeaveRequestHeader.TESTFIELD(Posted,TRUE);
                        UpdateOntimeResumption;
                    end;
                }


                action("Cancel Leave Request")
                {
                    Image = Cancel;
                    ApplicationArea = All;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    var
                        CancelLeaveRequest: Record "Cancel Leave Request";

                    begin
                        //
                        if Rec."Resumption Date" <> 0D then
                            ERROR('Cannot Cancel the Leave request,Duty Resumption created for this Leave');

                        TESTFIELD(Posted, true);
                        CancelLeaveRequest.RESET;
                        CancelLeaveRequest.SETRANGE("Leave Request ID", Rec."Leave Request ID");
                        if not CancelLeaveRequest.FINDFIRST then begin
                            if not CONFIRM('Do you want to Cancel the Leave Request ?', true) then
                                exit;
                            CancelLeaveRequest.INIT;
                            CancelLeaveRequest.TRANSFERFIELDS(Rec);
                            CancelLeaveRequest."Workflow Status" := CancelLeaveRequest."Workflow Status"::Open;
                            CancelLeaveRequest."Created Date" := WORKDATE;
                            CancelLeaveRequest."Created By" := USERID;
                            CancelLeaveRequest."Created Date Time" := CURRENTDATETIME;
                            CancelLeaveRequest."Submission Date" := 0D;

                            CancelLeaveRequest.INSERT;
                            COMMIT;
                        end;
                        PAGE.RUNMODAL(60065, CancelLeaveRequest);
                    end;
                }
            }
            group(Approval)
            {
                Caption = 'Approval';
                action(Approve)
                {
                    ApplicationArea = All;

                    Caption = 'Approve';
                    Image = Approve;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ToolTip = 'Approve the requested changes.';
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.ApproveRecordApprovalRequest(RECORDID);
                    end;
                }

                action(Reject)
                {
                    ApplicationArea = All;

                    Caption = 'Reject';
                    Enabled = OpenApprovalEntriesExistForCurrUser;
                    Image = Reject;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ToolTip = 'Reject the approval request.';
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.RejectRecordApprovalRequest(RECORDID);
                    end;
                }
                action(Delegate)
                {
                    ApplicationArea = All;

                    Caption = 'Delegate';
                    Enabled = OpenApprovalEntriesExistForCurrUser;
                    Image = Delegate;
                    Promoted = true;
                    PromotedCategory = Process;
                    ToolTip = 'Delegate the approval to a substitute approver.';
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.DelegateRecordApprovalRequest(RECORDID);
                    end;
                }
            }
            action(Approvals)
            {
                AccessByPermission = TableData "Approval Entry" = R;
                ApplicationArea = Suite;
                Caption = 'Approvals';
                Promoted = true;
                PromotedCategory = Category4;
                Image = Approvals;
                ToolTip = 'View a list of the records that are waiting to be approved. For example, you can see who requested the record to be approved, when it was sent, and when it is due to be approved.';

                trigger OnAction()
                var
                    GenJournalLine: Record "Gen. Journal Line";
                    ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    ApprovalEntry: Record "Approval Entry";
                begin
                    ApprovalEntry.Reset();
                    ApprovalEntry.SETRANGE("Table ID", DATABASE::"Leave Request Header");
                    ApprovalEntry.SETRANGE("Record ID to Approve", Rec.RecordId);
                    ApprovalEntry.SETRANGE("Related to Change", FALSE);
                    PAGE.RUN(70010, ApprovalEntry);
                    //commented By Avinash   ApprovalsMgmt.ShowLeaveRequestApprovalEntries(Rec);
                end;
            }
            action(Comments)
            {
                ApplicationArea = Suite;
                Caption = 'Comments';
                Image = ViewComments;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Scope = Repeater;
                ToolTip = 'View or add comments.';

                trigger OnAction()
                var
                    ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    RecRef: RecordRef;
                    ApprovalEntry: Record "Approval Entry";
                    RecID: RecordID;
                begin
                    RecRef.GET(Rec.RECORDID);
                    RecID := RecRef.RECORDID;
                    CLEAR(ApprovalsMgmt);
                    ApprovalEntry.RESET;
                    ApprovalEntry.SETRANGE("Table ID", RecID.TABLENO);
                    ApprovalEntry.SETRANGE("Record ID to Approve", RecRef.RECORDID);
                    //ApprovalEntry.SETRANGE(Status,ApprovalEntry.Status::Open);
                    //ApprovalEntry.SETRANGE("Approver ID",USERID);
                    ApprovalEntry.SETRANGE("Related to Change", false);
                    if ApprovalEntry.FINDFIRST then
                        ApprovalsMgmt.GetApprovalCommentForWorkflowStepInstanceID(RecRef, ApprovalEntry."Workflow Step Instance ID");
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        SetControlVisibility;
        Valid_IsCompensatoryLeave_LT;
    end;


    trigger OnAfterGetCurrRecord()
    begin
        Valid_IsCompensatoryLeave_LT;
    end;

    trigger OnOpenPage()
    begin
        SetControlVisibility;
    end;

    var
        CheckBoolG: Boolean;
        IsperBool: Boolean;
        DutyResume: Record "Duty Resumption";
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        P_DutyResume: Page "Duty Resumption";
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        CanCancelApprovalForRecord: Boolean;
        Text001: Label 'The approval process must be cancelled or completed to reopen this document.';
        LeaveRequestHeader: Record "Leave Request Header";
        EnableLeavePost: Boolean;
        EditLeaveRequest: Boolean;
        [InDataSet]
        DutyResumeEdit: Boolean;
        i: Integer;
        ShowRecCommentsEnabled: Boolean;
    // @Avinash 08.05.2020
    procedure Valid_IsCompensatoryLeave_LT()
    var
        LeaveType: Record "HCM Leave Types Wrkr";
    begin
        LeaveType.RESET;
        LeaveType.SETRANGE(Worker, Rec."Personnel Number");
        LeaveType.SETRANGE("Leave Type Id", Rec."Leave Type");
        LeaveType.SETRANGE("Earning Code Group", Rec."Earning Code Group");
        if LeaveType.FINDFIRST then begin
            if LeaveType."Is Compensatory Leave" then
                CheckBoolG := true
            else
                CheckBoolG := false;
        end;
    end;

    procedure CheckAttachmentsIfAfterdat()
    var
        LeaveType: Record "HCM Leave Types Wrkr";
        DocumentAttachment: Record "Document Attachment";
    begin
        LeaveType.RESET;
        LeaveType.SETRANGE(Worker, Rec."Personnel Number");
        LeaveType.SETRANGE("Leave Type Id", Rec."Leave Type");
        LeaveType.SETRANGE("Earning Code Group", Rec."Earning Code Group");
        if LeaveType.FINDFIRST then begin
            if LeaveType."Attachment Mandate" then begin
                if "Leave Days" > LeaveType."Attachments After Days" then begin
                    DocumentAttachment.Reset();
                    DocumentAttachment.SetRange("No.", "Leave Request ID");
                    DocumentAttachment.SetRange("Table ID", Database::"Leave Request Header");
                    if not DocumentAttachment.FindFirst() then
                        Error('Attachments required !');
                end;
            end;
        end;
    end;

    // @Avinash 08.05.2020
    local procedure SetControlVisibility()
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    begin
        OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(RECORDID);
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(RECORDID);
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(RECORDID);
        if Rec.Posted then
            EnableLeavePost := false
        else
            EnableLeavePost := true;


        if "Leave Request ID" <> '' then begin
            if (Rec."Workflow Status" = Rec."Workflow Status"::Open) or (Rec."Workflow Status" = Rec."Workflow Status"::Open) then
                EditLeaveRequest := true
            else
                EditLeaveRequest := false;
        end;

        if "Duty Resumption Request" then
            DutyResumeEdit := false
        else
            DutyResumeEdit := true;
    end;

    //commented By Avinash  [Scope('Internal')]
    procedure CreateDutyResumptionEntry()
    var
        Text00001: Label 'Duty Resumption Entries already exist';
    begin
        DutyResume.RESET;
        if not DutyResume.GET("Leave Request ID") then begin
            DutyResume.INIT;
            DutyResume.VALIDATE("Leave Request ID", "Leave Request ID");
            DutyResume.VALIDATE("Personnel Number", "Personnel Number");
            DutyResume.VALIDATE("Start Date", "Start Date");
            DutyResume.VALIDATE("End Date", "End Date");
            DutyResume.VALIDATE("Leave Type", "Leave Type");
            DutyResume.INSERT;
        end;
        CLEAR(P_DutyResume);
        CLEAR(DutyResume);
        DutyResume.SETRANGE("Leave Request ID", "Leave Request ID");
        if DutyResume.FINDFIRST then begin
            FILTERGROUP(2);
            P_DutyResume.SETTABLEVIEW(DutyResume);
            P_DutyResume.RUN;
            FILTERGROUP(0);
        end;
    end;

    //commented By Avinash  [Scope('Internal')]
    procedure GetEmployeePostionEmployeeID_LT(EmployeeID: Code[30]): Code[50]
    var
        PayrollJobPosWorkerAssignRec_L: Record "Payroll Job Pos. Worker Assign";
        PayrollPositionRec_L: Record "Payroll Position";
    begin
        PayrollJobPosWorkerAssignRec_L.RESET;
        PayrollJobPosWorkerAssignRec_L.SETRANGE(Worker, EmployeeID);
        PayrollJobPosWorkerAssignRec_L.SETRANGE("Is Primary Position", true);
        if PayrollJobPosWorkerAssignRec_L.FINDFIRST then begin
            PayrollPositionRec_L.RESET;
            PayrollPositionRec_L.SETRANGE("Position ID", PayrollJobPosWorkerAssignRec_L."Position ID");
            if PayrollPositionRec_L.FINDFIRST then
                exit(PayrollPositionRec_L.Worker);
        end;
    end;

    //commented By Avinash  [Scope('Internal')]
    procedure InsertApprovalEntryTrans_LT(TransID: Code[30]; SenderID: Code[50]; ReportingID: Code[50]; DelegateID: Code[50]; SequenceID: Integer)
    var
        ApprovalEntrtyTranscationRec_L: Record "Approval Entrty Transcation";
    begin
        //MESSAGE('Send -- %1   Rep -- %2   Seq -- %3',SenderID,ReportingID,SequenceID);

        ApprovalEntrtyTranscationRec_L.RESET;
        ApprovalEntrtyTranscationRec_L.INIT;
        ApprovalEntrtyTranscationRec_L."Trans ID" := TransID;
        ApprovalEntrtyTranscationRec_L."Advance Payrolll Type" := ApprovalEntrtyTranscationRec_L."Advance Payrolll Type"::Leaves;
        ApprovalEntrtyTranscationRec_L."Employee ID - Sender" := SenderID;
        ApprovalEntrtyTranscationRec_L."Reporting ID - Approver" := ReportingID;
        ApprovalEntrtyTranscationRec_L."Delegate ID" := DelegateID;
        ApprovalEntrtyTranscationRec_L."Sequence No." := SequenceID;
        // Start 21.04.2020
        ApprovalEntrtyTranscationRec_L."Document RecordsID" := Rec.RecordId;
        // Stop 21.04.2020
        ApprovalEntrtyTranscationRec_L.INSERT;
        //Message('  SenderID - %1    ReportingID - %2    DelegateID - %3', SenderID, ReportingID, DelegateID);
    end;

    //commented By Avinash  [Scope('Internal')]
    procedure LoopOfSeq_LT(EmpID: Code[50]; TransID: Code[30])
    var
        ApprovalLevelSetupRec_L: Record "Approval Level Setup";
        UserSetupRec_L: Record "User Setup";
        UserSetupRec2_L: Record "User Setup";
        OneEmpID: Code[50];
        TwoEmpID: Code[50];
        ThreeEmpID: Code[50];
        PreEmpID: Code[50];
        SenderID_L: Code[50];
        ReportingID_L: Code[50];
        CountForLoop_L: Integer;
        Delegate_L: Code[80];
        SeqNo_L: Integer;
        IsFinalPos: Boolean;
    begin
        CLEAR(SenderID_L);
        CLEAR(ReportingID_L);
        CLEAR(OneEmpID);
        CLEAR(TwoEmpID);
        CLEAR(ThreeEmpID);
        CLEAR(Delegate_L);
        IsFinalPos := false;

        ApprovalLevelSetupRec_L.RESET;
        ApprovalLevelSetupRec_L.SETRANGE("Advance Payrolll Type", ApprovalLevelSetupRec_L."Advance Payrolll Type"::Leaves);
        if ApprovalLevelSetupRec_L.FINDFIRST then begin
            SenderID_L := EmpID;
            CountForLoop_L := ApprovalLevelSetupRec_L.Level;
            SeqNo_L := 0;
            for i := 1 to CountForLoop_L do begin
                //Clear(Delegate_L);

                ReportingID_L := GetEmployeePostionEmployeeID_LT(SenderID_L);

                if GetEmployeePostionEmployeeID_FinalPosituion_LT(SenderID_L) then begin
                    if (ReportingID_L = '') then begin//(i = 1) AND
                        ReportingID_L := SenderID_L;
                        IsFinalPos := true;
                        // MESSAGE('dele');
                    end;
                    i := ApprovalLevelSetupRec_L.Level + 1;
                end;

                SeqNo_L += 1;

                if ReportingID_L = '' then
                    ERROR('Next level Approval Position Not Define');

                UserSetupRec_L.RESET;
                UserSetupRec_L.SETRANGE("Employee Id", SenderID_L);
                if not UserSetupRec_L.FINDFIRST then
                    ERROR('Employee Id  %1 must have a value in User Setup', SenderID_L);
                UserSetupRec_L.TESTFIELD("User ID");

                UserSetupRec2_L.RESET;
                UserSetupRec2_L.SETRANGE("Employee Id", ReportingID_L);
                if not UserSetupRec2_L.FINDFIRST then
                    ERROR('Employee Id  %1 must have a value in User Setup', ReportingID_L);
                UserSetupRec2_L.TESTFIELD("User ID");

                Delegate_L := CheckDelegateForEmployee_LT(ReportingID_L);

                //MESSAGE('Sender - %1 .............. Appr - %2 ', UserSetupRec_L."User ID",UserSetupRec2_L."User ID");
                //MESSAGE('I - %1',i);

                if i <= ApprovalLevelSetupRec_L.Level then begin
                    InsertApprovalEntryTrans_LT(TransID,
                                                 UserSetupRec_L."User ID",
                                                 UserSetupRec2_L."User ID",
                                                 Delegate_L,
                                                 SeqNo_L);
                    //Message('No Final i %1 Sender %2   App %3  Delegate_L %4', i, UserSetupRec_L."User ID", UserSetupRec2_L."User ID", Delegate_L);

                end else
                    if (GetEmployeePostionEmployeeID_FinalPosituion_LT(SenderID_L)) and (i > ApprovalLevelSetupRec_L.Level) then begin
                        InsertApprovalEntryTrans_LT(TransID,
                                                      UserSetupRec_L."User ID",
                                                      UserSetupRec2_L."User ID",
                                                      Delegate_L,
                                                      SeqNo_L);
                        IsFinalPos := true;

                        // Message(' Final i %1 Sender %2   App %3  Delegate_L %4', i, UserSetupRec_L."User ID", UserSetupRec2_L."User ID", Delegate_L);
                    end;

                // Sender is Reporter
                OneEmpID := SenderID_L;
                SenderID_L := ReportingID_L;

            end;
            // Start At Last for Finance Approve 
            if not IsFinalPos then
                IF ApprovalLevelSetupRec_L."Direct Approve By Finance" THEN BEGIN
                    IF ApprovalLevelSetupRec_L."Finance User ID" <> '' THEN BEGIN
                        CLEAR(Delegate_L);
                        IF CheckDelegateForEmployee_LT2(ApprovalLevelSetupRec_L."Finance User ID", 2) <> '' THEN
                            Delegate_L := CheckDelegateForEmployee_LT2(ApprovalLevelSetupRec_L."Finance User ID", 2)
                        ELSE
                            CLEAR(Delegate_L);

                        InsertApprovalEntryTrans_LT(TransID, UserSetupRec2_L."User ID", ApprovalLevelSetupRec_L."Finance User ID", Delegate_L, (SeqNo_L + 1));

                    END ELSE
                        IF ApprovalLevelSetupRec_L."Finance User ID 2" <> '' THEN BEGIN
                            CLEAR(Delegate_L);
                            IF CheckDelegateForEmployee_LT2(ApprovalLevelSetupRec_L."Finance User ID 2", 2) <> '' THEN
                                Delegate_L := CheckDelegateForEmployee_LT2(ApprovalLevelSetupRec_L."Finance User ID 2", 2)
                            ELSE
                                CLEAR(Delegate_L);

                            InsertApprovalEntryTrans_LT(TransID, UserSetupRec2_L."User ID", ApprovalLevelSetupRec_L."Finance User ID 2", Delegate_L, (SeqNo_L + 2));
                        END;
                END;
            // Stop At Last for Finance Approve
        end;

    end;
    //###########################
    procedure CheckDelegateForEmployee_LT2(checkDelegateInfo_P: Code[150]; IsEmployeeOrUser: Integer): Code[80]
    var
        DelegateWFLTRec_L: Record "Delegate - WFLT";
        UserSetupRecL: Record "User Setup";
    begin
        IF IsEmployeeOrUser = 1 THEN BEGIN
            DelegateWFLTRec_L.RESET;
            DelegateWFLTRec_L.SETRANGE("Employee Code", checkDelegateInfo_P);
            IF DelegateWFLTRec_L.FINDFIRST THEN BEGIN
                IF DelegateWFLTRec_L."Delegate ID" <> '' THEN
                    IF (DelegateWFLTRec_L."From Date" >= TODAY) AND (DelegateWFLTRec_L."To Date" <= TODAY) THEN
                        EXIT(DelegateWFLTRec_L."Delegate ID");
            END;
        END ELSE
            IF IsEmployeeOrUser = 2 THEN BEGIN
                UserSetupRecL.RESET;
                UserSetupRecL.SETRANGE("User ID", checkDelegateInfo_P);
                IF UserSetupRecL.FINDFIRST THEN
                    UserSetupRecL.TESTFIELD("Employee Id");

                DelegateWFLTRec_L.RESET;
                DelegateWFLTRec_L.SETRANGE("Employee Code", UserSetupRecL."Employee Id");
                IF DelegateWFLTRec_L.FINDFIRST THEN BEGIN
                    IF DelegateWFLTRec_L."Delegate ID" <> '' THEN BEGIN
                        IF (DelegateWFLTRec_L."From Date" <= TODAY) AND (DelegateWFLTRec_L."To Date" >= TODAY) THEN BEGIN
                            EXIT(DelegateWFLTRec_L."Delegate ID");
                        END
                    END;
                END;
            END;
    end;
    //###########################

    //commented By Avinash  [Scope('Internal')]
    procedure CancelAndDeleteApprovalEntryTrans_LT(DocNo_P: RecordId)
    var
        ApprovalEntrtyTranscation: Record "Approval Entrty Transcation";
        ApprovalEntry: Record "Approval Entry";
    begin
        // ApprovalEntry.Reset();
        // ApprovalEntry.DeleteAll();

        ApprovalEntrtyTranscation.RESET;
        ApprovalEntrtyTranscation.SETRANGE("Document RecordsID", DocNo_P);
        if ApprovalEntrtyTranscation.FINDSET then begin
            ApprovalEntrtyTranscation.DELETEALL;
        end;
        //ApprovalEntrtyTranscation.DELETEALL;
        // Message('Delete');
    end;

    //commented By Avinash  [Scope('Internal')]
    procedure CheckDelegateForEmployee_LT(EmployeeCode_P: Code[30]): Code[80]
    var
        DelegateWFLTRec_L: Record "Delegate - WFLT";
    begin
        DelegateWFLTRec_L.RESET;
        DelegateWFLTRec_L.SETCURRENTKEY("Employee Code");
        DelegateWFLTRec_L.SETRANGE("Employee Code", EmployeeCode_P);
        if DelegateWFLTRec_L.FINDLAST then
            IF (DelegateWFLTRec_L."From Date" <= TODAY) AND (DelegateWFLTRec_L."To Date" >= TODAY) THEN begin
                EXIT(DelegateWFLTRec_L."Delegate ID");
            end;
    end;

    //commented By Avinash  [Scope('Internal')]
    procedure GetEmployeePostionEmployeeID_FinalPosituion_LT(EmployeeID: Code[30]): Boolean
    var
        PayrollJobPosWorkerAssignRec_L: Record "Payroll Job Pos. Worker Assign";
        PayrollPositionRec_L: Record "Payroll Position";
    begin
        PayrollJobPosWorkerAssignRec_L.RESET;
        PayrollJobPosWorkerAssignRec_L.SETRANGE(Worker, EmployeeID);
        PayrollJobPosWorkerAssignRec_L.SETRANGE("Is Primary Position", true);
        if PayrollJobPosWorkerAssignRec_L.FINDFIRST then begin
            PayrollPositionRec_L.RESET;
            PayrollPositionRec_L.SETRANGE("Position ID", PayrollJobPosWorkerAssignRec_L."Position ID");
            if PayrollPositionRec_L.FINDFIRST then
                if PayrollPositionRec_L."Final authority" then
                    exit(true)
                else
                    exit(false);
        end;
    end;
}

