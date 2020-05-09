page 60202 "Leave Requests_RC"
{
    Caption = 'Leave Requests RC';
    CardPageID = "Leave Request Card_RC";
    DelayedInsert = true;
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Leave Request Header";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Leave Request ID"; "Leave Request ID")
                {
                    Editable = false;
                }
                field("Personnel Number"; "Personnel Number")
                {
                }
                field("Employee Name"; "Employee Name")
                {
                    Editable = false;
                }
                field("Leave Type"; "Leave Type")
                {
                }
                field("Short Name"; "Short Name")
                {
                    Editable = false;
                }
                field(Description; Description)
                {
                    Editable = false;
                }
                field("Start Date"; "Start Date")
                {
                }
                field("Leave Start Day Type"; "Leave Start Day Type")
                {
                }
                field("End Date"; "End Date")
                {
                }
                field("Leave Days"; "Leave Days")
                {
                }
                field("Leave End Day Type"; "Leave End Day Type")
                {
                }
                field("Leave Remarks"; "Leave Remarks")
                {
                }
                field("Cover Resource"; "Cover Resource")
                {
                }
                field("Submission Date"; "Submission Date")
                {
                }
                field("Workflow Status"; "Workflow Status")
                {
                    Editable = false;
                }
                field(Posted; Posted)
                {
                    Editable = false;
                }
                field("Leave Cancelled"; "Leave Cancelled")
                {
                    Editable = false;
                }
                field("Leave Planner ID"; "Leave Planner ID")
                {
                    Visible = false;
                }
                field("Created By"; "Created By")
                {
                    Editable = false;
                }
                field("Created Date Time"; "Created Date Time")
                {
                    Editable = false;
                }
                field("Resumption Type"; "Resumption Type")
                {
                    Editable = false;
                }
                field("Resumption Date"; "Resumption Date")
                {
                    Editable = false;
                }
                field("Net Leave Days"; "Net Leave Days")
                {
                    Editable = false;
                }
                field("Duty Resumption Request"; "Duty Resumption Request")
                {
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Submit For Approval")
            {
                Caption = 'Submit For Approval';
                Enabled = NOT OpenApprovalEntriesExist;
                Image = ReleaseDoc;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    // Start #Levtech WF
                    LeaveRequestCardPage_G.CancelAndDeleteApprovalEntryTrans_LT(rec.RecordId);
                    // Stop #Levtech WF
                    TESTFIELD(Posted, false);
                    if not CONFIRM('Do you want to Submit the leave request?') then
                        exit;

                    CurrPage.SETSELECTIONFILTER(LeaveRequestHeader);
                    if LeaveRequestHeader.FINDFIRST then begin
                        SubmitLeave(LeaveRequestHeader);
                        TESTFIELD(Posted, false);
                        //commented By Avinash   if ApprovalsMgmt.CheckLeaveRequestApprovalPossible(LeaveRequestHeader) then begin
                        // Start #Levtech  WF
                        //commented By Avinash  LeaveRequestCardPage_G.LoopOfSeq_LT("Personnel Number", "Leave Request ID");
                        // Stop #Levtech WF
                        //commented By Avinash  ApprovalsMgmt.OnSendLeaveRequestForApproval(LeaveRequestHeader);
                        //commented By Avinash   end;
                    end;
                end;
            }
            action("Cancel Approval Request")
            {
                Caption = 'Cancel Approval Request';
                Enabled = CanCancelApprovalForRecord;
                Image = CancelApprovalRequest;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    CurrPage.SETSELECTIONFILTER(LeaveRequestHeader);
                    if LeaveRequestHeader.FINDFIRST then begin
                        if LeaveRequestHeader."Workflow Status" = LeaveRequestHeader."Workflow Status"::Released then
                            ERROR('You cannot cancel approved leaves');

                        //commented By Avinash   ApprovalsMgmt.OnCancelLeaveApprovalRequest(LeaveRequestHeader);
                        // Start #Levtech WF
                        LeaveRequestCardPage_G.CancelAndDeleteApprovalEntryTrans_LT(rec.RecordId);
                        // Stop #Levtech WF
                    end;
                end;
            }
            action(Reopen)
            {
                Enabled = "Workflow Status" <> "Workflow Status"::Open;
                Image = ReOpen;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    if Rec."Workflow Status" = Rec."Workflow Status"::"Pending For Approval" then
                        ERROR(Text001);

                    TESTFIELD(Posted, false);
                    Reopen(Rec);
                end;
            }
            action(Post)
            {
                Caption = 'Post';
                Enabled = EnableLeavePost;
                Image = Post;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    //

                    TESTFIELD("Workflow Status", "Workflow Status"::Released);
                    if not CONFIRM('Do you want to post the leave request?') then
                        exit;

                    CurrPage.SETSELECTIONFILTER(LeaveRequestHeader);
                    if LeaveRequestHeader.FINDFIRST then begin
                        LeaveRequestHeader.TESTFIELD("Workflow Status", "Workflow Status"::Released);
                        TESTFIELD(Posted, false);
                        PostLeave(LeaveRequestHeader);
                    end;
                end;
            }
            group(Resumption)
            {
                Caption = 'Resumption';
                action("Duty Resumption")
                {
                    Caption = 'Duty Resumption';
                    Enabled = DutyResumeEdit;
                    Image = Replan;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    begin
                        //
                        TESTFIELD(Posted, true);
                        CreateDutyResumptionEntry;
                    end;
                }
                action("Late Resumption")
                {
                    Caption = 'Late Resumption';
                    Image = Replan;
                    Promoted = true;
                    PromotedCategory = Category4;
                    Visible = false;

                    trigger OnAction()
                    begin
                        //
                    end;
                }
                action("On Time Resumption")
                {
                    Caption = 'On Time Resumption';
                    Image = Replan;
                    Promoted = true;
                    PromotedCategory = Category4;
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
                    PromotedCategory = Category4;
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
                    PromotedCategory = Category4;
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
                    PromotedCategory = Category4;
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
        }
    }

    trigger OnAfterGetRecord()
    begin
        SetControlVisibility;
    end;

    trigger OnOpenPage()
    begin
        SetControlVisibility;
    end;

    var
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
        LeaveRequestCardPage_G: Page "Leave Request Card";

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
            if (Rec."Workflow Status" = Rec."Workflow Status"::Open) then
                EditLeaveRequest := true
            else
                EditLeaveRequest := false;
        end;

        if ("Duty Resumption Request") or ("Duty Resumption ID" <> '') then
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
            DutyResume.INSERT(true);
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
}

