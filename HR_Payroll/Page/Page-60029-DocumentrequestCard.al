// // // page 60029 "Document request Card-1"
// // // {
// // //     Caption = 'Document request Card';
// // //     PageType = Card;
// // //     SourceTable = "Document Request";
// // //     UsageCategory = Administration;
// // //     ApplicationArea = All;

// // //     layout
// // //     {
// // //         area(content)
// // //         {
// // //             group(General)
// // //             {
// // //                 field("Document Request ID"; "Document Request ID")
// // //                 {

// // //                     trigger OnAssistEdit()
// // //                     begin
// // //                         IF AssistEdit(xRec) THEN
// // //                             CurrPage.UPDATE;
// // //                     end;
// // //                 }
// // //                 field("Employee ID"; "Employee ID")
// // //                 {
// // //                 }
// // //                 field("Employee Name"; "Employee Name")
// // //                 {
// // //                     Editable = false;
// // //                 }
// // //                 field(Addressee; Addressee)
// // //                 {
// // //                 }
// // //                 field("Document format ID"; "Document format ID")
// // //                 {
// // //                 }
// // //                 field("Certificate For Dependent"; "Certificate For Dependent")
// // //                 {
// // //                     Enabled = "Document format ID" = "Document format ID"::"Administrative Certificate";
// // //                 }
// // //                 field("Dependent Name"; "Dependent Name")
// // //                 {
// // //                     Editable = false;
// // //                 }
// // //                 field("Document Title"; "Document Title")
// // //                 {
// // //                     Editable = false;
// // //                 }
// // //                 field("Request Date"; "Request Date")
// // //                 {
// // //                 }
// // //                 field("Document Date"; "Document Date")
// // //                 {
// // //                 }
// // //                 field("WorkFlow Status"; "WorkFlow Status")
// // //                 {
// // //                 }
// // //             }
// // //         }
// // //     }

// // //     actions
// // //     {
// // //         area(processing)
// // //         {
// // //             group(Approval)
// // //             {
// // //                 Caption = 'Approval';
// // //                 action(Completed)
// // //                 {
// // //                     Caption = 'Completed';
// // //                     Image = Email;
// // //                     Promoted = true;

// // //                     trigger OnAction()
// // //                     begin
// // //                         //commented By Avinash   IF "WorkFlow Status" = "WorkFlow Status"::"1" THEN BEGIN
// // //                         //commented By Avinash     Email_Confirmation.Document_Request(Rec);
// // //                         //commented By Avinash  END ELSE
// // //                         //commented By Avinash     ERROR('WorkFlow status should be Approved for reopen');
// // //                     end;
// // //                 }
// // //             }
// // //             group(ActionGroup11)
// // //             {
// // //                 Caption = 'Approval';
// // //                 action(Approve)
// // //                 {
// // //                     ApplicationArea = All;
// // //                     Caption = 'Approve';
// // //                     Image = Approve;
// // //                     Promoted = true;
// // //                     PromotedCategory = Category4;
// // //                     PromotedIsBig = true;
// // //                     ToolTip = 'Approve the requested changes.';
// // //                     Visible = OpenApprovalEntriesExistForCurrUser;

// // //                     trigger OnAction()
// // //                     var
// // //                         ApprovalsMgmt: Codeunit "Approvals Mgmt.";
// // //                     begin
// // //                         ApprovalsMgmt.ApproveRecordApprovalRequest(RECORDID);
// // //                     end;
// // //                 }
// // //                 action(Reject)
// // //                 {
// // //                     ApplicationArea = All;
// // //                     Caption = 'Reject';
// // //                     Enabled = OpenApprovalEntriesExistForCurrUser;
// // //                     Image = Reject;
// // //                     Promoted = true;
// // //                     PromotedCategory = Category4;
// // //                     PromotedIsBig = true;
// // //                     ToolTip = 'Reject the approval request.';
// // //                     Visible = OpenApprovalEntriesExistForCurrUser;

// // //                     trigger OnAction()
// // //                     var
// // //                         ApprovalsMgmt: Codeunit "Approvals Mgmt.";
// // //                     begin
// // //                         ApprovalsMgmt.RejectRecordApprovalRequest(RECORDID);
// // //                     end;
// // //                 }
// // //                 action(Delegate)
// // //                 {
// // //                     ApplicationArea = All;
// // //                     Caption = 'Delegate';
// // //                     Enabled = OpenApprovalEntriesExistForCurrUser;
// // //                     Image = Delegate;
// // //                     Promoted = true;
// // //                     PromotedCategory = Category4;
// // //                     ToolTip = 'Delegate the approval to a substitute approver.';
// // //                     Visible = OpenApprovalEntriesExistForCurrUser;

// // //                     trigger OnAction()
// // //                     var
// // //                         ApprovalsMgmt: Codeunit "Approvals Mgmt.";
// // //                     begin
// // //                         ApprovalsMgmt.DelegateRecordApprovalRequest(RECORDID);
// // //                     end;
// // //                 }
// // //             }
// // //             group("Request Approval")
// // //             {
// // //                 Caption = 'Request Approval';
// // //                 Image = SendApprovalRequest;
// // //                 action(SendApprovalRequest)
// // //                 {
// // //                     ApplicationArea = Suite;
// // //                     Caption = 'Send A&pproval Request';
// // //                     Enabled = NOT OpenApprovalEntriesExist;
// // //                     Image = SendApprovalRequest;
// // //                     Promoted = true;
// // //                     PromotedCategory = Category9;
// // //                     PromotedOnly = true;
// // //                     ToolTip = 'Send an approval request.';

// // //                     trigger OnAction()
// // //                     var
// // //                         ApprovalsMgmt: Codeunit "Approvals Mgmt.";
// // //                     begin
// // //                         TESTFIELD("Document Request ID");
// // //                         TESTFIELD("Employee ID");
// // //                         TESTFIELD(Addressee);
// // //                         TESTFIELD("Document format ID");
// // //                         TESTFIELD("Request Date");
// // //                         TESTFIELD("Document Date");

// // //                         //commented By Avinash    IF ApprovalsMgmt.CheckDocReqPossible(Rec) THEN
// // //                         //commented By Avinash    ApprovalsMgmt.OnSendDocReqForApproval(Rec)
// // //                     end;
// // //                 }
// // //                 action(CancelApprovalRequest)
// // //                 {
// // //                     ApplicationArea = Suite;
// // //                     Caption = 'Cancel Approval Re&quest';
// // //                     Enabled = CanCancelApprovalForRecord;
// // //                     Image = CancelApprovalRequest;
// // //                     Promoted = true;
// // //                     PromotedCategory = Category9;
// // //                     PromotedOnly = true;
// // //                     ToolTip = 'Cancel the approval request.';

// // //                     trigger OnAction()
// // //                     var
// // //                         ApprovalsMgmt: Codeunit "Approvals Mgmt.";
// // //                     begin
// // //                         //commented By Avinash   ApprovalsMgmt.OnCancelDocReqApprovalRequest(Rec);
// // //                     end;
// // //                 }
// // //                 action(Reopen)
// // //                 {
// // //                     ApplicationArea = Basic, Suite;
// // //                     Caption = 'Re&open';
// // //                     Enabled = "WorkFlow Status" <> "WorkFlow Status"::Open;
// // //                     Image = ReOpen;
// // //                     Promoted = true;
// // //                     PromotedCategory = Process;
// // //                     PromotedOnly = true;
// // //                     ToolTip = 'Reopen the document to change it after it has been approved. Approved documents have the Released status and must be opened before they can be changed.';

// // //                     trigger OnAction()
// // //                     var
// // //                         ReleaseSalesDoc: Codeunit "Release Sales Document";
// // //                     begin
// // //                         //commented By Avinash  IF "WorkFlow Status" = "WorkFlow Status"::"2" THEN
// // //                         //commented By Avinash   ERROR('WorkFlow status should be Approved for reopen');

// // //                         //commented By Avinash   "WorkFlow Status" := "WorkFlow Status"::"0";
// // //                     end;
// // //                 }
// // //                 action(Approvals)
// // //                 {
// // //                     AccessByPermission = TableData "Approval Entry" = R;
// // //                     ApplicationArea = Suite;
// // //                     Caption = 'Approvals';
// // //                     Image = Approvals;
// // //                     ToolTip = 'View a list of the records that are waiting to be approved. For example, you can see who requested the record to be approved, when it was sent, and when it is due to be approved.';

// // //                     trigger OnAction()
// // //                     var
// // //                         GenJournalLine: Record "Gen. Journal Line";
// // //                         ApprovalsMgmt: Codeunit "Approvals Mgmt.";
// // //                     begin
// // //                         //commented By Avinash   ApprovalsMgmt.ShowDocRequestApprovalEntries(Rec);
// // //                     end;
// // //                 }
// // //                 action(Comments)
// // //                 {
// // //                     ApplicationArea = Suite;
// // //                     Caption = 'Comments';
// // //                     Image = ViewComments;
// // //                     Promoted = true;
// // //                     PromotedCategory = Process;
// // //                     PromotedIsBig = true;
// // //                     Scope = Repeater;
// // //                     ToolTip = 'View or add comments.';

// // //                     trigger OnAction()
// // //                     var
// // //                         ApprovalsMgmt: Codeunit "Approvals Mgmt.";
// // //                         RecRef: RecordRef;
// // //                         ApprovalEntry: Record "Approval Entry";
// // //                         RecID: RecordID;
// // //                     begin
// // //                         RecRef.GET(Rec.RECORDID);
// // //                         RecID := RecRef.RECORDID;
// // //                         CLEAR(ApprovalsMgmt);
// // //                         ApprovalEntry.RESET;
// // //                         ApprovalEntry.SETRANGE("Table ID", RecID.TABLENO);
// // //                         ApprovalEntry.SETRANGE("Record ID to Approve", RecRef.RECORDID);
// // //                         //ApprovalEntry.SETRANGE(Status,ApprovalEntry.Status::Open);
// // //                         //ApprovalEntry.SETRANGE("Approver ID",USERID);
// // //                         ApprovalEntry.SETRANGE("Related to Change", FALSE);
// // //                         IF ApprovalEntry.FINDFIRST THEN
// // //                             ApprovalsMgmt.GetApprovalCommentForWorkflowStepInstanceID(RecRef, ApprovalEntry."Workflow Step Instance ID");
// // //                     end;
// // //                 }
// // //             }
// // //             group("Report")
// // //             {
// // //                 Caption = 'Report';
// // //                 Image = SendApprovalRequest;
// // //                 action("Document ")
// // //                 {
// // //                     Caption = 'Print Document';
// // //                     Enabled = "WorkFlow Status" = "WorkFlow Status"::Released;
// // //                     Image = PrintAttachment;
// // //                     Promoted = true;

// // //                     trigger OnAction()
// // //                     begin
// // //                         /*TESTFIELD("Employee ID");
// // //                         TESTFIELD(Addressee);
// // //                         TESTFIELD("Request Date");
// // //                         TESTFIELD("WorkFlow Status","WorkFlow Status"::Released);
                        
// // //                         IF "Document format ID" = "Document format ID"::" " THEN
// // //                           ERROR('Select the Document format ID');
// // //                         */
// // //                         //commented By Avinash  IF "Document format ID" = "Document format ID"::"1" THEN BEGIN
// // //                         //commented By Avinash  CLEAR(Trans_SalaryRep);
// // //                         //commented By Avinash   Rec2 := Rec;
// // //                         //commented By Avinash   CurrPage.SETSELECTIONFILTER(Rec2);
// // //                         //commented By Avinash   Trans_SalaryRep.SETTABLEVIEW(Rec2);
// // //                         //commented By Avinash   Trans_SalaryRep.RUNMODAL;
// // //                         //commented By Avinash  END;


// // //                         //commented By Avinash  IF "Document format ID" = "Document format ID"::"3" THEN BEGIN
// // //                         //commented By Avinash     CLEAR(AdminCertRep);
// // //                         //commented By Avinash     EmployeeDependentsMaster.RESET;
// // //                         //commented By Avinash    EmployeeDependentsMaster.SETRANGE("Employee ID", Rec."Employee ID");
// // //                         //commented By Avinash     IF EmployeeDependentsMaster.FINDFIRST THEN BEGIN
// // //                         //commented By Avinash         AdminCertRep.SETTABLEVIEW(EmployeeDependentsMaster);
// // //                         //commented By Avinash       AdminCertRep.RUNMODAL;
// // //                         //commented By Avinash     //commented By Avinash   END;
// // //                         //commented By Avinash END;

// // //                         //commented By Avinash   IF "Document format ID" = "Document format ID"::"2" THEN BEGIN
// // //                         //commented By Avinash   CLEAR(USConsulateRep);
// // //                         IdentificationMasterRec.RESET;
// // //                         IdentificationMasterRec.SETRANGE("Employee No.", Rec."Employee ID");
// // //                         IF IdentificationMasterRec.FINDFIRST THEN BEGIN
// // //                             //commented By Avinash   USConsulateRep.SETTABLEVIEW(IdentificationMasterRec);
// // //                             //commented By Avinash   USConsulateRep.RUNMODAL;
// // //                         END;
// // //                         //commented By Avinash   END;
// // //                         //commented By Avinash    IF "Document format ID" = "Document format ID"::"4" THEN BEGIN
// // //                         //commented By Avinash   CLEAR(AdimArabRep);
// // //                         EmpRec.RESET;
// // //                         EmpRec.SETRANGE("No.", "Employee ID");
// // //                         IF EmpRec.FINDFIRST THEN BEGIN
// // //                             //commented By Avinash   AdimArabRep.SETTABLEVIEW(EmpRec);
// // //                             //commented By Avinash   AdimArabRep.RUNMODAL;
// // //                         END;
// // //                         //commented By Avinash   END;

// // //                     end;
// // //                 }
// // //             }
// // //         }
// // //     }

// // //     trigger OnAfterGetCurrRecord()
// // //     begin
// // //         SetControlVisibility();
// // //     end;

// // //     trigger OnAfterGetRecord()
// // //     begin
// // //         SetControlVisibility();
// // //     end;

// // //     trigger OnOpenPage()
// // //     begin
// // //         SetControlVisibility();
// // //     end;

// // //     var
// // //         OpenApprovalEntriesExistForCurrUser: Boolean;
// // //         OpenApprovalEntriesExist: Boolean;
// // //         CanCancelApprovalForRecord: Boolean;
// // //         ApprovalsMgmt: Codeunit "Approvals Mgmt.";
// // //         //commented By Avinash Email_Confirmation: Codeunit Email_Confirmation;
// // //         Rec2: Record "Employment Type";
// // //         //commented By Avinash Trans_SalaryRep: Report "Transfer of Salary";
// // //         //commented By Avinash  AdminCertRep: Report "ADMINISTRATIVE CERTIFICATE";
// // //         //EmployeeDependentsMaster: Record "Employee Dependents Master";
// // //         //commented By Avinash  USConsulateRep: Report "US Consulate";
// // //         IdentificationMasterRec: Record "Identification Master";
// // //         EmpRec: Record Employee;
// // //     //commented By Avinash  AdimArabRep: Report DocReq_861;

// // //     local procedure SetControlVisibility()
// // //     var
// // //         ApprovalsMgmt: Codeunit "Approvals Mgmt.";
// // //     begin
// // //         OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(RECORDID);
// // //         OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(RECORDID);
// // //         CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(RECORDID);
// // //     end;
// // // }

