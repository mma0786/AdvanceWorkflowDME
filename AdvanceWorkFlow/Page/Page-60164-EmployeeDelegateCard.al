page 60164 "Employee Delegate - Card"
{
    Caption = 'Employee Delegation';
    DelayedInsert = false;
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Card;
    SourceTable = "Delegate - WFLT";
    UsageCategory = Administration;
    //ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Employee Code"; "Employee Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Employee ID"; "Employee ID")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Delegate To"; "Delegate To")
                {
                    ApplicationArea = All;
                }
                field("To Date"; "To Date")
                {
                    ApplicationArea = All;
                }
                field("From Date"; "From Date")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        DelegateWFLTRec_G.RESET;
        DelegateWFLTRec_G.SETRANGE("Employee Code", "Employee Code");
        DelegateWFLTRec_G.SETRANGE("Employee ID", "Employee ID");
        if DelegateWFLTRec_G.FINDFIRST then
            if DelegateWFLTRec_G."Delegate To" <> '' then begin
                DelegateWFLTRec_G.TESTFIELD("From Date");
                DelegateWFLTRec_G.TESTFIELD("To Date");
            end;
    end;

    var
        DelegateWFLTRec_G: Record "Delegate - WFLT";
}

