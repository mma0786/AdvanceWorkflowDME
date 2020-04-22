page 60075 "Educational Claim List"
{
    CardPageID = "Educational Claim Card";
    Editable = false;
    PageType = List;
    SourceTable = "Educational Claim Header LT";
    SourceTableView = SORTING("Claim ID", "Employee No.")
                      ORDER(Ascending);
    UsageCategory = Administration;
    ApplicationArea = All;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Claim ID"; "Claim ID")
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
                field("Claim Date"; "Claim Date")
                {
                    ApplicationArea = All;
                }
                field("Academic year"; "Academic year")
                {
                    ApplicationArea = All;
                }
                field("Pay Period"; "Pay Period")
                {
                    ApplicationArea = All;
                }
                field("Posting Type"; "Posting Type")
                {
                    ApplicationArea = All;
                }
                field("Approval Status"; "Approval Status")
                {
                    ApplicationArea = All;
                }
                field(Posted; Posted)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            group("Request Approval")
            {
                Caption = 'Request Approval';
                Image = SendApprovalRequest;
                action(SendApprovalRequest)
                {
                    ApplicationArea = Suite;
                    Caption = 'Send A&pproval Request';
                    Enabled = "Approval Status" = "Approval Status"::Open;
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category9;
                    PromotedOnly = true;
                    ToolTip = 'Send an approval request.';

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                        EduClamLineRecL: Record "Educational Claim Lines LT";
                        RecordLink: Record "Record Link";
                    begin
                        // Card page function
                        /////   EducationalClaimCardLT.CheckAllowanceDepentedCount_Edu_LT;
                        // Card page funcation
                        TESTFIELD(Posted, false);
                        TESTFIELD("Employee No.");
                        TESTFIELD("Claim Date");
                        TESTFIELD("Posting Type");
                        TESTFIELD("Academic year");
                        if "Posting Type" = "Posting Type"::Payroll then begin
                            TESTFIELD("Pay Month");
                            TESTFIELD("Pay Period");
                        end;
                        EduClamLineRecL.RESET;
                        EduClamLineRecL.SETRANGE("Claim ID", "Claim ID");
                        EduClamLineRecL.SETRANGE("Employee No.", "Employee No.");
                        EduClamLineRecL.SETFILTER("Dependent ID", '<>%1', '');
                        if EduClamLineRecL.FINDSET then begin
                            repeat
                                if EduClamLineRecL."Current Claim Amount" <= 0 then
                                    ERROR('Current Claim Amount should not be Zero in Line No. %1 ', EduClamLineRecL."Line No.");
                                if (EduClamLineRecL."Period End Date" = 0D) or (EduClamLineRecL."Period Start Date" = 0D) then
                                    ERROR('Period Start Date and End Date should not be Blank.');

                            until EduClamLineRecL.NEXT = 0;
                        end else
                            ERROR('Please add Line and proceed.');

                        // Notification Mag for selecting Book Allowance
                        EduClamLineRecL.RESET;
                        EduClamLineRecL.SETRANGE("Claim ID", "Claim ID");
                        EduClamLineRecL.SETRANGE("Employee No.", "Employee No.");
                        EduClamLineRecL.SETRANGE("Academic year", "Academic year");
                        EduClamLineRecL.SETRANGE("Allowance Type", EduClamLineRecL."Allowance Type"::"Educational Book Allowance");
                        if not EduClamLineRecL.FINDFIRST then
                            ERROR(EduAllErr);
                        // Notification Mag for selecting Book Allowance

                        //
                        RecordLink.RESET;
                        RecordLink.SETRANGE("Record ID", Rec.RECORDID);
                        if not RecordLink.FINDFIRST then
                            ERROR('Attachment is mandatory');
                        //

                        //commented By Avinash if ApprovalsMgmt.CheckEduAllowPossible(Rec) then
                        //commented By Avinash    ApprovalsMgmt.OnSendEduAllowForApproval(Rec);
                    end;
                }
                action(CancelApprovalRequest)
                {
                    ApplicationArea = Suite;
                    Caption = 'Cancel Approval Re&quest';
                    Enabled = "Approval Status" = "Approval Status"::"Pending Approval";
                    Image = CancelApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category9;
                    PromotedOnly = true;
                    ToolTip = 'Cancel the approval request.';

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                        EduClamLineRecL: Record "Educational Claim Lines LT";
                    begin

                        TESTFIELD("Employee No.");
                        TESTFIELD("Claim Date");
                        TESTFIELD("Posting Type");
                        TESTFIELD("Academic year");
                        if "Posting Type" = "Posting Type"::Payroll then begin
                            TESTFIELD("Pay Month");
                            TESTFIELD("Pay Period");
                        end;

                        // EduClamLineRecL.RESET;
                        // EduClamLineRecL.SETRANGE("Claim ID", "Claim ID");
                        // EduClamLineRecL.SETRANGE("Employee No.", "Employee No.");
                        // EduClamLineRecL.SETFILTER("Dependent ID", '<>%1', '');
                        // if not EduClamLineRecL.FINDSET then
                        //     ERROR('Please add Line and proceed.');

                        //Confirmation before Cancell Approval Request.
                        if CONFIRM(Text0001, false) then begin
                            //commented By Avinash ApprovalsMgmt.OnCancelEduAllowApprovalRequest(Rec);
                            "Approval Status" := "Approval Status"::Open;
                        end;
                    end;
                }
            }
            group(ActionGroup11)
            {
                Caption = 'Release';
                Image = ReleaseDoc;
                action(Release)
                {
                    Caption = 'Re&lease';
                    Image = ReleaseDoc;
                    Promoted = true;
                    PromotedCategory = Process;
                    ShortCutKey = 'Ctrl+F9';
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        ReleaseSalesDoc: Codeunit "Release Sales Document";
                    begin
                    end;
                }
                action(Reopen)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Re&open';
                    Image = ReOpen;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;

                    ToolTip = 'Reopen the document to change it after it has been approved. Approved documents have the Released status and must be opened before they can be changed.';

                    trigger OnAction()
                    var
                        ReleaseSalesDoc: Codeunit "Release Sales Document";
                    begin
                        TESTFIELD(Posted, false);

                        if "Approval Status" = "Approval Status"::Released then begin
                            "Approval Status" := "Approval Status"::Open;
                            MODIFY();
                        end;
                    end;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin

        if ("Approval Status" = "Approval Status"::"Pending Approval") or ("Approval Status" = "Approval Status"::Released) then
            CancelContrlaVarG := true
        else
            CancelContrlaVarG := false;
    end;

    trigger OnAfterGetRecord()
    begin

        if ("Approval Status" = "Approval Status"::"Pending Approval") or ("Approval Status" = "Approval Status"::Released) then
            CancelContrlaVarG := true
        else
            CancelContrlaVarG := false;
    end;

    trigger OnModifyRecord(): Boolean
    begin

        if ("Approval Status" = "Approval Status"::"Pending Approval") or ("Approval Status" = "Approval Status"::Released) then
            CancelContrlaVarG := true
        else
            CancelContrlaVarG := false;
    end;

    trigger OnOpenPage()
    begin

        if ("Approval Status" = "Approval Status"::"Pending Approval") or ("Approval Status" = "Approval Status"::Released) then
            CancelContrlaVarG := true
        else
            CancelContrlaVarG := false;
    end;

    var
        CanCancelApprovalForRecord: Boolean;
        OpenApprovalEntriesExist: Boolean;
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        lineRec: Record "Educational Claim Lines LT";
        EduAllErr: Label 'Book Allowance is not selected \Please Select Book Allowance';
        Text0001: Label 'Are you sure you want to cancel the approval request.';
        EducationalClaimCardLT: Page "Educational Allowance Card";
        CancelContrlaVarG: Boolean;

    local procedure SetControlAppearance()
    begin
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(RECORDID);
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(RECORDID);
    end;
}

