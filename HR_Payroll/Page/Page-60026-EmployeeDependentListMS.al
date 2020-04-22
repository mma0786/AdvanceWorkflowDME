page 60026 "Employee Dependent List MS1"
{
    CardPageID = "Employee Dependent Card1";
    PageType = List;
    SourceTable = "Employee Dependents Master";
    UsageCategory = Administration;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; "No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Employee ID"; "Employee ID")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Employee Name"; "Employee Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Dependent First Name"; "Dependent First Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Dependent Middle Name"; "Dependent Middle Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Dependent Last Name"; "Dependent Last Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Dependent Name in Arabic"; "Dependent Name in Arabic")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Name in Passport in English"; "Name in Passport in English")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Relationship; Relationship)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Nationality; Nationality)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Gender; Gender)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Date of Birth"; "Date of Birth")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Marital Status"; "Marital Status")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Child with Special needs"; "Child with Special needs")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Child Educational Level"; "Child Educational Level")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Is Emergency Contact"; "Is Emergency Contact")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Full Time Student"; "Full Time Student")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Dependent Contact No."; "Dependent Contact No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Dependent Contact Type"; "Dependent Contact Type")
                {
                    ApplicationArea = All;
                    Editable = false;
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

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        //commented By Avinash  if ApprovalsMgmt.CheckDep_2Possible(Rec) then
                        //commented By Avinash     ApprovalsMgmt.OnSendDoc_2ReqForApproval(Rec);
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

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        //commented By Avinash    ApprovalsMgmt.IsDep_2WorkflowEnabled(Rec);
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

                    trigger OnAction()
                    var
                        ReleaseSalesDoc: Codeunit "Release Sales Document";
                    begin
                        if "Workflow Status" = "Workflow Status"::"Pending Approval" then
                            ERROR('WorkFlow status should be Approved for reopen');

                        "Workflow Status" := "Workflow Status"::Open;
                    end;
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        SetControlVisibility;
    end;

    var
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        CanCancelApprovalForRecord: Boolean;
        RecEmployee: Record Employee;
        HrSetup: Record "Human Resources Setup";
        NoseriesMgt: Codeunit NoSeriesManagement;
        RecEmpIdent: Record "Identification Master";

    local procedure SetControlVisibility()
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    begin
        OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(RECORDID);
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(RECORDID);
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(RECORDID);
    end;
}

