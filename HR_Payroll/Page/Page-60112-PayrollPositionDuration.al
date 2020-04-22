page 60112 "Payroll Position Duration"
{
    AutoSplitKey = true;
    Caption = 'Position Duration';
    DelayedInsert = true;
    PageType = ListPart;
    SourceTable = "Payroll Position Duration";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Activation; Activation)
                {
                    ApplicationArea = All;
                }
                field(Retirement; Retirement)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Retire)
            {
                ApplicationArea = All;
                Image = "Action";
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    TESTFIELD(Activation);
                    CLEAR(RetirePosDuration);
                    RetirePosDuration.SetValuesToRetire(Activation, Retirement, "Positin ID", true, Rec);
                    RetirePosDuration.RUNMODAL;
                end;
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        SETFILTER(Activation, '<=%1', WORKDATE);
        SETFILTER(Retirement, '>=%1|%2', WORKDATE, 0D);
    end;

    trigger OnAfterGetRecord()
    begin
        SETFILTER(Activation, '<=%1', WORKDATE);
        SETFILTER(Retirement, '>=%1|%2', WORKDATE, 0D);
    end;

    var
        RetirePosDuration: Report "Retire Position Duration";
}

