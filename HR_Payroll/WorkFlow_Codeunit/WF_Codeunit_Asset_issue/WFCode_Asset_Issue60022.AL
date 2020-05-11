codeunit 60022 WFCode_Asset_Issue
{
    trigger OnRun()
    begin

    end;

    var
        WFMngt: Codeunit "Workflow Management";
        AppMgmt: Codeunit "Approvals Mgmt.";
        WorkflowEventHandling: Codeunit "Workflow Event Handling";
        WorkflowResponseHandling: Codeunit "Workflow Response Handling";
        Send_AssetIssueReq: TextConst ENU = 'LT Approval Request for Asset Issue is requested', ENG = 'LT Approval Request for Asset Issue is requested';
        AppReq_AssetIssue: TextConst ENU = 'LT Approval Request for Asset Issue is approved', ENG = 'LT Approval Request for Asset Issue is approved';
        RejReq_AssetIssue: TextConst ENU = 'LT Approval Request for Asset Issue is rejected', ENG = 'LT Approval Request for Asset Issueis rejected';
        DelReq_AssetIssue: TextConst ENU = 'LT Approval Request for Asset Issue is delegated', ENG = 'LT Approval Request for Asset Issue is delegated';
        SendForPendAppTxt: TextConst ENU = 'LT Status of Asset Issue changed to Pending approval', ENG = 'LT Status of Asset Issue changed to Pending approval';
        CancelForPendAppTxt: TextConst ENU = 'LT Approval Rquest for Asset Issue is Canceled', ENG = 'LT Approval request for Asset Issue is Canceled';
        Release_AssetIssueTxt: TextConst ENU = 'LT ReleaseAssetIssue', ENG = 'LT ReleaseAssetIssue';
        ReOpen_AssetIssueTxt: TextConst ENU = 'LT ReOpenAssetIssue', ENG = 'LT ReOpenAssetIssue';
        AssetIssue_Message: TextConst ENU = 'LT AssetIssueMessage', ENG = 'LT AssetIssueMessage';
        AssetIssueSend_Message: TextConst ENU = 'LT AssetIssueSendMessage', ENG = 'LT AssetIssueSendMessage';
        // Avinash Reject Code
        SendForRejectTxt: TextConst ENU = 'LT Status of Asset Issue changed to Reject', ENG = 'LT Status of Asset Issue changed to Reject';
        Send_AssetIssueReject_AssetIssueReq: TextConst ENU = 'LT Approval Request for Asset Issue is Rejected', ENG = 'LT Approval Request for Asset Issue is Rejected';
    // Avinash Reject Code



    //Events Subscribe Start

    //Send For Approval Event************************************************************************************ start
    procedure RunWorkflowOnSend_AssetIssueApprovalCode(): Code[128]
    begin
        exit('RunWorkflowOnSend_NEW_AssetIssueApproval');
    end;
    // Avinash Reject
    procedure RunWorkflowOnSend_AssetIssueRejectCode(): Code[128]
    begin
        exit('RunWorkflowOnSend_NEW_AssetIssueReject');
    end;
    // Avinash Reject

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"InitCodeunit_Asset_Issue", 'OnSendAssetIssue_Approval', '', true, true)]
    procedure RunWorkflowOnSend_AssetIssueApproval(var AssetAssignmentRegister: Record "Asset Assignment Register")
    begin
        WFMngt.HandleEvent(RunWorkflowOnSend_AssetIssueApprovalCode, AssetAssignmentRegister);
    end;
    // End

    //Cancel For Approval Event************************************************************************************ End
    procedure RunWorkflowOnCancel_AssetIssueApprovalCode(): Code[128]
    begin
        exit('RunWorkflowOnCancel_NEW_AssetIssueApproval');
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"InitCodeunit_Asset_Issue", 'OnCancelAssetIssue_Approval', '', true, true)]
    procedure RunWorkflowOnCancel_AssetIssueApproval(var AssetAssignmentRegister: Record "Asset Assignment Register")
    begin
        WFMngt.HandleEvent(RunWorkflowOnCancel_AssetIssueApprovalCode, AssetAssignmentRegister);
    end;
    //End

    //Approve Approval reques Event************************************************************************************ End
    procedure RunWorkflowOnApprove_AssetIssueApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnApprove_NEW_AssetIssueApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnApproveApprovalRequest', '', true, true)]
    procedure RunWorkflowOnApprove_AssetIssueApproval(var ApprovalEntry: Record "Approval Entry")
    var
        RequisitionRequestsRec: Record "Asset Assignment Register";
        l_ApprovalEntry: Record "Approval Entry";
    begin
        l_ApprovalEntry.Reset;
        l_ApprovalEntry.SetRange("Table ID", ApprovalEntry."Table ID");
        l_ApprovalEntry.SetRange("Document No.", ApprovalEntry."Document No.");
        l_ApprovalEntry.SetFilter(Status, '%1|%2', l_ApprovalEntry.Status::Open, l_ApprovalEntry.Status::Created);
        if not l_ApprovalEntry.FindLast then begin
            RequisitionRequestsRec.Reset();
            RequisitionRequestsRec.SetRange("Issue Document No.", ApprovalEntry."Document No.");
            if RequisitionRequestsRec.FindFirst() then begin
                RequisitionRequestsRec."WorkFlow Status" := RequisitionRequestsRec."WorkFlow Status"::Released;
                RequisitionRequestsRec.Modify(true);
            end;
        end;
        WFMngt.HandleEventOnKnownWorkflowInstance(RunWorkflowOnApprove_AssetIssueApprovalCode(), ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
    end;
    //End
    //Reject Approval reques Event************************************************************************************ End
    procedure RunWorkflowOnReject_AssetIssueApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnReject_NEW_AssetIssueApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnRejectApprovalRequest', '', true, true)]
    procedure RunWorkflowOnReject_AssetIssueApproval(var ApprovalEntry: Record "Approval Entry")
    var
        AssetAssignmentRegisterRec: Record "Asset Assignment Register";
        l_ApprovalEntry: Record "Approval Entry";
    begin
        // WFMngt.HandleEventOnKnownWorkflowInstance(RunWorkflowOnReject_AssetIssueApprovalCode, ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
        // Avinash Reject

        l_ApprovalEntry.Reset;
        l_ApprovalEntry.SetRange("Table ID", ApprovalEntry."Table ID");
        l_ApprovalEntry.SetRange("Document No.", ApprovalEntry."Document No.");
        l_ApprovalEntry.SetFilter(Status, '%1|%2', l_ApprovalEntry.Status::Open, l_ApprovalEntry.Status::Created);
        if l_ApprovalEntry.FindFirst() then begin
            AssetAssignmentRegisterRec.Reset();
            AssetAssignmentRegisterRec.SetRange(RecID, ApprovalEntry."Record ID to Approve");
            if AssetAssignmentRegisterRec.FindFirst() then begin
                AssetAssignmentRegisterRec."WorkFlow Status" := AssetAssignmentRegisterRec."WorkFlow Status"::Rejected;
                AssetAssignmentRegisterRec.Modify(true);
            end;
        end;
        WFMngt.HandleEventOnKnownWorkflowInstance(SetStatusToReject_LT_Code_AssetIssue(), ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
        // Avinash Reject
    end;
    //End
    //Delegate Approval reques Event************************************************************************************ End
    procedure RunWorkflowOnDelegate_AssetIssueApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnDelegate_AssetIssueApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnDelegateApprovalRequest', '', true, true)]
    procedure RunWorkflowOnDelegate_AssetIssueApproval(var ApprovalEntry: Record "Approval Entry")
    begin
        WFMngt.HandleEventOnKnownWorkflowInstance(RunWorkflowOnDelegate_AssetIssueApprovalCode, ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
    end;
    //End
    //Events Subscribe End


    //Code for changeing approval status Pending approval in Transfer Orders
    procedure SetStatusToPendingApprovalCode_AssetIssue(): Code[128] // Done
    begin
        exit(UpperCase('SetStatusToPendingApproval_NEW_AssetIssue'));
    end;
    // Avinash Reject
    procedure SetStatusToReject_LT_Code_AssetIssue(): Code[128]
    begin
        exit(UpperCase('SetStatusToReject_LT__NEW_AssetIssue'));
    end;
    // Avinash Reject


    procedure SetStatusToPendingApproval_AssetIssue(var Variant: Variant)
    var
        RecRef: RecordRef;
        AssetAssignmentRegister: Record "Asset Assignment Register";
    begin
        RecRef.GetTable(Variant);
        case RecRef.Number() of
            DATABASE::"Asset Assignment Register":
                begin
                    RecRef.SetTable(AssetAssignmentRegister);
                    AssetAssignmentRegister.Validate("WorkFlow Status", AssetAssignmentRegister."WorkFlow Status"::"Pending For Approval");
                    AssetAssignmentRegister.Modify();
                    Variant := AssetAssignmentRegister;
                end;
        end;
    end;

    // Avinash Reject Funcation
    procedure SetStatusToReject_LT_AssetIssue(var Variant: Variant)
    var
        RecRef: RecordRef;
        AssetAssignmentRegister: Record "Asset Assignment Register";
    begin
        RecRef.GetTable(Variant);
        case RecRef.Number() of
            DATABASE::"Asset Assignment Register":
                begin
                    Message('Reject');
                    RecRef.SetTable(AssetAssignmentRegister);
                    AssetAssignmentRegister.Validate("WorkFlow Status", AssetAssignmentRegister."WorkFlow Status"::Rejected);
                    AssetAssignmentRegister.Modify();
                    Variant := AssetAssignmentRegister;
                end;
        end;
    end;
    // Avinash Reject Fucnaion

    //Code for approval status changes to Released in Transfer Order
    procedure Release_AssetIssueCode(): Code[128]
    begin
        exit(UpperCase('Release_NEW_AssetIssue'));
    end;

    procedure Release_AssetIssue(var Variant: Variant)
    var
        RecRef: RecordRef;
        TargetRecRef: RecordRef;
        ApprovalEntry: Record "Approval Entry";
        AssetAssignmentRegister: Record "Asset Assignment Register";
    begin
        RecRef.GetTable(Variant);
        ///  InsertEmailNotification(Variant);

        case RecRef.Number() of
            DATABASE::"Approval Entry":
                begin
                    ApprovalEntry := Variant;
                    TargetRecRef.Get(ApprovalEntry."Record ID to Approve");
                    Variant := TargetRecRef;

                    Release_AssetIssue(Variant);
                end;
            DATABASE::"Asset Assignment Register":
                begin

                    RecRef.SetTable(AssetAssignmentRegister);
                    AssetAssignmentRegister.Validate("WorkFlow Status", AssetAssignmentRegister."WorkFlow Status"::Released);
                    AssetAssignmentRegister.Modify();
                    Variant := AssetAssignmentRegister;

                end;
        end;
    end;

    //Code for approval status changes to Open When Cancel or Reopen
    procedure ReOpen_AssetIssueCode(): Code[128]
    begin
        exit(UpperCase('ReOpen_NEW_AssetIssue'));
    end;

    procedure ReOpen_AssetIssue(var Variant: Variant)
    var
        RecRef: RecordRef;
        TargetRecRef: RecordRef;
        ApprovalEntry: Record "Approval Entry";
        AssetAssignmentRegister: Record "Asset Assignment Register";
    begin
        RecRef.GetTable(Variant);
        //  InsertEmailNotification(Variant);
        case RecRef.Number() of
            DATABASE::"Approval Entry":
                begin
                    ApprovalEntry := Variant;
                    TargetRecRef.Get(ApprovalEntry."Record ID to Approve");
                    Variant := TargetRecRef;
                    ReOpen_AssetIssue(Variant);

                end;
            DATABASE::"Asset Assignment Register":
                begin
                    RecRef.SetTable(AssetAssignmentRegister);
                    AssetAssignmentRegister.Validate("WorkFlow Status", AssetAssignmentRegister."WorkFlow Status"::Open);
                    AssetAssignmentRegister.Modify();
                    Variant := AssetAssignmentRegister;
                end;
        end;
    end;

    //Code For MEssage Notification start
    procedure AssetIssueMessageCode(): Code[128]
    begin
        exit(UpperCase('AssetIssue_NEW_Message'));
    end;

    procedure AssetIssueMessage(var Variant: Variant)
    var
        RecRef: RecordRef;
        TargetRecRef: RecordRef;
        ApprovalEntry: Record "Approval Entry";
        AssetAssignmentRegister: Record "Asset Assignment Register";
    begin
        RecRef.GetTable(Variant);
        case RecRef.Number() of
            DATABASE::"Asset Assignment Register":
                begin
                    RecRef.SetTable(AssetAssignmentRegister);
                    Message('The approval request for the record has been canceled.');
                    Variant := AssetAssignmentRegister;
                end;
        end;
    end;

    procedure AssetIssueSendMessageCode(): Code[128]
    begin
        exit(UpperCase('AssetIssue_NEW_SendMessage'));
    end;

    procedure AssetIssueSendMessage(var Variant: Variant)
    var
        RecRef: RecordRef;
        TargetRecRef: RecordRef;
        ApprovalEntry: Record "Approval Entry";
        AssetAssignmentRegister: Record "Asset Assignment Register";
    begin
        RecRef.GetTable(Variant);
        case RecRef.Number() of
            DATABASE::"Asset Assignment Register":
                begin
                    RecRef.SetTable(AssetAssignmentRegister);
                    Message('The approval request for the record has been sent.');
                    Variant := AssetAssignmentRegister;
                end;
        end;
    end;
    //Code For Message Notification END

    //Inserting Transfer Order Details to Approval Entry Table
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnPopulateApprovalEntryArgument', '', true, true)]
    local procedure OnPopulateApprovalEntryArgument(var RecRef: RecordRef; var ApprovalEntryArgument: Record "Approval Entry"; WorkflowStepInstance: Record "Workflow Step Instance")
    var
        AssetAssignmentRegister: Record "Asset Assignment Register";
    begin
        case RecRef.Number of
            database::"Asset Assignment Register":
                begin
                    RecRef.SetTable(AssetAssignmentRegister);
                    ApprovalEntryArgument."Table ID" := RecRef.Number;
                    ApprovalEntryArgument."Document No." := AssetAssignmentRegister."Issue Document No.";
                    // // // AssetAssignmentRegister.CalcFields("Total Amount ");
                    // // // ApprovalEntryArgument.Amount := AssetAssignmentRegister."Total Amount ";
                    // // // ApprovalEntryArgument."Amount (LCY)" := AssetAssignmentRegister."Total Amount ";
                    //ApprovalEntryArgument."Document Type" := ApprovalEntryArgument."Document Type"::Quote;
                end;
        end;

    end;

    //Adding Events to event Library
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Event Handling", 'OnAddWorkflowEventsToLibrary', '', true, true)]
    procedure OnAddWorkflowEventsToLibrary()
    begin

        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnSend_AssetIssueApprovalCode, Database::"Asset Assignment Register", Send_AssetIssueReq, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnApprove_AssetIssueApprovalCode, Database::"Approval Entry", AppReq_AssetIssue, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnCancel_AssetIssueApprovalCode, Database::"Asset Assignment Register", CancelForPendAppTxt, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnReject_AssetIssueApprovalCode, Database::"Approval Entry", RejReq_AssetIssue, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnDelegate_AssetIssueApprovalCode, Database::"Approval Entry", DelReq_AssetIssue, 0, false);
        // Avinash Reject Code
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnSend_AssetIssueRejectCode, Database::"Asset Assignment Register", Send_AssetIssueReject_AssetIssueReq, 0, false);
        // Avinash Reject Code

    end;

    //Adding Newly created responses to workflowResponselibrary
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnAddWorkflowResponsesToLibrary', '', true, true)]
    procedure OnAddWorkflowResponsesToLibrary()
    begin
        WorkflowResponseHandling.AddResponseToLibrary(SetStatusToPendingApprovalCode_AssetIssue, 0, SendForPendAppTxt, 'GROUP 0');
        WorkflowResponseHandling.AddResponseToLibrary(Release_AssetIssueCode, 0, Release_AssetIssueTxt, 'GROUP 0');
        WorkflowResponseHandling.AddResponseToLibrary(ReOpen_AssetIssueCode, 0, ReOpen_AssetIssueTxt, 'GROUP 0');
        //WorkflowResponseHandling.AddResponseToLibrary(SendEmailCodeAssetIssue, 0, '', 'GROUP 0');
        WorkflowResponseHandling.AddResponseToLibrary(AssetIssueMessageCode, 0, AssetIssue_Message, 'GROUP 0');
        WorkflowResponseHandling.AddResponseToLibrary(AssetIssueSendMessageCode, 0, AssetIssueSend_Message, 'GROUP 0');
        // Avinash Reject Code
        WorkflowResponseHandling.AddResponseToLibrary(SetStatusToReject_LT_Code_AssetIssue, 0, SendForRejectTxt, 'GROUP 0');
        // Avinash Reject Code 




    end;

    //06JAN20 start
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnAddWorkflowResponsePredecessorsToLibrary', '', true, true)]
    procedure OnAddWorkflowResponsePredecessorsToLibrary(ResponseFunctionName: Code[128])
    var
        WorkflowEventHandling: Codeunit "InitCodeunit_Asset_Issue";
    begin
        case ResponseFunctionName of
            //WorkFlowResponseHandling.SetStatusToPendingApprovalCode:
            //  WorkFlowResponseHandling.AddResponsePredecessor(WorkFlowResponseHandling.SetStatusToPendingApproval, WorkFlowEventHandlingExtCust.RunWorkFlowOnApproveApprovalRequestForRequisitionCode);
            WorkFlowResponseHandling.SendApprovalRequestForApprovalCode:
                WorkFlowResponseHandling.AddResponsePredecessor(WorkFlowResponseHandling.SendApprovalRequestForApprovalCode, RunWorkflowOnApprove_AssetIssueApprovalCode());
        //WorkFlowResponseHandling.CancelAllApprovalRequestsCode;
        //WorkFlowResponseHandling.AddResponsePredecessor(WorkFlowResponseHandling.CancelAllApprovalRequestsCode,WorkFlowEventHandlingExtCust.run);
        //WorkFlowResponseHandling.OpenDocumentCode;
        //WorkFlowResponseHandling.AddResponsePredecessor(WorkFlowResponseHandling.OpenDocumentCode,WorkFlowEventHandlingExtCust.op);
        end;
    end;

    //06JAN20 END


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnExecuteWorkflowResponse', '', false, false)]
    procedure ExeRespForAssetIssue(var ResponseExecuted: Boolean; Variant: Variant; xVariant: Variant; ResponseWorkflowStepInstance: Record "Workflow Step Instance")
    var
        WorkflowResponse: Record "Workflow Response";
    begin
        IF WorkflowResponse.GET(ResponseWorkflowStepInstance."Function Name") THEN
            case WorkflowResponse."Function Name" of

                SetStatusToPendingApprovalCode_AssetIssue():
                    begin
                        SetStatusToPendingApproval_AssetIssue(Variant);
                        ResponseExecuted := true;
                    end;
                Release_AssetIssueCode():
                    begin
                        Release_AssetIssue(Variant);
                        ResponseExecuted := true;
                    end;
                ReOpen_AssetIssueCode():
                    begin
                        ReOpen_AssetIssue(Variant);
                        ResponseExecuted := true;
                    end;
                SendEmailCodeAssetIssue():
                    begin
                        SendEmailRFQ(Variant);
                        ResponseExecuted := true;
                    end;
                AssetIssueMessageCode():
                    begin
                        AssetIssueMessage(Variant);
                        ResponseExecuted := true;
                    end;
                AssetIssueSendMessageCode():
                    begin
                        AssetIssueSendMessage(Variant);
                        ResponseExecuted := true;
                    end;
                // Avinash Reject Code
                SetStatusToReject_LT_Code_AssetIssue():
                    begin
                        Message('Workflow');
                        SetStatusToReject_LT_AssetIssue(Variant);
                        ResponseExecuted := true;
                    end;
            // Avinash Reject Code

            end;
    end;
    // Avinash

    // Avinash 

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
            database::"Asset Assignment Register":
                IsSufficient := IsRFQSufficeintApprover(UserSetup, ApprovalEntryArgument."Amount (LCY)");
        end;
    end;
    //Approver ChaIN End

    // Emial Notificaion Creation 05DEC2019 Start

    procedure SendEmailCodeAssetIssue(): Code[128]
    begin
        exit(UpperCase('SendEmail_NEW_AssetIssue'));
    end;

    procedure SendEmailRFQ(var Variant: Variant)
    var
        RecRef: RecordRef;
        RFQHeader: Record "Asset Assignment Register";
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
            DATABASE::"Asset Assignment Register":
                begin
                    TableId := RecRef.Number;
                    RecRef.SetTable(RFQHeader);
                    ApprovalEntry.Reset();
                    ApprovalEntry.SetRange("Table ID", TableId);
                    ApprovalEntry.SetRange("Document No.", RFQHeader."Issue Document No.");
                    if ApprovalEntry.FindSet then begin
                        repeat
                            if (ApprovalEntry.Status = ApprovalEntry.Status::Open) or (ApprovalEntry.Status = ApprovalEntry.Status::Created) then begin
                                UserSetup.Reset();
                                if UserSetup.Get(ApprovalEntry."Approver ID") then
                                    UserSetup.TestField("E-Mail");
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
        AssetAssignmentRegister: Record "Asset Assignment Register";
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
            Database::"Asset Assignment Register":
                begin
                    // This is Commented By Avinash
                    // // // // Recref.SetTable(AssetAssignmentRegister);
                    // // // // l_ApprovalEntry.Reset();
                    // // // // l_ApprovalEntry.SetRange("Table ID", Recref.Number);
                    // // // // l_ApprovalEntry.SetRange("Document No.", AssetAssignmentRegister."Requisition No.");
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
                    // This is Commented By Avinash

                end;

        end;
    end;
    // // // // // //Insert Email Notification Entries End

}