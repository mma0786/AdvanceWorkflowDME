page 60148 "Asset Issue List"
{
    CardPageID = "Asset Issue";
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Asset Assignment Register";
    SourceTableView = WHERE("Transaction Type" = FILTER(Issue),
                            Posted = FILTER(false));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Issue Document No."; "Issue Document No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("FA No"; "FA No")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("FA Description"; "FA Description")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Issue to/Return by"; "Issue to/Return by")
                {
                    Caption = 'Issue to';
                    Editable = false;
                }
                field("Asset Custody Type"; "Asset Custody Type")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("WorkFlow Status"; "WorkFlow Status")
                {
                    Editable = false;
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
                        CurrPage.SETSELECTIONFILTER(AssetAssignmentRegister);
                        if AssetAssignmentRegister.FINDSET then begin
                            //commented By Avinash  if not ApprovalsMgmt.CheckAARPossiblePosting(Rec) then begin
                            TESTFIELD("WorkFlow Status", Rec."WorkFlow Status"::Released);
                            Post_Action;
                            Rec.DELETE
                            //commented By Avinash  end else begin
                            //commented By Avinash  Post_Action;
                            //commented By Avinash    Rec.DELETE;
                            //commented By Avinash  end;
                        end;

                        /*IF "WorkFlow Status" = "WorkFlow Status"::Released THEN
                          Post_Action
                        ELSE
                          ERROR('Workflow Status should be Released')*/

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
                    //Visible = false;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
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
                        AssetAssiReg.SETFILTER("WorkFlow Status", '%1|%2', AssetAssiReg."WorkFlow Status"::"Pending For Approval", AssetAssiReg."WorkFlow Status"::Released);

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
                            // if (FixedAssetRec."Issued to Department" <> '') or (FixedAssetRec."Issued to Employee" <> '') then
                            //     ERROR('Asset has been issued to other Employee or Department');
                            //commented By Avinash
                        end;

                        /*
                        AssetAssiReg.RESET;
                        AssetAssiReg.SETRANGE("FA No",Rec."FA No");
                        IF AssetAssiReg.FINDSET THEN  BEGIN
                          REPEAT
                            IF AssetAssiReg."WorkFlow Status" <> AssetAssiReg."WorkFlow Status"::Open THEN
                              ERROR('This asset is already requested by another emplyee');
                          UNTIL AssetAssiReg.NEXT = 0;
                        END;
                        
                        FA_Rec.RESET;
                        IF FA_Rec.GET("FA No") THEN
                          IF FA_Rec."Asset Custody" <> FA_Rec."Asset Custody"::Employer THEN
                            ERROR('Asset is already issued to %1%2',FA_Rec."Issued to Employee",FA_Rec."Issued to Department");
                          */
                        //commented By Avinash    if ApprovalsMgmt.CheckAARPossible(Rec) then
                        //commented By Avinash     ApprovalsMgmt.OnSendAARForApproval(Rec);

                    end;
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
                    //Visible = false;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        //commented By Avinash  ApprovalsMgmt.OnCancelAARApprovalRequest(Rec);
                        "WorkFlow Status" := "WorkFlow Status"::Open;

                        Cancel := true;
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
                        CurrPage.SETSELECTIONFILTER(AssetAssignmentRegister);
                        if AssetAssignmentRegister.FINDSET then begin
                            if (AssetAssignmentRegister."WorkFlow Status" = AssetAssignmentRegister."WorkFlow Status"::Rejected) or (AssetAssignmentRegister."WorkFlow Status" = AssetAssignmentRegister."WorkFlow Status"::Released) then begin
                                AssetAssignmentRegister."WorkFlow Status" := AssetAssignmentRegister."WorkFlow Status"::Open;
                                AssetAssignmentRegister.MODIFY;
                            end else
                                ERROR('You cannot reopen untill the document the workFlow is approved or rejected');
                        end;
                    end;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        SetControlVisibility;

        if ("WorkFlow Status" = "WorkFlow Status"::Rejected) or ("WorkFlow Status" = "WorkFlow Status"::Released) then
            PostAction := true;

        //IF Cancel THEN
        //"WorkFlow Status" := "WorkFlow Status"::Open;
    end;

    trigger OnAfterGetRecord()
    begin
        SetControlVisibility;

        if ("WorkFlow Status" = "WorkFlow Status"::Rejected) or ("WorkFlow Status" = "WorkFlow Status"::Released) then
            PostAction := true;
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
        //IF Cancel THEN
        //"WorkFlow Status" := "WorkFlow Status"::Open;
    end;

    trigger OnOpenPage()
    begin
        SetControlVisibility;

        if ("WorkFlow Status" = "WorkFlow Status"::Rejected) or ("WorkFlow Status" = "WorkFlow Status"::Released) then
            PostAction := true;
    end;

    var
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        CanCancelApprovalForRecord: Boolean;
        RecRef: RecordRef;
        RecordLinkRec: Record "Record Link";
        FASetup: Record "FA Setup";
        NoSeriesCU: Codeunit NoSeriesManagement;
        FA_Rec: Record "Fixed Asset";
        PostAction: Boolean;
        AssetAssignmentRegister: Record "Asset Assignment Register";
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        OpenAction: Boolean;
        FixedAssetRec: Record "Fixed Asset";
        EmployeeRec: Record Employee;
        AssetAssiReg: Record "Asset Assignment Register";
        Cancel: Boolean;
        Employee: Record Employee;
        PayrollDepartment: Record "Payroll Department";
        AssetAssignmentRegisterG: Record "Asset Assignment Register";

    local procedure SetControlVisibility()
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    begin
        OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(RECORDID);
        /*OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(RECORDID);
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(RECORDID);
        */

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

    local procedure Post_Action()
    var
        AssetAssRegRec: Record "Asset Assignment Register";
    begin
        AssetAssRegRec.INIT;
        AssetAssRegRec."Issue Document No." := "Issue Document No.";
        FASetup.GET;
        //commented By Avinash AssetAssRegRec."Posted Issue Document No" := NoSeriesCU.GetNextNo(FASetup."Posted Issue Document No", WORKDATE, true);
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
        if AssetAssRegRec.INSERT then begin
            if "Asset Custody Type" = "Asset Custody Type"::Employee then begin
                FA_Rec.RESET;
                if FA_Rec.GET("FA No") then begin
                    //commented By Avinash
                    // FA_Rec."Asset Custody" := FA_Rec."Asset Custody"::Employee;
                    // FA_Rec."Issued to Employee" := "Issue to/Return by";
                    // FA_Rec."Issued to Department" := '';
                    // FA_Rec.MODIFY;
                    //commented By Avinash
                end;
            end else
                if "Asset Custody Type" = "Asset Custody Type"::Department then begin
                    if FA_Rec.GET("FA No") then begin
                        //commented By Avinash
                        // FA_Rec."Asset Custody" := FA_Rec."Asset Custody"::Department;
                        // FA_Rec."Issued to Department" := "Issue to/Return by";
                        // FA_Rec."Issued to Employee" := '';
                        //commented By Avinash
                        FA_Rec.MODIFY;
                    end;
                end;
        end;
    end;
}

