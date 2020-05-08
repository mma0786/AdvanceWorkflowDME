page 60183 "Loan Adjustment  Lines"
{
    PageType = ListPart;
    SourceTable = "Loan Adjustment Lines";
    SourceTableView = SORTING("Entry No.", "Loan Adjustment ID") ORDER(Ascending);
    InsertAllowed = false;


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
                    Editable = false;
                }
                field("Loan Description"; "Loan Description")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Employee ID"; "Employee ID")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Employee Name"; "Employee Name")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Installament Date"; "Installament Date")
                {
                    Caption = 'Installment Date';
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
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Status; Status)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Create new loan line")
            {
                Image = CreateYear;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                ApplicationArea = All;
                trigger OnAction()
                begin
                    LoanAdjustmentLines.RESET;
                    LoanAdjustmentLines.SETRANGE("Loan Adjustment ID", "Loan Adjustment ID");
                    LoanAdjustmentLines.SETRANGE("Loan Request ID", "Loan Request ID");
                    LoanAdjustmentLines.SETRANGE(Loan, Loan);
                    LoanAdjustmentLines.SETRANGE("Employee ID", "Employee ID");
                    if LoanAdjustmentLines.FINDLAST then begin
                        LoanAdjustmentLines.INIT;
                        LoanAdjustmentLines."Entry No." := LoanAdjustmentLines."Entry No." + 1;
                        LoanAdjustmentLines."Loan Adjustment ID" := "Loan Adjustment ID";
                        LoanAdjustmentLines."Loan Request ID" := "Loan Request ID";
                        LoanAdjustmentLines.Loan := Loan;
                        LoanAdjustmentLines."Loan Description" := "Loan Description";
                        LoanAdjustmentLines."Employee ID" := "Employee ID";
                        LoanAdjustmentLines."Employee Name" := "Employee Name";
                        LoanAdjustmentLines."Installament Date" := 0D;
                        LoanAdjustmentLines."Principal Installment Amount" := 0;
                        LoanAdjustmentLines."Interest Installment Amount" := 0;
                        LoanAdjustmentLines.Currency := Currency;
                        LoanAdjustmentLines.Status := LoanAdjustmentLines.Status::Unrecovered;
                        LoanAdjustmentLines."New Line" := true;
                        if LoanAdjustmentLines.INSERT(true) then
                            MESSAGE(Text001);

                    end;
                end;
            }
        }
    }

    var
        LoanAdjustmentLines: Record "Loan Adjustment Lines";
        Text001: Label 'New Loan Adjustment Line has been created !';
}

