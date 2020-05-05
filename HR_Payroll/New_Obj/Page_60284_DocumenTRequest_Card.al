page 60284 "Document request Card"
{
    // version LT_HRMS-P1-009

    Caption = 'Document request Card';
    PageType = Card;
    SourceTable = "Document Request";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Document Request ID"; "Document Request ID")
                {

                    trigger OnAssistEdit();
                    begin
                        if AssistEdit(xRec) then
                            CurrPage.UPDATE;
                    end;
                }
                field("Employee ID"; "Employee ID")
                {
                }
                field("Employee Name"; "Employee Name")
                {
                    Editable = false;
                }
                field(Addressee; Addressee)
                {
                }
                field("Document format ID"; "Document format ID")
                {
                }
                field("Certificate For Dependent"; "Certificate For Dependent")
                {
                    Enabled = "Document format ID" = "Document format ID"::"Administrative Certificate";
                }
                field("Dependent Name"; "Dependent Name")
                {
                    Editable = false;
                }
                field("Document Title"; "Document Title")
                {
                    Editable = false;
                }
                field("Request Date"; "Request Date")
                {
                }
                field("Document Date"; "Document Date")
                {
                }
                field("WorkFlow Status"; "WorkFlow Status")
                {
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group(Approval)
            {
                Caption = 'Approval';
                action(Completed)
                {
                    Caption = 'Completed';
                    Image = Email;
                    Promoted = true;

                    trigger OnAction();
                    begin
                        if "WorkFlow Status" = "WorkFlow Status"::Released then begin
                            // Email_Confirmation.Document_Request(Rec);
                        end else
                            ERROR('WorkFlow status should be Approved for reopen');
                    end;
                }
            }
            group(ActionGroup11)
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
                    Visible = OpenApprovalEntriesExistForCurrUser;

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
                    Visible = OpenApprovalEntriesExistForCurrUser;

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
                    Enabled = NOT OpenApprovalEntriesExist;
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category9;
                    PromotedOnly = true;
                    ToolTip = 'Send an approval request.';

                    trigger OnAction();
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                        Wfcode: Codeunit InitCodeunit_DocLetterRec;
                    begin
                        TESTFIELD("Document Request ID");
                        TESTFIELD("Employee ID");
                        TESTFIELD(Addressee);
                        TESTFIELD("Document format ID");
                        TESTFIELD("Request Date");
                        TESTFIELD("Document Date");
                        /* if ApprovalsMgmt.CheckDocReqPossible(Rec) then
                            ApprovalsMgmt.OnSendDocReqForApproval(Rec)*/
                        Wfcode.IsDocLetter_Enabled(rec);
                        Wfcode.OnSendDocLetter_Approval(Rec);
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

                    trigger OnAction();
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                        WfCode: Codeunit InitCodeunit_DocLetterRec;
                    begin
                        //  ApprovalsMgmt.OnCancelDocReqApprovalRequest(Rec);
                        WfCode.OnCancelDocLetter_Approval(Rec);
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
                action(Approvals)
                {
                    AccessByPermission = TableData "Approval Entry" = R;
                    ApplicationArea = Suite;
                    Caption = 'Approvals';
                    Image = Approvals;
                    ToolTip = 'View a list of the records that are waiting to be approved. For example, you can see who requested the record to be approved, when it was sent, and when it is due to be approved.';

                    trigger OnAction();
                    var
                        GenJournalLine: Record "Gen. Journal Line";
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        //   ApprovalsMgmt.ShowDocRequestApprovalEntries(Rec);
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
            }
            group("Report")
            {
                Caption = 'Report';
                Image = SendApprovalRequest;
                action("Document ")
                {
                    Caption = 'Print Document';
                    Enabled = "WorkFlow Status" = "WorkFlow Status"::Released;
                    Image = PrintAttachment;
                    Promoted = true;

                    trigger OnAction();
                    begin
                        /*TESTFIELD("Employee ID");
                        TESTFIELD(Addressee);
                        TESTFIELD("Request Date");
                        TESTFIELD("WorkFlow Status","WorkFlow Status"::Released);
                        
                        IF "Document format ID" = "Document format ID"::" " THEN
                          ERROR('Select the Document format ID');
                        */
                        /*if "Document format ID" = "Document format ID"::"Bank Transfer" then begin
                          CLEAR(Trans_SalaryRep);
                          Rec2 := Rec;
                          CurrPage.SETSELECTIONFILTER(Rec2);
                          Trans_SalaryRep.SETTABLEVIEW(Rec2);
                          Trans_SalaryRep.RUNMODAL;
                        end;
                        
                        
                        if "Document format ID" = "Document format ID"::"Administrative Certificate" then begin
                          CLEAR(AdminCertRep);
                          EmployeeDependentsMaster.RESET;
                          EmployeeDependentsMaster.SETRANGE("Employee ID",Rec."Employee ID");
                          if EmployeeDependentsMaster.FINDFIRST then begin
                            AdminCertRep.SETTABLEVIEW(EmployeeDependentsMaster);
                            AdminCertRep.RUNMODAL;
                          end;
                        end;
                        
                        if "Document format ID" = "Document format ID"::"US Consulate" then begin
                          CLEAR(USConsulateRep);
                          IdentificationMasterRec.RESET;
                          IdentificationMasterRec.SETRANGE("Employee No.",Rec."Employee ID");
                          if IdentificationMasterRec.FINDFIRST then begin
                            USConsulateRep.SETTABLEVIEW(IdentificationMasterRec);
                            USConsulateRep.RUNMODAL;
                          end;
                        end;
                        if "Document format ID" = "Document format ID"::"Administrative Certificate Arabic" then begin
                          CLEAR(AdimArabRep);
                          EmpRec.RESET;
                          EmpRec.SETRANGE("No.","Employee ID");
                          if EmpRec.FINDFIRST then  begin
                              AdimArabRep.SETTABLEVIEW(EmpRec);
                              AdimArabRep.RUNMODAL;
                          end;
                        end;
*/
                    end;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord();
    begin
        SetControlVisibility();
    end;

    trigger OnAfterGetRecord();
    begin
        SetControlVisibility();
    end;

    trigger OnOpenPage();
    begin
        SetControlVisibility();
    end;

    var
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        CanCancelApprovalForRecord: Boolean;
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        // Email_Confirmation : Codeunit "Email Confirmation";
        Rec2: Record "Document Request";
        // Trans_SalaryRep : Report "Transfer of Salary";
        //  AdminCertRep : Report "ADMINISTRATIVE CERTIFICATE";
        EmployeeDependentsMaster: Record "Employee Dependents Master";
        //  USConsulateRep : Report "US Consulate";
        IdentificationMasterRec: Record "Identification Master";
        EmpRec: Record Employee;
    // AdimArabRep : Report DocReq_861;

    local procedure SetControlVisibility();
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    begin
        OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(RECORDID);
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(RECORDID);
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(RECORDID);
    end;
}

