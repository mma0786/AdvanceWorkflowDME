codeunit 60024 WFCode_Asset_Return
{
    trigger OnRun()
    begin

    end;

    var
        WFMngt: Codeunit "Workflow Management";
        AppMgmt: Codeunit "Approvals Mgmt.";
        WorkflowEventHandling: Codeunit "Workflow Event Handling";
        WorkflowResponseHandling: Codeunit "Workflow Response Handling";
        Send_AssetReturnReq: TextConst ENU = 'LT Approval Request for Asset Return is requested', ENG = 'LT Approval Request for Asset Return is requested';
        AppReq_AssetReturn: TextConst ENU = 'LT Approval Request for Asset Return is approved', ENG = 'LT Approval Request for Asset Return is approved';
        //RejReq_AssetReturn: TextConst ENU = 'LT Approval Request for Asset Return is rejected', ENG = 'LT Approval Request for Asset Returnis rejected';
        DelReq_AssetReturn: TextConst ENU = 'LT Approval Request for Asset Return is delegated', ENG = 'LT Approval Request for Asset Return is delegated';
        SendForPendAppTxt: TextConst ENU = 'LT Status of Asset Return changed to Pending approval', ENG = 'LT Status of Asset Return changed to Pending approval';
        CancelForPendAppTxt: TextConst ENU = 'LT Approval Rquest for Asset Return is Canceled', ENG = 'LT Approval request for Asset Return is Canceled';
        Release_AssetReturnTxt: TextConst ENU = 'LT ReleaseAssetReturn', ENG = 'LT ReleaseAssetReturn';
        ReOpen_AssetReturnTxt: TextConst ENU = 'LT ReOpenAssetReturn', ENG = 'LT ReOpenAssetReturn';
        AssetReturn_Message: TextConst ENU = 'LT AssetReturnMessage', ENG = 'LT AssetReturnMessage';
        AssetReturnSend_Message: TextConst ENU = 'LT AssetReturnSendMessage', ENG = 'LT AssetReturnSendMessage';
        // Sathish Reject Code
        SendForRejectTxt: TextConst ENU = 'LT Status of Asset Return changed to Reject', ENG = 'LT Status of Asset Return changed to Reject';
        Send_AssetReturnReject_AssetReturnReq: TextConst ENU = 'LT Approval Request for Asset Return is Rejected', ENG = 'LT Approval Request for Asset Return is Rejected';
    // Sathish Reject Code



    //Events Subscribe Start

    //Send For Approval Event************************************************************************************ start
    procedure RunWorkflowOnSend_AssetReturnApprovalCode(): Code[128]
    begin
        exit('RunWorkflowOnSend_NEW_AssetReturnApproval');
    end;
    // Sathish Reject
    procedure RunWorkflowOnSend_AssetReturnRejectCode(): Code[128]
    begin
        exit('RunWorkflowOnSend_NEW_AssetReturnReject');
    end;
    // Sathish Reject

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"InitCodeunit_Asset_Return", 'OnSendAssetReturn_Approval', '', true, true)]
    procedure RunWorkflowOnSend_AssetReturnApproval(var AssetAssignmentRegister: Record "Asset Assignment Register")
    begin
        WFMngt.HandleEvent(RunWorkflowOnSend_AssetReturnApprovalCode, AssetAssignmentRegister);
    end;
    // End

    //Cancel For Approval Event************************************************************************************ End
    procedure RunWorkflowOnCancel_AssetReturnApprovalCode(): Code[128]
    begin
        exit('RunWorkflowOnCancel_NEW_AssetReturnApproval');
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"InitCodeunit_Asset_Return", 'OnCancelAssetReturn_Approval', '', true, true)]
    procedure RunWorkflowOnCancel_AssetReturnApproval(var AssetAssignmentRegister: Record "Asset Assignment Register")
    begin
        WFMngt.HandleEvent(RunWorkflowOnCancel_AssetReturnApprovalCode, AssetAssignmentRegister);
    end;
    //End

    //Approve Approval reques Event************************************************************************************ End
    procedure RunWorkflowOnApprove_AssetReturnApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnApprove_NEW_AssetReturnApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnApproveApprovalRequest', '', true, true)]
    procedure RunWorkflowOnApprove_AssetReturnApproval(var ApprovalEntry: Record "Approval Entry")
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
            RequisitionRequestsRec.SetRange("Return Document No.", ApprovalEntry."Document No.");
            if RequisitionRequestsRec.FindFirst() then begin
                RequisitionRequestsRec."WorkFlow Status" := RequisitionRequestsRec."WorkFlow Status"::Released;
                RequisitionRequestsRec.Modify(true);
            end;
        end;
        WFMngt.HandleEventOnKnownWorkflowInstance(RunWorkflowOnApprove_AssetReturnApprovalCode(), ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
    end;
    //End
    //Reject Approval reques Event************************************************************************************ End
    procedure RunWorkflowOnReject_AssetReturnApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnReject_NEW_AssetReturnApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnRejectApprovalRequest', '', true, true)]
    procedure RunWorkflowOnReject_AssetReturnApproval(var ApprovalEntry: Record "Approval Entry")
    var
        AssetAssignmentRegisterRec: Record "Asset Assignment Register";
        l_ApprovalEntry: Record "Approval Entry";
    begin
        // WFMngt.HandleEventOnKnownWorkflowInstance(RunWorkflowOnReject_AssetReturnApprovalCode, ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
        // Sathish Reject

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
        WFMngt.HandleEventOnKnownWorkflowInstance(SetStatusToReject_LT_Code_AssetReturn(), ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
        // Sathish Reject
    end;
    //End
    //Delegate Approval reques Event************************************************************************************ End
    procedure RunWorkflowOnDelegate_AssetReturnApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnDelegate_AssetReturnApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnDelegateApprovalRequest', '', true, true)]
    procedure RunWorkflowOnDelegate_AssetReturnApproval(var ApprovalEntry: Record "Approval Entry")
    begin
        WFMngt.HandleEventOnKnownWorkflowInstance(RunWorkflowOnDelegate_AssetReturnApprovalCode, ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
    end;
    //End
    //Events Subscribe End


    //Code for changeing approval status Pending approval in Transfer Orders
    procedure SetStatusToPendingApprovalCode_AssetReturn(): Code[128] // Done
    begin
        exit(UpperCase('SetStatusToPendingApproval_NEW_AssetReturn'));
    end;
    // Sathish Reject
    procedure SetStatusToReject_LT_Code_AssetReturn(): Code[128]
    begin
        exit(UpperCase('SetStatusToReject_LT__NEW_AssetReturn'));
    end;
    // Sathish Reject


    procedure SetStatusToPendingApproval_AssetReturn(var Variant: Variant)
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

    // Sathish Reject Funcation
    procedure SetStatusToReject_LT_AssetReturn(var Variant: Variant)
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
    // Sathish Reject Fucnaion

    //Code for approval status changes to Released in Transfer Order
    procedure Release_AssetReturnCode(): Code[128]
    begin
        exit(UpperCase('Release_NEW_AssetReturn'));
    end;

    procedure Release_AssetReturn(var Variant: Variant)
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

                    Release_AssetReturn(Variant);
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
    procedure ReOpen_AssetReturnCode(): Code[128]
    begin
        exit(UpperCase('ReOpen_NEW_AssetReturn'));
    end;

    procedure ReOpen_AssetReturn(var Variant: Variant)
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
                    ReOpen_AssetReturn(Variant);

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
    procedure AssetReturnMessageCode(): Code[128]
    begin
        exit(UpperCase('AssetReturn_NEW_Message'));
    end;

    procedure AssetReturnMessage(var Variant: Variant)
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

    procedure AssetReturnSendMessageCode(): Code[128]
    begin
        exit(UpperCase('AssetReturn_NEW_SendMessage'));
    end;

    procedure AssetReturnSendMessage(var Variant: Variant)
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
                    ApprovalEntryArgument."Document No." := AssetAssignmentRegister."Return Document No.";
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

        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnSend_AssetReturnApprovalCode, Database::"Asset Assignment Register", Send_AssetReturnReq, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnApprove_AssetReturnApprovalCode, Database::"Approval Entry", AppReq_AssetReturn, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnCancel_AssetReturnApprovalCode, Database::"Asset Assignment Register", CancelForPendAppTxt, 0, false);
        //WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnReject_AssetReturnApprovalCode, Database::"Approval Entry", RejReq_AssetReturn, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnDelegate_AssetReturnApprovalCode, Database::"Approval Entry", DelReq_AssetReturn, 0, false);
        // Sathish Reject Code
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnSend_AssetReturnRejectCode, Database::"Asset Assignment Register", Send_AssetReturnReject_AssetReturnReq, 0, false);
        // Sathish Reject Code

    end;

    //Adding Newly created responses to workflowResponselibrary
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnAddWorkflowResponsesToLibrary', '', true, true)]
    procedure OnAddWorkflowResponsesToLibrary()
    begin
        WorkflowResponseHandling.AddResponseToLibrary(SetStatusToPendingApprovalCode_AssetReturn, 0, SendForPendAppTxt, 'GROUP 0');
        WorkflowResponseHandling.AddResponseToLibrary(Release_AssetReturnCode, 0, Release_AssetReturnTxt, 'GROUP 0');
        WorkflowResponseHandling.AddResponseToLibrary(ReOpen_AssetReturnCode, 0, ReOpen_AssetReturnTxt, 'GROUP 0');
        //WorkflowResponseHandling.AddResponseToLibrary(SendEmailCodeAssetReturn, 0, '', 'GROUP 0');
        WorkflowResponseHandling.AddResponseToLibrary(AssetReturnMessageCode, 0, AssetReturn_Message, 'GROUP 0');
        WorkflowResponseHandling.AddResponseToLibrary(AssetReturnSendMessageCode, 0, AssetReturnSend_Message, 'GROUP 0');
        // Sathish Reject Code
        WorkflowResponseHandling.AddResponseToLibrary(SetStatusToReject_LT_Code_AssetReturn, 0, SendForRejectTxt, 'GROUP 0');
        // Sathish Reject Code 




    end;

    //06JAN20 start
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnAddWorkflowResponsePredecessorsToLibrary', '', true, true)]
    procedure OnAddWorkflowResponsePredecessorsToLibrary(ResponseFunctionName: Code[128])
    var
        WorkflowEventHandling: Codeunit "InitCodeunit_Asset_Return";
    begin
        case ResponseFunctionName of
            //WorkFlowResponseHandling.SetStatusToPendingApprovalCode:
            //  WorkFlowResponseHandling.AddResponsePredecessor(WorkFlowResponseHandling.SetStatusToPendingApproval, WorkFlowEventHandlingExtCust.RunWorkFlowOnApproveApprovalRequestForRequisitionCode);
            WorkFlowResponseHandling.SendApprovalRequestForApprovalCode:
                WorkFlowResponseHandling.AddResponsePredecessor(WorkFlowResponseHandling.SendApprovalRequestForApprovalCode, RunWorkflowOnApprove_AssetReturnApprovalCode());
        //WorkFlowResponseHandling.CancelAllApprovalRequestsCode;
        //WorkFlowResponseHandling.AddResponsePredecessor(WorkFlowResponseHandling.CancelAllApprovalRequestsCode,WorkFlowEventHandlingExtCust.run);
        //WorkFlowResponseHandling.OpenDocumentCode;
        //WorkFlowResponseHandling.AddResponsePredecessor(WorkFlowResponseHandling.OpenDocumentCode,WorkFlowEventHandlingExtCust.op);
        end;
    end;

    //06JAN20 END


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnExecuteWorkflowResponse', '', false, false)]
    procedure ExeRespForAssetReturn(var ResponseExecuted: Boolean; Variant: Variant; xVariant: Variant; ResponseWorkflowStepInstance: Record "Workflow Step Instance")
    var
        WorkflowResponse: Record "Workflow Response";
    begin
        IF WorkflowResponse.GET(ResponseWorkflowStepInstance."Function Name") THEN
            case WorkflowResponse."Function Name" of

                SetStatusToPendingApprovalCode_AssetReturn():
                    begin
                        SetStatusToPendingApproval_AssetReturn(Variant);
                        ResponseExecuted := true;
                    end;
                Release_AssetReturnCode():
                    begin
                        Release_AssetReturn(Variant);
                        ResponseExecuted := true;
                    end;
                ReOpen_AssetReturnCode():
                    begin
                        ReOpen_AssetReturn(Variant);
                        ResponseExecuted := true;
                    end;
                SendEmailCodeAssetReturn():
                    begin
                        SendEmailRFQ(Variant);
                        ResponseExecuted := true;
                    end;
                AssetReturnMessageCode():
                    begin
                        AssetReturnMessage(Variant);
                        ResponseExecuted := true;
                    end;
                AssetReturnSendMessageCode():
                    begin
                        AssetReturnSendMessage(Variant);
                        ResponseExecuted := true;
                    end;
                // Sathish Reject Code
                SetStatusToReject_LT_Code_AssetReturn():
                    begin
                        Message('Workflow');
                        SetStatusToReject_LT_AssetReturn(Variant);
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
            database::"Asset Assignment Register":
                IsSufficient := IsRFQSufficeintApprover(UserSetup, ApprovalEntryArgument."Amount (LCY)");
        end;
    end;
    //Approver ChaIN End

    // Emial Notificaion Creation 05DEC2019 Start

    procedure SendEmailCodeAssetReturn(): Code[128]
    begin
        exit(UpperCase('SendEmail_NEW_AssetReturn'));
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
                    ApprovalEntry.SetRange("Document No.", RFQHeader."Return Document No.");
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
                    // This is Commented By Sathish
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
                    // This is Commented By Sathish

                end;

        end;
    end;
    // // // // // //Insert Email Notification Entries End

}