page 60155 "Leave Adjmt. Journal Header"
{
    Caption = 'Leave Adjmt. Journal';
    PageType = Worksheet;
    SourceTable = "Leave Adj Journal header";
    ApplicationArea = All;
    UsageCategory = Documents;
    layout
    {
        area(content)
        {
            field("Show Records"; ShowRecords)
            {
                ApplicationArea = All;
                trigger OnValidate()
                begin
                    if ShowRecords = ShowRecords::Posted then
                        SETRANGE(Posted, true)
                    else
                        if ShowRecords = ShowRecords::"Not Posted" then
                            SETRANGE(Posted, false)
                        else
                            SETRANGE(Posted);

                    CurrPage.UPDATE;
                end;
            }
            field("Show User Created Records Only"; ShowUserCreatedRecordsOnly)
            {
                ApplicationArea = All;
                trigger OnValidate()
                begin
                    if ShowUserCreatedRecordsOnly then
                        SETRANGE("Posted By", USERID)
                    else
                        SETRANGE("Posted By");
                end;
            }
            repeater(Group)
            {
                field("Journal No."; "Journal No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Description; Description)
                {
                    Editable = NOT POSTED;
                    ShowMandatory = true;
                    ApplicationArea = All;
                }
                field("Pay Cycle"; "Pay Cycle")
                {
                    Editable = NOT POSTED;
                    ShowMandatory = true;
                    ApplicationArea = All;
                }
                field("Pay Period Start"; "Pay Period Start")
                {
                    Editable = NOT POSTED;
                    ShowMandatory = true;
                    ApplicationArea = All;
                }
                field("Pay Period End"; "Pay Period End")
                {
                    Editable = NOT POSTED;
                    ShowMandatory = true;
                    ApplicationArea = All;
                }
                field("Create By"; "Create By")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Created DateTime"; "Created DateTime")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Posted; Posted)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Posted By"; "Posted By")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Posted DateTime"; "Posted DateTime")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Posted Date"; "Posted Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Is Opening"; "Is Opening")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Lines)
            {
                Caption = 'Lines';
                Image = Line;
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                RunObject = Page "Leave Adjmt. Journal Lines";
                RunPageLink = "Journal No." = FIELD("Journal No.");
            }
            action(Card)
            {
                Caption = 'Card';
                Image = JobJournal;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Leave Adjmt. Journal Card";
                RunPageLink = "Journal No." = FIELD("Journal No.");
                RunPageOnRec = true;
                Visible = false;
                ApplicationArea = All;
            }
            action(Post)
            {
                Caption = 'Post';
                Image = Post;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                ApplicationArea = All;
                trigger OnAction()
                var
                    LeaveAdjJournal: Record "Leave Adj Journal header";
                    LeaveAdjJournalLines: Record "Leave Adj Journal Lines";
                begin
                    TESTFIELD(Posted, false);
                    CurrPage.SETSELECTIONFILTER(LeaveAdjJournal);
                    if LeaveAdjJournal.FINDFIRST then begin
                        LeaveAdjJournalLines.RESET;
                        LeaveAdjJournalLines.SETRANGE("Journal No.", LeaveAdjJournal."Journal No.");
                        if LeaveAdjJournalLines.FINDFIRST then begin
                            repeat
                                //commented By Avinash
                                if LeaveAdjJournal."Is Opening" then
                                    AccrualCompCalc.ValidateOpeningBalanceLeaves(LeaveAdjJournalLines."Employee Code", LeaveAdjJournalLines."Leave Type ID", NORMALDATE(LeaveAdjJournal."Pay Period Start"),
                                                                                 NORMALDATE(LeaveAdjJournal."Pay Period End"), LeaveAdjJournalLines."Earning Code Group",
                                                                                 LeaveAdjJournalLines."Accrual ID", LeaveAdjJournalLines."Calculation Units")
                                else
                                    AccrualCompCalc.ValidateAdjustmentLeaves(LeaveAdjJournalLines."Employee Code", LeaveAdjJournalLines."Leave Type ID", NORMALDATE(LeaveAdjJournal."Pay Period Start"),
                                                                                 NORMALDATE(LeaveAdjJournal."Pay Period End"), LeaveAdjJournalLines."Earning Code Group",
                                                                                 LeaveAdjJournalLines."Accrual ID", LeaveAdjJournalLines."Calculation Units");
                                AccrualCompCalc.OnAfterValidateAccrualLeaves(LeaveAdjJournalLines."Employee Code", NORMALDATE(LeaveAdjJournal."Pay Period Start"), LeaveAdjJournalLines."Leave Type ID", LeaveAdjJournalLines."Earning Code Group");
                            //commented By Avinash
                            until LeaveAdjJournalLines.NEXT = 0;
                            LeaveAdjJournal.Posted := true;
                            LeaveAdjJournal."Posted By" := USERID;
                            LeaveAdjJournal."Posted Date" := WORKDATE;
                            LeaveAdjJournal."Posted DateTime" := CURRENTDATETIME;
                            LeaveAdjJournal.MODIFY;
                        end
                        else
                            ERROR('There is nothing to post');

                    end;
                    MESSAGE('Leave Adjusment is posted');
                end;
            }
        }
    }

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    var
        LeaveAdjJournalheader: Record "Leave Adj Journal header";
    begin
        LeaveAdjJournalheader.RESET;
        CurrPage.SETSELECTIONFILTER(LeaveAdjJournalheader);
        if LeaveAdjJournalheader.FINDFIRST then begin
            if LeaveAdjJournalheader."Journal No." <> '' then begin
                TESTFIELD(Description);
                TESTFIELD("Pay Cycle");
                TESTFIELD("Pay Period End");
                TESTFIELD("Pay Period Start");
            end;
        end;
    end;

    var
        ShowRecords: Option All,"Not Posted",Posted;
        ShowUserCreatedRecordsOnly: Boolean;
        AccrualCompCalc: Codeunit "Accrual Component Calculate";
}

