page 60152 "Full and Final Journal Card"
{
    PageType = Card;
    SourceTable = "Full and Final Calculation";


    layout
    {
        area(content)
        {
            group(General)
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
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Service Days"; "Service Days")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Joining Date"; "Joining Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Termination Date"; "Termination Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Currency; Currency)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Pay Cycle"; "Pay Cycle")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Pay Period Start Date"; "Pay Period Start Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Pay Period End Date"; "Pay Period End Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Calculated; Calculated)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Workflow Status"; "Workflow Status")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
            //commented By Avinash
            part("Payroll Calculations"; "FS Earning Codes")
            {
                Caption = 'Payroll Calculations';
                Editable = false;
                SubPageLink = "Journal ID" = FIELD("Journal ID"), "Employee No." = FIELD("Employee No.");
                ApplicationArea = All;
            }
            part("Employee Benefits"; "FS Benefit Ledger")
            {
                Caption = 'Employee Benefits';
                SubPageLink = "Journal ID" = FIELD("Journal ID"),
                              "Employee No." = FIELD("Employee No.");
                UpdatePropagation = Both;
                ApplicationArea = All;
            }
            part("Leave Encashments"; "Leave Encashments")
            {
                Editable = false;
                SubPageLink = "Journal ID" = FIELD("Journal ID"),
                              "Employee No." = FIELD("Employee No.");
            }
            part("Recovery of Advances"; "FS Loans")
            {
                Caption = 'Recovery of Advances';
                SubPageLink = "Journal ID" = FIELD("Journal ID"),
                              "Employee No." = FIELD("Employee No.");
                UpdatePropagation = Both;
            }
            //commented By Avinash
            group(Summarry)
            {
                Editable = false;
                field("Payroll Amount"; "Payroll Amount")
                {
                    ApplicationArea = All;
                }
                field("Leave Encashment"; "Leave Encashment")
                {
                    ApplicationArea = All;
                }
                field("Indemnity/Gratuity Amount"; "Indemnity/Gratuity Amount")
                {
                    ApplicationArea = All;
                }
                field("Loan Recovery"; "Loan Recovery")
                {
                    ApplicationArea = All;
                }
                field("Payroll Summarry"; "Payroll Amount" + "Leave Encashment" + "Indemnity/Gratuity Amount" + "Loan Recovery")
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
            action("Full & Final Calculation")
            {
                Caption = 'Full and Final Settlement Calculation';
                Image = Calculate;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;
                trigger OnAction()
                var
                    RecEmployee: Record Employee;
                begin
                    if not CONFIRM('Do you want to calculate the Full and Final Settlement ?', true) then
                        exit;


                    FSEarningCodes.RESET;
                    FSEarningCodes.SETRANGE("Journal ID", Rec."Journal ID");
                    FSEarningCodes.DELETEALL;

                    FSBenefits.RESET;
                    FSBenefits.SETRANGE("Journal ID", Rec."Journal ID");
                    FSBenefits.DELETEALL;

                    FSLoans.RESET;
                    FSLoans.SETRANGE("Journal ID", Rec."Journal ID");
                    FSLoans.DELETEALL;

                    CLEAR(FandFCalc);
                    RecEmployee.RESET;
                    RecEmployee.SETRANGE("No.", "Employee No.");
                    RecEmployee.FINDFIRST;
                    FandFCalc.SetValues("Pay Cycle", "Pay Period Start Date", "Pay Period End Date", Rec);
                    FandFCalc.SETTABLEVIEW(RecEmployee);
                    FandFCalc.RUNMODAL;
                end;
            }
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
                var
                    WfCode: Codeunit InitCodeunit_Final_Sett;
                begin
                    //


                    CurrPage.SETSELECTIONFILTER(FullandFinalCalculation);
                    if FullandFinalCalculation.FINDFIRST then begin

                        if WfCode.IsF_And_F_Enabled(rec) then begin
                            if not CONFIRM('Do you want to Submit the Full and Final settlement ?') then
                                exit;
                            WfCode.OnSendF_And_F_Approval(rec);
                        end;
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
                var
                    WfCode: Codeunit InitCodeunit_Final_Sett;
                begin
                    //
                    //commented By Avinash  ApprovalsMgmt.OnCancelFandFApprovalRequest(Rec);
                    WfCode.OnCancelF_And_F_Approval(rec);
                end;
            }
            action(Approvals)
            {
                AccessByPermission = TableData "Approval Entry" = R;
                ApplicationArea = Suite;
                Caption = 'Approvals';
                Image = Approvals;
                ToolTip = 'View a list of the records that are waiting to be approved. For example, you can see who requested the record to be approved, when it was sent, and when it is due to be approved.';

                trigger OnAction()
                var
                    GenJournalLine: Record "Gen. Journal Line";
                    ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                begin
                    //commented By Avinash   ApprovalsMgmt.ShowFullandFinalApprovalEntries(Rec);
                end;
            }
            action(Comments)
            {
                ApplicationArea = Suite;
                Caption = 'Comments';
                Image = ViewComments;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Scope = Repeater;
                ToolTip = 'View or add comments.';

                trigger OnAction()
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

            // Avinash 05.05.2020
            action("Attachment")
            {
                ApplicationArea = All;
                Image = Attachments;
                Promoted = true;
                Caption = 'Attachment';
                //PromotedCategory = Category8;
                ToolTip = 'Add a file as an attachment. You can attach images as well as documents.';
                trigger
                OnAction()
                var
                    DocumentAttachmentDetails: Page "Document Attachment Details";
                    RecRef: RecordRef;
                begin
                    RecRef.GETTABLE(Rec);
                    DocumentAttachmentDetails.OpenForRecRef(RecRef);
                    DocumentAttachmentDetails.RUNMODAL;
                end;
            }
            // Avinash 05.05.2020
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

    trigger OnAfterGetRecord()
    begin
        CALCFIELDS("Payroll Amount", "Leave Encashment", "Indemnity/Gratuity Amount", "Loan Recovery");
    end;

    var
        FandFCalc: Report "Generate Full and Final Calc";
        FSEarningCodes: Record "FS - Earning Code";
        FSBenefits: Record "FS Benefits";
        FSLoans: Record "FS Loans";
        FullandFinalCalculation: Record "Full and Final Calculation";
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        CanCancelApprovalForRecord: Boolean;
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        Text001: Label 'The approval process must be cancelled or completed to reopen this document.';
}

