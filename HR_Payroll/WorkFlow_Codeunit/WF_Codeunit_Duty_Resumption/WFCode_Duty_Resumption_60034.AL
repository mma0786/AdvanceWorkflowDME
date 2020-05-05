codeunit 60034 WFCode_Duty_Resumption
{
    trigger OnRun()
    begin

    end;

    var
        WFMngt: Codeunit "Workflow Management";
        AppMgmt: Codeunit "Approvals Mgmt.";
        WorkflowEventHandling: Codeunit "Workflow Event Handling";
        WorkflowResponseHandling: Codeunit "Workflow Response Handling";
        Send_Duty_ResumptionReq: TextConst ENU = 'LT Approval Request for Duty Resumption is requested', ENG = 'LT Approval Request for Duty Resumption is requested';
        AppReq_Duty_Resumption: TextConst ENU = 'LT Approval Request for Duty Resumption is approved', ENG = 'LT Approval Request for Duty Resumption is approved';
        //RejReq_Duty_Resumption: TextConst ENU = 'LT Approval Request for Duty Resumption is rejected', ENG = 'LT Approval Request for Duty Resumptionis rejected';
        DelReq_Duty_Resumption: TextConst ENU = 'LT Approval Request for Duty Resumption is delegated', ENG = 'LT Approval Request for Duty Resumption is delegated';
        SendForPendAppTxt: TextConst ENU = 'LT Status of Duty Resumption changed to Pending approval', ENG = 'LT Status of Duty Resumption changed to Pending approval';
        CancelForPendAppTxt: TextConst ENU = 'LT Approval Rquest for Duty Resumption is Canceled', ENG = 'LT Approval request for Duty Resumption is Canceled';
        Release_Duty_ResumptionTxt: TextConst ENU = 'LT ReleaseDuty_Resumption', ENG = 'LT ReleaseDuty_Resumption';
        ReOpen_Duty_ResumptionTxt: TextConst ENU = 'LT ReOpenDuty_Resumption', ENG = 'LT ReOpenDuty_Resumption';
        Duty_Resumption_Message: TextConst ENU = 'LT Duty_ResumptionMessage', ENG = 'LT Duty_ResumptionMessage';
        Duty_ResumptionSend_Message: TextConst ENU = 'LT Duty_ResumptionSendMessage', ENG = 'LT Duty_ResumptionSendMessage';
        //  Reject Code
        SendForRejectTxt: TextConst ENU = 'LT Status of Duty Resumption changed to Reject', ENG = 'LT Status of Duty Resumption changed to Reject';
        Send_Duty_ResumptionReject_Duty_ResumptionReq: TextConst ENU = 'LT Approval Request for Duty Resumption is Rejected', ENG = 'LT Approval Request for Duty Resumption is Rejected';
    //  Reject Code



    //Events Subscribe Start

    //Send For Approval Event************************************************************************************ start
    procedure RunWorkflowOnSend_Duty_ResumptionApprovalCode(): Code[128]
    begin
        exit('RunWorkflowOnSend_NEW_Duty_ResumptionApproval');
    end;
    //  Reject
    procedure RunWorkflowOnSend_Duty_ResumptionRejectCode(): Code[128]
    begin
        exit('RunWorkflowOnSend_NEW_Duty_ResumptionReject');
    end;
    //  Reject

    [EventSubscriber(ObjectType::Codeunit, Codeunit::InitCodeunit_Duty_Resumption, 'OnSendDuty_Resumption_Approval', '', true, true)]
    procedure RunWorkflowOnSend_Duty_ResumptionApproval(var DutyResRec: Record "Duty Resumption")
    begin
        WFMngt.HandleEvent(RunWorkflowOnSend_Duty_ResumptionApprovalCode, DutyResRec);
    end;
    // End

    //Cancel For Approval Event************************************************************************************ End
    procedure RunWorkflowOnCancel_Duty_ResumptionApprovalCode(): Code[128]
    begin
        exit('RunWorkflowOnCancel_NEW_Duty_ResumptionApproval');
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::InitCodeunit_Duty_Resumption, 'OnCancelDuty_Resumption_Approval', '', true, true)]
    procedure RunWorkflowOnCancel_Duty_ResumptionApproval(var DutyResRec: Record "Duty Resumption")
    begin
        WFMngt.HandleEvent(RunWorkflowOnCancel_Duty_ResumptionApprovalCode, DutyResRec);
    end;
    //End

    //Approve Approval reques Event************************************************************************************ End
    procedure RunWorkflowOnApprove_Duty_ResumptionApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnApprove_NEW_Duty_ResumptionApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnApproveApprovalRequest', '', true, true)]
    procedure RunWorkflowOnApprove_Duty_ResumptionApproval(var ApprovalEntry: Record "Approval Entry")
    var
        RequisitionRequestsRec: Record "Duty Resumption";
        l_ApprovalEntry: Record "Approval Entry";
    begin
        l_ApprovalEntry.Reset;
        l_ApprovalEntry.SetRange("Table ID", ApprovalEntry."Table ID");
        l_ApprovalEntry.SetRange("Document No.", ApprovalEntry."Document No.");
        l_ApprovalEntry.SetFilter(Status, '%1|%2', l_ApprovalEntry.Status::Open, l_ApprovalEntry.Status::Created);
        if not l_ApprovalEntry.FindLast then begin
            RequisitionRequestsRec.Reset();
            RequisitionRequestsRec.SetRange("Leave Request ID", ApprovalEntry."Document No.");
            if RequisitionRequestsRec.FindFirst() then begin
                RequisitionRequestsRec."WorkFlow Status" := RequisitionRequestsRec."WorkFlow Status"::Released;
                RequisitionRequestsRec.Modify(true);
            end;
        end;
        WFMngt.HandleEventOnKnownWorkflowInstance(RunWorkflowOnApprove_Duty_ResumptionApprovalCode(), ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
    end;
    //End
    //Reject Approval reques Event************************************************************************************ End
    procedure RunWorkflowOnReject_Duty_ResumptionApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnReject_NEW_Duty_ResumptionApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnRejectApprovalRequest', '', true, true)]
    procedure RunWorkflowOnReject_Duty_ResumptionApproval(var ApprovalEntry: Record "Approval Entry")
    var
        DutyResRecRec: Record "Duty Resumption";
        l_ApprovalEntry: Record "Approval Entry";
    begin
        // WFMngt.HandleEventOnKnownWorkflowInstance(RunWorkflowOnReject_Duty_ResumptionApprovalCode, ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
        //  Reject

        l_ApprovalEntry.Reset;
        l_ApprovalEntry.SetRange("Table ID", ApprovalEntry."Table ID");
        l_ApprovalEntry.SetRange("Document No.", ApprovalEntry."Document No.");
        l_ApprovalEntry.SetFilter(Status, '%1|%2', l_ApprovalEntry.Status::Open, l_ApprovalEntry.Status::Created);
        if l_ApprovalEntry.FindFirst() then begin
            DutyResRecRec.Reset();
            DutyResRecRec.SetRange(RecID, ApprovalEntry."Record ID to Approve");
            if DutyResRecRec.FindFirst() then begin
                DutyResRecRec."WorkFlow Status" := DutyResRecRec."WorkFlow Status"::Rejected;
                DutyResRecRec.Modify(true);
            end;
        end;
        WFMngt.HandleEventOnKnownWorkflowInstance(SetStatusToReject_LT_Code_Duty_Resumption(), ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
        //  Reject
    end;
    //End
    //Delegate Approval reques Event************************************************************************************ End
    procedure RunWorkflowOnDelegate_Duty_ResumptionApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnDelegate_Duty_ResumptionApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnDelegateApprovalRequest', '', true, true)]
    procedure RunWorkflowOnDelegate_Duty_ResumptionApproval(var ApprovalEntry: Record "Approval Entry")
    begin
        WFMngt.HandleEventOnKnownWorkflowInstance(RunWorkflowOnDelegate_Duty_ResumptionApprovalCode, ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
    end;
    //End
    //Events Subscribe End


    //Code for changeing approval status Pending approval in Transfer Orders
    procedure SetStatusToPendingApprovalCode_Duty_Resumption(): Code[128] // Done
    begin
        exit(UpperCase('SetStatusToPendingApproval_NEW_Duty_Resumption'));
    end;
    //  Reject
    procedure SetStatusToReject_LT_Code_Duty_Resumption(): Code[128]
    begin
        exit(UpperCase('SetStatusToReject_LT__NEW_Duty_Resumption'));
    end;
    //  Reject


    procedure SetStatusToPendingApproval_Duty_Resumption(var Variant: Variant)
    var
        RecRef: RecordRef;
        DutyResRec: Record "Duty Resumption";
    begin
        RecRef.GetTable(Variant);
        case RecRef.Number() of
            DATABASE::"Duty Resumption":
                begin
                    RecRef.SetTable(DutyResRec);
                    DutyResRec.Validate("WorkFlow Status", DutyResRec."WorkFlow Status"::"Pending Approval");
                    DutyResRec.Modify();
                    Variant := DutyResRec;
                end;
        end;
    end;

    //  Reject Funcation
    procedure SetStatusToReject_LT_Duty_Resumption(var Variant: Variant)
    var
        RecRef: RecordRef;
        DutyResRec: Record "Duty Resumption";
    begin
        RecRef.GetTable(Variant);
        case RecRef.Number() of
            DATABASE::"Duty Resumption":
                begin
                    Message('Reject');
                    RecRef.SetTable(DutyResRec);
                    DutyResRec.Validate("WorkFlow Status", DutyResRec."WorkFlow Status"::Rejected);
                    DutyResRec.Modify();
                    Variant := DutyResRec;
                end;
        end;
    end;
    //  Reject Fucnaion

    //Code for approval status changes to Released in Transfer Order
    procedure Release_Duty_ResumptionCode(): Code[128]
    begin
        exit(UpperCase('Release_NEW_Duty_Resumption'));
    end;

    procedure Release_Duty_Resumption(var Variant: Variant)
    var
        RecRef: RecordRef;
        TargetRecRef: RecordRef;
        ApprovalEntry: Record "Approval Entry";
        DutyResRec: Record "Duty Resumption";
    begin
        RecRef.GetTable(Variant);
        ///  InsertEmailNotification(Variant);

        case RecRef.Number() of
            DATABASE::"Approval Entry":
                begin
                    ApprovalEntry := Variant;
                    TargetRecRef.Get(ApprovalEntry."Record ID to Approve");
                    Variant := TargetRecRef;

                    Release_Duty_Resumption(Variant);
                end;
            DATABASE::"Duty Resumption":
                begin

                    RecRef.SetTable(DutyResRec);
                    DutyResRec.Validate("WorkFlow Status", DutyResRec."WorkFlow Status"::Released);
                    DutyResRec.Modify();
                    Variant := DutyResRec;

                end;
        end;
    end;

    //Code for approval status changes to Open When Cancel or Reopen
    procedure ReOpen_Duty_ResumptionCode(): Code[128]
    begin
        exit(UpperCase('ReOpen_NEW_Duty_Resumption'));
    end;

    procedure ReOpen_Duty_Resumption(var Variant: Variant)
    var
        RecRef: RecordRef;
        TargetRecRef: RecordRef;
        ApprovalEntry: Record "Approval Entry";
        DutyResRec: Record "Duty Resumption";
    begin
        RecRef.GetTable(Variant);
        //  InsertEmailNotification(Variant);
        case RecRef.Number() of
            DATABASE::"Approval Entry":
                begin
                    ApprovalEntry := Variant;
                    TargetRecRef.Get(ApprovalEntry."Record ID to Approve");
                    Variant := TargetRecRef;
                    ReOpen_Duty_Resumption(Variant);

                end;
            DATABASE::"Duty Resumption":
                begin
                    RecRef.SetTable(DutyResRec);
                    DutyResRec.Validate("WorkFlow Status", DutyResRec."WorkFlow Status"::Open);
                    DutyResRec.Modify();
                    Variant := DutyResRec;
                end;
        end;
    end;

    //Code For MEssage Notification start
    procedure Duty_ResumptionMessageCode(): Code[128]
    begin
        exit(UpperCase('Duty_Resumption_NEW_Message'));
    end;

    procedure Duty_ResumptionMessage(var Variant: Variant)
    var
        RecRef: RecordRef;
        TargetRecRef: RecordRef;
        ApprovalEntry: Record "Approval Entry";
        DutyResRec: Record "Duty Resumption";
    begin
        RecRef.GetTable(Variant);
        case RecRef.Number() of
            DATABASE::"Duty Resumption":
                begin
                    RecRef.SetTable(DutyResRec);
                    Message('The approval request for the record has been canceled.');
                    Variant := DutyResRec;
                end;
        end;
    end;

    procedure Duty_ResumptionSendMessageCode(): Code[128]
    begin
        exit(UpperCase('Duty_Resumption_NEW_SendMessage'));
    end;

    procedure Duty_ResumptionSendMessage(var Variant: Variant)
    var
        RecRef: RecordRef;
        TargetRecRef: RecordRef;
        ApprovalEntry: Record "Approval Entry";
        DutyResRec: Record "Duty Resumption";
    begin
        RecRef.GetTable(Variant);
        case RecRef.Number() of
            DATABASE::"Duty Resumption":
                begin
                    RecRef.SetTable(DutyResRec);
                    Message('The approval request for the record has been sent.');
                    Variant := DutyResRec;
                end;
        end;
    end;
    //Code For Message Notification END

    //Inserting Transfer Order Details to Approval Entry Table
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnPopulateApprovalEntryArgument', '', true, true)]
    local procedure OnPopulateApprovalEntryArgument(var RecRef: RecordRef; var ApprovalEntryArgument: Record "Approval Entry"; WorkflowStepInstance: Record "Workflow Step Instance")
    var
        DutyResRec: Record "Duty Resumption";
    begin
        case RecRef.Number of
            database::"Duty Resumption":
                begin
                    RecRef.SetTable(DutyResRec);
                    ApprovalEntryArgument."Table ID" := RecRef.Number;
                    ApprovalEntryArgument."Document No." := DutyResRec."Leave Request ID";
                    // // // DutyResRec.CalcFields("Total Amount ");
                    // // // ApprovalEntryArgument.Amount := DutyResRec."Total Amount ";
                    // // // ApprovalEntryArgument."Amount (LCY)" := DutyResRec."Total Amount ";
                    //ApprovalEntryArgument."Document Type" := ApprovalEntryArgument."Document Type"::Quote;
                end;
        end;

    end;

    //Adding Events to event Library
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Event Handling", 'OnAddWorkflowEventsToLibrary', '', true, true)]
    procedure OnAddWorkflowEventsToLibrary()
    begin

        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnSend_Duty_ResumptionApprovalCode, Database::"Duty Resumption", Send_Duty_ResumptionReq, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnApprove_Duty_ResumptionApprovalCode, Database::"Approval Entry", AppReq_Duty_Resumption, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnCancel_Duty_ResumptionApprovalCode, Database::"Duty Resumption", CancelForPendAppTxt, 0, false);
        //WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnReject_Duty_ResumptionApprovalCode, Database::"Approval Entry", RejReq_Duty_Resumption, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnDelegate_Duty_ResumptionApprovalCode, Database::"Approval Entry", DelReq_Duty_Resumption, 0, false);
        //  Reject Code
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnSend_Duty_ResumptionRejectCode, Database::"Duty Resumption", Send_Duty_ResumptionReject_Duty_ResumptionReq, 0, false);
        //  Reject Code

    end;

    //Adding Newly created responses to workflowResponselibrary
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnAddWorkflowResponsesToLibrary', '', true, true)]
    procedure OnAddWorkflowResponsesToLibrary()
    begin
        WorkflowResponseHandling.AddResponseToLibrary(SetStatusToPendingApprovalCode_Duty_Resumption, 0, SendForPendAppTxt, 'GROUP 0');
        WorkflowResponseHandling.AddResponseToLibrary(Release_Duty_ResumptionCode, 0, Release_Duty_ResumptionTxt, 'GROUP 0');
        WorkflowResponseHandling.AddResponseToLibrary(ReOpen_Duty_ResumptionCode, 0, ReOpen_Duty_ResumptionTxt, 'GROUP 0');
        //WorkflowResponseHandling.AddResponseToLibrary(SendEmailCodeDuty_Resumption, 0, '', 'GROUP 0');
        WorkflowResponseHandling.AddResponseToLibrary(Duty_ResumptionMessageCode, 0, Duty_Resumption_Message, 'GROUP 0');
        WorkflowResponseHandling.AddResponseToLibrary(Duty_ResumptionSendMessageCode, 0, Duty_ResumptionSend_Message, 'GROUP 0');
        //  Reject Code
        WorkflowResponseHandling.AddResponseToLibrary(SetStatusToReject_LT_Code_Duty_Resumption, 0, SendForRejectTxt, 'GROUP 0');
        //  Reject Code 




    end;

    //06JAN20 start
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnAddWorkflowResponsePredecessorsToLibrary', '', true, true)]
    procedure OnAddWorkflowResponsePredecessorsToLibrary(ResponseFunctionName: Code[128])
    var
        WorkflowEventHandling: Codeunit InitCodeunit_Duty_Resumption;
    begin
        case ResponseFunctionName of
            //WorkFlowResponseHandling.SetStatusToPendingApprovalCode:
            //  WorkFlowResponseHandling.AddResponsePredecessor(WorkFlowResponseHandling.SetStatusToPendingApproval, WorkFlowEventHandlingExtCust.RunWorkFlowOnApproveApprovalRequestForRequisitionCode);
            WorkFlowResponseHandling.SendApprovalRequestForApprovalCode:
                WorkFlowResponseHandling.AddResponsePredecessor(WorkFlowResponseHandling.SendApprovalRequestForApprovalCode, RunWorkflowOnApprove_Duty_ResumptionApprovalCode());
        //WorkFlowResponseHandling.CancelAllApprovalRequestsCode;
        //WorkFlowResponseHandling.AddResponsePredecessor(WorkFlowResponseHandling.CancelAllApprovalRequestsCode,WorkFlowEventHandlingExtCust.run);
        //WorkFlowResponseHandling.OpenDocumentCode;
        //WorkFlowResponseHandling.AddResponsePredecessor(WorkFlowResponseHandling.OpenDocumentCode,WorkFlowEventHandlingExtCust.op);
        end;
    end;

    //06JAN20 END


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnExecuteWorkflowResponse', '', false, false)]
    procedure ExeRespForDuty_Resumption(var ResponseExecuted: Boolean; Variant: Variant; xVariant: Variant; ResponseWorkflowStepInstance: Record "Workflow Step Instance")
    var
        WorkflowResponse: Record "Workflow Response";
    begin
        IF WorkflowResponse.GET(ResponseWorkflowStepInstance."Function Name") THEN
            case WorkflowResponse."Function Name" of

                SetStatusToPendingApprovalCode_Duty_Resumption():
                    begin
                        SetStatusToPendingApproval_Duty_Resumption(Variant);
                        ResponseExecuted := true;
                    end;
                Release_Duty_ResumptionCode():
                    begin
                        Release_Duty_Resumption(Variant);
                        ResponseExecuted := true;
                    end;
                ReOpen_Duty_ResumptionCode():
                    begin
                        ReOpen_Duty_Resumption(Variant);
                        ResponseExecuted := true;
                    end;
                SendEmailCodeDuty_Resumption():
                    begin
                        SendEmailRFQ(Variant);
                        ResponseExecuted := true;
                    end;
                Duty_ResumptionMessageCode():
                    begin
                        Duty_ResumptionMessage(Variant);
                        ResponseExecuted := true;
                    end;
                Duty_ResumptionSendMessageCode():
                    begin
                        Duty_ResumptionSendMessage(Variant);
                        ResponseExecuted := true;
                    end;
                //  Reject Code
                SetStatusToReject_LT_Code_Duty_Resumption():
                    begin
                        Message('Workflow');
                        SetStatusToReject_LT_Duty_Resumption(Variant);
                        ResponseExecuted := true;
                    end;
            //  Reject Code

            end;
    end;
    // 

    //  

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
            database::"Duty Resumption":
                IsSufficient := IsRFQSufficeintApprover(UserSetup, ApprovalEntryArgument."Amount (LCY)");
        end;
    end;
    //Approver ChaIN End

    // Emial Notificaion Creation 05DEC2019 Start

    procedure SendEmailCodeDuty_Resumption(): Code[128]
    begin
        exit(UpperCase('SendEmail_NEW_Duty_Resumption'));
    end;

    procedure SendEmailRFQ(var Variant: Variant)
    var
        RecRef: RecordRef;
        RFQHeader: Record "Duty Resumption";
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
            DATABASE::"Duty Resumption":
                begin
                    TableId := RecRef.Number;
                    RecRef.SetTable(RFQHeader);
                    ApprovalEntry.Reset();
                    ApprovalEntry.SetRange("Table ID", TableId);
                    ApprovalEntry.SetRange("Document No.", RFQHeader."Leave Request ID");
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
        DutyResRec: Record "Duty Resumption";
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
            Database::"Duty Resumption":
                begin
                    // This is Commented By 
                    // // // // Recref.SetTable(DutyResRec);
                    // // // // l_ApprovalEntry.Reset();
                    // // // // l_ApprovalEntry.SetRange("Table ID", Recref.Number);
                    // // // // l_ApprovalEntry.SetRange("Document No.", DutyResRec."Requisition No.");
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
                    // This is Commented By 

                end;

        end;
    end;
    // // // // // //Insert Email Notification Entries End

}