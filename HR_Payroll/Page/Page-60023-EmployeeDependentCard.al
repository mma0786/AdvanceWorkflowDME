page 60023 "Employee Dependent Card1"
{
    PageType = Card;
    SourceTable = "Employee Dependents Master";
    //UsageCategory = Administration;
    // ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
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
                field("Personal Title"; "Personal Title")
                {
                    ApplicationArea = All;
                    Editable = EditField;
                }
                field("Dependent First Name"; "Dependent First Name")
                {
                    ApplicationArea = All;
                    Editable = EditField;
                    ShowMandatory = true;
                }
                field("Dependent Middle Name"; "Dependent Middle Name")
                {
                    ApplicationArea = All;
                    Editable = EditField;
                }
                field("Dependent Last Name"; "Dependent Last Name")
                {
                    ApplicationArea = All;
                    Editable = EditField;
                }
                field("Dependent Name in Arabic"; "Dependent Name in Arabic")
                {
                    ApplicationArea = All;
                    Editable = EditField;
                }
                field("Name in Passport in English"; "Name in Passport in English")
                {
                    Editable = EditField;
                }
                field(Relationship; Relationship)
                {
                    ApplicationArea = All;
                    Editable = EditField;
                    ShowMandatory = true;

                    trigger OnValidate()
                    begin
                        if Rec.Relationship <> Relationship::Child then begin
                            Clear("Child with Special needs");
                            Clear("Full Time Student");
                            Clear("Child Educational Level");
                        end;
                        ChildControle;
                        CurrPage.UPDATE;
                    end;
                }
                field(Gender; Gender)
                {
                    ApplicationArea = All;
                    Editable = EditField;
                    ShowMandatory = true;
                }
                field(Nationality; Nationality)
                {
                    ApplicationArea = All;
                    Editable = EditField;
                    ShowMandatory = true;
                }
                field("Date of Birth"; "Date of Birth")
                {
                    ApplicationArea = All;
                    Editable = EditField;
                    ShowMandatory = true;
                }
                field("Marital Status"; "Marital Status")
                {
                    ApplicationArea = All;
                    Editable = EditField;
                }
                field("<Marital Status>"; "Child with Special needs")
                {
                    ApplicationArea = All;
                    Editable = ChildBool;

                    trigger OnValidate()
                    begin
                        //Relationship = Relationship::Child
                    end;
                }
                field("Full Time Student"; "Full Time Student")
                {
                    ApplicationArea = All;
                    Editable = ChildBool;
                }
                field("Child Educational Level"; "Child Educational Level")
                {
                    ApplicationArea = All;
                    Editable = ChildBool;
                }
                field("Is Emergency Contact"; "Is Emergency Contact")
                {
                    ApplicationArea = All;
                    Editable = EditField;
                }
                field(Status; Status)
                {
                    ApplicationArea = All;
                    // Editable = false;
                    Visible = false;
                }
                field("Workflow Status"; "Workflow Status")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                }
                field(Religion; Religion)
                {
                    ApplicationArea = All;
                }
                field("Religion Desciption"; "Religion Desciption")
                {
                    ApplicationArea = All;
                }
                field("Is Nominee"; "Is Nominee")
                {
                    ApplicationArea = All;
                }
            }
            part("Dependent Address"; "Dependent Address ListPart1")
            {
                SubPageLink = "Dependent ID" = FIELD("No."), "Table Type Option" = FILTER("Dependent Address Line");
            }
            part("Dependent Contacts"; "Dependent Contacts SubPage")
            {
                SubPageLink = "Dependent ID" = FIELD("No."), "Table Type Option" = FILTER("Dependent Contacts Line");
                Caption = 'Dependent Contacts';
            }
            group("Contact & Address")
            {
                Visible = false;
                field("Dependent Contact No."; "Dependent Contact No.")
                {
                    ApplicationArea = All;
                    Editable = EditField;
                }
                field("Dependent Contact Type"; "Dependent Contact Type")
                {
                    ApplicationArea = All;
                    Editable = EditField;
                }
                field("Primary Contact"; "Primary Contact")
                {
                    ApplicationArea = All;
                    Editable = EditField;
                }
                field(Address; Address)
                {
                    ApplicationArea = All;
                    Editable = EditField;
                }
                field("Address 2"; "Address 2")
                {
                    ApplicationArea = All;
                    Editable = EditField;
                }
                field(PostCode; PostCode)
                {
                    ApplicationArea = All;
                    Editable = EditField;
                }
                field(City; City)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Country Region code"; "Country Region code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Private Phone Number"; "Private Phone Number")
                {
                    ApplicationArea = All;
                    Editable = EditField;
                }
                field("Direct Phone Number"; "Direct Phone Number")
                {
                    ApplicationArea = All;
                    Editable = EditField;
                }
                field("Private Email"; "Private Email")
                {
                    ApplicationArea = All;
                    Editable = EditField;
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
                    Visible = false;

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
                    Visible = false;

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

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        TESTFIELD("Dependent First Name");
                        TESTFIELD(Relationship);
                        TESTFIELD(Gender);
                        TESTFIELD(Nationality);
                        TESTFIELD("Date of Birth");

                        //commented By Avinash IF ApprovalsMgmt.CheckDep_2Possible(Rec) THEN
                        //commented By Avinash   ApprovalsMgmt.OnSendDoc_2ReqForApproval(Rec);
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

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        //ApprovalsMgmt.IsDep_2WorkflowEnabled(Rec);
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
                        ReleaseSalesDoc: Codeunit "Release Sales Document";
                    begin
                        /*IF "Workflow Status" = "Workflow Status"::"Pending Approval" THEN
                          ERROR('WorkFlow status should be Approved for reopen');

                        "Workflow Status" := "Workflow Status"::Open;
                        */

                    end;
                }
                action("Modified List")
                {
                    Image = OpenWorksheet;
                    //commented By Avinash RunObject = Page Page50031;
                    //commented By Avinash RunPageLink = Field1 = FIELD(Field1);
                    Visible = false;
                }
            }
            group(Status1)
            {
                Caption = 'Status';
                Image = SendApprovalRequest;
                action("Inactive ")
                {
                    Caption = 'Make Inactive';
                    Image = ServiceMan;
                    Promoted = true;
                    PromotedCategory = Category10;
                    Visible = false;

                    trigger OnAction()
                    begin
                        /*TESTFIELD(Status,Status::Active);
                        Status := Status::Inactive;
                        */

                    end;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        SetControlVisibility;
        Edit;
        ChildControle;
    end;

    trigger OnAfterGetRecord()
    begin
        SetControlVisibility;
        Edit;
        ChildControle;
    end;

    trigger OnModifyRecord(): Boolean
    begin
        Edit;
        ChildControle
        //CurrPage.UPDATE;
    end;

    trigger OnOpenPage()
    begin
        SetControlVisibility;
        Edit;
        ChildControle;

    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        EmployeeDependentsMaster.RESET;
        EmployeeDependentsMaster.SETRANGE("No.", "No.");
        IF EmployeeDependentsMaster.FINDFIRST THEN BEGIN
            EmployeeDependentsMaster.TESTFIELD("Dependent First Name");
            EmployeeDependentsMaster.TESTFIELD(Gender);
            EmployeeDependentsMaster.TESTFIELD(Relationship);
            EmployeeDependentsMaster.TESTFIELD("Date of Birth");
            IF EmployeeDependentsMaster."Full Time Student" = TRUE THEN
                EmployeeDependentsMaster.TESTFIELD("Child Educational Level");
        END;
    end;

    var
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        CanCancelApprovalForRecord: Boolean;
        RecEmployee: Record Employee;
        HrSetup: Record "Human Resources Setup";
        NoseriesMgt: Codeunit NoSeriesManagement;
        RecEmpIdent: Record "Identification Master";
        EditField: Boolean;
        EmployeeDependentsMaster: Record "Employee Dependents Master";
        ChildBool: Boolean;

    local procedure SetControlVisibility()
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    begin
        OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(RECORDID);
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(RECORDID);
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(RECORDID);

        ChildControle;
    end;

    local procedure Edit()
    begin
        // "Workflow Status" := "Workflow Status"::Released; // Back end fields
        // Status := Status::Active; // Back end fields
        EditField := TRUE;

    end;

    local procedure ChildControle()
    begin
        //ChildBool := true;
        IF Relationship = Relationship::Child THEN
            ChildBool := TRUE
        else
            ChildBool := false;
    end;
}

