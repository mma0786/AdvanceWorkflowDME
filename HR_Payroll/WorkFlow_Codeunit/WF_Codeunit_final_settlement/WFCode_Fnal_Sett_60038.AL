codeunit 60038 WFCode_Final_Sett

{
    trigger OnRun()
    begin

    end;

    var
        WFMngt: Codeunit "Workflow Management";
        AppMgmt: Codeunit "Approvals Mgmt.";
        WorkflowEventHandling: Codeunit "Workflow Event Handling";
        WorkflowResponseHandling: Codeunit "Workflow Response Handling";
        Send_F_And_FReq: TextConst ENU = 'LT Approval Request for Full and Final  Settlement is requested', ENG = 'LT Approval Request for Full and Final  Settlement is requested';
        AppReq_F_And_F: TextConst ENU = 'LT Approval Request for Full and Final  Settlement is approved', ENG = 'LT Approval Request for Full and Final  Settlement is approved';
        RejReq_F_And_F: TextConst ENU = 'LT Approval Request for Full and Final  Settlement is rejected', ENG = 'LT Approval Request for Full and Final  Settlementis rejected';
        DelReq_F_And_F: TextConst ENU = 'LT Approval Request for Full and Final  Settlement is delegated', ENG = 'LT Approval Request for Full and Final  Settlement is delegated';
        SendForPendAppTxt: TextConst ENU = 'LT Status of Full and Final  Settlement changed to Pending approval', ENG = 'LT Status of Full and Final  Settlement changed to Pending approval';
        CancelForPendAppTxt: TextConst ENU = 'LT Approval Rquest for Full and Final  Settlement is Canceled', ENG = 'LT Approval request for Full and Final  Settlement is Canceled';
        Release_F_And_FTxt: TextConst ENU = 'LT ReleaseF_And_F', ENG = 'LT ReleaseF_And_F';
        ReOpen_F_And_FTxt: TextConst ENU = 'LT ReOpenF_And_F', ENG = 'LT ReOpenF_And_F';
        F_And_F_Message: TextConst ENU = 'LT F_And_FMessage', ENG = 'LT F_And_FMessage';
        F_And_FSend_Message: TextConst ENU = 'LT F_And_FSendMessage', ENG = 'LT F_And_FSendMessage';
        // Avinash Reject Code
        SendForRejectTxt: TextConst ENU = 'LT Status of Full and Final  Settlement changed to Reject', ENG = 'LT Status of Full and Final  Settlement changed to Reject';
        Send_F_And_FReject_F_And_FReq: TextConst ENU = 'LT Approval Request for Full and Final  Settlement is Rejected', ENG = 'LT Approval Request for Full and Final  Settlement is Rejected';
    // Avinash Reject Code



    //Events Subscribe Start

    //Send For Approval Event************************************************************************************ start
    procedure RunWorkflowOnSend_F_And_FApprovalCode(): Code[128]
    begin
        exit('RunWorkflowOnSend_NEW_F_And_FApproval');
    end;
    // Avinash Reject
    procedure RunWorkflowOnSend_F_And_FRejectCode(): Code[128]
    begin
        exit('RunWorkflowOnSend_NEW_F_And_FReject');
    end;
    // Avinash Reject

    [EventSubscriber(ObjectType::Codeunit, Codeunit::InitCodeunit_Final_Sett, 'OnSendF_And_F_Approval', '', true, true)]
    procedure RunWorkflowOnSend_F_And_FApproval(var FAndF: Record "Full and Final Calculation")
    begin
        WFMngt.HandleEvent(RunWorkflowOnSend_F_And_FApprovalCode, FAndF);
    end;
    // End

    //Cancel For Approval Event************************************************************************************ End
    procedure RunWorkflowOnCancel_F_And_FApprovalCode(): Code[128]
    begin
        exit('RunWorkflowOnCancel_NEW_F_And_FApproval');
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::InitCodeunit_Final_Sett, 'OnCancelF_And_F_Approval', '', true, true)]
    procedure RunWorkflowOnCancel_F_And_FApproval(var FAndF: Record "Full and Final Calculation")
    begin
        WFMngt.HandleEvent(RunWorkflowOnCancel_F_And_FApprovalCode, FAndF);
    end;
    //End

    //Approve Approval reques Event************************************************************************************ End
    procedure RunWorkflowOnApprove_F_And_FApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnApprove_NEW_F_And_FApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnApproveApprovalRequest', '', true, true)]
    procedure RunWorkflowOnApprove_F_And_FApproval(var ApprovalEntry: Record "Approval Entry")
    var
        RequisitionRequestsRec: Record "Full and Final Calculation";
        l_ApprovalEntry: Record "Approval Entry";
    begin
        l_ApprovalEntry.Reset;
        l_ApprovalEntry.SetRange("Table ID", ApprovalEntry."Table ID");
        l_ApprovalEntry.SetRange("Document No.", ApprovalEntry."Document No.");
        l_ApprovalEntry.SetFilter(Status, '%1|%2', l_ApprovalEntry.Status::Open, l_ApprovalEntry.Status::Created);
        if not l_ApprovalEntry.FindLast then begin
            RequisitionRequestsRec.Reset();
            RequisitionRequestsRec.SetRange("Employee No.", ApprovalEntry."Document No.");
            if RequisitionRequestsRec.FindFirst() then begin
                RequisitionRequestsRec."WorkFlow Status" := RequisitionRequestsRec."WorkFlow Status"::Released;
                RequisitionRequestsRec.Modify(true);
            end;
        end;
        WFMngt.HandleEventOnKnownWorkflowInstance(RunWorkflowOnApprove_F_And_FApprovalCode(), ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
    end;
    //End
    //Reject Approval reques Event************************************************************************************ End
    procedure RunWorkflowOnReject_F_And_FApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnReject_NEW_F_And_FApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnRejectApprovalRequest', '', true, true)]
    procedure RunWorkflowOnReject_F_And_FApproval(var ApprovalEntry: Record "Approval Entry")
    var
        FAndFRec: Record "Full and Final Calculation";
        l_ApprovalEntry: Record "Approval Entry";
    begin
        // WFMngt.HandleEventOnKnownWorkflowInstance(RunWorkflowOnReject_F_And_FApprovalCode, ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
        // Avinash Reject

        l_ApprovalEntry.Reset;
        l_ApprovalEntry.SetRange("Table ID", ApprovalEntry."Table ID");
        l_ApprovalEntry.SetRange("Document No.", ApprovalEntry."Document No.");
        l_ApprovalEntry.SetFilter(Status, '%1|%2', l_ApprovalEntry.Status::Open, l_ApprovalEntry.Status::Created);
        if l_ApprovalEntry.FindFirst() then begin
            FAndFRec.Reset();
            FAndFRec.SetRange(RecID, ApprovalEntry."Record ID to Approve");
            if FAndFRec.FindFirst() then begin
                FAndFRec."WorkFlow Status" := FAndFRec."WorkFlow Status"::Rejected;
                FAndFRec.Modify(true);
            end;
        end;
        WFMngt.HandleEventOnKnownWorkflowInstance(SetStatusToReject_LT_Code_F_And_F(), ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
        // Avinash Reject
    end;
    //End
    //Delegate Approval reques Event************************************************************************************ End
    procedure RunWorkflowOnDelegate_F_And_FApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnDelegate_F_And_FApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnDelegateApprovalRequest', '', true, true)]
    procedure RunWorkflowOnDelegate_F_And_FApproval(var ApprovalEntry: Record "Approval Entry")
    begin
        WFMngt.HandleEventOnKnownWorkflowInstance(RunWorkflowOnDelegate_F_And_FApprovalCode, ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
    end;
    //End
    //Events Subscribe End


    //Code for changeing approval status Pending approval in Transfer Orders
    procedure SetStatusToPendingApprovalCode_F_And_F(): Code[128] // Done
    begin
        exit(UpperCase('SetStatusToPendingApproval_NEW_F_And_F'));
    end;
    // Avinash Reject
    procedure SetStatusToReject_LT_Code_F_And_F(): Code[128]
    begin
        exit(UpperCase('SetStatusToReject_LT__NEW_F_And_F'));
    end;
    // Avinash Reject


    procedure SetStatusToPendingApproval_F_And_F(var Variant: Variant)
    var
        RecRef: RecordRef;
        FAndF: Record "Full and Final Calculation";
    begin
        RecRef.GetTable(Variant);
        case RecRef.Number() of
            DATABASE::"Full and Final Calculation":
                begin
                    RecRef.SetTable(FAndF);
                    FAndF.Validate("WorkFlow Status", FAndF."WorkFlow Status"::"Pending Approval");
                    FAndF.Modify();
                    Variant := FAndF;
                end;
        end;
    end;

    // Avinash Reject Funcation
    procedure SetStatusToReject_LT_F_And_F(var Variant: Variant)
    var
        RecRef: RecordRef;
        FAndF: Record "Full and Final Calculation";
    begin
        RecRef.GetTable(Variant);
        case RecRef.Number() of
            DATABASE::"Full and Final Calculation":
                begin
                    Message('Reject');
                    RecRef.SetTable(FAndF);
                    FAndF.Validate("WorkFlow Status", FAndF."WorkFlow Status"::Rejected);
                    FAndF.Modify();
                    Variant := FAndF;
                end;
        end;
    end;
    // Avinash Reject Fucnaion

    //Code for approval status changes to Released in Transfer Order
    procedure Release_F_And_FCode(): Code[128]
    begin
        exit(UpperCase('Release_NEW_F_And_F'));
    end;

    procedure Release_F_And_F(var Variant: Variant)
    var
        RecRef: RecordRef;
        TargetRecRef: RecordRef;
        ApprovalEntry: Record "Approval Entry";
        FAndF: Record "Full and Final Calculation";
    begin
        RecRef.GetTable(Variant);
        ///  InsertEmailNotification(Variant);

        case RecRef.Number() of
            DATABASE::"Approval Entry":
                begin
                    ApprovalEntry := Variant;
                    TargetRecRef.Get(ApprovalEntry."Record ID to Approve");
                    Variant := TargetRecRef;

                    Release_F_And_F(Variant);
                end;
            DATABASE::"Full and Final Calculation":
                begin

                    RecRef.SetTable(FAndF);
                    FAndF.Validate("WorkFlow Status", FAndF."WorkFlow Status"::Released);
                    FAndF.Modify();
                    Variant := FAndF;

                end;
        end;
    end;

    //Code for approval status changes to Open When Cancel or Reopen
    procedure ReOpen_F_And_FCode(): Code[128]
    begin
        exit(UpperCase('ReOpen_NEW_F_And_F'));
    end;

    procedure ReOpen_F_And_F(var Variant: Variant)
    var
        RecRef: RecordRef;
        TargetRecRef: RecordRef;
        ApprovalEntry: Record "Approval Entry";
        FAndF: Record "Full and Final Calculation";
    begin
        RecRef.GetTable(Variant);
        //  InsertEmailNotification(Variant);
        case RecRef.Number() of
            DATABASE::"Approval Entry":
                begin
                    ApprovalEntry := Variant;
                    TargetRecRef.Get(ApprovalEntry."Record ID to Approve");
                    Variant := TargetRecRef;
                    ReOpen_F_And_F(Variant);

                end;
            DATABASE::"Full and Final Calculation":
                begin
                    RecRef.SetTable(FAndF);
                    FAndF.Validate("WorkFlow Status", FAndF."WorkFlow Status"::Open);
                    FAndF.Modify();
                    Variant := FAndF;
                end;
        end;
    end;

    //Code For MEssage Notification start
    procedure F_And_FMessageCode(): Code[128]
    begin
        exit(UpperCase('F_And_F_NEW_Message'));
    end;

    procedure F_And_FMessage(var Variant: Variant)
    var
        RecRef: RecordRef;
        TargetRecRef: RecordRef;
        ApprovalEntry: Record "Approval Entry";
        FAndF: Record "Full and Final Calculation";
    begin
        RecRef.GetTable(Variant);
        case RecRef.Number() of
            DATABASE::"Full and Final Calculation":
                begin
                    RecRef.SetTable(FAndF);
                    Message('The approval request for the record has been canceled.');
                    Variant := FAndF;
                end;
        end;
    end;

    procedure F_And_FSendMessageCode(): Code[128]
    begin
        exit(UpperCase('F_And_F_NEW_SendMessage'));
    end;

    procedure F_And_FSendMessage(var Variant: Variant)
    var
        RecRef: RecordRef;
        TargetRecRef: RecordRef;
        ApprovalEntry: Record "Approval Entry";
        FAndF: Record "Full and Final Calculation";
    begin
        RecRef.GetTable(Variant);
        case RecRef.Number() of
            DATABASE::"Full and Final Calculation":
                begin
                    RecRef.SetTable(FAndF);
                    Message('The approval request for the record has been sent.');
                    Variant := FAndF;
                end;
        end;
    end;
    //Code For Message Notification END

    //Inserting Transfer Order Details to Approval Entry Table
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnPopulateApprovalEntryArgument', '', true, true)]
    local procedure OnPopulateApprovalEntryArgument(var RecRef: RecordRef; var ApprovalEntryArgument: Record "Approval Entry"; WorkflowStepInstance: Record "Workflow Step Instance")
    var
        FAndF: Record "Full and Final Calculation";
    begin
        case RecRef.Number of
            database::"Full and Final Calculation":
                begin
                    RecRef.SetTable(FAndF);
                    ApprovalEntryArgument."Table ID" := RecRef.Number;
                    ApprovalEntryArgument."Document No." := FAndF."Employee No.";
                    // // // FAndF.CalcFields("Total Amount ");
                    // // // ApprovalEntryArgument.Amount := FAndF."Total Amount ";
                    // // // ApprovalEntryArgument."Amount (LCY)" := FAndF."Total Amount ";
                    //ApprovalEntryArgument."Document Type" := ApprovalEntryArgument."Document Type"::Quote;
                end;
        end;

    end;

    //Adding Events to event Library
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Event Handling", 'OnAddWorkflowEventsToLibrary', '', true, true)]
    procedure OnAddWorkflowEventsToLibrary()
    begin

        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnSend_F_And_FApprovalCode, Database::"Full and Final Calculation", Send_F_And_FReq, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnApprove_F_And_FApprovalCode, Database::"Approval Entry", AppReq_F_And_F, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnCancel_F_And_FApprovalCode, Database::"Full and Final Calculation", CancelForPendAppTxt, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnReject_F_And_FApprovalCode, Database::"Approval Entry", RejReq_F_And_F, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnDelegate_F_And_FApprovalCode, Database::"Approval Entry", DelReq_F_And_F, 0, false);
        // Avinash Reject Code
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnSend_F_And_FRejectCode, Database::"Full and Final Calculation", Send_F_And_FReject_F_And_FReq, 0, false);
        // Avinash Reject Code

    end;

    //Adding Newly created responses to workflowResponselibrary
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnAddWorkflowResponsesToLibrary', '', true, true)]
    procedure OnAddWorkflowResponsesToLibrary()
    begin
        WorkflowResponseHandling.AddResponseToLibrary(SetStatusToPendingApprovalCode_F_And_F, 0, SendForPendAppTxt, 'GROUP 0');
        WorkflowResponseHandling.AddResponseToLibrary(Release_F_And_FCode, 0, Release_F_And_FTxt, 'GROUP 0');
        WorkflowResponseHandling.AddResponseToLibrary(ReOpen_F_And_FCode, 0, ReOpen_F_And_FTxt, 'GROUP 0');
        //WorkflowResponseHandling.AddResponseToLibrary(SendEmailCodeF_And_F, 0, '', 'GROUP 0');
        WorkflowResponseHandling.AddResponseToLibrary(F_And_FMessageCode, 0, F_And_F_Message, 'GROUP 0');
        WorkflowResponseHandling.AddResponseToLibrary(F_And_FSendMessageCode, 0, F_And_FSend_Message, 'GROUP 0');
        // Avinash Reject Code
        WorkflowResponseHandling.AddResponseToLibrary(SetStatusToReject_LT_Code_F_And_F, 0, SendForRejectTxt, 'GROUP 0');
        // Avinash Reject Code 




    end;

    //06JAN20 start
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnAddWorkflowResponsePredecessorsToLibrary', '', true, true)]
    procedure OnAddWorkflowResponsePredecessorsToLibrary(ResponseFunctionName: Code[128])
    var
        WorkflowEventHandling: Codeunit InitCodeunit_Final_Sett;
    begin
        case ResponseFunctionName of
            //WorkFlowResponseHandling.SetStatusToPendingApprovalCode:
            //  WorkFlowResponseHandling.AddResponsePredecessor(WorkFlowResponseHandling.SetStatusToPendingApproval, WorkFlowEventHandlingExtCust.RunWorkFlowOnApproveApprovalRequestForRequisitionCode);
            WorkFlowResponseHandling.SendApprovalRequestForApprovalCode:
                WorkFlowResponseHandling.AddResponsePredecessor(WorkFlowResponseHandling.SendApprovalRequestForApprovalCode, RunWorkflowOnApprove_F_And_FApprovalCode());
        //WorkFlowResponseHandling.CancelAllApprovalRequestsCode;
        //WorkFlowResponseHandling.AddResponsePredecessor(WorkFlowResponseHandling.CancelAllApprovalRequestsCode,WorkFlowEventHandlingExtCust.run);
        //WorkFlowResponseHandling.OpenDocumentCode;
        //WorkFlowResponseHandling.AddResponsePredecessor(WorkFlowResponseHandling.OpenDocumentCode,WorkFlowEventHandlingExtCust.op);
        end;
    end;

    //06JAN20 END


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnExecuteWorkflowResponse', '', false, false)]
    procedure ExeRespForF_And_F(var ResponseExecuted: Boolean; Variant: Variant; xVariant: Variant; ResponseWorkflowStepInstance: Record "Workflow Step Instance")
    var
        WorkflowResponse: Record "Workflow Response";
    begin
        IF WorkflowResponse.GET(ResponseWorkflowStepInstance."Function Name") THEN
            case WorkflowResponse."Function Name" of

                SetStatusToPendingApprovalCode_F_And_F():
                    begin
                        SetStatusToPendingApproval_F_And_F(Variant);
                        ResponseExecuted := true;
                    end;
                Release_F_And_FCode():
                    begin
                        Release_F_And_F(Variant);
                        ResponseExecuted := true;
                    end;
                ReOpen_F_And_FCode():
                    begin
                        ReOpen_F_And_F(Variant);
                        ResponseExecuted := true;
                    end;
                SendEmailCodeF_And_F():
                    begin
                        SendEmailRFQ(Variant);
                        ResponseExecuted := true;
                    end;
                F_And_FMessageCode():
                    begin
                        F_And_FMessage(Variant);
                        ResponseExecuted := true;
                    end;
                F_And_FSendMessageCode():
                    begin
                        F_And_FSendMessage(Variant);
                        ResponseExecuted := true;
                    end;
                // Avinash Reject Code
                SetStatusToReject_LT_Code_F_And_F():
                    begin
                        Message('Workflow');
                        SetStatusToReject_LT_F_And_F(Variant);
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
            database::"Full and Final Calculation":
                IsSufficient := IsRFQSufficeintApprover(UserSetup, ApprovalEntryArgument."Amount (LCY)");
        end;
    end;
    //Approver ChaIN End

    // Emial Notificaion Creation 05DEC2019 Start

    procedure SendEmailCodeF_And_F(): Code[128]
    begin
        exit(UpperCase('SendEmail_NEW_F_And_F'));
    end;

    procedure SendEmailRFQ(var Variant: Variant)
    var
        RecRef: RecordRef;
        RFQHeader: Record "Full and Final Calculation";
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
            DATABASE::"Full and Final Calculation":
                begin
                    TableId := RecRef.Number;
                    RecRef.SetTable(RFQHeader);
                    ApprovalEntry.Reset();
                    ApprovalEntry.SetRange("Table ID", TableId);
                    ApprovalEntry.SetRange("Document No.", RFQHeader."Employee No.");
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
        FAndF: Record "Full and Final Calculation";
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
            Database::"Full and Final Calculation":
                begin
                    // This is Commented By Avinash
                    // // // // Recref.SetTable(FAndF);
                    // // // // l_ApprovalEntry.Reset();
                    // // // // l_ApprovalEntry.SetRange("Table ID", Recref.Number);
                    // // // // l_ApprovalEntry.SetRange("Document No.", FAndF."Requisition No.");
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