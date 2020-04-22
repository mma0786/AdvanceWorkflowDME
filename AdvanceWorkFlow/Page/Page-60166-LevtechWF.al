page 60166 "Levtech #WF"
{
    PageType = List;
    SourceTable = "Approval Entry";
    ApplicationArea = All;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Table ID"; "Table ID")
                {
                    ApplicationArea = All;
                }
                field("Document Type"; "Document Type")
                {
                    ApplicationArea = All;
                }
                field("Document No."; "Document No.")
                {
                    ApplicationArea = All;
                }
                field("Sequence No."; "Sequence No.")
                {
                    ApplicationArea = All;
                }
                field("Approval Code"; "Approval Code")
                {
                    ApplicationArea = All;
                }
                field("Sender ID"; "Sender ID")
                {
                    ApplicationArea = All;
                }
                field("Salespers./Purch. Code"; "Salespers./Purch. Code")
                {
                    ApplicationArea = All;
                }
                field("Approver ID"; "Approver ID")
                {
                    ApplicationArea = All;
                }
                field(Status; Status)
                {
                    ApplicationArea = All;
                }
                field("Date-Time Sent for Approval"; "Date-Time Sent for Approval")
                {
                    ApplicationArea = All;
                }
                field("Last Date-Time Modified"; "Last Date-Time Modified")
                {
                    ApplicationArea = All;
                }
                field("Last Modified By User ID"; "Last Modified By User ID")
                {
                    ApplicationArea = All;
                }
                field(Comment; Comment)
                {
                    ApplicationArea = All;
                }
                field("Due Date"; "Due Date")
                {
                    ApplicationArea = All;
                }
                field(Amount; Amount)
                {
                    ApplicationArea = All;
                }
                field("Amount (LCY)"; "Amount (LCY)")
                {
                    ApplicationArea = All;
                }
                field("Currency Code"; "Currency Code")
                {
                    ApplicationArea = All;
                }
                field("Approval Type"; "Approval Type")
                {
                    ApplicationArea = All;
                }
                field("Limit Type"; "Limit Type")
                {
                    ApplicationArea = All;
                }
                field("Available Credit Limit (LCY)"; "Available Credit Limit (LCY)")
                {
                    ApplicationArea = All;
                }
                field("Pending Approvals"; "Pending Approvals")
                {
                    ApplicationArea = All;
                }
                field("Record to Approve ID"; FORMAT("Record ID to Approve", 0, 1))
                {
                    ApplicationArea = All;
                }
                field("Delegation Date Formula"; "Delegation Date Formula")
                {
                    ApplicationArea = All;
                }
                field("Number of Approved Requests"; "Number of Approved Requests")
                {
                    ApplicationArea = All;
                }
                field("Number of Rejected Requests"; "Number of Rejected Requests")
                {
                    ApplicationArea = All;
                }
                field("Entry No."; "Entry No.")
                {
                    ApplicationArea = All;
                }
                field("Workflow Step Instance ID"; "Workflow Step Instance ID")
                {
                    ApplicationArea = All;
                }
                field("Related to Change"; "Related to Change")
                {
                    ApplicationArea = All;
                }
                field("Advance Date"; "Advance Date")
                {
                    ApplicationArea = All;
                }
            }


        }


    }
    actions
    {
        area(Processing)
        {
            action("Delete Approval Entrty Transcation Record")
            {
                Image = Delete;
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                trigger OnAction()
                var
                    ApprovalEntrtyTranscation: Record "Approval Entrty Transcation";
                begin
                    ApprovalEntrtyTranscation.Reset();
                    ApprovalEntrtyTranscation.DeleteAll();
                end;

            }
        }
    }


}

