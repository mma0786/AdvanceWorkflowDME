page 60084 "Payroll Statements"
{
    DelayedInsert = false;
    PageType = Worksheet;
    SourceTable = "Payroll Statement";
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            field("Exclude Cancelled"; ExcludeCancelled)
            {
                ApplicationArea = All;

                trigger OnValidate()
                begin
                    if ExcludeCancelled then
                        SETFILTER(Status, '<>%1', Status::Cancelled)
                    else
                        SETRANGE(Status);

                    CurrPage.UPDATE;
                end;
            }
            repeater(Group)
            {
                field("Payroll Statement ID"; "Payroll Statement ID")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Payroll Statement Description"; "Payroll Statement Description")
                {
                    ShowMandatory = true;
                    ApplicationArea = All;
                }
                field("Pay Cycle"; "Pay Cycle")
                {
                    ShowMandatory = true;
                    ApplicationArea = All;
                }
                field("Payroll Period"; "Payroll Period")
                {
                    ShowMandatory = true;
                    ApplicationArea = All;
                }
                field("Pay Period Start Date"; "Pay Period Start Date")
                {
                    ApplicationArea = All;
                }
                field("Pay Period End Date"; "Pay Period End Date")
                {
                    ApplicationArea = All;
                }
                field(Status; Status)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Is Opening"; "Is Opening")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Created Date and Time"; "Created Date and Time")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Created By"; "Created By")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Workflow Status"; "Workflow Status")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Payment Status"; "Payment Status")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Statement Type"; "Statement Type")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field(Confirmed; Confirmed)
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
            action("Generate Payroll Statement")
            {
                Enabled = "Workflow Status" = "Workflow Status"::Open;
                Image = Calculate;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    CurrPage.SETSELECTIONFILTER(PayrollStatement);
                    if PayrollStatement.FINDFIRST then begin
                        //<LT_Sathish_04Mar2020_Dll_Error>
                        // Comment - repports Contains of dll error

                        CLEAR(GeneratePayrollStatement);
                        GeneratePayrollStatement.SetValues(PayrollStatement);
                        GeneratePayrollStatement.RUNMODAL;

                        //</LT_Sathish_04Mar2020_Dll_Error>
                    end;
                end;
            }
            // Start Avinash
            action("Generate Payroll Statement DLL API Report")
            {

                Image = Calculate;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                var
                    GeneratePayrollStatementL: Report "Generate Payroll Statement DLL";
                begin
                    Message('My DLL Repoprt');
                    CurrPage.SETSELECTIONFILTER(PayrollStatement);
                    if PayrollStatement.FINDFIRST then begin
                        CLEAR(GeneratePayrollStatementL);
                        GeneratePayrollStatementL.SetValues(PayrollStatement);
                        GeneratePayrollStatementL.RUNMODAL;
                    end;
                end;
            }
            // Stop Avinash
            action("Payroll Statement Employees")
            {
                Caption = 'Payroll Statement Employees';
                Enabled = EditPayrollStatementEmployee;
                Image = PaymentJournal;
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Payroll Statement Employees";
                RunPageLink = "Payroll Statement ID" = FIELD("Payroll Statement ID");


            }
            action("Payroll Error Log")
            {
                Image = ErrorLog;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Payroll Error Log";
                RunPageLink = "Payroll Statement ID" = FIELD("Payroll Statement ID");
                RunPageView = SORTING("Entry No.");
                ApplicationArea = All;
            }
            action("Submit For Approval")
            {
                Caption = 'Submit For Approval';
                Enabled = "Workflow Status" = "Workflow Status"::Open;
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                var
                    wfcode: Codeunit InitCodeunit_Payroll;
                begin
                    //
                    if not CONFIRM('Do you want to Submit the Payroll Statement?') then
                        exit;

                    CurrPage.SETSELECTIONFILTER(PayrollStatement);
                    if PayrollStatement.FINDFIRST then begin
                        //SubmitLeave(FullandFinalCalculation);
                        //commented By Avinash    if ApprovalsMgmt.CheckPayrollStatementRequestApprovalPossible(PayrollStatement) then
                        //commented By Avinash   ApprovalsMgmt.OnSendPayrollStatementRequestForApproval(PayrollStatement);

                        wfcode.IsPayrollStat_Enabled(rec);
                        wfcode.IsPayrollStatApprovalWorkflowEnabled(Rec);
                    end;
                    CurrPage.UPDATE;
                end;
            }
            action("Cancel Approval Request")
            {
                Caption = 'Cancel Approval Request';
                Enabled = "Workflow Status" = "Workflow Status"::"Pending Approval";
                Image = CancelApprovalRequest;
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    wfcode: Codeunit InitCodeunit_Payroll;
                begin
                    //
                    CurrPage.SETSELECTIONFILTER(PayrollStatement);
                    if PayrollStatement.FINDFIRST then begin
                        PayrollStatement.TESTFIELD("Workflow Status", PayrollStatement."Workflow Status"::"Pending Approval");
                        //commented By Avinash    ApprovalsMgmt.OnCancelPayrollStatementApprovalRequest(Rec);
                        wfcode.OnCancelPayrollStat_Approval(Rec);
                    end;
                    CurrPage.UPDATE;
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
                    //commented By Avinash  ApprovalsMgmt.ShowPayrollStatementApprovalEntries(Rec);
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
                Enabled = EiditPostBool;
                Image = ReOpen;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;
                trigger OnAction()
                begin
                    CurrPage.SETSELECTIONFILTER(PayrollStatement);
                    if PayrollStatement.FINDFIRST then begin
                        if PayrollStatement."Workflow Status" = PayrollStatement."Workflow Status"::"Pending Approval" then
                            ERROR(Text001);
                    end;
                    //commented By Avinash  Reopen(PayrollStatement);
                    CurrPage.UPDATE;
                end;
            }
            action("Confirm Payroll Statement")
            {
                Enabled = "Workflow Status" = "Workflow Status"::Approved;
                Image = Confirm;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    CLEAR(PayrollStatement);
                    CurrPage.SETSELECTIONFILTER(PayrollStatement);
                    if PayrollStatement.FINDFIRST then begin
                        PayrollStatement.TESTFIELD("Workflow Status", PayrollStatement."Workflow Status"::Approved);
                        //
                        PayrollStatement2.RESET;
                        PayrollStatement2.SETRANGE("Pay Period Start Date", CALCDATE('-CM', PayrollStatement."Pay Period Start Date" - 1));
                        if PayrollStatement2.FINDFIRST then
                            if not (PayrollStatement2.Status = PayrollStatement2.Status::Confirmed) then
                                ERROR('Previous Payroll Statement is not confirmed. Please confirm it to continue');
                        //
                        if not CONFIRM('Do you want to confirm the Payroll Statement ?', true) then
                            exit;
                        ConfirmPayroll(PayrollStatement);
                    end;


                    CurrPage.UPDATE;
                end;
            }
            action(Post)
            {
                Enabled = Status = Status::Confirmed;
                Image = Post;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    //
                    if not CONFIRM('This action will post payroll and create journal lines, Do you want to continue?', true) then
                        exit;
                    CurrPage.SETSELECTIONFILTER(PayrollStatement);
                    if PayrollStatement.FINDFIRST then begin
                        PayrollStatement.TESTFIELD("Workflow Status", PayrollStatement."Workflow Status"::Approved);
                        CLEAR(PayrollStatementJV);
                        PayrollStatementJV.SetValue(PayrollStatement."Payroll Statement ID");
                        PayrollStatementJV.RUN;

                    end;
                    Posted := true;
                    CurrPage.UPDATE;
                end;
            }
            action("Notify Employees")
            {
                Image = SendMail;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    //
                end;
            }
            action("Report")
            {
                Image = Print;
                Promoted = true;
                PromotedCategory = Category7;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                var
                    PayrollStatementRecL: Record "Payroll Statement";
                begin


                    CurrPage.SETSELECTIONFILTER(PayrollStatementRecL);
                    if PayrollStatementRecL.FINDFIRST then begin
                        CLEAR(PayrollStatementRep);
                        PayrollStatementRep.SetData(PayrollStatementRecL."Pay Cycle",
                        PayrollStatementRecL."Pay Period",
                       PayrollStatementRecL."Payroll Statement ID",
                       PayrollStatementRecL."Pay Period Start Date",
                       PayrollStatementRecL."Pay Period End Date");

                        PayrollStatementRep.RUNMODAL;
                    end;

                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        if Status = Status::Processing then begin
            EditPayrollStatementEmployee := false;
        end
        else begin
            EditPayrollStatementEmployee := true;
        end;

        EditPost;

        PayrollStatementEmployee.RESET;
        PayrollStatementEmployee.SETRANGE("Payroll Statement ID", Rec."Payroll Statement ID");
        if PayrollStatementEmployee.FINDFIRST then
            PayrollstatementEmployeeEntriesExist := false
        else
            PayrollstatementEmployeeEntriesExist := true;
    end;

    trigger OnOpenPage()
    begin
        ExcludeCancelled := true;
        SETFILTER(Status, '<>%1', Status::Cancelled);
        EditPost;

        PayrollStatementEmployee.RESET;
        PayrollStatementEmployee.SETRANGE("Payroll Statement ID", Rec."Payroll Statement ID");
        if PayrollStatementEmployee.FINDFIRST then
            PayrollstatementEmployeeEntriesExist := false
        else
            PayrollstatementEmployeeEntriesExist := true;
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    var
        PayrollStatementRecL: Record "Payroll Statement";
    begin
        PayrollStatementRecL.RESET;
        CurrPage.SETSELECTIONFILTER(PayrollStatementRecL);
        if PayrollStatementRecL.FINDFIRST then begin
            if PayrollStatementRecL."Payroll Statement ID" <> '' then begin
                PayrollStatementRecL.TESTFIELD("Payroll Statement Description");
                PayrollStatementRecL.TESTFIELD("Pay Period");
                PayrollStatementRecL.TESTFIELD("Pay Cycle");
            end;
        end;
    end;

    var
        ExcludeCancelled: Boolean;
        EditPayrollStatementEmployee: Boolean;
        PayrollStatement: Record "Payroll Statement";
        //<LT_Sathish_04Mar2020_Dll_Error>
        // Comment - repports Contains of dll error
        GeneratePayrollStatement: Report "Generate Payroll Statements";
        //<LT_Sathish_04Mar2020_Dll_Error>
        Statement_No: Code[10];
        PayrollStatementJV: Codeunit "Payroll Statement JV";
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        CanCancelApprovalForRecord: Boolean;
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        Text001: Label 'The approval process must be cancelled or completed to reopen this document.';
        EiditPostBool: Boolean;
        [InDataSet]
        GenPayStatBool: Boolean;
        [InDataSet]
        PayrollstatementEmployeeEntriesExist: Boolean;
        PayrollStatementEmployee: Record "Payroll Statement Employee";
        PayrollStatement2: Record "Payroll Statement";
        PayrollStatementRep: Report "Payroll Statement Report";

    local procedure EditPost()
    begin
        EiditPostBool := false;

        if "Workflow Status" = "Workflow Status"::Open then
            GenPayStatBool := true
        else
            GenPayStatBool := false;


    end;
}

