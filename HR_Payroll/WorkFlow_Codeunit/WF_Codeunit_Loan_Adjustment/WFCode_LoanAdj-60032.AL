codeunit 60032 WFCode_Loan_Adj
{
    trigger OnRun()
    begin

    end;

    var
        WFMngt: Codeunit "Workflow Management";
        AppMgmt: Codeunit "Approvals Mgmt.";
        WorkflowEventHandling: Codeunit "Workflow Event Handling";
        WorkflowResponseHandling: Codeunit "Workflow Response Handling";
        Send_Loan_AdjReq: TextConst ENU = 'LT Approval Request for Loan Adjustment is requested', ENG = 'LT Approval Request for Loan Adjustment is requested';
        AppReq_Loan_Adj: TextConst ENU = 'LT Approval Request for Loan Adjustment is approved', ENG = 'LT Approval Request for Loan Adjustment is approved';
        RejReq_Loan_Adj: TextConst ENU = 'LT Approval Request for Loan Adjustment is rejected', ENG = 'LT Approval Request for Loan Adjustmentis rejected';
        DelReq_Loan_Adj: TextConst ENU = 'LT Approval Request for Loan Adjustment is delegated', ENG = 'LT Approval Request for Loan Adjustment is delegated';
        SendForPendAppTxt: TextConst ENU = 'LT Status of Loan Adjustment changed to Pending approval', ENG = 'LT Status of Loan Adjustment changed to Pending approval';
        CancelForPendAppTxt: TextConst ENU = 'LT Approval Rquest for Loan Adjustment is Canceled', ENG = 'LT Approval request for Loan Adjustment is Canceled';
        Release_Loan_AdjTxt: TextConst ENU = 'LT ReleaseLoan_Adj', ENG = 'LT ReleaseLoan_Adj';
        ReOpen_Loan_AdjTxt: TextConst ENU = 'LT ReOpenLoan_Adj', ENG = 'LT ReOpenLoan_Adj';
        Loan_Adj_Message: TextConst ENU = 'LT Loan_AdjMessage', ENG = 'LT Loan_AdjMessage';
        Loan_AdjSend_Message: TextConst ENU = 'LT Loan_AdjSendMessage', ENG = 'LT Loan_AdjSendMessage';
        // Sathish Reject Code
        SendForRejectTxt: TextConst ENU = 'LT Status of Loan Adjustment changed to Reject', ENG = 'LT Status of Loan Adjustment changed to Reject';
        Send_Loan_AdjReject_Loan_AdjReq: TextConst ENU = 'LT Approval Request for Loan Adjustment is Rejected', ENG = 'LT Approval Request for Loan Adjustment is Rejected';
    // Sathish Reject Code



    //Events Subscribe Start

    //Send For Approval Event************************************************************************************ start
    procedure RunWorkflowOnSend_Loan_AdjApprovalCode(): Code[128]
    begin
        exit('RunWorkflowOnSend_NEW_Loan_AdjApproval');
    end;
    // Sathish Reject
    procedure RunWorkflowOnSend_Loan_AdjRejectCode(): Code[128]
    begin
        exit('RunWorkflowOnSend_NEW_Loan_AdjReject');
    end;
    // Sathish Reject

    [EventSubscriber(ObjectType::Codeunit, Codeunit::InitCodeunit_Loan_Adj, 'OnSendLoan_Adj_Approval', '', true, true)]
    procedure RunWorkflowOnSend_Loan_AdjApproval(var LoanAdjRec: Record "Loan Adjustment Header")
    begin
        WFMngt.HandleEvent(RunWorkflowOnSend_Loan_AdjApprovalCode, LoanAdjRec);
    end;
    // End

    //Cancel For Approval Event************************************************************************************ End
    procedure RunWorkflowOnCancel_Loan_AdjApprovalCode(): Code[128]
    begin
        exit('RunWorkflowOnCancel_NEW_Loan_AdjApproval');
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::InitCodeunit_Loan_Adj, 'OnCancelLoan_Adj_Approval', '', true, true)]
    procedure RunWorkflowOnCancel_Loan_AdjApproval(var LoanAdjRec: Record "Loan Adjustment Header")
    begin
        WFMngt.HandleEvent(RunWorkflowOnCancel_Loan_AdjApprovalCode, LoanAdjRec);
    end;
    //End

    //Approve Approval reques Event************************************************************************************ End
    procedure RunWorkflowOnApprove_Loan_AdjApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnApprove_NEW_Loan_AdjApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnApproveApprovalRequest', '', true, true)]
    procedure RunWorkflowOnApprove_Loan_AdjApproval(var ApprovalEntry: Record "Approval Entry")
    var
        RequisitionRequestsRec: Record "Loan Adjustment Header";
        l_ApprovalEntry: Record "Approval Entry";
    begin
        l_ApprovalEntry.Reset;
        l_ApprovalEntry.SetRange("Table ID", ApprovalEntry."Table ID");
        l_ApprovalEntry.SetRange("Document No.", ApprovalEntry."Document No.");
        l_ApprovalEntry.SetFilter(Status, '%1|%2', l_ApprovalEntry.Status::Open, l_ApprovalEntry.Status::Created);
        if not l_ApprovalEntry.FindLast then begin
            RequisitionRequestsRec.Reset();
            RequisitionRequestsRec.SetRange("Loan Adjustment ID", ApprovalEntry."Document No.");
            if RequisitionRequestsRec.FindFirst() then begin
                RequisitionRequestsRec."WorkFlow Status" := RequisitionRequestsRec."WorkFlow Status"::Released;
                RequisitionRequestsRec.Modify(true);
            end;
        end;
        WFMngt.HandleEventOnKnownWorkflowInstance(RunWorkflowOnApprove_Loan_AdjApprovalCode(), ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
    end;
    //End
    //Reject Approval reques Event************************************************************************************ End
    procedure RunWorkflowOnReject_Loan_AdjApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnReject_NEW_Loan_AdjApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnRejectApprovalRequest', '', true, true)]
    procedure RunWorkflowOnReject_Loan_AdjApproval(var ApprovalEntry: Record "Approval Entry")
    var
        LoanAdjRecRec: Record "Loan Adjustment Header";
        l_ApprovalEntry: Record "Approval Entry";
    begin
        // WFMngt.HandleEventOnKnownWorkflowInstance(RunWorkflowOnReject_Loan_AdjApprovalCode, ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
        // Sathish Reject

        l_ApprovalEntry.Reset;
        l_ApprovalEntry.SetRange("Table ID", ApprovalEntry."Table ID");
        l_ApprovalEntry.SetRange("Document No.", ApprovalEntry."Document No.");
        l_ApprovalEntry.SetFilter(Status, '%1|%2', l_ApprovalEntry.Status::Open, l_ApprovalEntry.Status::Created);
        if l_ApprovalEntry.FindFirst() then begin
            LoanAdjRecRec.Reset();
            LoanAdjRecRec.SetRange("Loan Adjustment ID", ApprovalEntry."Document No.");
            if LoanAdjRecRec.FindFirst() then begin
                LoanAdjRecRec."WorkFlow Status" := LoanAdjRecRec."WorkFlow Status"::Open;
                LoanAdjRecRec.Modify(true);
            end;
        end;
        WFMngt.HandleEventOnKnownWorkflowInstance(SetStatusToReject_LT_Code_Loan_Adj(), ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
        // Sathish Reject
    end;
    //End
    //Delegate Approval reques Event************************************************************************************ End
    procedure RunWorkflowOnDelegate_Loan_AdjApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnDelegate_Loan_AdjApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnDelegateApprovalRequest', '', true, true)]
    procedure RunWorkflowOnDelegate_Loan_AdjApproval(var ApprovalEntry: Record "Approval Entry")
    begin
        WFMngt.HandleEventOnKnownWorkflowInstance(RunWorkflowOnDelegate_Loan_AdjApprovalCode, ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
    end;
    //End
    //Events Subscribe End


    //Code for changeing approval status Pending approval in Transfer Orders
    procedure SetStatusToPendingApprovalCode_Loan_Adj(): Code[128] // Done
    begin
        exit(UpperCase('SetStatusToPendingApproval_NEW_Loan_Adj'));
    end;
    // Sathish Reject
    procedure SetStatusToReject_LT_Code_Loan_Adj(): Code[128]
    begin
        exit(UpperCase('SetStatusToReject_LT__NEW_Loan_Adj'));
    end;
    // Sathish Reject


    procedure SetStatusToPendingApproval_Loan_Adj(var Variant: Variant)
    var
        RecRef: RecordRef;
        LoanAdjRec: Record "Loan Adjustment Header";
    begin
        RecRef.GetTable(Variant);
        case RecRef.Number() of
            DATABASE::"Loan Adjustment Header":
                begin
                    RecRef.SetTable(LoanAdjRec);
                    LoanAdjRec.Validate("WorkFlow Status", LoanAdjRec."WorkFlow Status"::"Pending For Approval");
                    LoanAdjRec.Modify();
                    Variant := LoanAdjRec;
                end;
        end;
    end;

    // Sathish Reject Funcation
    procedure SetStatusToReject_LT_Loan_Adj(var Variant: Variant)
    var
        RecRef: RecordRef;
        LoanAdjRec: Record "Loan Adjustment Header";
    begin
        RecRef.GetTable(Variant);
        case RecRef.Number() of
            DATABASE::"Loan Adjustment Header":
                begin
                    Message('Reject');
                    RecRef.SetTable(LoanAdjRec);
                    LoanAdjRec.Validate("WorkFlow Status", LoanAdjRec."WorkFlow Status"::Rejected);
                    LoanAdjRec.Modify();
                    Variant := LoanAdjRec;
                end;
        end;
    end;
    // Sathish Reject Fucnaion

    //Code for approval status changes to Released in Transfer Order
    procedure Release_Loan_AdjCode(): Code[128]
    begin
        exit(UpperCase('Release_NEW_Loan_Adj'));
    end;

    procedure Release_Loan_Adj(var Variant: Variant)
    var
        RecRef: RecordRef;
        TargetRecRef: RecordRef;
        ApprovalEntry: Record "Approval Entry";
        LoanAdjRec: Record "Loan Adjustment Header";
    begin
        RecRef.GetTable(Variant);
        ///  InsertEmailNotification(Variant);

        case RecRef.Number() of
            DATABASE::"Approval Entry":
                begin
                    ApprovalEntry := Variant;
                    TargetRecRef.Get(ApprovalEntry."Record ID to Approve");
                    Variant := TargetRecRef;

                    Release_Loan_Adj(Variant);
                end;
            DATABASE::"Loan Adjustment Header":
                begin

                    RecRef.SetTable(LoanAdjRec);
                    LoanAdjRec.Validate("WorkFlow Status", LoanAdjRec."WorkFlow Status"::Released);
                    LoanAdjRec.Modify();
                    Variant := LoanAdjRec;

                end;
        end;
    end;

    //Code for approval status changes to Open When Cancel or Reopen
    procedure ReOpen_Loan_AdjCode(): Code[128]
    begin
        exit(UpperCase('ReOpen_NEW_Loan_Adj'));
    end;

    procedure ReOpen_Loan_Adj(var Variant: Variant)
    var
        RecRef: RecordRef;
        TargetRecRef: RecordRef;
        ApprovalEntry: Record "Approval Entry";
        LoanAdjRec: Record "Loan Adjustment Header";
    begin
        RecRef.GetTable(Variant);
        //  InsertEmailNotification(Variant);
        case RecRef.Number() of
            DATABASE::"Approval Entry":
                begin
                    ApprovalEntry := Variant;
                    TargetRecRef.Get(ApprovalEntry."Record ID to Approve");
                    Variant := TargetRecRef;
                    ReOpen_Loan_Adj(Variant);

                end;
            DATABASE::"Loan Adjustment Header":
                begin
                    RecRef.SetTable(LoanAdjRec);
                    LoanAdjRec.Validate("WorkFlow Status", LoanAdjRec."WorkFlow Status"::Open);
                    LoanAdjRec.Modify();
                    Variant := LoanAdjRec;
                end;
        end;
    end;

    //Code For MEssage Notification start
    procedure Loan_AdjMessageCode(): Code[128]
    begin
        exit(UpperCase('Loan_Adj_NEW_Message'));
    end;

    procedure Loan_AdjMessage(var Variant: Variant)
    var
        RecRef: RecordRef;
        TargetRecRef: RecordRef;
        ApprovalEntry: Record "Approval Entry";
        LoanAdjRec: Record "Loan Adjustment Header";
    begin
        RecRef.GetTable(Variant);
        case RecRef.Number() of
            DATABASE::"Loan Adjustment Header":
                begin
                    RecRef.SetTable(LoanAdjRec);
                    Message('The approval request for the record has been canceled.');
                    Variant := LoanAdjRec;
                end;
        end;
    end;

    procedure Loan_AdjSendMessageCode(): Code[128]
    begin
        exit(UpperCase('Loan_Adj_NEW_SendMessage'));
    end;

    procedure Loan_AdjSendMessage(var Variant: Variant)
    var
        RecRef: RecordRef;
        TargetRecRef: RecordRef;
        ApprovalEntry: Record "Approval Entry";
        LoanAdjRec: Record "Loan Adjustment Header";
    begin
        RecRef.GetTable(Variant);
        case RecRef.Number() of
            DATABASE::"Loan Adjustment Header":
                begin
                    RecRef.SetTable(LoanAdjRec);
                    Message('The approval request for the record has been sent.');
                    Variant := LoanAdjRec;
                end;
        end;
    end;
    //Code For Message Notification END

    //Inserting Transfer Order Details to Approval Entry Table
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnPopulateApprovalEntryArgument', '', true, true)]
    local procedure OnPopulateApprovalEntryArgument(var RecRef: RecordRef; var ApprovalEntryArgument: Record "Approval Entry"; WorkflowStepInstance: Record "Workflow Step Instance")
    var
        LoanAdjRec: Record "Loan Adjustment Header";
    begin
        case RecRef.Number of
            database::"Loan Adjustment Header":
                begin
                    RecRef.SetTable(LoanAdjRec);
                    ApprovalEntryArgument."Table ID" := RecRef.Number;
                    ApprovalEntryArgument."Document No." := LoanAdjRec."Loan Adjustment ID";
                    // // // LoanAdjRec.CalcFields("Total Amount ");
                    // // // ApprovalEntryArgument.Amount := LoanAdjRec."Total Amount ";
                    // // // ApprovalEntryArgument."Amount (LCY)" := LoanAdjRec."Total Amount ";
                    //ApprovalEntryArgument."Document Type" := ApprovalEntryArgument."Document Type"::Quote;
                end;
        end;

    end;

    //Adding Events to event Library
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Event Handling", 'OnAddWorkflowEventsToLibrary', '', true, true)]
    procedure OnAddWorkflowEventsToLibrary()
    begin

        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnSend_Loan_AdjApprovalCode, Database::"Loan Adjustment Header", Send_Loan_AdjReq, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnApprove_Loan_AdjApprovalCode, Database::"Approval Entry", AppReq_Loan_Adj, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnCancel_Loan_AdjApprovalCode, Database::"Loan Adjustment Header", CancelForPendAppTxt, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnReject_Loan_AdjApprovalCode, Database::"Approval Entry", RejReq_Loan_Adj, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnDelegate_Loan_AdjApprovalCode, Database::"Approval Entry", DelReq_Loan_Adj, 0, false);
        // Sathish Reject Code
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnSend_Loan_AdjRejectCode, Database::"Loan Adjustment Header", Send_Loan_AdjReject_Loan_AdjReq, 0, false);
        // Sathish Reject Code

    end;

    //Adding Newly created responses to workflowResponselibrary
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnAddWorkflowResponsesToLibrary', '', true, true)]
    procedure OnAddWorkflowResponsesToLibrary()
    begin
        WorkflowResponseHandling.AddResponseToLibrary(SetStatusToPendingApprovalCode_Loan_Adj, 0, SendForPendAppTxt, 'GROUP 0');
        WorkflowResponseHandling.AddResponseToLibrary(Release_Loan_AdjCode, 0, Release_Loan_AdjTxt, 'GROUP 0');
        WorkflowResponseHandling.AddResponseToLibrary(ReOpen_Loan_AdjCode, 0, ReOpen_Loan_AdjTxt, 'GROUP 0');
        //WorkflowResponseHandling.AddResponseToLibrary(SendEmailCodeLoan_Adj, 0, '', 'GROUP 0');
        WorkflowResponseHandling.AddResponseToLibrary(Loan_AdjMessageCode, 0, Loan_Adj_Message, 'GROUP 0');
        WorkflowResponseHandling.AddResponseToLibrary(Loan_AdjSendMessageCode, 0, Loan_AdjSend_Message, 'GROUP 0');
        // Sathish Reject Code
        WorkflowResponseHandling.AddResponseToLibrary(SetStatusToReject_LT_Code_Loan_Adj, 0, SendForRejectTxt, 'GROUP 0');
        // Sathish Reject Code 




    end;

    //06JAN20 start
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnAddWorkflowResponsePredecessorsToLibrary', '', true, true)]
    procedure OnAddWorkflowResponsePredecessorsToLibrary(ResponseFunctionName: Code[128])
    var
        WorkflowEventHandling: Codeunit InitCodeunit_Loan_Adj;
    begin
        case ResponseFunctionName of
            //WorkFlowResponseHandling.SetStatusToPendingApprovalCode:
            //  WorkFlowResponseHandling.AddResponsePredecessor(WorkFlowResponseHandling.SetStatusToPendingApproval, WorkFlowEventHandlingExtCust.RunWorkFlowOnApproveApprovalRequestForRequisitionCode);
            WorkFlowResponseHandling.SendApprovalRequestForApprovalCode:
                WorkFlowResponseHandling.AddResponsePredecessor(WorkFlowResponseHandling.SendApprovalRequestForApprovalCode, RunWorkflowOnApprove_Loan_AdjApprovalCode());
        //WorkFlowResponseHandling.CancelAllApprovalRequestsCode;
        //WorkFlowResponseHandling.AddResponsePredecessor(WorkFlowResponseHandling.CancelAllApprovalRequestsCode,WorkFlowEventHandlingExtCust.run);
        //WorkFlowResponseHandling.OpenDocumentCode;
        //WorkFlowResponseHandling.AddResponsePredecessor(WorkFlowResponseHandling.OpenDocumentCode,WorkFlowEventHandlingExtCust.op);
        end;
    end;

    //06JAN20 END


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnExecuteWorkflowResponse', '', false, false)]
    procedure ExeRespForLoan_Adj(var ResponseExecuted: Boolean; Variant: Variant; xVariant: Variant; ResponseWorkflowStepInstance: Record "Workflow Step Instance")
    var
        WorkflowResponse: Record "Workflow Response";
    begin
        IF WorkflowResponse.GET(ResponseWorkflowStepInstance."Function Name") THEN
            case WorkflowResponse."Function Name" of

                SetStatusToPendingApprovalCode_Loan_Adj():
                    begin
                        SetStatusToPendingApproval_Loan_Adj(Variant);
                        ResponseExecuted := true;
                    end;
                Release_Loan_AdjCode():
                    begin
                        Release_Loan_Adj(Variant);
                        ResponseExecuted := true;
                    end;
                ReOpen_Loan_AdjCode():
                    begin
                        ReOpen_Loan_Adj(Variant);
                        ResponseExecuted := true;
                    end;
                SendEmailCodeLoan_Adj():
                    begin
                        SendEmailRFQ(Variant);
                        ResponseExecuted := true;
                    end;
                Loan_AdjMessageCode():
                    begin
                        Loan_AdjMessage(Variant);
                        ResponseExecuted := true;
                    end;
                Loan_AdjSendMessageCode():
                    begin
                        Loan_AdjSendMessage(Variant);
                        ResponseExecuted := true;
                    end;
                // Sathish Reject Code
                SetStatusToReject_LT_Code_Loan_Adj():
                    begin
                        Message('Workflow');
                        SetStatusToReject_LT_Loan_Adj(Variant);
                        ResponseExecuted := true;
                    end;
            // Sathish Reject Code

            end;
    end;
    // Sathish

    // Sathish 

    //Approver Chain Setup
    procedure IsRFQSufficeintApprover(UserSetup: Record "User Setup"; ApprovalAmountLCY: Decimal): Boolean
    begin
        IF UserSetup."User ID" = UserSetup."Approver ID" THEN
            EXIT(TRUE);
        IF UserSetup."Unlimited Purchase Approval" OR
        ((ApprovalAmountLCY <= UserSetup."Purchase Amount Approval Limit") AND (UserSetup."Purchase Amount Approval Limit" <> 0))
        THEN
            EXIT(TRUE);
        EXIT(FALSE);
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnAfterIsSufficientApprover', '', true, true)]
    local procedure OnAfterIsSufficientApprover(UserSetup: Record "User Setup"; ApprovalEntryArgument: Record "Approval Entry"; var IsSufficient: Boolean)
    begin
        case ApprovalEntryArgument."Table ID" of
            database::"Loan Adjustment Header":
                IsSufficient := IsRFQSufficeintApprover(UserSetup, ApprovalEntryArgument."Amount (LCY)");
        end;
    end;
    //Approver ChaIN End

    // Emial Notificaion Creation 05DEC2019 Start

    procedure SendEmailCodeLoan_Adj(): Code[128]
    begin
        exit(UpperCase('SendEmail_NEW_Loan_Adj'));
    end;

    procedure SendEmailRFQ(var Variant: Variant)
    var
        RecRef: RecordRef;
        RFQHeader: Record "Loan Adjustment Header";
        SmtpMailSetup: Record "SMTP Mail Setup";
        SmtpMail: Codeunit "SMTP Mail";
        ComapnyInfo: Record "Company Information";
        // TempBlob: Record TempBlob;
        FileName: Text;
        FileManagement: Codeunit "File Management";
        DocumentUrl: Text;
        PageManagement: Codeunit "Page Management";
        ApprovalEntry: Record "Approval Entry";
        TableId: Integer;
        UserSetup: Record "User Setup";
        RfqNo: Code[80];
    begin
        RecRef.GetTable(Variant);
        case RecRef.Number() of
            DATABASE::"Loan Adjustment Header":
                begin
                    TableId := RecRef.Number;
                    RecRef.SetTable(RFQHeader);
                    ApprovalEntry.Reset();
                    ApprovalEntry.SetRange("Table ID", TableId);
                    ApprovalEntry.SetRange("Document No.", RFQHeader."Loan Adjustment ID");
                    if ApprovalEntry.FindSet then begin
                        repeat
                            if (ApprovalEntry.Status = ApprovalEntry.Status::Open) or (ApprovalEntry.Status = ApprovalEntry.Status::Created) then begin
                                UserSetup.Reset();
                                if UserSetup.Get(ApprovalEntry."Approver ID") then
                                    // UserSetup.TestField("E-Mail");
                                    //InsertEmailNotification(Variant);
                                    Variant := RFQHeader;
                            end;
                        until ApprovalEntry.Next = 0;
                    end;
                end;
        end;
    end;


    //Insert Email Notiifcation Entries Start
    procedure InsertEmailNotification(var Variant: Variant)
    var
        // InsertEmailNotficationEntries: Record "Email Notification Entries";
        // EmailNotificationRec: Record "Email Notification Entries";
        ApprovalEntry: Record "Approval Entry";
        LoanAdjRec: Record "Loan Adjustment Header";
        l_ApprovalEntry: Record "Approval Entry";
        Recref: RecordRef;
    begin
        RecRef.GetTable(Variant);
        case RecRef.Number() of
            /*   DATABASE::"Approval Entry":
                   begin
                       Recref.SetTable(ApprovalEntry);
                       InsertEmailNotficationEntries.Init;
                       EmailNotificationRec.Reset;
                       if EmailNotificationRec.findlast then;
                       InsertEmailNotficationEntries."Entry No" := EmailNotificationRec."Entry No" + 1;
                       InsertEmailNotficationEntries."Table No" := ApprovalEntry."Table ID";
                       InsertEmailNotficationEntries."Document No" := ApprovalEntry."Document No.";
                       InsertEmailNotficationEntries.status := ApprovalEntry.Status;
                       InsertEmailNotficationEntries.UserID := ApprovalEntry."Approver ID";
                       InsertEmailNotficationEntries.Insert(true);

            END; */
            Database::"Loan Adjustment Header":
                begin
                    // This is Commented By Sathish
                    // // // // Recref.SetTable(LoanAdjRec);
                    // // // // l_ApprovalEntry.Reset();
                    // // // // l_ApprovalEntry.SetRange("Table ID", Recref.Number);
                    // // // // l_ApprovalEntry.SetRange("Document No.", LoanAdjRec."Requisition No.");
                    // // // // if l_ApprovalEntry.FindLast() then begin
                    // // // //     InsertEmailNotficationEntries.Init;
                    // // // //     EmailNotificationRec.Reset;
                    // // // //     if EmailNotificationRec.findlast then;
                    // // // //     InsertEmailNotficationEntries."Entry No" := EmailNotificationRec."Entry No" + 1;
                    // // // //     InsertEmailNotficationEntries."Table No" := l_ApprovalEntry."Table ID";
                    // // // //     InsertEmailNotficationEntries."Document No" := l_ApprovalEntry."Document No.";
                    // // // //     InsertEmailNotficationEntries.status := l_ApprovalEntry.Status;
                    // // // //     InsertEmailNotficationEntries.UserID := l_ApprovalEntry."Approver ID";
                    // // // //     InsertEmailNotficationEntries.Insert(true);
                    // // // // end;
                    // This is Commented By Sathish

                end;

        end;
    end;
    // // // // // //Insert Email Notification Entries End

}