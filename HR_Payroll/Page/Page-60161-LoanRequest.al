page 60161 "Loan Request"
{
    Caption = 'Loan Request';
    PageType = Card;
    SourceTable = "Loan Request";
    SourceTableView = SORTING("Entry No.", "Loan Request ID")
                      ORDER(Ascending);

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Request ID"; "Loan Request ID")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Employee No."; "Employee ID")
                {
                    Enabled = VarEditable;
                    ShowMandatory = true;
                    ApplicationArea = All;
                }
                field("Employee Name"; "Employee Name")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("WorkFlow Status"; "WorkFlow Status")
                {
                    Caption = 'Workflow Status';
                    //Editable = false;
                    ApplicationArea = All;
                }
                field("Loan Type"; "Loan Type")
                {
                    Editable = VarEditable;
                    ShowMandatory = true;
                    ApplicationArea = All;
                }
                field("Loan Description"; "Loan Description")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Request Date"; "Request Date")
                {
                    Editable = VarEditable;
                    ApplicationArea = All;
                }
                field("Request Amount"; "Request Amount")
                {
                    Editable = VarEditable;
                    ApplicationArea = All;
                }
                field("Interest Rate"; "Interest Rate")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Number of Installments"; "Number of Installments")
                {
                    Editable = VarEditable;
                    ShowMandatory = true;
                    ApplicationArea = All;
                }
                field("Repayment Start Date"; "Repayment Start Date")
                {
                    Editable = VarEditable;
                    ApplicationArea = All;
                }
                field("Created By"; "Created By")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Created Time"; "Created Time")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Total Installment Amount"; "Total Installment Amount")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Posting Type"; "Posting Type")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Pay Period"; "Pay Period")
                {
                    Editable = VarEditable;
                    Visible = false;
                    ApplicationArea = All;
                }
            }


            part("Installment Generation"; "Loan Generation")
            {
                Caption = 'Installment Generation';
                Editable = false;
                SubPageLink = "Loan Request ID" = FIELD("Loan Request ID");
                SubPageView = SORTING("Entry No.") ORDER(Ascending);
                ApplicationArea = All;
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
                action("Create Journal")
                {
                    Caption = 'Create Journal';
                    Enabled = JournalButton;
                    Image = PostApplication;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = All;
                    trigger OnAction()
                    begin
                        if ("Posting Type" = "Posting Type"::Finance) and ("Journal Created" = false) then
                            CreateJournal;


                        if ("Posting Type" = "Posting Type"::Payroll) and ("Journal Created" = false) then
                            PayrollAdjmtJournal;
                    end;
                }
                action("Send for Approval")
                {
                    Caption = 'Send for Approval';
                    Enabled = (NOT OpenApprovalEntriesExist) AND ("Workflow Status" = "Workflow Status"::Open);
                    Image = ReleaseDoc;
                    Promoted = true;
                    PromotedCategory = Process;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        ApprovalEntry: Record "Approval Entry";
                        wfcode: Codeunit InitCodeunit_Loan_Request;
                    begin
                        TESTFIELD("Employee ID");
                        TESTFIELD("Loan Type");

                        TESTFIELD("Request Amount");
                        TESTFIELD("Number of Installments");
                        //TESTFIELD("Interest Rate");
                        TESTFIELD("Repayment Start Date");

                        //commented By Avinash   ApprovalsMgmt.OnSendLoanRequestForApproval(Rec);

                        /* if UserSetup.GET(USERID) then begin
                             ApprovalEntry.SETRANGE("Table ID", 60113);
                             ApprovalEntry.SETRANGE("Document No.", "Loan Request ID");
                             ApprovalEntry.SETFILTER(Status, '%1', ApprovalEntry.Status::Approved);
                             if ApprovalEntry.FINDFIRST then begin
                                 if UserSetup."Approval Administrator" = true then
                                     LoanRequest.SETRANGE("Loan Request ID", "Loan Request ID");
                                 LoanRequest.SETRANGE("Loan Type", "Loan Type");
                                 if LoanRequest.FINDFIRST then begin
                                     LoanRequest."WorkFlow Status" := LoanRequest."WorkFlow Status"::Approved;
                                     LoanRequest.MODIFY;
                                 end;

                             
                    end;

                    end*/
                        wfcode.Is_Loan_Request_Enabled(rec);
                        wfcode.OnSendLoan_Request_Approval(Rec);
                    end;
                }
                action("Cancel Approval Request")
                {
                    Caption = 'Cancel Approval Request';
                    Enabled = "WorkFlow Status" = "WorkFlow Status"::"Pending For Approval";
                    Image = CancelApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Process;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        WfCode: Codeunit InitCodeunit_Loan_Request;
                    begin
                        //commented By Avinash     ApprovalsMgmt.OnCancelLoanApprovalRequest(Rec);
                        /*
                        "WorkFlow Status" := "WorkFlow Status"::Open;
                        MODIFY;
                        */
                        TestField("WorkFlow Status", "WorkFlow Status"::"Pending For Approval");
                        WfCode.OnCancelLoan_Request_Approval(rec);
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
                        ApprovalEntry.SETRANGE("Table ID", DATABASE::"Loan Request");
                        ApprovalEntry.SETRANGE("Record ID to Approve", Rec.RecordId);
                        ApprovalEntry.SETRANGE("Related to Change", FALSE);
                        PAGE.RUN(70010, ApprovalEntry);
                    end;
                }
                action(Reopen)
                {
                    Enabled = ("WorkFlow Status" = "WorkFlow Status"::Released);
                    Image = ReOpen;
                    Promoted = true;
                    PromotedCategory = Process;
                    ApplicationArea = All;
                    trigger OnAction()
                    begin
                        LoanInstallmentGenerationRecG.RESET;
                        LoanInstallmentGenerationRecG.SETRANGE("Loan Request ID", "Loan Request ID");
                        LoanInstallmentGenerationRecG.SETRANGE("Employee ID", "Employee ID");
                        LoanInstallmentGenerationRecG.SETRANGE(Loan, "Loan Type");
                        if LoanInstallmentGenerationRecG.FINDSET then begin
                            CounterLineG := LoanInstallmentGenerationRecG.COUNT;
                            if CounterLineG > 0 then
                                ERROR('Installment Lines generated,cannot Re-open the Request.');
                        end;
                        if Rec."WorkFlow Status" = Rec."WorkFlow Status"::"Pending For Approval" then
                            ERROR(Text001);

                        Reopen(Rec);
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
                action("Journal Lines")
                {
                    Image = Journals;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = "Report";
                    ApplicationArea = All;
                    trigger OnAction()
                    begin
                        if LoanTypeSetup.GET("Loan Type") then;
                        LoanTypeSetup.TESTFIELD("Loan Type Journal Batch");
                        LoanTypeSetup.TESTFIELD("Loan Type Template");

                        GenJournalLine.SETRANGE("Journal Batch Name", LoanTypeSetup."Loan Type Journal Batch");
                        GenJournalLine.SETRANGE("Journal Template Name", LoanTypeSetup."Loan Type Template");
                        //GenJournalLine.SETFILTER("Document Date",'%1',"Request Date");
                        GenJournalLine.SETRANGE("Document No.", "Journal Document No.");
                        if GenJournalLine.FINDFIRST then
                            PAGE.RUN(PAGE::"General Journal", GenJournalLine)
                        else
                            ERROR(Text5004, "Loan Request ID");
                    end;
                }
                action("Create Installment")
                {
                    Enabled = ("WorkFlow Status" = "WorkFlow Status"::Released);
                    Image = CreateInteraction;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    Visible = true;
                    ApplicationArea = All;
                    trigger OnAction()
                    var
                        newdate: Date;
                        PrincipalAmount: Decimal;
                        ReountOffValueG: Decimal;
                    begin
                        // Commented By Avinas 
                        // // // if "WorkFlow Status" <> "WorkFlow Status"::Approved then
                        // // //     ERROR(Text5002);

                        TESTFIELD("Request Amount");
                        TESTFIELD("Number of Installments");
                        //TESTFIELD("Interest Rate");
                        TESTFIELD("Repayment Start Date");

                        if "Installment Created" = true then
                            ERROR(Text50001);

                        PrincipalAmnt := 0;
                        InterestAmnt := 0;

                        PrincipalAmnt := ROUND((("Request Amount") / ("Number of Installments")), 0.01);
                        InterestAmnt := ROUND((("Request Amount") * (("Interest Rate") / 100) / ("Number of Installments")), 0.01);

                        EmployeeEarningCodeGroups.SETRANGE("Employee Code", "Employee ID");
                        if EmployeeEarningCodeGroups.FINDFIRST then;

                        CLEAR(PrincipalAmount);
                        CLEAR(ReountOffValueG);
                        for i := 1 to "Number of Installments" do begin
                            if LoanInstallmentGeneration.FINDLAST then;
                            LoanInstallmentGeneration."Entry No." := LoanInstallmentGeneration."Entry No." + 1;
                            LoanInstallmentGeneration."Loan Request ID" := "Loan Request ID";
                            LoanInstallmentGeneration.Loan := "Loan Type";
                            LoanInstallmentGeneration."Loan Description" := "Loan Description";
                            LoanInstallmentGeneration."Employee ID" := "Employee ID";
                            LoanInstallmentGeneration."Employee Name" := "Employee Name";
                            LoanInstallmentGeneration.Currency := EmployeeEarningCodeGroups.Currency;


                            if i > 1 then
                                LoanInstallmentGeneration."Installament Date" := CALCDATE('1M', VarDate)
                            else
                                LoanInstallmentGeneration."Installament Date" := "Repayment Start Date";

                            VarDate := LoanInstallmentGeneration."Installament Date";

                            LoanInstallmentGeneration."Interest Installment Amount" := InterestAmnt;
                            if i = "Number of Installments" then begin
                                ReountOffValueG := ROUND("Request Amount" - (ROUND(PrincipalAmnt, 0.01) * "Number of Installments"), 0.01);
                                // MESSAGE('PrincipalAmnt %1  ReountOffValueG %2',PrincipalAmnt , ReountOffValueG);

                                LoanInstallmentGeneration."Principal Installment Amount" := (ROUND(PrincipalAmnt, 0.01) + ReountOffValueG);
                            end else
                                LoanInstallmentGeneration."Principal Installment Amount" := ROUND(PrincipalAmnt, 0.01);

                            LoanInstallmentGeneration.Status := LoanInstallmentGeneration.Status::Unrecovered;
                            LoanInstallmentGeneration.INSERT;

                            "Total Installment Amount" := "Total Installment Amount" + LoanInstallmentGeneration."Interest Installment Amount";


                            "Installment Created" := true;
                            VarEditable := false;
                        end;
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        EditableFun;
        if ("Installment Created" = true) and ("Journal Created" = false) then
            JournalButton := true;

        SetControlVisibility;
    end;

    trigger OnModifyRecord(): Boolean
    begin
        EditableFun;
    end;

    trigger OnOpenPage()
    begin
        VarEditable := true;
        if ("Installment Created" = true) and ("Journal Created" = false) then
            JournalButton := true;

        SetControlVisibility;
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    var
        LoanRequest: Record "Loan Request";
    begin
        LoanRequest.RESET;
        CurrPage.SETSELECTIONFILTER(LoanRequest);
        if LoanRequest.FINDFIRST then begin
            if (LoanRequest."Loan Request ID" <> '') then begin
                TESTFIELD("Employee ID");
                TESTFIELD("Loan Type");
                TESTFIELD("Number of Installments");
            end;
        end;
    end;

    var
        LoanInstallmentGeneration: Record "Loan Installment Generation";
        i: Integer;
        Installmentamount: Decimal;
        Text50001: Label 'Installment Lines Already Created !!';
        PrincipalAmnt: Decimal;
        InterestAmnt: Decimal;
        PeriodLength: DateFormula;
        [InDataSet]
        VarEditable: Boolean;
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        LeaveRequestHeader: Record "Leave Request Header";
        Text001: Label 'Loan Request workflow status must be cancelled or completed to open the document !';
        EmployeeEarningCodeGroups: Record "Employee Earning Code Groups";
        Text5002: Label 'Workflow Status should be Approved to create Installments !';
        UserSetup: Record "User Setup";
        LoanRequest: Record "Loan Request";
        VarDate: Date;
        GenJournalLine: Record "Gen. Journal Line";
        LoanTypeSetup: Record "Loan Type Setup";
        GenJournalBatch: Record "Gen. Journal Batch";
        NoSeriesManagement: Codeunit NoSeriesManagement;
        Text50003: Label 'Journal Created Successfully with Document No.%1 !';
        EditJournal: Boolean;
        GeneralJournal: Page "General Journal";
        Text5004: Label 'Journal Lines does not exist again Loan Request %1';
        JournalButton: Boolean;
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        CanCancelApprovalForRecord: Boolean;
        LoanInstallmentGenerationRecG: Record "Loan Installment Generation";
        CounterLineG: Integer;

    local procedure EditableFun()
    begin
        if "Installment Created" = true then
            VarEditable := false;

        if "WorkFlow Status" <> "WorkFlow Status"::Open then
            VarEditable := false
        else
            VarEditable := true;
    end;

    local procedure CreateJournal()
    var
        GenJournalLineRecL: Record "Gen. Journal Line";
        GenJournalLineRecL2: Record "Gen. Journal Line";
        EducationalClaimLinesRecL: Record "Educational Claim Lines LT";
        NewLineNoL: Integer;
        NewDocumentNoL: Code[20];
        UpdateDimensions: Codeunit "Update Dimensions";
    begin
        LoanTypeSetup.SETRANGE("Loan Code", "Loan Type");
        if LoanTypeSetup.FINDFIRST then;

        GenJournalBatch.GET(LoanTypeSetup."Loan Type Template", LoanTypeSetup."Loan Type Journal Batch");
        GenJournalBatch.TESTFIELD("No. Series");

        NewDocumentNoL := NoSeriesManagement.GetNextNo(GenJournalBatch."No. Series", TODAY, true);
        GenJournalLineRecL2.RESET;
        GenJournalLineRecL2.SETRANGE("Journal Batch Name", LoanTypeSetup."Loan Type Journal Batch");
        GenJournalLineRecL2.SETRANGE("Journal Template Name", LoanTypeSetup."Loan Type Template");
        GenJournalLineRecL2.DELETEALL;


        GenJournalLineRecL2.RESET;
        GenJournalLineRecL2.SETRANGE("Journal Batch Name", LoanTypeSetup."Loan Type Journal Batch");
        GenJournalLineRecL2.SETRANGE("Journal Template Name", LoanTypeSetup."Loan Type Template");
        GenJournalLineRecL2.SETRANGE("Document No.", NewDocumentNoL);
        if GenJournalLineRecL2.FINDLAST then;
        GenJournalLineRecL.INIT;
        GenJournalLineRecL."Journal Batch Name" := LoanTypeSetup."Loan Type Journal Batch";
        GenJournalLineRecL."Journal Template Name" := LoanTypeSetup."Loan Type Template";
        GenJournalLineRecL."Line No." := GenJournalLineRecL2."Line No." + 10000;
        GenJournalLineRecL.INSERT;
        GenJournalLineRecL.VALIDATE("Document No.", NewDocumentNoL);
        GenJournalLineRecL.VALIDATE("Document Date", "Request Date");
        GenJournalLineRecL.VALIDATE("Posting Date", TODAY);
        GenJournalLineRecL.VALIDATE("Document Type", GenJournalLineRecL."Document Type"::Payment);
        GenJournalLineRecL.VALIDATE("Account Type", GenJournalLineRecL."Account Type"::"G/L Account");
        GenJournalLineRecL.VALIDATE("Account No.", LoanTypeSetup."Main Account No.");
        GenJournalLineRecL.VALIDATE("Bal. Account Type", GenJournalLineRecL."Account Type"::"G/L Account");
        GenJournalLineRecL.VALIDATE("Bal. Account No.", LoanTypeSetup."Offset Account No.");
        GenJournalLineRecL.VALIDATE(Amount, "Request Amount");
        UpdateDimensions.ValidateShortCutDimension(GenJournalLineRecL, Rec."Employee ID");
        if GenJournalLineRecL.MODIFY then begin
            EditJournal := false;
            "Journal Created" := true;
            JournalButton := false;
            MESSAGE(Text50003, NewDocumentNoL);
            VALIDATE("Journal Document No.", NewDocumentNoL);
            MODIFY;
        end;
    end;

    local procedure PayrollAdjmtJournal()
    var
        PayrollAdjmtJournalheaderRecL: Record "Payroll Adjmt. Journal header";
        PayPeriod: Record "Pay Periods";
        AdvPayrollSetup: Record "Advance Payroll Setup";
        NoSeriesManagement: Codeunit NoSeriesManagement;
        DocumentNo: Code[20];
    begin
        AdvPayrollSetup.GET;

        PayPeriod.SETRANGE("Pay Cycle", "Pay Cycle");
        if PayPeriod.FINDFIRST then begin

            PayrollAdjmtJournalheaderRecL.INIT;
            DocumentNo := NoSeriesManagement.GetNextNo(AdvPayrollSetup."Payroll Adj Journal No. Series", TODAY, true);

            PayrollAdjmtJournalheaderRecL.VALIDATE("Journal No.", DocumentNo);
            PayrollAdjmtJournalheaderRecL.Description := 'Loan Request Payroll Adjustment';
            PayrollAdjmtJournalheaderRecL.VALIDATE("Pay Cycle", "Pay Cycle");
            PayrollAdjmtJournalheaderRecL.VALIDATE("Pay Period Start", PayPeriod."Period Start Date");
            PayrollAdjmtJournalheaderRecL.VALIDATE("Pay Period End", PayPeriod."Period End Date");
            PayrollAdjmtJournalheaderRecL."Create By" := USERID;
            PayrollAdjmtJournalheaderRecL.VALIDATE("Created DateTime", CURRENTDATETIME);
            PayrollAdjmtJournalheaderRecL."Posted By" := USERID;
            PayrollAdjmtJournalheaderRecL.Posted := true;
            PayrollAdjmtJournalheaderRecL.VALIDATE("Posted DateTime", CURRENTDATETIME);

            if PayrollAdjmtJournalheaderRecL.INSERT then begin
                PayrollAdjmtJournalLine(DocumentNo);
                "Journal Created" := true;
                JournalButton := false;
                MESSAGE('Payroll Adjustment Created Successfully  %1', DocumentNo);

            end;
        end;
    end;

    local procedure PayrollAdjmtJournalLine("DocumentNo.": Code[20])
    var
        PayrollAdjmtJournalLines1: Record "Payroll Adjmt. Journal Lines";
        PayrollAdjmtJournalLines: Record "Payroll Adjmt. Journal Lines";
        NewLineNo: Integer;
    begin
        LoanTypeSetup.SETRANGE("Loan Code", "Loan Type");
        if LoanTypeSetup.FINDFIRST then;

        PayrollAdjmtJournalLines.RESET;
        PayrollAdjmtJournalLines.SETRANGE("Journal No.", "DocumentNo.");
        if PayrollAdjmtJournalLines.FINDLAST then
            NewLineNo := PayrollAdjmtJournalLines."Line No." + 10000
        else
            NewLineNo := 10000;

        PayrollAdjmtJournalLines1.INIT;
        PayrollAdjmtJournalLines1.VALIDATE("Journal No.", "DocumentNo.");
        PayrollAdjmtJournalLines1.VALIDATE("Line No.", NewLineNo);
        PayrollAdjmtJournalLines1.VALIDATE("Employee Code", "Employee ID");
        PayrollAdjmtJournalLines1.VALIDATE("Employee Name", "Employee Name");
        PayrollAdjmtJournalLines1.VALIDATE("Earning Code", LoanTypeSetup."Payout Earning Code");
        PayrollAdjmtJournalLines1.VALIDATE(Amount, "Request Amount");
        PayrollAdjmtJournalLines1.INSERT;

        /*
        HCMLoanTableGCCWrkr.SETRANGE(Active,TRUE);
        IF PAGE.RUNMODAL(0,HCMLoanTableGCCWrkr) = ACTION::LookupOK THEN BEGIN
           "Loan Type" := HCMLoanTableGCCWrkr."Loan Id";
           "Loan Description" := HCMLoanTableGCCWrkr.Description;
           "Interest Rate" := HCMLoanTableGCCWrkr."Fixed Interest Percentage";
          END;
        
        
        */

    end;

    local procedure SetControlVisibility()
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    begin
        OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(RECORDID);
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(RECORDID);
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(RECORDID);
    end;
}

