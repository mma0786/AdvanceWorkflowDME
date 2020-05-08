page 60182 "Loan Adjustment"
{
    Caption = 'Loan Adjustment Header';
    PageType = Document;
    SourceTable = "Loan Adjustment Header";
    SourceTableView = SORTING("Loan Adjustment ID", "Loan ID", "Loan Request ID")
                      ORDER(Ascending);
    ApplicationArea = All;
    UsageCategory = Documents;
    PromotedActionCategoriesML = ENU = 'New,Process,Report,Approval,'','','','',Request Approval', ESP = 'New,Process,Report,Approval,'','','','',Request Approval';
    layout
    {
        area(content)
        {
            group(General)
            {
                Editable = VarEditable;
                field("Loan Adjustment ID"; "Loan Adjustment ID")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Adjustment Date"; "Adjustment Date")
                {
                    ApplicationArea = All;
                }
                field("Employee ID"; "Employee ID")
                {
                    ApplicationArea = All;
                }
                field("Employee Name"; "Employee Name")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Loan Request ID"; "Loan Request ID")
                {
                    ApplicationArea = All;
                }
                field("Loan ID"; "Loan ID")
                {
                    ApplicationArea = All;
                }
                field("Loan Description"; "Loan Description")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Loan Request Amount"; "Loan Request Amount")
                {
                    Caption = 'Loan Amount Requested';
                    ApplicationArea = All;
                }
                field("Workflow Status"; "Workflow Status")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
            }


            part("Loan Adjustment  Lines"; "Loan Adjustment  Lines")
            {
                Editable = "Workflow Status" = "Workflow Status"::Open;
                SubPageLink = "Employee ID" = FIELD("Employee ID"),
                              Loan = FIELD("Loan ID"),
                              "Loan Request ID" = FIELD("Loan Request ID"),
                              "Loan Adjustment ID" = FIELD("Loan Adjustment ID");
                SubPageView = SORTING("Entry No.") ORDER(Ascending);
            }


        }
    }

    actions
    {
        area(processing)
        {
            action("Get Loan Details")
            {
                Image = GetBinContent;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                Visible = false;
                ApplicationArea = All;
            }
            action("Update Installment")
            {
                Image = UpdateUnitCost;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    if not "Update Loan Bool" then
                        if "Workflow Status" = "Workflow Status"::Approved then begin


                            LoanInstallmentGeneration.RESET;
                            LoanAdjustmentLines.SETRANGE("Loan Adjustment ID", "Loan Adjustment ID");
                            LoanInstallmentGeneration.SETRANGE("Employee ID", "Employee ID");
                            LoanInstallmentGeneration.SETRANGE(Loan, "Loan ID");
                            LoanInstallmentGeneration.SETRANGE("Loan Request ID", "Loan Request ID");
                            if LoanInstallmentGeneration.FINDSET then
                                LoanInstallmentGeneration.DELETEALL;

                            LoanAdjustmentLines.SETRANGE("Loan Adjustment ID", "Loan Adjustment ID");
                            LoanAdjustmentLines.SETRANGE("Employee ID", "Employee ID");
                            LoanAdjustmentLines.SETRANGE(Loan, "Loan ID");
                            LoanAdjustmentLines.SETRANGE("Loan Request ID", "Loan Request ID");
                            if LoanAdjustmentLines.FINDSET then
                                repeat
                                    LoanInstallmentGeneration.INIT;
                                    LoanInstallmentGeneration."Entry No." := LoanInstallmentGeneration."Entry No." + 1;
                                    LoanInstallmentGeneration."Loan Request ID" := LoanAdjustmentLines."Loan Request ID";
                                    LoanInstallmentGeneration.Loan := LoanAdjustmentLines.Loan;
                                    LoanInstallmentGeneration."Loan Description" := LoanAdjustmentLines."Loan Description";
                                    LoanInstallmentGeneration."Employee ID" := LoanAdjustmentLines."Employee ID";
                                    LoanInstallmentGeneration."Employee Name" := LoanAdjustmentLines."Employee Name";
                                    LoanInstallmentGeneration."Installament Date" := LoanAdjustmentLines."Installament Date";
                                    LoanInstallmentGeneration."Principal Installment Amount" := LoanAdjustmentLines."Principal Installment Amount";
                                    LoanInstallmentGeneration."Interest Installment Amount" := LoanAdjustmentLines."Interest Installment Amount";
                                    LoanInstallmentGeneration.Currency := LoanAdjustmentLines.Currency;
                                    LoanInstallmentGeneration.Status := LoanAdjustmentLines.Status;
                                    // Updated Installment
                                    LoanAdjustmentLines."Installament Updated" := true;
                                    LoanAdjustmentLines.MODIFY;
                                    // Updated Installment
                                    LoanInstallmentGeneration.INSERT(true);
                                until LoanAdjustmentLines.NEXT = 0;
                            MESSAGE(Text50006);
                            "Update Loan Bool" := true;
                            Modify();
                        end
                        else
                            ERROR(Text50003);



                end;
            }
            group("Request Approval")
            {
                action("Submit For Approval")
                {
                    Caption = 'Submit For Approval';
                    Image = ReleaseDoc;
                    Promoted = true;
                    PromotedCategory = Category9;
                    PromotedIsBig = true;
                    ApplicationArea = All;
                    trigger OnAction()
                    var
                        LoanAdjustmentHeader: Record "Loan Adjustment Header";
                        LoanLineAmountTotalL: Decimal;
                    begin
                        TESTFIELD("Workflow Status", "Workflow Status"::Open);
                        TESTFIELD("Employee ID");
                        TESTFIELD("Loan ID");
                        TESTFIELD("Loan Request ID");

                        CLEAR(LoanLineAmountTotalL);
                        LoanAdjustmentLinesRecG.RESET;
                        LoanAdjustmentLinesRecG.SETRANGE("Loan Adjustment ID", "Loan Adjustment ID");
                        LoanAdjustmentLinesRecG.SETRANGE("Loan Request ID", "Loan Request ID");
                        LoanAdjustmentLinesRecG.SETRANGE(Loan, "Loan ID");
                        LoanAdjustmentLinesRecG.SETRANGE("Employee ID", "Employee ID");
                        if LoanAdjustmentLinesRecG.FINDSET then
                            repeat
                                LoanAdjustmentLinesRecG.TESTFIELD("Installament Date");
                                LoanLineAmountTotalL += LoanAdjustmentLinesRecG."Principal Installment Amount";
                            until LoanAdjustmentLinesRecG.NEXT = 0;

                        if LoanLineAmountTotalL <> "Loan Request Amount" then
                            ERROR('Sum of Installment Amounts %1 must be equal to Loan Amount requested %2.', LoanLineAmountTotalL, "Loan Request Amount");

                        LoanAdjustmentLines.RESET;
                        LoanAdjustmentLines.SETRANGE("Loan Adjustment ID", "Loan Adjustment ID");
                        LoanAdjustmentLines.SETRANGE("Loan Request ID", "Loan Request ID");
                        LoanAdjustmentLines.SETRANGE(Loan, "Loan ID");
                        LoanAdjustmentLines.SETRANGE("Employee ID", "Employee ID");
                        if LoanAdjustmentLines.ISEMPTY then
                            ERROR(Text50002);

                        PrincipalAmnt := 0;
                        Installemtamnt := 0;

                        LoanAdjustmentLines.SETRANGE("Loan Adjustment ID", "Loan Adjustment ID");
                        LoanAdjustmentLines.SETRANGE("Employee ID", "Employee ID");
                        LoanAdjustmentLines.SETRANGE(Loan, "Loan ID");
                        LoanAdjustmentLines.SETRANGE("Loan Request ID", "Loan Request ID");
                        if LoanAdjustmentLines.FINDSET then
                            repeat
                                PrincipalAmnt := PrincipalAmnt + LoanAdjustmentLines."Principal Installment Amount";
                                Installemtamnt := Installemtamnt + LoanAdjustmentLines."Interest Installment Amount";

                            until LoanAdjustmentLines.NEXT = 0;


                        LoanRequest.SETRANGE("Employee ID", "Employee ID");
                        LoanRequest.SETRANGE("Loan Type", "Loan ID");
                        LoanRequest.SETRANGE("Loan Request ID", "Loan Request ID");
                        if LoanRequest.FINDFIRST then;

                        PrincipalDiff := 0;
                        if LoanRequest."Request Amount" <> PrincipalAmnt then begin
                            PrincipalDiff := LoanRequest."Request Amount" - ABS(PrincipalAmnt);
                            if ABS(PrincipalDiff) > 1 then
                                ERROR(Text50001, LoanRequest."Request Amount", PrincipalAmnt);

                        end;

                        InstDiff := 0;
                        if LoanRequest."Total Installment Amount" <> Installemtamnt then begin
                            InstDiff := LoanRequest."Total Installment Amount" - ABS(Installemtamnt);
                            if ABS(InstDiff) > 1 then
                                ERROR(Text50005, Installemtamnt, LoanRequest."Total Installment Amount");

                        end;


                        //commented By Avinash  ApprovalsMgmt.OnSendLoanAdjRequestForApproval(Rec);
                        /*
                        IF UserSetup.GET(USERID) THEN BEGIN
                          ApprovalEntry.SETRANGE("Table ID",55006);
                          ApprovalEntry.SETRANGE("Document No.","Loan Adjustment ID");
                          ApprovalEntry.SETFILTER(Status,'%1',ApprovalEntry.Status::Approved);
                          IF ApprovalEntry.FINDFIRST THEN BEGIN
                             IF UserSetup."Approval Administrator" = TRUE THEN
                                LoanAdjustmentHeader.SETRANGE("Loan Adjustment ID","Loan Adjustment ID");
                                LoanAdjustmentHeader.SETRANGE("Loan ID","Loan ID");
                                IF LoanAdjustmentHeader.FINDFIRST THEN BEGIN
                                    LoanAdjustmentHeader."Workflow Status" := LoanAdjustmentHeader."Workflow Status"::Approved ;
                                     LoanAdjustmentHeader.MODIFY;
                                END;
                            END;
                          END
                          */
                        WFCode.IsLoan_Adj_Enabled(Rec);
                        WFCode.OnSendLoan_Adj_Approval(Rec);
                    end;
                }
                action("Cancel Approval Request")
                {
                    Caption = 'Cancel Approval Request';
                    Image = CancelApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category9;
                    ApplicationArea = All;
                    trigger OnAction()
                    begin
                        TESTFIELD("Workflow Status", "Workflow Status"::"Pending For Approval");
                        //commented By Avinash  ApprovalsMgmt.OnCancelLoanAdjApprovalRequest(Rec);
                        WFCode.OnCancelLoan_Adj_Approval(Rec);
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
                    Enabled = OpenApprovalEntriesExistForCurrUser;

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
            action(Reopen)
            {
                Image = ReOpen;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                ApplicationArea = All;
                trigger OnAction()
                begin
                    if "Update Loan Bool" then
                        Error('Loan Line already updated, cannot reopen .');

                    LoanAdjustmentLines.SETRANGE("Loan Adjustment ID", "Loan Adjustment ID");
                    LoanAdjustmentLines.SETRANGE("Employee ID", "Employee ID");
                    LoanAdjustmentLines.SETRANGE(Loan, "Loan ID");
                    LoanAdjustmentLines.SETRANGE("Loan Request ID", "Loan Request ID");
                    if LoanAdjustmentLines.FINDSET then
                        repeat
                            LoanAdjustmentLines.TESTFIELD("Installament Updated", false);
                        until LoanAdjustmentLines.NEXT = 0;


                    if Rec."Workflow Status" = Rec."Workflow Status"::"Pending For Approval" then
                        ERROR(Text001)
                    else
                        Rec."Workflow Status" := Rec."Workflow Status"::Open;
                    //commented By Avinash   Reopen(Rec);
                end;
            }
            action("Loan Request Card")
            {
                Image = ShowSelected;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = All;
                RunObject = Page "Loan Request";
                RunPageLink = "Loan Request ID" = FIELD("Loan Request ID");
                RunPageView = SORTING("Entry No.", "Loan Request ID") ORDER(Ascending);
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        EditableFun;
        SetControlAppearance;
    end;

    trigger OnInit()
    begin
        "Workflow Status" := "Workflow Status"::Open;
    end;

    trigger OnModifyRecord(): Boolean
    begin
        //EditableFun;
        SetControlAppearance;
    end;

    trigger OnOpenPage()
    begin
        VarEditable := true;
        "Workflow Status" := "Workflow Status"::Open;
    end;

    var
        LoanInstallmentGeneration: Record "Loan Installment Generation";
        LoanAdjustmentLines: Record "Loan Adjustment Lines";
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        PrincipalAmnt: Decimal;
        LoanRequest: Record "Loan Request";
        Text50001: Label 'Requested Loan Amount of %1 is not equal to sum of Principal Amount %2 on Loan Adjustment Lines !';
        Text001: Label 'Loan Adjustment workflow status must be Approved to Re-Open !';
        Text50002: Label 'No Loan Adjustment Lines are present !';
        Text50003: Label 'Workflow Status should be Approved !';
        UserSetup: Record "User Setup";
        ApprovalEntry: Record "Approval Entry";
        InterestAmnt: Decimal;
        Text50004: Label 'Loan Adjustment Lines already Exist !';
        VarEditable: Boolean;
        Installemtamnt: Decimal;
        Text50005: Label 'Sum of Installment Amount %1 is not equal to Installment amount sum on Loan Request Lines %2 !';
        Text50006: Label 'Loan Installment Lines has been updated ! ';
        PrincipalDiff: Decimal;
        InstDiff: Decimal;
        WFCode: Codeunit InitCodeunit_Loan_Adj;
        LoanAdjustmentLinesRecG: Record "Loan Adjustment Lines";
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        CanCancelApprovalForRecord: Boolean;

    local procedure EditableFun()
    begin
        if "Workflow Status" = "Workflow Status"::Open then
            VarEditable := true
        else
            VarEditable := false;
    end;

    procedure SetControlAppearance()
    var
    begin


        OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(RECORDID);
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(RECORDID);
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(RECORDID);
    end;
}

