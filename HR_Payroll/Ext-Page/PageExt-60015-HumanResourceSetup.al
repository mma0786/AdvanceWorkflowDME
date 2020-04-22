pageextension 60015 HumanResourceSetup extends "Human Resources Setup"
{
    layout
    {
        // Add changes to page layout here
        addlast(Numbering)
        {
            field("Dependent Nos."; "Dependent Nos.")
            {
                ApplicationArea = All;
            }
            field("Dependent Request"; "Dependent Request")
            {
                ApplicationArea = All;
            }
            field("Employee Creation Request Nos."; "Employee Creation Request Nos.")
            {
                ApplicationArea = All;
            }
            field("Employee Identification Nos."; "Employee Identification Nos.")
            {
                ApplicationArea = All;
            }
            field("Document Request ID"; "Document Request ID")
            {
                ApplicationArea = All;
            }
            field("Document format ID"; "Document format ID")
            {
                ApplicationArea = All;
            }
            field("Overtime Request ID No."; "Overtime Request ID No.")
            {
                ApplicationArea = All;
            }
            field("Overtime Benefit Claim No"; "Overtime Benefit Claim No")
            {
                ApplicationArea = All;
            }
            field("Contract No."; "Contract No.")
            {
                ApplicationArea = All;
            }
            field("Sector ID"; "Sector ID")
            {
                ApplicationArea = All;
            }
            field("Employee Payout Scheme ID"; "Employee Payout Scheme ID")
            {
                ApplicationArea = All;
            }
            field("Short Leave Request Id"; "Short Leave Request Id")
            {
                ApplicationArea = All;
            }
            field("User Registration>"; "User Registration")
            {
                ApplicationArea = All;
            }
            field("Time Attande-Reception"; "Time Attande-Reception")
            {
                ApplicationArea = All;
            }
            field(Registration; '')
            {
                Caption = 'Registration';
                Style = Strong;
                StyleExpr = TRUE;
                Visible = false;
            }
            field("Driving License Request ID"; "Driving License Request ID")
            {
                ApplicationArea = All;
            }
            field("Car Registration ID"; "Car Registration ID")
            {
                ApplicationArea = All;
            }
        }

        addafter(Numbering)
        {
            group(Journal)
            {
                Caption = 'Journal';
                field("OT Expense Journal Template"; "OT Expense Journal Template")
                {
                    ApplicationArea = All;
                }
                field("OT Expense Journal Batch"; "OT Expense Journal Batch")
                {
                    ApplicationArea = All;
                }
                field("OT Expense Debit Account"; "OT Expense Debit Account")
                {
                    ApplicationArea = All;
                }
            }
            group("Education Claim Journal")
            {
                Caption = 'Education & other alowance ';
                field("Education Allowance Debit"; "Education Allowance Debit")
                {
                    ApplicationArea = All;
                }
                field("Education Allowance Credit"; "Education Allowance Credit")
                {
                    ApplicationArea = All;
                }
                field("Edu. Allow. Payroll Component"; "Edu. Allow. Payroll Component")
                {
                    ApplicationArea = All;
                }
                field("Edu. Book Allowance Debit"; "Edu. Book Allowance Debit")
                {
                    ApplicationArea = All;
                }
                field("Edu. Book Allowance Credit"; "Edu. Book Allowance Credit")
                {
                    ApplicationArea = All;
                }
                field("Edu Book Payroll Component"; "Edu Book Payroll Component")
                {
                    ApplicationArea = All;
                }
                field("Special Need Allowance Debit"; "Special Need Allowance Debit")
                {
                    ApplicationArea = All;
                }
                field("Special Need Allowance Credit"; "Special Need Allowance Credit")
                {
                    ApplicationArea = All;
                }
                field("Special Need Payroll Component"; "Special Need Payroll Component")
                {
                    ApplicationArea = All;
                }
                field("Edu. Claim Journal Template"; "Edu. Claim Journal Template")
                {
                    ApplicationArea = All;
                }
                field("Edu. Claim Journal Batch"; "Edu. Claim Journal Batch")
                {
                    ApplicationArea = All;
                }
            }
            group(General)
            {
                field("Employee Dimension Code"; "Employee Dimension Code")
                {
                    LookupPageID = "Dimension List";
                    ApplicationArea = All;
                }
                field("Permissible Short Leave Hrs"; "Permissible Short Leave Hrs")
                {
                    ApplicationArea = All;
                }
            }
        }




    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}