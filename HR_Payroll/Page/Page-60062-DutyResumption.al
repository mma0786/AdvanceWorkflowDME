page 60062 "Duty Resumption"
{
    PageType = Card;
    SourceTable = "Duty Resumption";
    UsageCategory = Administration;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Leave Request ID"; "Leave Request ID")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Start Date"; "Start Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("End Date"; "End Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Leave Type"; "Leave Type")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Resumption Date"; "Resumption Date")
                {
                    ApplicationArea = All;
                    Editable = ResumeDateEditable;

                    trigger OnValidate()
                    begin
                        LeaveReqLines.RESET;
                        LeaveReqLines.SETRANGE("Leave Request ID", "Leave Request ID");
                        if LeaveReqLines.FINDSET then
                            LeaveReqLines.DELETEALL;

                        if "Resumption Date" = 0D then begin
                            ExtensionLineVisible := false;
                        end;

                        if "Resumption Date" >= "End Date" + 2 then begin
                            ExtensionLineVisible := true;
                            LeaveReqLines.INIT;
                            LeaveReqLines.VALIDATE("Leave Request ID", "Leave Request ID");
                            LeaveReqLines."Line No" += LeaveReqLines."Line No" + 1000;
                            LeaveReqLines.VALIDATE("Personnel Number", "Personnel Number");
                            LeaveReqLines.VALIDATE("Start Date", Rec."End Date" + 1);
                            LeaveReqLines.VALIDATE("End Date", Rec."Resumption Date" - 1);
                            LeaveReqLines."Created By" := USERID;
                            LeaveReqLines."Created Date Time" := CURRENTDATETIME;
                            LeaveReqLines."Created Date" := TODAY;
                            LeaveReqLines."Submission Date" := TODAY;
                            LeaveReqLines."Workflow Status" := LeaveReqLines."Workflow Status"::Open;
                            LeaveReqLines.INSERT(true);
                        end else
                            ExtensionLineVisible := false;
                    end;
                }
                field("Personnel Number"; "Personnel Number")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Workflow Status"; "Workflow Status")
                {
                    ApplicationArea = All;
                    Editable = true;
                }
            }
            part("Leave Extension"; "Leave Extension Lines")
            {
                Caption = 'Leave Extension';
                ApplicationArea = All;
                SubPageLink = "Leave Request ID" = FIELD("Leave Request ID"), "Personnel Number" = field("Personnel Number");
                SubPageView = SORTING("Leave Request ID", "Line No") ORDER(Ascending);
                Visible = ExtensionLineVisible;
            }
        }
        area(factboxes)
        {
            systempart(Control11; Notes)
            {
                ApplicationArea = All;
            }
            systempart(Control12; Links)
            {
                ApplicationArea = All;
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
                Image = SendApprovalRequest;
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                Var
                    WfCode: Codeunit InitCodeunit_Duty_Resumption;
                begin
                    // Start PHASE -2 #Levtech WF
                    //commented By Avinash    CancelAndDeleteApprovalEntryTrans_LT("Leave Request ID");
                    // Stop PHASE -2 #Levtech WF


                    TESTFIELD("Workflow Status", "Workflow Status"::Open);
                    TESTFIELD("Resumption Date");
                    LeaveReqLines.RESET;
                    LeaveReqLines.SETRANGE("Leave Request ID", "Leave Request ID");
                    if LeaveReqLines.FINDSET then
                        repeat
                            LeaveReqLines.TESTFIELD("Leave Type");
                            LeaveReqLines.SubmitLeave(LeaveReqLines);
                        until LeaveReqLines.NEXT = 0;

                    CurrPage.SETSELECTIONFILTER(T_DutyResmue);
                    if T_DutyResmue.FINDSET then;
                    //commented By Avinash    if ApprovalsMgmt.CheckDutyResumePossible(Rec) then begin
                    // Start #Levtech  WF
                    //commented By Avinash    LoopOfSeq_LT("Personnel Number", "Leave Request ID");
                    // Stop #Levtech WF
                    //commented By Avinash   ApprovalsMgmt.OnSendDutyResumeForApproval(Rec);

                    //commented By Avinash   end;

                    //New Wf Code

                    WfCode.IsDuty_Resumption_Enabled(Rec);
                    WfCode.OnSendDuty_Resumption_Approval(rec);
                end;
            }
            action("Cancel Approval Request")
            {
                Caption = 'Cancel Approval Request';
                Enabled = CanCancelApprovalForRecord;
                Image = CancelApprovalRequest;
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    WfCode: Codeunit InitCodeunit_Duty_Resumption;

                begin
                    // Start PHASE- 2 #Levtech WF
                    //commented By Avinash   CancelAndDeleteApprovalEntryTrans_LT("Leave Request ID");
                    // Stop PHASE -2 #Levtech WF
                    //commented By Avinash  ApprovalsMgmt.OnCancelDutyResumeApprovalReq(Rec);
                    //New WfCode
                    WfCode.OnCancelDuty_Resumption_Approval(Rec);
                end;
            }
            action(Approvals)
            {
                AccessByPermission = TableData "Approval Entry" = R;
                ApplicationArea = Suite;

                Caption = 'Approvals';
                Image = Approvals;
                ToolTip = 'View a list of the records that are waiting to be approved. For example, you can see who requested the record to be approved, when it was sent, and when it is due to be approved.';

                trigger OnAction()
                var
                    GenJournalLine: Record "Gen. Journal Line";
                    ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                begin
                    //commented By Avinash    ApprovalsMgmt.ShowDutyResumptionApprovalEntries(Rec);
                end;
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        if "Workflow Status" = "Workflow Status"::Released then
            ResumeDateEditable := false
        else
            ResumeDateEditable := true;

        if "Resumption Date" <> 0D then begin
            if "Resumption Date" >= "End Date" + 2 then
                ExtensionLineVisible := true
            else
                ExtensionLineVisible := false;
        end;
    end;

    trigger OnAfterGetRecord()
    begin
        SetControlVisibility;
    end;

    trigger OnInit()
    begin
        ExtensionLineVisible := false;
    end;

    trigger OnOpenPage()
    begin


        SetControlVisibility;
    end;

    var
        //LeaveReqHeader: Record "Leave Request Header";
        T_DutyResmue: Record "Duty Resumption";
        EmpWorkDate: Record EmployeeWorkDate_GCC;
        LeaveType: Record "HCM Leave Types ErnGrp";
        Employee: Record Employee;
        LeaveReqLines: Record "Leave Extension";
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        [InDataSet]
        ExtensionLineVisible: Boolean;
        [InDataSet]
        ResumeDateEditable: Boolean;
        OpenApprovalEntriesExist: Boolean;
        OpenApprovalEntriesExistForCurrUser: Boolean;
        CanCancelApprovalForRecord: Boolean;
        LineExtEditable: Boolean;
        i: Integer;

    local procedure SetControlVisibility()
    begin
        OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(RECORDID);
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(RECORDID);
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(RECORDID);
    end;

    local procedure "#########################-Start Customize Workflow-##################################"()
    begin
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
            // Start 22-11-2019
            PayrollPositionRec_L.SETFILTER("Valid From", '%1', 0D);
            // Stop 22-11-2019
            if PayrollPositionRec_L.FINDFIRST then
                exit(PayrollPositionRec_L.Worker);
        end;
    end;

    //commented By Avinash  [Scope('Internal')]
    procedure InsertApprovalEntryTrans_LT(TransID: Code[30]; SenderID: Code[50]; ReportingID: Code[50]; DelegateID: Code[50]; SequenceID: Integer)
    var
        ApprovalEntrtyTranscationRec_L: Record "Approval Entrty Transcation";
    begin
        ApprovalEntrtyTranscationRec_L.RESET;
        ApprovalEntrtyTranscationRec_L.INIT;
        ApprovalEntrtyTranscationRec_L."Trans ID" := TransID;
        ApprovalEntrtyTranscationRec_L."Advance Payrolll Type" := ApprovalEntrtyTranscationRec_L."Advance Payrolll Type"::"Duty Resumption";
        ApprovalEntrtyTranscationRec_L."Employee ID - Sender" := SenderID;
        ApprovalEntrtyTranscationRec_L."Reporting ID - Approver" := ReportingID;
        ApprovalEntrtyTranscationRec_L."Delegate ID" := DelegateID;
        ApprovalEntrtyTranscationRec_L."Sequence No." := SequenceID;
        ApprovalEntrtyTranscationRec_L.INSERT;
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
    begin
        CLEAR(SenderID_L);
        CLEAR(ReportingID_L);
        CLEAR(OneEmpID);
        CLEAR(TwoEmpID);
        CLEAR(ThreeEmpID);
        CLEAR(Delegate_L);

        ApprovalLevelSetupRec_L.RESET;
        ApprovalLevelSetupRec_L.SETRANGE("Advance Payrolll Type", ApprovalLevelSetupRec_L."Advance Payrolll Type"::"Duty Resumption");
        if ApprovalLevelSetupRec_L.FINDFIRST then begin
            SenderID_L := EmpID;
            CountForLoop_L := ApprovalLevelSetupRec_L.Level;
            SeqNo_L := 0;
            for i := 1 to CountForLoop_L do begin
                ReportingID_L := GetEmployeePostionEmployeeID_LT(SenderID_L);

                if GetEmployeePostionEmployeeID_FinalPosituion_LT(SenderID_L) then begin
                    if (ReportingID_L = '') then begin
                        ReportingID_L := SenderID_L;
                    end;
                    i := ApprovalLevelSetupRec_L.Level + 1;
                end;
                SeqNo_L += 1;

                if ReportingID_L = '' then
                    ERROR('Next level Approval Position Not Define');

                UserSetupRec_L.RESET;
                //commented By Avinash  UserSetupRec_L.SETRANGE("Employee Id", SenderID_L);
                if not UserSetupRec_L.FINDFIRST then
                    ERROR('Employee Id  %1 must have a value in User Setup', SenderID_L);
                UserSetupRec_L.TESTFIELD("User ID");

                UserSetupRec2_L.RESET;
                //commented By Avinash  UserSetupRec2_L.SETRANGE("Employee Id", ReportingID_L);
                if not UserSetupRec2_L.FINDFIRST then
                    ERROR('Employee Id  %1 must have a value in User Setup', ReportingID_L);
                UserSetupRec2_L.TESTFIELD("User ID");

                Delegate_L := CheckDelegateForEmployee_LT(ReportingID_L);


                if i <= ApprovalLevelSetupRec_L.Level then
                    InsertApprovalEntryTrans_LT(TransID,
                                                 UserSetupRec_L."User ID",
                                                 UserSetupRec2_L."User ID",
                                                 Delegate_L,
                                                 SeqNo_L);

                if (GetEmployeePostionEmployeeID_FinalPosituion_LT(SenderID_L)) and (i > ApprovalLevelSetupRec_L.Level) then
                    InsertApprovalEntryTrans_LT(TransID,
                                                  UserSetupRec_L."User ID",
                                                  UserSetupRec2_L."User ID",
                                                  Delegate_L,
                                                  SeqNo_L);

                // Sender is Reporter
                OneEmpID := SenderID_L;
                SenderID_L := ReportingID_L;

            end;
        end;
    end;

    //commented By Avinash  [Scope('Internal')]
    procedure CancelAndDeleteApprovalEntryTrans_LT(DocNo_P: Code[50])
    var
        ApprovalEntrtyTranscation: Record "Approval Entrty Transcation";
    begin
        ApprovalEntrtyTranscation.RESET;
        ApprovalEntrtyTranscation.SETRANGE("Trans ID", DocNo_P);
        if ApprovalEntrtyTranscation.FINDSET then
            ApprovalEntrtyTranscation.DELETEALL;
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
            if (WORKDATE >= DelegateWFLTRec_L."From Date") or (WORKDATE <= DelegateWFLTRec_L."To Date") then
                exit(DelegateWFLTRec_L."Delegate ID");
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

    local procedure "##########################-Stop Customize Workflow-##################################"()
    begin
    end;
}

