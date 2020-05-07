codeunit 60036 WFCode_DocLetter

{
    trigger OnRun()
    begin

    end;

    var
        WFMngt: Codeunit "Workflow Management";
        AppMgmt: Codeunit "Approvals Mgmt.";
        WorkflowEventHandling: Codeunit "Workflow Event Handling";
        WorkflowResponseHandling: Codeunit "Workflow Response Handling";
        Send_DocLetterReq: TextConst ENU = 'LT Approval Request for Document Letter is requested', ENG = 'LT Approval Request for Document Letter is requested';
        AppReq_DocLetter: TextConst ENU = 'LT Approval Request for Document Letter is approved', ENG = 'LT Approval Request for Document Letter is approved';
        RejReq_DocLetter: TextConst ENU = 'LT Approval Request for Document Letter is rejected', ENG = 'LT Approval Request for Document Letteris rejected';
        DelReq_DocLetter: TextConst ENU = 'LT Approval Request for Document Letter is delegated', ENG = 'LT Approval Request for Document Letter is delegated';
        SendForPendAppTxt: TextConst ENU = 'LT Status of Document Letter changed to Pending approval', ENG = 'LT Status of Document Letter changed to Pending approval';
        CancelForPendAppTxt: TextConst ENU = 'LT Approval Rquest for Document Letter is Canceled', ENG = 'LT Approval request for Document Letter is Canceled';
        Release_DocLetterTxt: TextConst ENU = 'LT ReleaseDocLetter', ENG = 'LT ReleaseDocLetter';
        ReOpen_DocLetterTxt: TextConst ENU = 'LT ReOpenDocLetter', ENG = 'LT ReOpenDocLetter';
        DocLetter_Message: TextConst ENU = 'LT DocLetterMessage', ENG = 'LT DocLetterMessage';
        DocLetterSend_Message: TextConst ENU = 'LT DocLetterSendMessage', ENG = 'LT DocLetterSendMessage';
        // Avinash Reject Code
        SendForRejectTxt: TextConst ENU = 'LT Status of Document Letter changed to Reject', ENG = 'LT Status of Document Letter changed to Reject';
        Send_DocLetterReject_DocLetterReq: TextConst ENU = 'LT Approval Request for Document Letter is Rejected', ENG = 'LT Approval Request for Document Letter is Rejected';
    // Avinash Reject Code



    //Events Subscribe Start

    //Send For Approval Event************************************************************************************ start
    procedure RunWorkflowOnSend_DocLetterApprovalCode(): Code[128]
    begin
        exit('RunWorkflowOnSend_NEW_DocLetterApproval');
    end;
    // Avinash Reject
    procedure RunWorkflowOnSend_DocLetterRejectCode(): Code[128]
    begin
        exit('RunWorkflowOnSend_NEW_DocLetterReject');
    end;
    // Avinash Reject

    [EventSubscriber(ObjectType::Codeunit, Codeunit::InitCodeunit_DocLetterRec, 'OnSendDocLetter_Approval', '', true, true)]
    procedure RunWorkflowOnSend_DocLetterApproval(var DocLetterRec: Record "Document Request")
    begin
        WFMngt.HandleEvent(RunWorkflowOnSend_DocLetterApprovalCode, DocLetterRec);
    end;
    // End

    //Cancel For Approval Event************************************************************************************ End
    procedure RunWorkflowOnCancel_DocLetterApprovalCode(): Code[128]
    begin
        exit('RunWorkflowOnCancel_NEW_DocLetterApproval');
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::InitCodeunit_DocLetterRec, 'OnCancelDocLetter_Approval', '', true, true)]
    procedure RunWorkflowOnCancel_DocLetterApproval(var DocLetterRec: Record "Document Request")
    begin
        WFMngt.HandleEvent(RunWorkflowOnCancel_DocLetterApprovalCode, DocLetterRec);
    end;
    //End

    //Approve Approval reques Event************************************************************************************ End
    procedure RunWorkflowOnApprove_DocLetterApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnApprove_NEW_DocLetterApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnApproveApprovalRequest', '', true, true)]
    procedure RunWorkflowOnApprove_DocLetterApproval(var ApprovalEntry: Record "Approval Entry")
    var
        RequisitionRequestsRec: Record "Document Request";
        l_ApprovalEntry: Record "Approval Entry";
    begin
        l_ApprovalEntry.Reset;
        l_ApprovalEntry.SetRange("Table ID", ApprovalEntry."Table ID");
        l_ApprovalEntry.SetRange("Document No.", ApprovalEntry."Document No.");
        l_ApprovalEntry.SetFilter(Status, '%1|%2', l_ApprovalEntry.Status::Open, l_ApprovalEntry.Status::Created);
        if not l_ApprovalEntry.FindLast then begin
            RequisitionRequestsRec.Reset();
            RequisitionRequestsRec.SetRange("Document Request ID", ApprovalEntry."Document No.");
            if RequisitionRequestsRec.FindFirst() then begin
                RequisitionRequestsRec."WorkFlow Status" := RequisitionRequestsRec."WorkFlow Status"::Released;
                RequisitionRequestsRec.Modify(true);
            end;
        end;
        WFMngt.HandleEventOnKnownWorkflowInstance(RunWorkflowOnApprove_DocLetterApprovalCode(), ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
    end;
    //End
    //Reject Approval reques Event************************************************************************************ End
    procedure RunWorkflowOnReject_DocLetterApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnReject_NEW_DocLetterApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnRejectApprovalRequest', '', true, true)]
    procedure RunWorkflowOnReject_DocLetterApproval(var ApprovalEntry: Record "Approval Entry")
    var
        DocLetterRecRec: Record "Document Request";
        l_ApprovalEntry: Record "Approval Entry";

    begin
        // WFMngt.HandleEventOnKnownWorkflowInstance(RunWorkflowOnReject_DocLetterApprovalCode, ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
        // Avinash Reject

        l_ApprovalEntry.Reset;
        l_ApprovalEntry.SetRange("Table ID", ApprovalEntry."Table ID");
        l_ApprovalEntry.SetRange("Document No.", ApprovalEntry."Document No.");
        l_ApprovalEntry.SetFilter(Status, '%1|%2', l_ApprovalEntry.Status::Open, l_ApprovalEntry.Status::Created);
        if l_ApprovalEntry.FindFirst() then begin
            DocLetterRecRec.Reset();
            //DocLetterRecRec.SetRange(RecID, ApprovalEntry."Record ID to Approve");
            DocLetterRecRec.SetRange("Document Request ID", ApprovalEntry."Document No.");
            if DocLetterRecRec.FindFirst() then begin
                DocLetterRecRec."WorkFlow Status" := DocLetterRecRec."WorkFlow Status"::Open;
                DocLetterRecRec.Modify(true);
            end;
        end;
        WFMngt.HandleEventOnKnownWorkflowInstance(SetStatusToReject_LT_Code_DocLetter(), ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
        // Avinash Reject
    end;
    //End
    //Delegate Approval reques Event************************************************************************************ End
    procedure RunWorkflowOnDelegate_DocLetterApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnDelegate_DocLetterApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnDelegateApprovalRequest', '', true, true)]
    procedure RunWorkflowOnDelegate_DocLetterApproval(var ApprovalEntry: Record "Approval Entry")
    begin
        WFMngt.HandleEventOnKnownWorkflowInstance(RunWorkflowOnDelegate_DocLetterApprovalCode, ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
    end;
    //End
    //Events Subscribe End


    //Code for changeing approval status Pending approval in Transfer Orders
    procedure SetStatusToPendingApprovalCode_DocLetter(): Code[128] // Done
    begin
        exit(UpperCase('SetStatusToPendingApproval_NEW_DocLetter'));
    end;
    // Avinash Reject
    procedure SetStatusToReject_LT_Code_DocLetter(): Code[128]
    begin
        exit(UpperCase('SetStatusToReject_LT__NEW_DocLetter'));
    end;
    // Avinash Reject


    procedure SetStatusToPendingApproval_DocLetter(var Variant: Variant)
    var
        RecRef: RecordRef;
        DocLetterRec: Record "Document Request";
    begin
        RecRef.GetTable(Variant);
        case RecRef.Number() of
            DATABASE::"Document Request":
                begin
                    RecRef.SetTable(DocLetterRec);
                    DocLetterRec.Validate("WorkFlow Status", DocLetterRec."WorkFlow Status"::"Pending Approval");
                    DocLetterRec.Modify();
                    Variant := DocLetterRec;
                end;
        end;
    end;

    // Avinash Reject Funcation
    procedure SetStatusToReject_LT_DocLetter(var Variant: Variant)
    var
        RecRef: RecordRef;
        DocLetterRec: Record "Document Request";
    begin
        RecRef.GetTable(Variant);
        case RecRef.Number() of
            DATABASE::"Document Request":
                begin
                    //RecRef.SetTable(DocLetterRec);
                    DocLetterRec := Variant;
                    DocLetterRec.Validate("WorkFlow Status", DocLetterRec."WorkFlow Status"::Rejected);
                    DocLetterRec.Modify();
                    Variant := DocLetterRec;
                end;
        end;
    end;
    // Avinash Reject Fucnaion

    //Code for approval status changes to Released in Transfer Order
    procedure Release_DocLetterCode(): Code[128]
    begin
        exit(UpperCase('Release_NEW_DocLetter'));
    end;

    procedure Release_DocLetter(var Variant: Variant)
    var
        RecRef: RecordRef;
        TargetRecRef: RecordRef;
        ApprovalEntry: Record "Approval Entry";
        DocLetterRec: Record "Document Request";
    begin
        RecRef.GetTable(Variant);
        ///  InsertEmailNotification(Variant);

        case RecRef.Number() of
            DATABASE::"Approval Entry":
                begin
                    ApprovalEntry := Variant;
                    TargetRecRef.Get(ApprovalEntry."Record ID to Approve");
                    Variant := TargetRecRef;

                    Release_DocLetter(Variant);
                end;
            DATABASE::"Document Request":
                begin

                    RecRef.SetTable(DocLetterRec);
                    DocLetterRec.Validate("WorkFlow Status", DocLetterRec."WorkFlow Status"::Released);
                    DocLetterRec.Modify();
                    Variant := DocLetterRec;

                end;
        end;
    end;

    //Code for approval status changes to Open When Cancel or Reopen
    procedure ReOpen_DocLetterCode(): Code[128]
    begin
        exit(UpperCase('ReOpen_NEW_DocLetter'));
    end;

    procedure ReOpen_DocLetter(var Variant: Variant)
    var
        RecRef: RecordRef;
        TargetRecRef: RecordRef;
        ApprovalEntry: Record "Approval Entry";
        DocLetterRec: Record "Document Request";
    begin
        RecRef.GetTable(Variant);
        //  InsertEmailNotification(Variant);
        case RecRef.Number() of
            DATABASE::"Approval Entry":
                begin
                    ApprovalEntry := Variant;
                    TargetRecRef.Get(ApprovalEntry."Record ID to Approve");
                    Variant := TargetRecRef;
                    ReOpen_DocLetter(Variant);

                end;
            DATABASE::"Document Request":
                begin
                    //RecRef.SetTable(DocLetterRec);
                    DocLetterRec := Variant;
                    DocLetterRec.Validate("WorkFlow Status", DocLetterRec."WorkFlow Status"::Open);
                    DocLetterRec.Modify();
                    Variant := DocLetterRec;
                end;
        end;
    end;

    //Code For MEssage Notification start
    procedure DocLetterMessageCode(): Code[128]
    begin
        exit(UpperCase('DocLetter_NEW_Message'));
    end;

    procedure DocLetterMessage(var Variant: Variant)
    var
        RecRef: RecordRef;
        TargetRecRef: RecordRef;
        ApprovalEntry: Record "Approval Entry";
        DocLetterRec: Record "Document Request";
    begin
        RecRef.GetTable(Variant);
        case RecRef.Number() of
            DATABASE::"Document Request":
                begin
                    RecRef.SetTable(DocLetterRec);
                    Message('The approval request for the record has been canceled.');
                    Variant := DocLetterRec;
                end;
        end;
    end;

    procedure DocLetterSendMessageCode(): Code[128]
    begin
        exit(UpperCase('DocLetter_NEW_SendMessage'));
    end;

    procedure DocLetterSendMessage(var Variant: Variant)
    var
        RecRef: RecordRef;
        TargetRecRef: RecordRef;
        ApprovalEntry: Record "Approval Entry";
        DocLetterRec: Record "Document Request";
    begin
        RecRef.GetTable(Variant);
        case RecRef.Number() of
            DATABASE::"Document Request":
                begin
                    RecRef.SetTable(DocLetterRec);
                    Message('The approval request for the record has been sent.');
                    Variant := DocLetterRec;
                end;
        end;
    end;
    //Code For Message Notification END

    //Inserting Transfer Order Details to Approval Entry Table
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnPopulateApprovalEntryArgument', '', true, true)]
    local procedure OnPopulateApprovalEntryArgument(var RecRef: RecordRef; var ApprovalEntryArgument: Record "Approval Entry"; WorkflowStepInstance: Record "Workflow Step Instance")
    var
        DocLetterRec: Record "Document Request";
    begin
        case RecRef.Number of
            database::"Document Request":
                begin
                    RecRef.SetTable(DocLetterRec);
                    ApprovalEntryArgument."Table ID" := RecRef.Number;
                    ApprovalEntryArgument."Document No." := DocLetterRec."Document Request ID";
                    // // // DocLetterRec.CalcFields("Total Amount ");
                    // // // ApprovalEntryArgument.Amount := DocLetterRec."Total Amount ";
                    // // // ApprovalEntryArgument."Amount (LCY)" := DocLetterRec."Total Amount ";
                    //ApprovalEntryArgument."Document Type" := ApprovalEntryArgument."Document Type"::Quote;
                end;
        end;

    end;

    //Adding Events to event Library
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Event Handling", 'OnAddWorkflowEventsToLibrary', '', true, true)]
    procedure OnAddWorkflowEventsToLibrary()
    begin

        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnSend_DocLetterApprovalCode, Database::"Document Request", Send_DocLetterReq, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnApprove_DocLetterApprovalCode, Database::"Approval Entry", AppReq_DocLetter, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnCancel_DocLetterApprovalCode, Database::"Document Request", CancelForPendAppTxt, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnReject_DocLetterApprovalCode, Database::"Approval Entry", RejReq_DocLetter, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnDelegate_DocLetterApprovalCode, Database::"Approval Entry", DelReq_DocLetter, 0, false);
        // Avinash Reject Code
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnSend_DocLetterRejectCode, Database::"Document Request", Send_DocLetterReject_DocLetterReq, 0, false);
        // Avinash Reject Code

    end;

    //Adding Newly created responses to workflowResponselibrary
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnAddWorkflowResponsesToLibrary', '', true, true)]
    procedure OnAddWorkflowResponsesToLibrary()
    begin
        WorkflowResponseHandling.AddResponseToLibrary(SetStatusToPendingApprovalCode_DocLetter, 0, SendForPendAppTxt, 'GROUP 0');
        WorkflowResponseHandling.AddResponseToLibrary(Release_DocLetterCode, 0, Release_DocLetterTxt, 'GROUP 0');
        WorkflowResponseHandling.AddResponseToLibrary(ReOpen_DocLetterCode, 0, ReOpen_DocLetterTxt, 'GROUP 0');
        //WorkflowResponseHandling.AddResponseToLibrary(SendEmailCodeDocLetter, 0, '', 'GROUP 0');
        WorkflowResponseHandling.AddResponseToLibrary(DocLetterMessageCode, 0, DocLetter_Message, 'GROUP 0');
        WorkflowResponseHandling.AddResponseToLibrary(DocLetterSendMessageCode, 0, DocLetterSend_Message, 'GROUP 0');
        // Avinash Reject Code
        WorkflowResponseHandling.AddResponseToLibrary(SetStatusToReject_LT_Code_DocLetter, 0, SendForRejectTxt, 'GROUP 0');
        // Avinash Reject Code 




    end;

    //06JAN20 start
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnAddWorkflowResponsePredecessorsToLibrary', '', true, true)]
    procedure OnAddWorkflowResponsePredecessorsToLibrary(ResponseFunctionName: Code[128])
    var
        WorkflowEventHandling: Codeunit InitCodeunit_DocLetterRec;
    begin
        case ResponseFunctionName of
            //WorkFlowResponseHandling.SetStatusToPendingApprovalCode:
            //  WorkFlowResponseHandling.AddResponsePredecessor(WorkFlowResponseHandling.SetStatusToPendingApproval, WorkFlowEventHandlingExtCust.RunWorkFlowOnApproveApprovalRequestForRequisitionCode);
            WorkFlowResponseHandling.SendApprovalRequestForApprovalCode:
                WorkFlowResponseHandling.AddResponsePredecessor(WorkFlowResponseHandling.SendApprovalRequestForApprovalCode, RunWorkflowOnApprove_DocLetterApprovalCode());
        //WorkFlowResponseHandling.CancelAllApprovalRequestsCode;
        //WorkFlowResponseHandling.AddResponsePredecessor(WorkFlowResponseHandling.CancelAllApprovalRequestsCode,WorkFlowEventHandlingExtCust.run);
        //WorkFlowResponseHandling.OpenDocumentCode;
        //WorkFlowResponseHandling.AddResponsePredecessor(WorkFlowResponseHandling.OpenDocumentCode,WorkFlowEventHandlingExtCust.op);
        end;
    end;

    //06JAN20 END


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnExecuteWorkflowResponse', '', false, false)]
    procedure ExeRespForDocLetter(var ResponseExecuted: Boolean; var Variant: Variant; xVariant: Variant; ResponseWorkflowStepInstance: Record "Workflow Step Instance")
    var
        WorkflowResponse: Record "Workflow Response";
    begin
        IF WorkflowResponse.GET(ResponseWorkflowStepInstance."Function Name") THEN//Document Request
            case WorkflowResponse."Function Name" of

                SetStatusToPendingApprovalCode_DocLetter():
                    begin
                        SetStatusToPendingApproval_DocLetter(Variant);
                        ResponseExecuted := true;
                    end;
                Release_DocLetterCode():
                    begin
                        Release_DocLetter(Variant);
                        ResponseExecuted := true;
                    end;
                ReOpen_DocLetterCode()://Reject
                    begin
                        ReOpen_DocLetter(Variant);
                        ResponseExecuted := true;
                    end;
                SendEmailCodeDocLetter():
                    begin
                        SendEmailRFQ(Variant);
                        ResponseExecuted := true;
                    end;
                DocLetterMessageCode():
                    begin
                        DocLetterMessage(Variant);
                        ResponseExecuted := true;
                    end;
                DocLetterSendMessageCode():
                    begin
                        DocLetterSendMessage(Variant);
                        ResponseExecuted := true;
                    end;
                // Avinash Reject Code
                SetStatusToReject_LT_Code_DocLetter():
                    begin
                        SetStatusToReject_LT_DocLetter(Variant);
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
            database::"Document Request":
                IsSufficient := IsRFQSufficeintApprover(UserSetup, ApprovalEntryArgument."Amount (LCY)");
        end;
    end;
    //Approver ChaIN End

    // Emial Notificaion Creation 05DEC2019 Start

    procedure SendEmailCodeDocLetter(): Code[128]
    begin
        exit(UpperCase('SendEmail_NEW_DocLetter'));
    end;

    procedure SendEmailRFQ(var Variant: Variant)
    var
        RecRef: RecordRef;
        RFQHeader: Record "Document Request";

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
            DATABASE::"Document Request":
                begin
                    TableId := RecRef.Number;
                    RecRef.SetTable(RFQHeader);
                    ApprovalEntry.Reset();
                    ApprovalEntry.SetRange("Table ID", TableId);
                    ApprovalEntry.SetRange("Document No.", RFQHeader."Document Request ID");
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
        DocLetterRec: Record "Document Request";
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
            Database::"Document Request":
                begin
                    // This is Commented By Avinash
                    // // // // Recref.SetTable(DocLetterRec);
                    // // // // l_ApprovalEntry.Reset();
                    // // // // l_ApprovalEntry.SetRange("Table ID", Recref.Number);
                    // // // // l_ApprovalEntry.SetRange("Document No.", DocLetterRec."Requisition No.");
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