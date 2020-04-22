page 60162 "Loan Generation"
{
    Caption = 'Loan Generation';
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = ListPart;
    ShowFilter = false;
    SourceTable = "Loan Installment Generation";

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
                    Visible = false;
                    ApplicationArea = All;
                }
                field(Loan; Loan)
                {
                    ApplicationArea = All;
                }
                field("Loan Description"; "Loan Description")
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
                field("Installament Date"; "Installament Date")
                {
                    ApplicationArea = All;
                }
                field("Principal Installment Amount"; "Principal Installment Amount")
                {
                    ApplicationArea = All;
                }
                field("Interest Installment Amount"; "Interest Installment Amount")
                {
                    ApplicationArea = All;
                }
                field(Currency; Currency)
                {
                    ApplicationArea = All;
                }
                field(Status; Status)
                {
                    Caption = 'Recovery Status';
                    ApplicationArea = All;
                }
            }
        }
    }


}

