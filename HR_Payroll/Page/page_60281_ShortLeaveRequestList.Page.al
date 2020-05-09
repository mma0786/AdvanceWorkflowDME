page 60281 "Short Leave Request List"
{
    Caption = 'Short Leave List';
    PageType = List;
    SourceTable = "Short Leave Header";
    Editable = false;
    CardPageId = "Short Leave Request Card";
    ApplicationArea = all;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Short Leave Request Id"; "Short Leave Request Id")
                {
                    ApplicationArea = all;
                }
                field("Request Date"; "Request Date")
                {
                    ApplicationArea = all;
                }
                field("Employee Id"; "Employee Id")
                {
                    ApplicationArea = all;
                }
                field("Employee Name"; "Employee Name")
                {
                    ApplicationArea = all;
                }
                field("Pay Period"; "Pay Period")
                {
                    ApplicationArea = all;
                }
                field(Posted; Posted)
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("Action")
            {
                Caption = 'Action';

            }
            group(Approval)
            {
                Caption = 'Approval';
                Enabled = false;
                Visible = false;
                action(Approve)
                {
                    ApplicationArea = All;
                    Caption = 'Approve';
                    Image = Approve;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    ToolTip = 'Approve the requested changes.';

                    Visible = false;

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
                    Visible = false;

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
                    Visible = false;

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
                Enabled = false;
                Image = SendApprovalRequest;
                Visible = false;
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
                    Visible = false;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        TESTFIELD("Pay Month");
                        TESTFIELD("Pay Period");

                        IF ("Request Date" > "Pay Period Start") THEN
                            ERROR(ReqDateErr, "Pay Period");

                        IF ("Request Date" < "Pay Period End") THEN
                            ERROR(ReqDateErr, "Pay Period");

                        LineRec.RESET;
                        LineRec.SETRANGE("Short Leave Request Id", "Short Leave Request Id");
                        IF LineRec.FINDFIRST THEN;

                        LineRec.TESTFIELD("Req. End Time");
                        LineRec.TESTFIELD(Reason);

                        IF ("Request Date" > "Pay Period Start") THEN
                            ERROR(ReqDateErr, "Request Date");

                        IF ("Request Date" < "Pay Period End") THEN
                            ERROR(ReqDateErr, "Request Date");

                        TESTFIELD("Request Date");
                        TESTFIELD("Pay Period");
                        TESTFIELD("Employee Id");
                        TESTFIELD(Posted, FALSE);

                        //IF ApprovalsMgmt.CheckSLRPossible(Rec) THEN
                        //  ApprovalsMgmt.OnSendSLRForApproval(Rec);
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
                    PromotedOnly = true;
                    ToolTip = 'Cancel the approval request.';
                    Visible = false;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        // ApprovalsMgmt.OnCancelSLRApprovalRequest(Rec);
                        //ApprovalsMgmt.RejectRecordApprovalRequest(RECORDID);
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
                    Visible = false;

                    trigger OnAction()
                    var
                        ReleaseSalesDoc: Codeunit "Release Sales Document";
                    begin
                        TESTFIELD(Posted, FALSE);
                        IF "WorkFlow Status" = "WorkFlow Status"::"Pending Approval" THEN
                            ERROR('WorkFlow status should be Approved for reopen');

                        "WorkFlow Status" := "WorkFlow Status"::Open;
                    end;
                }
            }
            /* action("File Upload")
             {
                 Image = Attach;
                 Promoted = true;
                 PromotedIsBig = true;
                 //RunObject = Codeunit "61015";

                 trigger OnAction()
                 var
                     UploadFileFromESSCU: Codeunit "61015";
                 begin
                     UploadFileFromESSCU.UploadFileThroughESS_LT(RECORDID, 'Short Leave');
                 end;
             }*/
            action("File Download")
            {
                Image = Aging;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    RecordLinkRecL: Record "Record Link";
                begin
                    RecordLinkRecL.RESET;
                    RecordLinkRecL.SETRANGE("Record ID", RECORDID);
                    IF RecordLinkRecL.FINDSET THEN;
                    //  PAGE.RUN(PAGE::"Download File", RecordLinkRecL);
                end;
            }
        }
    }

    var
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        CanCancelApprovalForRecord: Boolean;
        ReqDateErr: Label 'The requested date should fall in pay period %1';
        LineRec: Record "Short Leave Line";

    local procedure SetControlVisibility()
    begin
    end;
}

