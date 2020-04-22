page 60156 "Leave Adjmt. Journal Lines"
{
    AutoSplitKey = true;
    DelayedInsert = true;
    LinksAllowed = false;
    MultipleNewLines = true;
    PageType = List;
    SourceTable = "Leave Adj Journal Lines";
    ApplicationArea = All;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                Editable = EditLine;
                field("Journal No."; "Journal No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Voucher Description"; "Voucher Description")
                {
                    ApplicationArea = All;
                }
                field("Line No."; "Line No.")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Employee Code"; "Employee Code")
                {
                    ShowMandatory = true;
                    ApplicationArea = All;
                }
                field("Employee Name"; "Employee Name")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Leave Type ID"; "Leave Type ID")
                {
                    ShowMandatory = true;
                    ApplicationArea = All;
                }
                field("Accrual ID"; "Accrual ID")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Calculation Units"; "Calculation Units")
                {
                    ShowMandatory = true;
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Post)
            {
                Caption = 'Post';
                Image = Post;
                Promoted = true;
                PromotedCategory = Process;
                Visible = false;
                ApplicationArea = All;
                trigger OnAction()
                begin
                    /*
                    TESTFIELD(Worker);
                    TESTFIELD("Earning Code");
                    IF NOT CONFIRM('Do you want to post the earning code update lines? ') THEN
                      EXIT;
                    PostEarningCodeUpdateLines("Journal ID");
                    */

                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        LeaveAdjHeader.GET(Rec."Journal No.");
        if LeaveAdjHeader.Posted then
            EditLine := false
        else
            EditLine := true;
    end;

    trigger OnOpenPage()
    begin
        EditLine := true;
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    var
        LeaveAdjJournalLines: Record "Leave Adj Journal Lines";
    begin
        LeaveAdjJournalLines.RESET;
        CurrPage.SETSELECTIONFILTER(LeaveAdjJournalLines);
        if LeaveAdjJournalLines.FINDFIRST then begin
            if LeaveAdjJournalLines."Journal No." <> '' then begin
                TESTFIELD("Employee Code");
                TESTFIELD("Leave Type ID");
                TESTFIELD("Calculation Units");
            end;
        end;
    end;

    var
        PayperiodCodeandLineNo: Code[40];
        [InDataSet]
        EditLine: Boolean;
        LeaveAdjHeader: Record "Leave Adj Journal header";
}

