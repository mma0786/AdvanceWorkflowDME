page 60233 "Loan Requests"
{
    CardPageID = "Loan Request";
    Editable = false;
    InsertAllowed = false;
    PageType = List;
    RefreshOnActivate = true;
    SourceTable = "Loan Request";
    SourceTableView = SORTING("Entry No.")
                      ORDER(Ascending);
    UsageCategory = Lists;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Entry No."; "Entry No.")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Loan Request ID"; "Loan Request ID")
                {
                    ApplicationArea = All;
                }
                field("Employee ID"; "Employee ID")
                {
                    ApplicationArea = All;
                }
                field("Employee Name"; "Employee Name")
                {
                    ApplicationArea = All;
                }
                field("Loan Type"; "Loan Type")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Loan Description"; "Loan Description")
                {
                    ApplicationArea = All;
                }
                field("Request Date"; "Request Date")
                {
                    ApplicationArea = All;
                }
                field("Request Amount"; "Request Amount")
                {
                }
                field("Interest Rate"; "Interest Rate")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Number of Installments"; "Number of Installments")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Repayment Start Date"; "Repayment Start Date")
                {
                    ApplicationArea = All;
                }
                field("Created By"; "Created By")
                {
                    ApplicationArea = All;
                }
                field("Created Time"; "Created Time")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Installment Created"; "Installment Created")
                {
                    ApplicationArea = All;
                }
                field("Posting Type"; "Posting Type")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Pay Period"; "Pay Period")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("WorkFlow Status"; "WorkFlow Status")
                {
                    ApplicationArea = All;
                }
                field("Created Date"; "Created Date")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
            }
        }
    }



    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        Text001: Label 'The approval process must be cancelled or completed to reopen this document.';
        LeaveRequestHeader: Record "Leave Request Header";
}

