page 60035 "HCM Loan Table GCC ErnGrps"
{
    CardPageID = "HCM Loan Table GCC ErnGrp";
    PageType = List;
    SourceTable = "HCM Loan Table GCC ErnGrp";
    UsageCategory = Lists;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Earning Code Group"; "Earning Code Group")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Code"; "Loan Code")
                {
                    ApplicationArea = All;
                }
                field(Description; "Loan Description")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Local Description"; "Arabic Name")
                {
                    ApplicationArea = All;
                    Editable = false;
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
                    ApplicationArea = All;
                    Enabled = EarningCodeEditable;
                }
                field("Min Amount"; "Min Loan Amount")
                {
                    ApplicationArea = All;
                    Editable = MinEditable;
                }
                field("Max Amount"; "Max Loan Amount")
                {
                    ApplicationArea = All;
                    Editable = MinEditable;
                }
                field("Interest %"; "Interest Percentage")
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
                    Caption = 'Active';
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
                ApplicationArea = All;
                Enabled = EarningCodeEditable;
                Image = Insert;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                begin
                    //commented By Avinash   MultipleEarningCodes.SETRANGE("Loan Code", "Loan Code");

                    //commented By Avinash  if PAGE.RUNMODAL(0, MultipleEarningCodes) = ACTION::LookupOK then begin
                    //commented By Avinash  end
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
        MinEditable: Boolean;
        EarningCodeEditable: Boolean;
    //commented By Avinash   MultipleEarningCodes: Record Table55005;

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

