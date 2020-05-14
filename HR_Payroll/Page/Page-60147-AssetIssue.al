page 60147 "Asset Issue"
{
    Caption = 'Asset Issue';
    DeleteAllowed = true;
    ModifyAllowed = true;
    PageType = Card;
    SourceTable = "Asset Assignment Register";
    SourceTableView = SORTING("Issue Document No.", "Posted Issue Document No", "Return Document No.", "Posted Return Document No")
                      ORDER(Ascending);
    // // UsageCategory = Documents;
    // // ApplicationArea = All;
    PromotedActionCategoriesML = ENU = 'New,Process,Report,Approval,'','','','',Request Approval', ESP = 'New,Process,Report,Approval,'','','','',Request Approval';
    layout
    {
        area(content)
        {
            group(General)
            {
                field("Issue Document No."; "Issue Document No.")
                {
                    Caption = 'Document No.';
                    Editable = false;
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        /*IF AssistEdit(xRec) THEN
                          CurrPage.UPDATE;
                        "Issue Date" := TODAY
                        */

                    end;
                }
                field("Transaction Type"; "Transaction Type")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("FA No"; "FA No")
                {
                    Caption = 'Fixed Asset No.';
                    Editable = Edit;
                    ShowMandatory = true;
                    ApplicationArea = All;
                    TableRelation = "Fixed Asset" where("Asset Custody" = filter(Employer));
                    trigger OnValidate()
                    begin
                        AssetAssiReg.RESET;
                        AssetAssiReg.SETRANGE("FA No", Rec."FA No");
                        if AssetAssiReg.FINDSET then begin
                            repeat
                                if AssetAssiReg."WorkFlow Status" <> AssetAssiReg."WorkFlow Status"::Open then begin

                                    if AssetAssiReg."Asset Custody Type" = AssetAssiReg."Asset Custody Type"::Employee then begin
                                        Employee.RESET;
                                        if Employee.GET(AssetAssiReg."Issue to/Return by") then;
                                        ERROR('This Asset has been requested by  %2 - %1', Employee.FullName, Employee."No.");
                                    end else begin
                                        if AssetAssiReg."Asset Custody Type" = AssetAssiReg."Asset Custody Type"::Department then begin
                                            PayrollDepartment.RESET;
                                            if PayrollDepartment.GET(AssetAssiReg."Issue to/Return by") then;
                                            ERROR('This Asset has been requested by %1', PayrollDepartment.Description);
                                        end;
                                    end;

                                end;
                            until AssetAssiReg.NEXT = 0;
                        end;
                    end;
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
                    trigger OnDrillDown()
                    var
                        Employee: Record Employee;
                    begin
                        Employee.RESET;
                        Employee.SETRANGE("No.", "Asset Owner");
                        if Employee.FINDFIRST then
                            PAGE.RUNMODAL(5201, Employee);
                    end;

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        Employee: Record Employee;
                    begin
                        Employee.RESET;
                        Employee.SETRANGE("No.", "Asset Owner");
                        if Employee.FINDFIRST then
                            PAGE.RUNMODAL(5201, Employee);
                    end;
                }
                field("Asset Owner Name"; "Asset Owner Name")
                {
                    Enabled = false;
                    ApplicationArea = All;
                }
                field("Company Name"; "Company Name")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Asset Custody Type"; "Asset Custody Type")
                {
                    Caption = 'Issue Type';
                    Editable = Edit;
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        /*IF ("Transaction Type" = "Transaction Type"::Issue) AND ("Asset Custody Type" = "Asset Custody Type"::Department) THEN
                          ERROR('Asset is not available for issue');
                         */

                    end;
                }
                field("Issue to/Return by"; "Issue to/Return by")
                {
                    Caption = 'Issue to';
                    Editable = Edit;
                    ShowMandatory = true;
                    ApplicationArea = All;
                }
                field(Name; Name)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Sub Department"; "Sub Department")
                {
                    Editable = Edit2;
                    ApplicationArea = All;
                }
                field("Sub Department Name"; "Sub Department Name")
                {
                    Enabled = false;
                    ApplicationArea = All;
                }
                field("Document Date"; "Document Date")
                {
                    Editable = Edit;
                    ApplicationArea = All;
                }
                field("Issue Date"; "Issue Date")
                {
                    Editable = Edit;
                    ShowMandatory = true;
                    ApplicationArea = All;
                }
                field("Issued Till"; "Issued Till")
                {
                    Editable = Edit;
                    ApplicationArea = All;
                }
                field("WorkFlow Status"; "WorkFlow Status")
                {
                    Editable = false;
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        if "WorkFlow Status" = "WorkFlow Status"::Released then
                            PostAction := true;
                    end;
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

                    trigger OnAction()
                    begin
                        IF "WorkFlow Status" = "WorkFlow Status"::Released THEN
                            Post_Action
                        ELSE
                            ERROR('Workflow Status should be Released')

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
                    PromotedOnly = true;
                    ToolTip = 'Send an approval request.';

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                        Ass_Iss_Init: Codeunit InitCodeunit_Asset_Issue;
                    begin
                        TESTFIELD("Issue Document No.");
                        TESTFIELD("FA No");
                        TESTFIELD("Issue to/Return by");
                        TESTFIELD("Issue Date");
                        TESTFIELD("Document Date");
                        //RecordID Update

                        RecordIDUpDate(Rec);
                        AssetAssiReg.RESET;
                        AssetAssiReg.SETRANGE("FA No", Rec."FA No");
                        //Error('Testing');
                        if AssetAssiReg.FINDSET then begin
                            repeat
                                if AssetAssiReg."WorkFlow Status" <> AssetAssiReg."WorkFlow Status"::Open then
                                    if AssetAssiReg."Asset Custody Type" = AssetAssiReg."Asset Custody Type"::Employee then begin
                                        Employee.RESET;
                                        if Employee.GET(AssetAssiReg."Issue to/Return by") then;
                                        ERROR('This Asset has been requested by  %2 - %1', Employee.FullName, Employee."No.");
                                    end else begin
                                        if AssetAssiReg."Asset Custody Type" = AssetAssiReg."Asset Custody Type"::Department then begin
                                            PayrollDepartment.RESET;
                                            if PayrollDepartment.GET(AssetAssiReg."Issue to/Return by") then;
                                            ERROR('This Asset has been requested by %1', PayrollDepartment.Description);
                                        end;
                                    end;
                            until AssetAssiReg.NEXT = 0;
                        end;

                        FixedAssetRec.RESET;
                        if FixedAssetRec.GET(Rec."FA No") then begin
                            //commented By Avinash
                            if (FixedAssetRec."Issued to Department" <> '') or (FixedAssetRec."Issued to Employee" <> '') then
                                ERROR('Asset has been issued to other Employee or Department');
                            //commented By Avinash
                        end;

                        // Start Working With Customization

                        // Start #Levtech WF
                        CancelAndDeleteApprovalEntryTrans_LT("Issue Document No.");
                        // Stop #Levtech WF

                        //commented By Avinash 
                        //commented By Avinash   if ApprovalsMgmt.CheckAARPossible(Rec) then begin
                        FixedAssetRec_G.RESET;
                        FixedAssetRec_G.SETRANGE("No.", "FA No");
                        if FixedAssetRec_G.FINDFIRST then begin
                            // Start #Levtech  WF
                            LoopOfSeq_LT("Asset Owner", "Issue Document No.");
                            // Stop #Levtech WF
                            // UpdateUserIDBaseOnResponsiableEmployee_LT(FixedAssetRec_G."Responsible Employee");

                            //commented By Avinash    
                            //Ass_Iss_Init.OnSend_Asset_Issue_Approval(Rec);

                            //commented By Avinash   end;
                            Ass_Iss_Init.IsAssetIssueApprovalWorkflowEnabled(Rec);
                            Ass_Iss_Init.OnSendAssetIssue_Approval(Rec);
                        end;
                        //  Ass_Iss_Init.OnCancel_Asset_Issue_Approval(Rec);

                    End;

                }
                action(CancelApprovalRequest)
                {
                    ApplicationArea = Suite;
                    Caption = 'Cancel Approval Re&quest';
                    Enabled = "WorkFlow Status" = "WorkFlow Status"::"Pending For Approval";
                    Image = CancelApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category9;
                    PromotedOnly = true;
                    ToolTip = 'Cancel the approval request.';

                    trigger OnAction()
                    var
                        Ass_Iss_Init: Codeunit InitCodeunit_Asset_Issue;

                    begin
                        //commented By Avinash  ApprovalsMgmt.OnCancelAARApprovalRequest(Rec);
                        Ass_Iss_Init.OnCancelAssetIssue_Approval(Rec);
                        //"WorkFlow Status" := "WorkFlow Status"::Open;
                        Cancel := true;

                        // Start #Levtech WF
                        //CancelAndDeleteApprovalEntryTrans_LT("Issue Document No.");
                        // Stop #Levtech WF
                        //   Ass_Iss_Init.OnCancel_Asset_Issue_Approval(Rec);
                    end;
                }
                action(Approvals)
                {
                    AccessByPermission = TableData "Approval Entry" = R;
                    ApplicationArea = Suite;
                    Caption = 'Approvals';
                    Promoted = true;
                    PromotedCategory = Category4;
                    Image = Approvals;
                    ToolTip = 'View a list of the records that are waiting to be approved. For example, you can see who requested the record to be approved, when it was sent, and when it is due to be approved.';

                    trigger OnAction()
                    var
                        GenJournalLine: Record "Gen. Journal Line";
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                        ApprovalEntry: Record "Approval Entry";
                    begin
                        ApprovalEntry.Reset();
                        ApprovalEntry.SETRANGE("Table ID", DATABASE::"Asset Assignment Register");
                        ApprovalEntry.SETRANGE("Record ID to Approve", Rec.RecordId);
                        ApprovalEntry.SETRANGE("Related to Change", FALSE);
                        PAGE.RUN(70010, ApprovalEntry);
                    end;
                }
                // Avinash
                action(ApprovalsDelete)
                {
                    AccessByPermission = TableData "Approval Entry" = R;
                    ApplicationArea = Suite;
                    Caption = 'Approvals Delete';
                    Image = Delete;
                    Visible = false;

                    trigger OnAction()
                    var
                        GenJournalLine: Record "Gen. Journal Line";
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                        ApprovalEntry: Record "Approval Entry";
                    begin
                        if Confirm('you want to delete all recors ?') then begin
                            ApprovalEntry.RESET;
                            ApprovalEntry.DeleteAll();
                        end;

                    end;
                }
                // Avinash

                action(Comments)
                {
                    ApplicationArea = Suite;
                    Caption = 'Comments';
                    Image = ViewComments;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    Scope = Repeater;
                    ToolTip = 'View or add comments.';

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";

                        RecRef: RecordRef;
                        ApprovalEntry: Record "Approval Entry";
                        RecID: RecordID;
                        InitialiseAllCodeunit: Codeunit InitialiseAllCodeunit;
                    begin
                        InitialiseAllCodeunit.Run();
                        /*
                        RecRef.GET(Rec.RECORDID);
                        RecID := RecRef.RECORDID;
                        //CLEAR(Wf_Cu);
                        ApprovalEntry.RESET;
                        ApprovalEntry.SETRANGE("Table ID", RecID.TABLENO);
                        //ApprovalEntry.SETRANGE("Record ID to Approve", RecRef.RECORDID);
                        //ApprovalEntry.SETRANGE(Status,ApprovalEntry.Status::Open);
                        //ApprovalEntry.SETRANGE("Approver ID",USERID);
                        //ApprovalEntry.SETRANGE("Related to Change", false);
                        if ApprovalEntry.FINDFIRST then
                            ApprovalsMgmt.GetApprovalCommentForWorkflowStepInstanceID(RecRef, ApprovalEntry."Workflow Step Instance ID");
                    
                    */
                    end;
                }
                action(Reopen)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Re&open';
                    Enabled = PostAction;
                    Image = ReOpen;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;
                    ToolTip = 'Reopen the document to change it after it has been approved. Approved documents have the Released status and must be opened before they can be changed.';

                    trigger OnAction()
                    var
                        ReleaseSalesDoc: Codeunit "Release Sales Document";
                    begin
                        if "WorkFlow Status" = "WorkFlow Status"::"Pending For Approval" then
                            ERROR('WorkFlow status should be Approved for reopen');

                        "WorkFlow Status" := "WorkFlow Status"::Open;
                    end;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        SetControlVisibility;


        if "WorkFlow Status" = "WorkFlow Status"::Open then
            Edit := true
        else
            Edit := false;

        if ("WorkFlow Status" = "WorkFlow Status"::Open) and ("Asset Custody Type" <> "Asset Custody Type"::Employee) then
            Edit2 := true
        else
            Edit2 := false;

        if ("WorkFlow Status" = "WorkFlow Status"::Rejected) or ("WorkFlow Status" = "WorkFlow Status"::Released) then
            PostAction := true;

        //CurrPage.UPDATE;
        //IF Cancel THEN
        //"WorkFlow Status" := "WorkFlow Status"::Open;
    end;

    trigger OnAfterGetRecord()
    begin
        SetControlVisibility;

        if "WorkFlow Status" = "WorkFlow Status"::Open then
            Edit := true
        else
            Edit := false;

        if ("WorkFlow Status" = "WorkFlow Status"::Open) and ("Asset Custody Type" <> "Asset Custody Type"::Employee) then
            Edit2 := true
        else
            Edit2 := false;
        if ("WorkFlow Status" = "WorkFlow Status"::Rejected) or ("WorkFlow Status" = "WorkFlow Status"::Released) then
            PostAction := true;

        //CurrPage.UPDATE;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        if ("WorkFlow Status" = "WorkFlow Status"::Rejected) or ("WorkFlow Status" = "WorkFlow Status"::Released) then
            PostAction := true;
        //IF Cancel THEN
        //"WorkFlow Status" := "WorkFlow Status"::Open;
    end;

    trigger OnModifyRecord(): Boolean
    begin
        /*IF "WorkFlow Status" <> "WorkFlow Status"::Open THEN BEGIN
          RecRef.GETTABLE(Rec);
          RecordLinkRec.SETRANGE("Record ID",RecRef.RECORDID);*/
        //IF RecordLinkRec.FINDFIRST THEN

        //IF Cancel THEN
        // "WorkFlow Status" := "WorkFlow Status"::Open;


    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        "Document Date" := TODAY;
        "Issue Date" := TODAY;
    end;

    trigger OnOpenPage()
    begin
        SetControlVisibility;
        if ("WorkFlow Status" = "WorkFlow Status"::Rejected) or ("WorkFlow Status" = "WorkFlow Status"::Released) then
            PostAction := true;
    end;

    var
        //ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        // Wf_Cu: Codeunit Cu_AAR_Wf_2;
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        CanCancelApprovalForRecord: Boolean;
        NoSeriesRec: Record "No. Series";
        NoSeriesCU: Codeunit NoSeriesManagement;
        FASetup: Record "FA Setup";
        ReleaseSalesDoc: Codeunit "Release Sales Document";
        AssetAssiReg: Record "Asset Assignment Register";
        [InDataSet]
        Edit: Boolean;
        RecRef: RecordRef;
        RecordLinkRec: Record "Record Link";
        FA_Rec: Record "Fixed Asset";
        [InDataSet]
        PostAction: Boolean;
        FixedAssetRec: Record "Fixed Asset";
        EmployeeRec: Record Employee;
        Cancel: Boolean;
        SubDepRec: Record "Sub Department";
        [InDataSet]
        Edit2: Boolean;
        Employee: Record Employee;
        PayrollDepartment: Record "Payroll Department";
        FixedAssetRec_G: Record "Fixed Asset";
        ___________Customise_Work_flow_____________: Boolean;
        i: Integer;

    local procedure SetControlVisibility()
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    //  Wf_Cu: Codeunit Cu_AAR_Wf_2;
    begin
        OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(RECORDID);
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(RECORDID);
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(RECORDID);


        /*IF "WorkFlow Status" = "WorkFlow Status"::Rejected THEN
          "WorkFlow Status" := "WorkFlow Status"::Open
          */

    end;

    local procedure Post_Action()
    var
        AssetAssRegRec: Record "Asset Assignment Register";
    begin

        AssetAssRegRec.INIT;
        AssetAssRegRec."Issue Document No." := "Issue Document No.";
        FASetup.GET;
        //commented By Avinash 
        AssetAssRegRec."Posted Issue Document No" := NoSeriesCU.GetNextNo(FASetup."Posted Issue Document No", WORKDATE, false);
        AssetAssRegRec.VALIDATE("FA No", "FA No");

        AssetAssRegRec."FA Description" := "FA Description";
        AssetAssRegRec."Asset Owner" := "Asset Owner";
        AssetAssRegRec.Posted := true;
        AssetAssRegRec."Asset Custody Type" := "Asset Custody Type";
        AssetAssRegRec."Posting Date" := WORKDATE;
        AssetAssRegRec."Posting Date" := WORKDATE;
        AssetAssRegRec."Company Name" := "Company Name";
        AssetAssRegRec."Issue to/Return by" := "Issue to/Return by";
        AssetAssRegRec.Name := Name;
        AssetAssRegRec."Document Date" := "Document Date";

        AssetAssRegRec."Issue Date" := "Issue Date";
        AssetAssRegRec."Issued Till" := "Issued Till";
        AssetAssRegRec.Status := AssetAssRegRec.Status::Issued;
        AssetAssRegRec.VALIDATE("Posting Date", TODAY);
        AssetAssRegRec."Asset Owner" := "Asset Owner";
        AssetAssRegRec."Sub Department" := "Sub Department";
        if AssetAssRegRec.INSERT then begin
            CurrPage.Update();

            if "Asset Custody Type" = "Asset Custody Type"::Employee then begin
                FA_Rec.RESET;
                if FA_Rec.GET("FA No") then begin
                    //commented By Avinash
                    FA_Rec."Asset Custody" := FA_Rec."Asset Custody"::Employee;
                    FA_Rec."Issued to Employee" := "Issue to/Return by";
                    FA_Rec."Issued to Department" := '';
                    if FA_Rec.MODIFY then begin
                        Message('POSTED');
                        Rec.Delete()
                    End;
                    //commented By Avinash
                end;
            end else
                if "Asset Custody Type" = "Asset Custody Type"::Department then begin
                    if FA_Rec.GET("FA No") then begin
                        //commented By Avinash
                        FA_Rec."Asset Custody" := FA_Rec."Asset Custody"::Department;
                        FA_Rec."Issued to Department" := "Issue to/Return by";
                        FA_Rec."Issued to Employee" := '';
                        if FA_Rec.MODIFY then begin
                            Message('POSTED');
                            Rec.Delete()
                        end;
                        //commented By Avinash
                    end;
                end;
        end;

    end;

    //commented By Avinash  [Scope('Internal')]
    procedure ShowRecord()
    var
        RecRef: RecordRef;
    begin
    end;

    //commented By Avinash  [Scope('Internal')]
    procedure RecordIDUpDate(var AssetAssignmentRegister: Record "Asset Assignment Register")
    var
        RecRef: RecordRef;
    begin
        RecRef.GETTABLE(AssetAssignmentRegister);
        AssetAssignmentRegister.RecID := RecRef.RECORDID;
        AssetAssignmentRegister.MODIFY(true);
    end;

    local procedure UpdateUserIDBaseOnResponsiableEmployee_LT(EmployeeNo_P: Code[30])
    var
        WorkflowUserGroupRec_L: Record "Workflow User Group";
        WorkflowUserGroupMemberRec_L: Record "Workflow User Group Member";
        WorkflowTableRelationValueRec_L: Record "Workflow Table Relation Value";
        UserSetupRec_L: Record "User Setup";
        WorkflowStepArgument: Record "Workflow Step Argument";
    begin
        //MESSAGE('inside fun');
        UserSetupRec_L.RESET;
        //commented By Avinash  UserSetupRec_L.SETRANGE("Employee Id", EmployeeNo_P);
        if not UserSetupRec_L.FINDFIRST then
            ERROR('Employee %1 Not have any User ID in  User Setup', EmployeeNo_P)
        else begin
            // MESSAGE('else %1',DATABASE::"Asset Assignment Register");
            // WorkflowTableRelationValueRec_L.RESET;
            // WorkflowTableRelationValueRec_L.SETCURRENTKEY("Table ID");
            //WorkflowTableRelationValueRec_L.SETRANGE("Table ID",DATABASE::"Asset Assignment Register");
            // IF WorkflowTableRelationValueRec_L.FINDFIRST THEN BEGIN
            // MESSAGE(' Workflow %1',WorkflowTableRelationValueRec_L."Workflow Code");
            WorkflowStepArgument.RESET;
            //commented By Avinash  WorkflowStepArgument.SETRANGE("Table No.", DATABASE::Table50075);
            if WorkflowStepArgument.FINDFIRST then;
            WorkflowUserGroupMemberRec_L.RESET;
            WorkflowUserGroupMemberRec_L.SETRANGE("Workflow User Group Code", WorkflowStepArgument."Workflow User Group Code");
            WorkflowUserGroupMemberRec_L.SETRANGE("Sequence No.", 1);
            if WorkflowUserGroupMemberRec_L.FINDFIRST then begin
                // MESSAGE('Update');
                WorkflowUserGroupMemberRec_L.RENAME(WorkflowStepArgument."Workflow User Group Code", UserSetupRec_L."User ID");
                WorkflowUserGroupMemberRec_L.VALIDATE("User Name", UserSetupRec_L."User ID");
                WorkflowUserGroupMemberRec_L.MODIFY;
            end else begin
                // MESSAGE('insert  %1    %2  p  %3',UserSetupRec_L."User ID",UserSetupRec_L."Employee Id",EmployeeNo_P);
                WorkflowUserGroupMemberRec_L.INIT;
                WorkflowUserGroupMemberRec_L.VALIDATE("Workflow User Group Code", WorkflowStepArgument."Workflow User Group Code");
                WorkflowUserGroupMemberRec_L.VALIDATE("User Name", UserSetupRec_L."User ID");
                WorkflowUserGroupMemberRec_L.VALIDATE("Sequence No.", 1);
                WorkflowUserGroupMemberRec_L.INSERT;//(TRUE);
            end;
        end;
        //END;
    end;

    local procedure "#************Workflow*******************"()
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
        ApprovalEntrtyTranscationRec_L."Advance Payrolll Type" := ApprovalEntrtyTranscationRec_L."Advance Payrolll Type"::Leaves;
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
        ApprovalLevelSetupRec_L.SETRANGE("Advance Payrolll Type", ApprovalLevelSetupRec_L."Advance Payrolll Type"::"Asset Issue");
        if ApprovalLevelSetupRec_L.FINDFIRST then begin

            UserSetupRec_L.RESET;
            //commented By Avinash   UserSetupRec_L.SETRANGE("Employee Id", EmpID);
            if not UserSetupRec_L.FINDFIRST then
                ERROR('Employee Id  %1 must have a value in User Setup', EmpID);

            UserSetupRec_L.TESTFIELD("User ID");

            if not ApprovalLevelSetupRec_L."Direct Approve By Finance" then begin

                // Checking Current User Delegate
                CLEAR(Delegate_L);
                if CheckDelegateForEmployee_LT(UserSetupRec_L."User ID", 2) <> '' then
                    Delegate_L := CheckDelegateForEmployee_LT(UserSetupRec_L."User ID", 2)
                else
                    Delegate_L := UserSetupRec_L."User ID";
                InsertApprovalEntryTrans_LT(TransID, USERID, UserSetupRec_L."User ID", Delegate_L, SeqNo_L);

                // Start Finance Person
                if (ApprovalLevelSetupRec_L."Finance User ID" <> '') then begin
                    CLEAR(Delegate_L);
                    if CheckDelegateForEmployee_LT(ApprovalLevelSetupRec_L."Finance User ID", 2) <> '' then
                        Delegate_L := CheckDelegateForEmployee_LT(UserSetupRec_L."User ID", 2)
                    else
                        Delegate_L := ApprovalLevelSetupRec_L."Finance User ID";
                    InsertApprovalEntryTrans_LT(TransID, USERID, ApprovalLevelSetupRec_L."Finance User ID", Delegate_L, SeqNo_L);
                end
                // Stop Finance Person
            end;

            if (ApprovalLevelSetupRec_L."Finance User ID" <> '') and (ApprovalLevelSetupRec_L."Direct Approve By Finance") then begin
                CLEAR(Delegate_L);
                if CheckDelegateForEmployee_LT(ApprovalLevelSetupRec_L."Finance User ID", 2) <> '' then
                    Delegate_L := CheckDelegateForEmployee_LT(UserSetupRec_L."User ID", 2)
                else
                    Delegate_L := ApprovalLevelSetupRec_L."Finance User ID";
                InsertApprovalEntryTrans_LT(TransID, USERID, ApprovalLevelSetupRec_L."Finance User ID", Delegate_L, SeqNo_L);
            end

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
    procedure CheckDelegateForEmployee_LT(checkDelegateInfo_P: Code[150]; IsEmployeeOrUser: Integer): Code[80]
    var
        DelegateWFLTRec_L: Record "Delegate - WFLT";
        UserSetupRecL: Record "User Setup";
    begin
        if IsEmployeeOrUser = 1 then begin
            DelegateWFLTRec_L.RESET;
            DelegateWFLTRec_L.SETRANGE("Employee Code", checkDelegateInfo_P);
            if DelegateWFLTRec_L.FINDFIRST then begin
                if DelegateWFLTRec_L."Delegate ID" <> '' then
                    if (DelegateWFLTRec_L."From Date" >= TODAY) and (DelegateWFLTRec_L."To Date" <= TODAY) then
                        exit(DelegateWFLTRec_L."Delegate ID");
            end;
        end else
            if IsEmployeeOrUser = 2 then begin
                UserSetupRecL.RESET;
                UserSetupRecL.SETRANGE("User ID", checkDelegateInfo_P);
                if UserSetupRecL.FINDFIRST then;//commented By Avinash
                                                //commented By Avinash  UserSetupRecL.TESTFIELD("Employee Id");

                DelegateWFLTRec_L.RESET;
                //commented By Avinash DelegateWFLTRec_L.SETRANGE("Employee Code", UserSetupRecL."Employee Id");
                if DelegateWFLTRec_L.FINDFIRST then begin
                    if DelegateWFLTRec_L."Delegate ID" <> '' then begin
                        if (DelegateWFLTRec_L."From Date" <= TODAY) and (DelegateWFLTRec_L."To Date" >= TODAY) then begin
                            exit(DelegateWFLTRec_L."Delegate ID");
                        end
                    end;
                end;
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
}

