page 60177 "Loan Type Setup"
{
    Caption = 'Loan Setup';
    PageType = Card;
    SourceTable = "Loan Type Setup";
    SourceTableView = SORTING("Loan Code")
                      ORDER(Ascending);

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Code"; "Loan Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Description; "Loan Description")
                {
                    ApplicationArea = All;
                }
                field("Local Description"; "Arabic Name")
                {
                    ApplicationArea = All;
                }
                field("Calculation Basis"; "Calculation Basis")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        EditableFunction;
                    end;
                }
                field("Earning Code for Principal"; "Earning Code for Principal")
                {
                    ApplicationArea = All;
                }
                field("Earning Code for Interest"; "Earning Code for Interest")
                {
                    ApplicationArea = All;
                }
                field("No. of times Earning Code"; "No. of times Earning Code")
                {
                    Enabled = EarningCodeEditable;
                    ApplicationArea = All;
                }
                field("Min Amount"; "Min Loan Amount")
                {
                    Editable = MinEditable;
                    ApplicationArea = All;
                }
                field("Max Amount"; "Max Loan Amount")
                {
                    Editable = MinEditable;
                    ApplicationArea = All;
                }
                field("Interest %"; "Interest Percentage")
                {
                    ApplicationArea = All;
                }
                field("Payout Earning Code"; "Payout Earning Code")
                {
                    ApplicationArea = All;
                }
                field("Allow Multiple Loans"; "Allow Multiple Loans")
                {
                    ApplicationArea = All;
                }
                field(Active; Active)
                {
                    ApplicationArea = All;
                }
                field("Loan Type Template"; "Loan Type Template")
                {
                    Caption = 'Loan Type Template';
                    ApplicationArea = All;
                }
                field("Loan Type Journal Batch"; "Loan Type Journal Batch")
                {
                    Caption = 'Loan Type Journal Batch';
                    ApplicationArea = All;
                }
                field("Number of Installments"; "Number of Installments")
                {
                    ApplicationArea = All;
                }
            }
            group("Accounting Setup")
            {
                group("Main Account")
                {
                    field("Main Account Type"; "Main Account Type")
                    {
                        ApplicationArea = All;
                    }
                    field("Main Account No."; "Main Account No.")
                    {
                        ApplicationArea = All;
                    }
                }
                group("Offset Account")
                {
                    field("Offset Account Type"; "Offset Account Type")
                    {
                        ApplicationArea = All;
                    }
                    field("Offset Account No."; "Offset Account No.")
                    {
                        ApplicationArea = All;
                    }
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Earning Code Selection")
            {
                Enabled = EarningCodeEditable;
                Image = Insert;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                ApplicationArea = All;
                trigger OnAction()
                begin
                    MultipleEarningCodes.SETRANGE("Loan Code", "Loan Code");

                    if PAGE.RUNMODAL(0, MultipleEarningCodes) = ACTION::LookupOK then begin
                    end
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        EditableFunction;
    end;

    trigger OnOpenPage()
    begin
        EditableFunction;
    end;

    var
        MultipleEarningCodes: Record "Multiple Earning Codes";
        MinEditable: Boolean;
        MultipleEditable: Boolean;
        EarningCodeEditable: Boolean;

    local procedure EditableFunction()
    begin


        if "Calculation Basis" = "Calculation Basis"::"Min/Max Amount" then begin
            EarningCodeEditable := false;
            MinEditable := true;
        end;

        if "Calculation Basis" = "Calculation Basis"::"Multiple Earning Code" then begin
            EarningCodeEditable := true;
            MinEditable := false;
        end
    end;
}

