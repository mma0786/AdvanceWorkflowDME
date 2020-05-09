page 60149 "Asset Return"
{
    // version LT_HRMS-P1-008,LT
    PromotedActionCategoriesML = ENU = 'New,Process,Report,Approval,'','','','',Request Approval', ESP = 'New,Process,Report,Approval,'','','','',Request Approval';
    PageType = Card;
    SourceTable = "Asset Assignment Register";
    SourceTableView = WHERE("Transaction Type" = FILTER(Return));

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Return Document No."; "Return Document No.")
                {
                    Caption = 'Document No.';
                    Editable = false;
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        /*PIF AssistEdit(xRec) THEN
                          CurrPage.UPDATE;
                        "Issue Date" := TODAY*/

                    end;
                }
                field("Return Document Date"; "Return Document Date")
                {
                    Caption = 'Document Date';
                    Editable = Edit;
                    ApplicationArea = All;
                }
                field("Transaction Type"; "Transaction Type")
                {
                    Enabled = false;
                    ApplicationArea = All;
                }
                field("Asset Custody Type"; "Asset Custody Type")
                {
                    Caption = 'Return Type';
                    Editable = Edit;
                    ApplicationArea = All;
                }
                field("Issue to/Return by"; "Issue to/Return by")
                {
                    Caption = 'Return By';
                    Editable = Edit;
                    ShowMandatory = true;
                    ApplicationArea = All;
                }
                field("Sub Department"; "Sub Department")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Issue Document Reference"; "Issue Document Reference")
                {
                    Editable = Edit;
                    ShowMandatory = true;
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        AssetAssRegRec2.RESET;
                        AssetAssRegRec2.SETRANGE("Issue Document No.", "Issue Document Reference");
                        AssetAssRegRec2.SETRANGE(Posted, true);
                        if AssetAssRegRec2.FINDFIRST then begin
                            Rec."Document Date" := AssetAssRegRec2."Document Date";
                            Rec."Issue Date" := AssetAssRegRec2."Issue Date";
                            Rec.VALIDATE("Asset Custody Type", AssetAssRegRec2."Asset Custody Type");
                            Rec.VALIDATE("FA No", AssetAssRegRec2."FA No");
                            Rec.VALIDATE(Name, AssetAssRegRec2.Name);
                            Rec.VALIDATE("FA Description", AssetAssRegRec2."FA Description");
                            Rec.VALIDATE("Asset Owner", AssetAssRegRec2."Asset Owner");
                            Rec.VALIDATE("Issue Document No.", AssetAssRegRec2."Issue Document No.");
                            Rec."Posted Issue Document No" := AssetAssRegRec2."Posted Issue Document No";
                            Status := Status::Returned;
                            Rec.VALIDATE("Sub Department", AssetAssRegRec2."Sub Department");
                            Rec."Company Name" := AssetAssRegRec2."Company Name";
                            Rec."Document Date" := AssetAssRegRec2."Document Date";

                        end;
                    end;
                }
                field("Issue Date"; "Issue Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Return Date"; "Return Date")
                {
                    Editable = Edit;
                    ApplicationArea = All;
                }
                field("FA No"; "FA No")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Name; Name)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("FA Description"; "FA Description")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Asset Owner"; "Asset Owner")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Asset Owner Name"; "Asset Owner Name")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Company Name"; "Company Name")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("WorkFlow Status"; "WorkFlow Status")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Posted; Posted)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("Action")
            {
                Caption = 'Action';
                action(Post)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'POST';
                    Ellipsis = true;
                    Enabled = "WorkFlow Status" = "WorkFlow Status"::Released;
                    Image = PostOrder;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    ShortCutKey = 'F9';

                    trigger OnAction();
                    begin

                        // // // // if not ApprovalsMgmt.CheckAARPossiblePosting(Rec) then begin
                        // // // //   TESTFIELD("WorkFlow Status",Rec."WorkFlow Status"::Released);
                        // // // //   Post_Action;
                        // // // //   Rec.DELETE
                        // // // // end else begin
                        // // // //   Post_Action;
                        // // // //   Rec.DELETE
                        // // // // end;
                        TESTFIELD("WorkFlow Status", Rec."WorkFlow Status"::Released);
                        Post_Action;

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
                    Enabled = OpenApprovalEntriesExistForCurrUser;
                    Image = Approve;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    ToolTip = 'Approve the requested changes.';

                    trigger OnAction();
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

                    trigger OnAction();
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

                    trigger OnAction();
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.DelegateRecordApprovalRequest(RECORDID);
                    end;
                }
            }
            group("Request Approval")
            {
                Caption = 'Request Approval';
                Image = SendApprovalRequest;
                action(SendApprovalRequest)
                {
                    ApplicationArea = Suite;
                    Caption = 'Send A&pproval Request';
                    Enabled = "WorkFlow Status" = "WorkFlow Status"::Open;
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category9;
                    ToolTip = 'Send an approval request.';

                    trigger OnAction();
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                        Ass_Ret_Init: Codeunit InitCodeunit_Asset_Return;
                    begin
                        TESTFIELD("Issue Document Reference");
                        TESTFIELD("Issue to/Return by");
                        TESTFIELD("Return Date");
                        AssetAssRegRec2.RESET;
                        AssetAssRegRec2.SETRANGE("Issue Document Reference", "Issue Document Reference");
                        if AssetAssRegRec2.FINDFIRST then begin
                            if AssetAssRegRec2."WorkFlow Status" <> AssetAssRegRec2."WorkFlow Status"::Open then
                                ERROR('Asset Return Request is Process %1', AssetAssRegRec2."Return Document No.");
                        end;

                        FixedAssetRec.RESET;
                        if FixedAssetRec.GET("FA No") then begin
                            if (FixedAssetRec."Issued to Department" = '') and (FixedAssetRec."Issued to Employee" = '') then
                                ERROR('Asset has been returned')
                        end;

                        TESTFIELD("Issue Document Reference");
                        TESTFIELD("FA No");
                        TESTFIELD("Issue to/Return by");
                        TESTFIELD("Issue Date");
                        TESTFIELD("Document Date");
                        //RecordID Update
                        RecordIDUpDate(Rec);

                        AssetAssRegRec2.RESET;
                        AssetAssRegRec2.SETRANGE("FA No", Rec."FA No");
                        AssetAssRegRec2.SETRANGE("WorkFlow Status", AssetAssRegRec2."WorkFlow Status"::Released);
                        AssetAssRegRec2.SETRANGE("Transaction Type", AssetAssRegRec2."Transaction Type"::Return);
                        if AssetAssRegRec2.FINDFIRST then
                            ERROR('The Asset return request is already in process %1', "FA No");

                        // Start #Levtech WF
                        CancelAndDeleteApprovalEntryTrans_LT("Return Document No.");
                        // Stop #Levtech WF

                        //<LT_Bc_Wf_Code>
                        Ass_Ret_Init.IsAssetReturn_Enabled(Rec);
                        Ass_Ret_Init.OnSendAssetReturn_Approval(Rec);
                        //<LT_Bc_Wf_Code>
                        // // // // // if ApprovalsMgmt.CheckAARPossible(Rec) then begin
                        // // // // //     // Start #Levtech  WF
                        // // // // //     LoopOfSeq_LT("Asset Owner", "Return Document No.");
                        // // // // //     // Stop #Levtech WF
                        // // // // //     ApprovalsMgmt.OnSendAARForApproval(Rec);
                        // // // // // end;

                        //CurrPage.UPDATE;
                        //VALIDATE("WorkFlow Status");
                    end;
                }
                action(CancelApprovalRequest)
                {
                    ApplicationArea = Suite;
                    Caption = 'Cancel Approval Re&quest';
                    Enabled = "WorkFlow Status" = "WorkFlow Status"::"Pending Approval";
                    Image = CancelApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category9;
                    ToolTip = 'Cancel the approval request.';

                    trigger OnAction();
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                        Ass_Ret_Init: Codeunit InitCodeunit_Asset_Return;
                    begin
                        // // // // ApprovalsMgmt.OnCancelAARApprovalRequest(Rec);
                        //<LT_Bc_Wf_Code>
                        Ass_Ret_Init.OnCancelAssetReturn_Approval(Rec);
                        //<LT_Bc_Wf_Code>
                        // Start #Levtech WF
                        CancelAndDeleteApprovalEntryTrans_LT("Return Document No.");
                        // Stop #Levtech WF
                        CurrPage.UPDATE;
                    end;
                }
                action(Approvals)
                {
                    AccessByPermission = TableData "Approval Entry" = R;
                    ApplicationArea = Suite;
                    Promoted = true;
                    PromotedCategory = Category4;
                    Caption = 'Approvals';
                    Image = Approvals;
                    ToolTip = 'View a list of the records that are waiting to be approved. For example, you can see who requested the record to be approved, when it was sent, and when it is due to be approved.';

                    trigger OnAction()
                    var
                        ApprovalEntry: Record "Approval Entry";
                    begin
                        ApprovalEntry.RESET;
                        ApprovalEntry.SETRANGE("Table ID", RecID.TABLENO);
                        ApprovalEntry.SetRange("Record ID to Approve", Rec.RecID);
                        if ApprovalEntry.FindSet() then begin
                            PAGE.RUNMODAL(658, ApprovalEntry);
                        end;
                    end;
                }
                action(Comments)
                {
                    ApplicationArea = Suite;
                    Caption = 'Comments';
                    Image = ViewComments;
                    ToolTip = 'View or add comments.';

                    trigger OnAction();
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
                action(Reopen)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Re&open';
                    Enabled = "WorkFlow Status" <> "WorkFlow Status"::Open;
                    Image = ReOpen;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;
                    ToolTip = 'Reopen the document to change it after it has been approved. Approved documents have the Released status and must be opened before they can be changed.';

                    trigger OnAction();
                    var
                        ReleaseSalesDoc: Codeunit "Release Sales Document";
                    begin
                        if "WorkFlow Status" = "WorkFlow Status"::"Pending Approval" then
                            ERROR('WorkFlow status should be Approved for reopen');

                        "WorkFlow Status" := "WorkFlow Status"::Open;
                    end;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord();
    begin
        SetControlVisibility;

        if "WorkFlow Status" = "WorkFlow Status"::Open then
            Edit := true
        else
            Edit := false;
    end;

    trigger OnAfterGetRecord();
    begin
        SetControlVisibility;

        if "WorkFlow Status" = "WorkFlow Status"::Open then
            Edit := true
        else
            Edit := false;
    end;

    trigger OnNewRecord(BelowxRec: Boolean);
    begin
        "Transaction Type" := "Transaction Type"::Return;
        "Document Date" := TODAY;
        "Return Date" := TODAY;
        "Return Document Date" := TODAY;
    end;

    trigger OnOpenPage();
    begin
        SetControlVisibility;
    end;

    var
        NoSeriesRec: Record "No. Series";
        NoSeriesCU: Codeunit NoSeriesManagement;
        FASetup: Record "FA Setup";
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        CanCancelApprovalForRecord: Boolean;
        editable: Boolean;
        AssetAssRegRec2: Record "Asset Assignment Register";
        [InDataSet]
        Edit: Boolean;
        FixedAssetRec: Record "Fixed Asset";
        FA_Rec: Record "Fixed Asset";
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        i: Integer;

    local procedure SetControlVisibility();
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    begin
        OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(RECORDID);
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(RECORDID);
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(RECORDID);
    end;

    procedure RecordIDUpDate(var AssetAssignmentRegister: Record "Asset Assignment Register");
    var
        RecRef: RecordRef;
    begin
        RecRef.GETTABLE(AssetAssignmentRegister);
        AssetAssignmentRegister.RecID := RecRef.RECORDID;
        AssetAssignmentRegister.MODIFY(true);
    end;

    local procedure Post_Action();
    var
        AssetAssRegRec: Record "Asset Assignment Register";
        Asseton: Text;
        PostedRetDocNo: Code[10];
    begin
        IF Rec.Posted = true then
            Error('Asset have been Retuned');
        AssetAssRegRec.INIT;
        AssetAssRegRec."Issue Document No." := "Issue Document No.";
        AssetAssRegRec."Posted Issue Document No" := "Posted Issue Document No";
        AssetAssRegRec.VALIDATE("Return Document No.", "Return Document No.");
        FASetup.GET;
        AssetAssRegRec."Posted Return Document No" := NoSeriesCU.GetNextNo(FASetup."Posted Return Document No", WORKDATE, true);
        AssetAssRegRec."Transaction Type" := AssetAssRegRec."Transaction Type"::Issue;
        AssetAssRegRec."Document Date" := "Document Date";
        AssetAssRegRec."Issue Date" := "Issue Date";
        AssetAssRegRec."Posting Date" := "Posting Date";
        AssetAssRegRec."FA No" := "FA No";
        AssetAssRegRec."Return Date" := "Return Date";
        if "Asset Custody Type" = "Asset Custody Type"::Employee then
            AssetAssRegRec."Asset Custody Type" := AssetAssRegRec."Asset Custody Type"::Employee
        else
            AssetAssRegRec."Asset Custody Type" := AssetAssRegRec."Asset Custody Type"::Department;
        AssetAssRegRec."Issue to/Return by" := "Issue to/Return by";
        AssetAssRegRec.Name := Name;
        AssetAssRegRec."Issued Till" := "Issued Till";
        AssetAssRegRec."Asset Owner" := "Asset Owner";
        AssetAssRegRec."Company Name" := "Company Name";
        AssetAssRegRec."Asset Owner Employee" := "Asset Owner Employee";
        AssetAssRegRec."Return Document Date" := "Return Document Date";
        AssetAssRegRec."FA Description" := "FA Description";
        AssetAssRegRec.Posted := true;
        AssetAssRegRec."Issue Document Reference" := "Issue Document Reference";
        AssetAssRegRec."Asset Owner Name" := "Asset Owner Name";
        AssetAssRegRec.Status := AssetAssRegRec.Status::Returned;
        AssetAssRegRec.VALIDATE("Sub Department", "Sub Department");
        if AssetAssRegRec.INSERT then begin
            //IF "Asset Custody Type" = "Asset Custody Type"::Employee THEN BEGIN
            if FA_Rec.GET("FA No") then begin
                FA_Rec."Asset Custody" := FA_Rec."Asset Custody"::Employer;
                FA_Rec."Issued to Department" := '';
                FA_Rec."Issued to Employee" := '';
                if FA_Rec.MODIFY then begin
                    Message('POSTED');
                    Rec.Delete();
                end;



            end;
            //END;
            Rec.Posted := true;
            AssetAssRegRec.RESET;
            AssetAssRegRec.SETRANGE("Issue Document No.", "Issue Document No.");
            AssetAssRegRec.SETRANGE("Posted Issue Document No", "Posted Issue Document No");
            AssetAssRegRec.SETRANGE("Return Document No.", '');
            AssetAssRegRec.SETRANGE("Posted Return Document No", '');
            if AssetAssRegRec.FINDSET then begin
                repeat
                    AssetAssRegRec.DELETE;
                until AssetAssRegRec.NEXT = 0;
            end;
        end;
    end;

    local procedure "#************Workflow*******************"();
    begin
    end;

    procedure GetEmployeePostionEmployeeID_LT(EmployeeID: Code[30]): Code[50];
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

    procedure InsertApprovalEntryTrans_LT(TransID: Code[30]; SenderID: Code[50]; ReportingID: Code[50]; DelegateID: Code[50]; SequenceID: Integer);
    var
        ApprovalEntrtyTranscationRec_L: Record "Approval Entrty Transcation";
    begin
        ApprovalEntrtyTranscationRec_L.RESET;
        ApprovalEntrtyTranscationRec_L.INIT;
        ApprovalEntrtyTranscationRec_L."Trans ID" := TransID;
        ApprovalEntrtyTranscationRec_L."Advance Payrolll Type" := ApprovalEntrtyTranscationRec_L."Advance Payrolll Type"::Leaves;
        ApprovalEntrtyTranscationRec_L."Employee ID - Sender" := SenderID;
        ApprovalEntrtyTranscationRec_L."Reporting ID - Approver" := ReportingID;
        ApprovalEntrtyTranscationRec_L."Delegate ID" := DelegateID;
        ApprovalEntrtyTranscationRec_L."Sequence No." := SequenceID;
        ApprovalEntrtyTranscationRec_L.INSERT;
    end;

    procedure LoopOfSeq_LT(EmpID: Code[50]; TransID: Code[30]);
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
        ApprovalLevelSetupRec_L.SETRANGE("Advance Payrolll Type", ApprovalLevelSetupRec_L."Advance Payrolll Type"::"Asset Issue");
        if ApprovalLevelSetupRec_L.FINDFIRST then begin
            UserSetupRec_L.RESET;
            UserSetupRec_L.SETRANGE("Employee Id", EmpID);
            if not UserSetupRec_L.FINDFIRST then
                ERROR('Employee Id  %1 must have a value in User Setup', EmpID);

            UserSetupRec_L.TESTFIELD("User ID");
            Delegate_L := CheckDelegateForEmployee_LT(EmpID);
            if not ApprovalLevelSetupRec_L."Direct Approve By Finance" then begin
                InsertApprovalEntryTrans_LT(TransID,
                                           USERID,
                                           UserSetupRec_L."User ID",
                                           Delegate_L,
                                           SeqNo_L);

                if (ApprovalLevelSetupRec_L."Finance User ID" <> '') then
                    InsertApprovalEntryTrans_LT(TransID,
                                               USERID,
                                               ApprovalLevelSetupRec_L."Finance User ID",
                                               Delegate_L,
                                               SeqNo_L);

            end;

            if (ApprovalLevelSetupRec_L."Finance User ID" <> '') and (ApprovalLevelSetupRec_L."Direct Approve By Finance") then begin
                InsertApprovalEntryTrans_LT(TransID,
                                           USERID,
                                           ApprovalLevelSetupRec_L."Finance User ID",
                                           Delegate_L,
                                           SeqNo_L);

            end

        end;
    end;

    procedure CancelAndDeleteApprovalEntryTrans_LT(DocNo_P: Code[50]);
    var
        ApprovalEntrtyTranscation: Record "Approval Entrty Transcation";
    begin
        ApprovalEntrtyTranscation.RESET;
        ApprovalEntrtyTranscation.SETRANGE("Trans ID", DocNo_P);
        if ApprovalEntrtyTranscation.FINDSET then
            ApprovalEntrtyTranscation.DELETEALL;
    end;

    procedure CheckDelegateForEmployee_LT(EmployeeCode_P: Code[30]): Code[80];
    var
        DelegateWFLTRec_L: Record "Delegate - WFLT";
    begin
        DelegateWFLTRec_L.RESET;
        DelegateWFLTRec_L.SETRANGE("Employee Code", EmployeeCode_P);
        if DelegateWFLTRec_L.FINDFIRST then
            exit(DelegateWFLTRec_L."Delegate ID");
    end;

    procedure GetEmployeePostionEmployeeID_FinalPosituion_LT(EmployeeID: Code[30]): Boolean;
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

