page 62012 "Employee Dependent List1"
{
    // version LT_HRMS-P1-006

    CardPageID = "Employee Dependent Card";
    PageType = List;
    SourceTable = "Employee Dependents Master";
    UsageCategory = Lists;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; "No.")
                {
                    Editable = false;
                }
                field("Employee ID"; "Employee ID")
                {
                    Editable = false;
                }
                field("Employee Name"; "Employee Name")
                {
                    Editable = false;
                }
                field("Dependent First Name"; "Dependent First Name")
                {
                    Editable = false;
                }
                field("Dependent Middle Name"; "Dependent Middle Name")
                {
                    Editable = false;
                }
                field("Dependent Last Name"; "Dependent Last Name")
                {
                    Editable = false;
                }
                field("Dependent Name in Arabic"; "Dependent Name in Arabic")
                {
                    Editable = false;
                }
                field("Name in Passport in English"; "Name in Passport in English")
                {
                    Editable = false;
                }
                field(Relationship; Relationship)
                {
                    Editable = false;
                }
                field(Nationality; Nationality)
                {
                    Editable = false;
                }
                field(Gender; Gender)
                {
                    Editable = false;
                }
                field("Date of Birth"; "Date of Birth")
                {
                    Editable = false;
                }
                field("Marital Status"; "Marital Status")
                {
                    Editable = false;
                }
                field("Child with Special needs"; "Child with Special needs")
                {
                    Editable = false;
                }
                field("Child Educational Level"; "Child Educational Level")
                {
                    Editable = false;
                }
                field("Is Emergency Contact"; "Is Emergency Contact")
                {
                    Editable = false;
                }
                field("Full Time Student"; "Full Time Student")
                {
                    Editable = false;
                }
                field("Dependent Contact No."; "Dependent Contact No.")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Dependent Contact Type"; "Dependent Contact Type")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Workflow Status"; "Workflow Status")
                {
                    Editable = false;
                }
                field(Status; Status)
                {
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
                    Visible = false;

                    trigger OnAction();
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        //ApprovalsMgmt.ApproveRecordApprovalRequest(RECORDID);
                        //OpenApprovalEntriesExistForCurrUser
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
                    Visible = false;

                    trigger OnAction();
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.RejectRecordApprovalRequest(RECORDID);
                        //Visib -OpenApprovalEntriesExistForCurrUser
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
                    Visible = false;

                    trigger OnAction();
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.DelegateRecordApprovalRequest(RECORDID);
                        //visib -OpenApprovalEntriesExistForCurrUser
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
                    Enabled = NOT OpenApprovalEntriesExist;
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category9;
                    PromotedOnly = true;
                    ToolTip = 'Send an approval request.';
                    Visible = false;

                    trigger OnAction();
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        TESTFIELD("Dependent First Name");
                        TESTFIELD(Relationship);
                        TESTFIELD(Gender);
                        TESTFIELD(Nationality);
                        TESTFIELD("Date of Birth");
                        // // // // if ApprovalsMgmt.CheckDep_2Possible(Rec) then
                        // // // //     ApprovalsMgmt.OnSendDoc_2ReqForApproval(Rec);
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
                    Visible = false;

                    trigger OnAction();
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        // // // ApprovalsMgmt.IsDep_2WorkflowEnabled(Rec);
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

                    trigger OnAction();
                    var
                        ReleaseSalesDoc: Codeunit "Release Sales Document";
                    begin
                        // // // if "Workflow Status" = "Workflow Status"::"1" then
                        // // //     ERROR('WorkFlow status should be Approved for reopen');

                        // // // "Workflow Status" := "Workflow Status"::"0";
                    end;
                }
            }
            group(ActionGroup21)
            {
                Caption = 'Request Approval';
                Image = SendApprovalRequest;
                action("Dependent Identification")
                {
                    Image = ContactPerson;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    // // // RunObject = Page Page50008;
                    // // // RunPageLink = Field1 = FILTER(2),
                    // // //               Field11 = FIELD(Field1);
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord();
    begin
        SetControlVisibility;
        if RecEmployee.GET("Employee ID") then begin
            FILTERGROUP(2);
            SETRANGE("Employee ID", RecEmployee."No.");
            FILTERGROUP(0);
        end;
    end;

    trigger OnAfterGetRecord();
    begin
        SetControlVisibility;
        if RecEmployee.GET("Employee ID") then begin
            FILTERGROUP(2);
            SETRANGE("Employee ID", RecEmployee."No.");
            FILTERGROUP(0);
        end;
    end;

    trigger OnOpenPage();
    begin
        SetControlVisibility;

        //IF "Employee ID" <> '' THEN BEGIN
        if RecEmployee.GET("Employee ID") then begin
            FILTERGROUP(2);
            SETRANGE("Employee ID", RecEmployee."No.");
            FILTERGROUP(0);
        end;
    end;

    var
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        CanCancelApprovalForRecord: Boolean;
        RecEmployee: Record Employee;
        HrSetup: Record "Human Resources Setup";
        NoseriesMgt: Codeunit NoSeriesManagement;
        RecEmpIdent: Record "Identification Master";
        DependentIdPage: Page "Dependent Identification";
        Id_MastertRec: Record "Identification Master";

    local procedure SetControlVisibility();
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    begin
        OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(RECORDID);
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(RECORDID);
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(RECORDID);
    end;
}

