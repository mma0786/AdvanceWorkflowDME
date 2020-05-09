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
                    AdvanceWorkflowCUL: Codeunit "Advance Workflow";
                begin
                    // @Avinash 09.05.2020
                    // Start #Levtech WF
                    CancelAndDeleteApprovalEntryTrans_LT(Rec.RecordId);
                    // Stop #Levtech WF

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


                    //LeaveRequestHeader.RESET;
                    if WfCode.IsDuty_Resumption_Enabled(Rec) then begin
                        // Start #Levtech  WF
                        LoopOfSeq_LT("Personnel Number", Rec."Leave Request ID");

                        // Stop #Levtech WF
                        WfCode.OnSendDuty_Resumption_Approval(rec);
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
                Image = CancelApprovalRequest;
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    WfCode: Codeunit InitCodeunit_Duty_Resumption;

                begin

                    WfCode.OnCancelDuty_Resumption_Approval(Rec);
                    // @Avinash 09.05.2020
                    // Start #Levtech WF
                    CancelAndDeleteApprovalEntryTrans_LT(Rec.RecordId);
                    // Stop #Levtech WF
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
                    ApprovalEntry: Record "Approval Entry";
                begin
                    ApprovalEntry.Reset();
                    ApprovalEntry.SETRANGE("Table ID", DATABASE::"Duty Resumption");
                    ApprovalEntry.SETRANGE("Record ID to Approve", Rec.RecordId);
                    ApprovalEntry.SETRANGE("Related to Change", FALSE);
                    PAGE.RUN(70010, ApprovalEntry);
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

    ///####################################################################################################
    local procedure "#########################-Start Customize Workflow-##################################"()
    begin
    end;

    procedure InsertApprovalEntryTrans_LT(TransID: Code[30]; SenderID: Code[50]; ReportingID: Code[50]; DelegateID: Code[50]; SequenceID: Integer)
    var
        ApprovalEntrtyTranscationRec_L: Record "Approval Entrty Transcation";
    begin
        //MESSAGE('Send -- %1   Rep -- %2   Seq -- %3',SenderID,ReportingID,SequenceID);

        ApprovalEntrtyTranscationRec_L.RESET;
        ApprovalEntrtyTranscationRec_L.INIT;
        ApprovalEntrtyTranscationRec_L."Trans ID" := TransID;
        ApprovalEntrtyTranscationRec_L."Advance Payrolll Type" := ApprovalEntrtyTranscationRec_L."Advance Payrolll Type"::"Duty Resumption";
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
        ApprovalLevelSetupRec_L.SETRANGE("Advance Payrolll Type", ApprovalLevelSetupRec_L."Advance Payrolll Type"::"Duty Resumption");
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
        ApprovalEntrtyTranscation.RESET;
        ApprovalEntrtyTranscation.SETRANGE("Document RecordsID", DocNo_P);
        if ApprovalEntrtyTranscation.FINDSET then begin
            ApprovalEntrtyTranscation.DELETEALL;
        end;

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





    local procedure "##########################-Stop Customize Workflow-##################################"()
    begin
    end;
}

