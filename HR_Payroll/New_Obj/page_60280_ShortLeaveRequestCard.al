page 60280 "Short Leave Request Card"
{
    Caption = 'Short Leave Request Card';
    PageType = Card;
    SourceTable = "Short Leave Header";


    layout
    {
        area(content)
        {
            group(General)
            {
                Editable = NOT Posted;
                field("Short Leave Request Id"; "Short Leave Request Id")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Request Date"; "Request Date")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Employee Id"; "Employee Id")
                {
                    ApplicationArea = all;
                    // Editable = EditBool;
                    ShowMandatory = true;
                }
                field("Employee Name"; "Employee Name")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Line Manager"; "Line Manager")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Pay Month"; "Pay Month")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Pay Period"; "Pay Period")
                {
                    ApplicationArea = all;
                    //  Editable = EditBool;
                    ShowMandatory = true;
                }
                field("Permissible Short Leave Hrs"; "Permissible Short Leave Hrs")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Monthly Cummulative Hrs"; "Monthly Cummulative Hrs")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Visible = false;
                }
                field("Balance of Short Leave Hours"; "Balance of Short Leave Hours")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Total Acc. short leave hours"; "Total Acc. short leave hours")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field(Posted; Posted)
                {
                    ApplicationArea = all;
                    Enabled = false;
                }
            }
            part("Short Leave Request SubPage"; "Short Leave Request SubPage")
            {
                Caption = 'Short Leave Request Line ';
                Editable = NOT Posted;
                SubPageLink = "Short Leave Request Id" = FIELD("Short Leave Request Id");
                ApplicationArea = all;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Comments1)
            {
                Caption = 'Comments';
                Image = Employee;
            }
            action(Comments)
            {
                Caption = 'Comments';
                Image = Comment;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "ShortLeaveComment1";
                RunPageLink = "Short Leave Request Id" = FIELD("Short Leave Request Id");

                trigger OnAction()
                begin
                    ShortLeaveCommRec.RESET;
                    IF NOT ShortLeaveCommRec.GET("Short Leave Request Id") THEN BEGIN
                        ShortLeaveCommRec.INIT;
                        ShortLeaveCommRec."Short Leave Request Id" := "Short Leave Request Id";
                        ShortLeaveCommRec.INSERT;
                    END
                    ;
                end;
            }
            action(POST)
            {
                Image = PostBatch;
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    ShortLeaveLineRecL: Record "Short Leave Line";
                begin
                    TESTFIELD(Posted, FALSE);

                    TESTFIELD("Short Leave Request Id");
                    TESTFIELD("Employee Id");
                    TESTFIELD("Pay Period");

                    ShortLeaveLineRecL.RESET;
                    ShortLeaveLineRecL.SETRANGE("Short Leave Request Id", "Short Leave Request Id");
                    ShortLeaveLineRecL.SETRANGE("Employee Id", "Employee Id");
                    IF ShortLeaveLineRecL.FINDSET THEN BEGIN
                        REPEAT
                            ShortLeaveLineRecL.TESTFIELD("Req. Start Time");
                            ShortLeaveLineRecL.TESTFIELD("Req. End Time");
                        UNTIL ShortLeaveLineRecL.NEXT = 0;
                    END;

                    Posted := TRUE;
                    //Commented By Avinash : Till Phase 2, Email Notification feature will be disabled.
                    /*
                    IF "Notification Sent" = FALSE THEN BEGIN
                      EmailNote.ShortLeaveNote(Rec,GetEmployeePostionEmployeeID_LT(Rec."Employee Id"));
                      "Notification Sent" := TRUE;
                      //MESSAGE('An E-Mail notifiction sent.')
                    END;
                    */
                    //Commented By Avinash : Till Phase 2, Email Notification feature will be disabled.
                    CurrPage.UPDATE(TRUE);

                end;
            }
            group("Action")
            {
                Caption = 'Action';
            }
            group(Approval)
            {
                Caption = 'Approval';
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
                    // ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin

                        // ApprovalsMgmt.ApproveRecordApprovalRequest(RECORDID);
                    end;
                }
                action(Reject)
                {
                    ApplicationArea = All;
                    Caption = 'Reject';
                    //Enabled = OpenApprovalEntriesExistForCurrUser;
                    Image = Reject;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    ToolTip = 'Reject the approval request.';
                    Visible = false;

                    trigger OnAction()
                    var
                    //  ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        //  ApprovalsMgmt.RejectRecordApprovalRequest(RECORDID);
                    end;
                }
                action(Delegate)
                {
                    ApplicationArea = All;
                    Caption = 'Delegate';
                    //Enabled = OpenApprovalEntriesExistForCurrUser;
                    Image = Delegate;
                    Promoted = true;
                    PromotedCategory = Category4;
                    ToolTip = 'Delegate the approval to a substitute approver.';
                    Visible = false;

                    trigger OnAction()
                    var
                    //  ApprovalsMgmt: Codeunit "1535";
                    begin
                        //  ApprovalsMgmt.DelegateRecordApprovalRequest(RECORDID);
                    end;
                }
            }
            group("Request Approval")
            {
                Caption = 'Request Approval';
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
                        ReqDateErr: Label 'The requested date should fall in pay period %1';
                        LineRec: Record "Short Leave Line";
                    //  ApprovalsMgmt: Codeunit "1535";
                    begin
                        TESTFIELD("Pay Month");
                        TESTFIELD("Pay Period");

                        IF ("Request Date" <= "Pay Period Start") THEN
                            ERROR(ReqDateErr, "Pay Period");

                        IF ("Request Date" >= "Pay Period End") THEN
                            ERROR(ReqDateErr, "Pay Period");

                        LineRec.RESET;
                        LineRec.SETRANGE("Short Leave Request Id", "Short Leave Request Id");
                        IF LineRec.FINDFIRST THEN;

                        LineRec.TESTFIELD("Req. End Time");
                        LineRec.TESTFIELD(Reason);


                        TESTFIELD("Request Date");
                        TESTFIELD("Pay Period");
                        TESTFIELD("Employee Id");
                        TESTFIELD(Posted, FALSE);

                        //  IF ApprovalsMgmt.CheckSLRPossible(Rec) THEN
                        //    ApprovalsMgmt.OnSendSLRForApproval(Rec);
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
                    //  ApprovalsMgmt: Codeunit "1535";
                    begin
                        //     ApprovalsMgmt.OnCancelSLRApprovalRequest(Rec);
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
                    //  ReleaseSalesDoc: Codeunit "Release Sales Document";
                    begin
                        TESTFIELD(Posted, FALSE);
                        IF "WorkFlow Status" = "WorkFlow Status"::"Pending Approval" THEN
                            ERROR('WorkFlow status should be Approved for reopen');

                        "WorkFlow Status" := "WorkFlow Status"::Open;
                    end;
                }
            }
        }



    }


    trigger OnAfterGetCurrRecord()
    begin
        SetControlVisibility;
        //EditF;
    end;

    trigger OnAfterGetRecord()
    begin
        SetControlVisibility;
        //EditF;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    var
        RecHRSetup: Record "Human Resources Setup";
        ShortLeaveLine: Record "Short Leave Line";
    begin
        //Added On 26 FEB
        "Request Date" := WORKDATE;
    end;

    trigger OnOpenPage()
    begin
        SetControlVisibility;
        EditBool := FALSE;
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        IF "Short Leave Request Id" <> '' THEN
            TESTFIELD("Employee Id");
    end;

    var
        ShortLeaveCommRec: Record "Short Leave Comments";
        ShortLeaveCommPage: Page ShortLeaveComment1;

        EditBool: Boolean;
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        CanCancelApprovalForRecord: Boolean;
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        [InDataSet]

        VisibBool: Boolean;
    // [InDataSet]
    Var
        ReqDateErr: Label 'The requested date should fall in pay period %1';
        LineRec: Record "Short Leave Line";
        EmailNote: Codeunit "Email_Confirmation";

    local procedure SetControlVisibility()
    begin
        OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(RECORDID);
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(RECORDID);
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(RECORDID);
    end;

    local procedure Visib()
    begin
        IF "WorkFlow Status" <> "WorkFlow Status"::Open THEN
            VisibBool := FALSE
        ELSE
            VisibBool := FALSE;
    end;

    /* local procedure EditF()

         EditBool := TRUE;
         IF Posted = TRUE THEN
           EditBool := FALSE;

     end;*/

    // [Scope('Internal')]
    procedure GetEmployeePostionEmployeeID_LT(EmployeeID: Code[30]): Code[50]
    var
        PayrollJobPosWorkerAssignRec_L: Record "Payroll Job Pos. Worker Assign";
        PayrollPositionRec_L: Record "Payroll Position";
    begin
        PayrollJobPosWorkerAssignRec_L.RESET;
        PayrollJobPosWorkerAssignRec_L.SETRANGE(Worker, EmployeeID);
        PayrollJobPosWorkerAssignRec_L.SETRANGE("Is Primary Position", TRUE);
        IF PayrollJobPosWorkerAssignRec_L.FINDFIRST THEN BEGIN
            PayrollPositionRec_L.RESET;
            PayrollPositionRec_L.SETRANGE("Position ID", PayrollJobPosWorkerAssignRec_L."Position ID");
            IF PayrollPositionRec_L.FINDFIRST THEN
                EXIT(PayrollPositionRec_L.Worker);
        END;

    end;

}

