page 60012 "Advance Payroll Setup"
{
    Caption = 'Advance Payroll Setup';
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Card;
    UsageCategory = Administration;
    ApplicationArea = All;
    PromotedActionCategories = 'New,Process,Report,Customer Groups,Payments';
    SourceTable = "Advance Payroll Setup";
    ;


    layout
    {
        area(content)
        {
            group(General)
            {
                field("Enable Alternate Calendar"; "Enable Alternate Calendar")
                {
                    ApplicationArea = All;
                }
                field("Employee Default Leave Type"; "Employee Default Leave Type")
                {
                    ApplicationArea = All;
                }
                field("Enable Benefit Adj. Jnl WF"; "Enable Benefit Adj. Jnl WF")
                {
                    ApplicationArea = All;
                }
                field("Enable Payroll Adj. Jnl WF"; "Enable Payroll Adj. Jnl WF")
                {
                    ApplicationArea = All;
                }
                field("Enable Loan Request WF"; "Enable Loan Request WF")
                {
                    ApplicationArea = All;
                }
                field("Enable Benefit claim req. WF"; "Enable Benefit claim req. WF")
                {
                    ApplicationArea = All;
                }
                field("Enable Leave Req. WF"; "Enable Leave Req. WF")
                {
                    ApplicationArea = All;
                }
                field("Enable Overtime Approval WF"; "Enable Overtime Approval WF")
                {
                    ApplicationArea = All;
                }
                field("Enable Payroll Statement WF"; "Enable Payroll Statement WF")
                {
                    ApplicationArea = All;
                }
                field("Enable Leave Resumption WF"; "Enable Leave Resumption WF")
                {
                    ApplicationArea = All;
                }
                field("Enable Salary Advance WF"; "Enable Salary Advance WF")
                {
                    ApplicationArea = All;
                }
                field("Enable Full and Final Jnl WF"; "Enable Full and Final Jnl WF")
                {
                    ApplicationArea = All;
                }
                field("Enable Document Req. WF"; "Enable Document Req. WF")
                {
                    ApplicationArea = All;
                }
                field("Enable Payout Scheme WF"; "Enable Payout Scheme WF")
                {
                    ApplicationArea = All;
                }
                field("Maintain Employment History"; "Maintain Employment History")
                {
                    ApplicationArea = All;
                }
                field("Maintain Benefit History"; "Maintain Benefit History")
                {
                    ApplicationArea = All;
                }
                field("Maintain Loan History"; "Maintain Loan History")
                {
                    ApplicationArea = All;
                }
                field("Maintain Leave History"; "Maintain Leave History")
                {
                    ApplicationArea = All;
                }
                field("Maintain Earning History"; "Maintain Earning History")
                {
                    ApplicationArea = All;
                }
                field("Leave Request Post"; "Leave Request Post")
                {
                    ApplicationArea = All;
                }
                field("Leave Resumption Post"; "Leave Resumption Post")
                {
                    ApplicationArea = All;
                }
                field("Post Leave Cancellation"; "Post Leave Cancellation")
                {
                    ApplicationArea = All;
                }
                field("Post Salary Adv. on approval"; "Post Salary Adv. on approval")
                {
                    ApplicationArea = All;
                }
                field("Salary Change Show Error"; "Salary Change Show Error")
                {
                    ApplicationArea = All;
                }
                field("Policy Change Show Error"; "Policy Change Show Error")
                {
                    ApplicationArea = All;
                }
                field("Accrual Effective Start Date"; "Accrual Effective Start Date")
                {
                    ApplicationArea = All;
                }
                field("Leave Period Start Date"; "Leave Period Start Date")
                {
                    ApplicationArea = All;
                }
                field("Leave Period End Date"; "Leave Period End Date")
                {
                    ApplicationArea = All;
                }
                field("Default Marital Status Spouse"; "Default Marital Status Spouse")
                {
                    ApplicationArea = All;
                    Caption = 'Default Marital Status for Spouse';
                }
            }
            group("Number Series")
            {
                Caption = 'Number Series';
                field("Job Nos"; "Job Nos")
                {
                    ApplicationArea = All;
                    Caption = 'Job ID';
                }
                field("Position No."; "Position No.")
                {
                    ApplicationArea = All;
                    Caption = 'Position ID';
                }
                field("Earning Code Update No. Series"; "Earning Code Update No. Series")
                {
                    ApplicationArea = All;
                    Caption = 'Earning Code Update ID';
                }
                field("Payroll Adj Journal No. Series"; "Payroll Adj Journal No. Series")
                {
                    ApplicationArea = All;
                    Caption = 'Payroll Adj Journal ID';
                }
                field("Benefit Adj journal No. Series"; "Benefit Adj journal No. Series")
                {
                    ApplicationArea = All;
                    Caption = 'Benefit Adj Journal ID';
                }
                field("Payroll Statement No. Series"; "Payroll Statement No. Series")
                {
                    ApplicationArea = All;
                    Caption = 'Payroll Statement ID';
                }
                field("Position No. Series"; "Position No. Series")
                {
                    ApplicationArea = All;
                    Caption = 'Position No.';
                }
                field("Benefit No. Series"; "Benefit No. Series")
                {
                    ApplicationArea = All;
                    Caption = 'Benefit No.';
                }
                field("Accrual Nos."; "Accrual Nos.")
                {
                    ApplicationArea = All;
                    Caption = 'Accrual ID';
                }
                field("Payroll Job Nos."; "Payroll Job Nos.")
                {
                    ApplicationArea = All;
                    Caption = 'Payroll Job Nos ID';
                }
                field("Leave Request Nos."; "Leave Request Nos.")
                {
                    ApplicationArea = All;
                    Caption = 'Leave Request ID';
                }
                field("OT Setup ID"; "OT Setup ID")
                {
                    ApplicationArea = All;
                    Caption = 'Over Time Setup ID';
                }
                field("Educational Claim Nos."; "Educational Claim Nos.")
                {
                    ApplicationArea = All;
                    Caption = 'Educational Claim ID';
                }
                field("FS Journal ID"; "FS Journal ID")
                {
                    ApplicationArea = All;
                    Caption = 'FS Journal ID';
                }
                field("Loan Type"; "Loan Type")
                {
                    ApplicationArea = All;
                    Caption = 'Loan Type';
                }
                field("Delegation No."; "Delegation No.")
                {
                    ApplicationArea = All;
                }
                field("Work Visa Request No."; "Work Visa Request No.")
                {
                    ApplicationArea = All;
                }
                field("Loan Request ID"; "Loan Request ID")
                {
                    ApplicationArea = All;
                }
                field("IQAMA Request No."; "IQAMA Request No.")
                {
                    ApplicationArea = All;
                }
                field("Leave Adj No Series"; "Leave Adj No Series")
                {
                    ApplicationArea = All;
                }
                field("Loan Adj. No Series"; "Loan Adj. No Series")
                {
                    ApplicationArea = All;
                }
                field("Mission Order No. Series"; "Mission Order No. Series")
                {
                    ApplicationArea = All;
                }
                field("Par diem Eligiblity No. Series"; "Par diem Eligiblity No. Series")
                {
                    ApplicationArea = All;
                }
                field("Mo Expense Request No. Series"; "Mo Expense Request No. Series")
                {
                    ApplicationArea = All;
                }
                field("Airport Access No. Series"; "Airport Access No. Series")
                {
                    ApplicationArea = All;
                }
                field("Ticketing Tool No. Series"; "Ticketing Tool No. Series")
                {
                    ApplicationArea = All;
                }
                field("Medical Expenses Doc No."; "Medical Expenses Doc No.")
                {
                    ApplicationArea = All;
                }
                field("Performance Appraisal Ser. No."; "Performance Appraisal Ser. No.")
                {
                    ApplicationArea = All;
                }
            }
            group(Journal)
            {
                Caption = 'Journal';
                field("Journal Template Name"; "Journal Template Name")
                {
                    ApplicationArea = All;
                }
                field("Journal Batch Name"; "Journal Batch Name")
                {
                    ApplicationArea = All;
                }
            }
            group("Per diem Journal")
            {
                field("Par diem Journal Template Name"; "Par diem Journal Template Name")
                {
                    ApplicationArea = All;
                }
                field("Par diem Journal Batch Name"; "Par diem Journal Batch Name")
                {
                    ApplicationArea = All;
                }
                field("Par diem Debit Account"; "Par diem Debit Account")
                {
                    ApplicationArea = All;
                }
                field("Par diem Credit Account"; "Par diem Credit Account")
                {
                    ApplicationArea = All;
                }
            }
            group("MO Expense Request")
            {
                field("MO Expense REQ Journal Template Name"; "MOEXPREQ Journal Template Name")
                {
                    ApplicationArea = All;
                    Caption = 'MO Expense REQ Journal Template Name';
                    ToolTip = 'MO Expense REQ Journal Template Name';
                }
                field("MO Exp Request Journal Batch Name"; "MOEXPREQ Journal Batch Name")
                {
                    ApplicationArea = All;
                    Caption = 'MO Exp Request Journal Batch Name';
                    ToolTip = 'MO Exp Request Journal Batch Name';
                }
                field("MO Expense Request Debit Account"; "MOEXPREQ Debit Account")
                {
                    ApplicationArea = All;
                    Caption = 'MO Expense Request Debit Account';
                    ToolTip = 'MO Expense Request Debit Account';
                }
                field("MO Expense Request Credit Account"; "MOEXPREQ Credit Account")
                {
                    ApplicationArea = All;
                    Caption = 'MO Expense Request Credit Account';
                    ToolTip = 'MO Expense Request Credit Account';
                }
            }
            group("Medical Expenses")
            {
                field("Medical Expenses Gen. Template"; "Medical Expenses Gen. Template")
                {
                    ApplicationArea = All;
                }
                field("Medical Expenses Gen. Batch"; "Medical Expenses Gen. Batch")
                {
                    ApplicationArea = All;
                }
                field("Medical Expenses Debit Account"; "Medical Expenses Debit Account")
                {
                    ApplicationArea = All;
                }
                field("Medical Expense Credit Account"; "Medical Expense Credit Account")
                {
                    ApplicationArea = All;
                }
            }
            group("Accrual Formula for per day")
            {
                field("Accrual Per day Formula"; "Accrual Per day Formula")
                {
                    ApplicationArea = All;
                }
            }
        }
    }



    trigger OnOpenPage()
    begin
        RESET;
        if not GET then begin
            INIT;
            INSERT;
        end;
    end;
}

