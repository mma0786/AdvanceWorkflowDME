page 60151 "Full and Final Settlement"
{
    CardPageID = "Full and Final Journal Card";
    PageType = List;
    SourceTable = "Full and Final Calculation";
    ApplicationArea = All;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Journal ID"; "Journal ID")
                {
                    ApplicationArea = All;
                }
                field("Employee No."; "Employee No.")
                {
                    ApplicationArea = All;
                }
                field("Employee Name"; "Employee Name")
                {
                    ApplicationArea = All;
                }
                field("Service Days"; "Service Days")
                {
                    ApplicationArea = All;
                }
                field("Joining Date"; "Joining Date")
                {
                    ApplicationArea = All;
                }
                field("Termination Date"; "Termination Date")
                {
                    ApplicationArea = All;
                }
                field(Currency; Currency)
                {
                    ApplicationArea = All;
                }
                field(Calculated; Calculated)
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
            action("Submit For Approval")
            {
                Caption = 'Submit For Approval';
                Enabled = NOT OpenApprovalEntriesExist;
                Image = ReleaseDoc;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = All;
                trigger OnAction()
                begin
                    //
                    if not CONFIRM('Do you want to Submit the leave request?') then
                        exit;

                    CurrPage.SETSELECTIONFILTER(FullandFinalCalculation);
                    if FullandFinalCalculation.FINDFIRST then begin
                        //SubmitLeave(FullandFinalCalculation);
                        //commented By Avinash   if ApprovalsMgmt.CheckFandFRequestApprovalPossible(FullandFinalCalculation) then
                        //commented By Avinash    ApprovalsMgmt.OnSendFandFRequestForApproval(FullandFinalCalculation);
                    end;
                end;
            }
            action("Cancel Approval Request")
            {
                Caption = 'Cancel Approval Request';
                Enabled = CanCancelApprovalForRecord;
                Image = CancelApprovalRequest;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;
                trigger OnAction()
                begin
                    //
                    //commented By Avinash  ApprovalsMgmt.OnCancelFandFApprovalRequest(Rec);
                end;
            }
            action(Reopen)
            {
                Enabled = "Workflow Status" <> "Workflow Status"::Open;
                Image = ReOpen;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;
                trigger OnAction()
                begin
                    if Rec."Workflow Status" = Rec."Workflow Status"::"Pending Approval" then
                        ERROR(Text001);

                    //Reopen(Rec);
                end;
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
        }
    }

    var
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        CanCancelApprovalForRecord: Boolean;
        FullandFinalCalculation: Record "Full and Final Calculation";
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        Text001: Label 'The approval process must be cancelled or completed to reopen this document.';
}

