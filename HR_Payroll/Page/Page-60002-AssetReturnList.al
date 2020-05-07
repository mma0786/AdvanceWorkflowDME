page 60002 "Asset Return List"
{
    CardPageID = "Asset Return";
    PageType = List;
    SourceTable = "Asset Assignment Register";
    SourceTableView = SORTING("Issue Document No.", "Posted Issue Document No", "Return Document No.", "Posted Return Document No")
                      ORDER(Ascending)
                      WHERE("Transaction Type" = FILTER(Return),
                            Posted = FILTER(false));
    UsageCategory = Administration;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                Editable = false;
                field("Return Document No."; "Return Document No.")
                {
                    ApplicationArea = All;
                    Caption = 'Document No.';
                    Editable = false;
                }
                field("FA No"; "FA No")
                {
                    ApplicationArea = All;
                    Caption = 'Fixed Asset No.';
                    Editable = false;
                }
                field("FA Description"; "FA Description")
                {
                    ApplicationArea = All;
                    Caption = 'Fixed Asset Description';
                    Editable = false;
                }
                field("Asset Custody Type"; "Asset Custody Type")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Issue to/Return by"; "Issue to/Return by")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("WorkFlow Status"; "WorkFlow Status")
                {
                    ApplicationArea = All;
                    Editable = false;
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

                        // // // if not ApprovalsMgmt.CheckAARPossiblePosting(Rec) then begin
                        TESTFIELD("WorkFlow Status", Rec."WorkFlow Status"::Released);
                        Post_Action;
                        Rec.DELETE
                        // // // end else begin
                        // // //     Post_Action;
                        // // //     Rec.DELETE
                        // // // end;
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

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                        //<LT_Bc_Wf_Code>
                        Ass_Ret_Init: Codeunit InitCodeunit_Asset_Return;
                    //<LT_Bc_Wf_Code>
                    begin
                        AssetAssRegRec2.RESET;
                        AssetAssRegRec2.SETRANGE("Issue Document Reference", "Issue Document Reference");
                        if AssetAssRegRec2.FINDFIRST then begin
                            //commented By Avinash if AssetAssRegRec2."WorkFlow Status" <> AssetAssRegRec2."WorkFlow Status"::Open then
                            //commented By Avinash   ERROR('Asset Return Request is Process %1', AssetAssRegRec2."Return Document No.");
                        end;

                        FixedAssetRec.RESET;
                        if FixedAssetRec.GET("FA No") then begin
                            //commented By Avinash if (FixedAssetRec."Issued to Department" = '') and (FixedAssetRec."Issued to Department" = '') then
                            //commented By Avinash   ERROR('Asset has been returned')
                        end;

                        TESTFIELD("Issue Document Reference");
                        TESTFIELD("FA No");
                        TESTFIELD("Issue to/Return by");
                        TESTFIELD("Issue Date");
                        TESTFIELD("Document Date");

                        AssetAssRegRec2.RESET;
                        AssetAssRegRec2.SETRANGE("FA No", Rec."FA No");
                        AssetAssRegRec2.SETRANGE("WorkFlow Status", AssetAssRegRec2."WorkFlow Status"::Released);
                        AssetAssRegRec2.SETRANGE("Transaction Type", AssetAssRegRec2."Transaction Type"::Return);
                        if AssetAssRegRec2.FINDFIRST then
                            ERROR('The Asset return request is already in process %1', "FA No");

                        //commented By Avinash  if ApprovalsMgmt.CheckAARPossible(Rec) then
                        //commented By Avinash   ApprovalsMgmt.OnSendAARForApproval(Rec);
                        //<LT_Bc_Wf_Code>
                        Ass_Ret_Init.IsAssetReturn_Enabled(Rec);
                        Ass_Ret_Init.OnSendAssetReturn_Approval(Rec);
                        //<LT_Bc_Wf_Code>
                    end;
                }
                action(CancelApprovalRequest)
                {
                    ApplicationArea = Suite;
                    Caption = 'Cancel Approval Re&quest';
                    Enabled = CanCancelApprovalForRecord;
                    Image = CancelApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category9;
                    PromotedOnly = true;
                    ToolTip = 'Cancel the approval request.';

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                        //<LT_Bc_Wf_Code>
                        Ass_Ret_Init: Codeunit InitCodeunit_Asset_Return;
                    //<LT_Bc_Wf_Code>
                    begin
                        //commented By Avinash  ApprovalsMgmt.OnCancelAARApprovalRequest(Rec);

                        //<LT_Bc_Wf_Code>
                        Ass_Ret_Init.OnCancelAssetReturn_Approval(Rec);
                        //<LT_Bc_Wf_Code>
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
    end;

    trigger OnAfterGetRecord()
    begin
        SetControlVisibility;
    end;

    trigger OnInit()
    begin
        SetControlVisibility;
    end;

    var
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        CanCancelApprovalForRecord: Boolean;
        FASetup: Record "FA Setup";
        NoSeriesRec: Record "No. Series";
        NoSeriesCU: Codeunit NoSeriesManagement;
        AssetAssRegRec2: Record "Asset Assignment Register";
        FA_Rec: Record "Fixed Asset";
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        AssetAssignmentRegister: Record "Asset Assignment Register";
        FixedAssetRec: Record "Fixed Asset";

    local procedure SetControlVisibility()
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    begin
        OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(RECORDID);
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(RECORDID);
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(RECORDID);
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
        Asseton: Text;
        PostedRetDocNo: Code[10];
    begin
        AssetAssRegRec.INIT;
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
        if AssetAssRegRec.INSERT then begin
            if "Asset Custody Type" = "Asset Custody Type"::Employee then begin
                if FA_Rec.GET("FA No") then begin
                    //commented By Avinash
                    FA_Rec."Asset Custody" := FA_Rec."Asset Custody"::Employer;
                    FA_Rec."Issued to Department" := '';
                    FA_Rec."Issued to Employee" := '';
                    FA_Rec.MODIFY;
                    // ;
                    //commented By Avinash
                end;
            end;
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
}

