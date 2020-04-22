page 60077 "Benefit Adjmt. Journal"
{
    PageType = Worksheet;
    SourceTable = "Benefit Adjmt. Journal header";
    UsageCategory = Administration;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            field("Show Records"; ShowRecords)
            {
                ApplicationArea = All;

                trigger OnValidate()
                begin
                    if ShowRecords = ShowRecords::Confirmed then
                        SETRANGE(Posted, true)
                    else
                        if ShowRecords = ShowRecords::"Not Confirmed" then
                            SETRANGE(Posted, false)
                        else
                            SETRANGE(Posted);

                    CurrPage.UPDATE;
                end;
            }
            field("Show User Created Records Only"; ShowUserCreatedRecordsOnly)
            {
                ApplicationArea = All;
                Visible = false;

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
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field("Pay Cycle"; "Pay Cycle")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field("Pay Period Start"; "Pay Period Start")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field("Pay Period End"; "Pay Period End")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ShowMandatory = true;
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
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                RunObject = Page "Benefit Adjmt. Lines";
                RunPageLink = "Journal No." = FIELD("Journal No.");
            }
            action(Card)
            {
                Caption = 'Card';
                Image = JobJournal;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Benefit Adjmt. Journal Card";
                RunPageLink = "Journal No." = FIELD("Journal No.");
                RunPageOnRec = true;
                Visible = false;
            }
            action(Post)
            {
                Caption = 'Post';
                Image = Post;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                begin
                    CurrPage.SETSELECTIONFILTER(BenefitAdjHeader);
                    if BenefitAdjHeader.FINDFIRST then begin
                        if not BenefitAdjHeader.Posted then begin
                            if not CONFIRM('Do you want to Confirm the Journals') then
                                exit;

                            PayrollStatement.RESET;
                            PayrollStatement.SETRANGE("Pay Period Start Date", BenefitAdjHeader."Pay Period Start");
                            PayrollStatement.SETRANGE("Workflow Status", PayrollStatement."Workflow Status"::Approved);
                            if PayrollStatement.FINDFIRST then begin
                                BenefitAdjJnlLine.RESET;
                                BenefitAdjJnlLine.SETRANGE("Journal No.", BenefitAdjHeader."Journal No.");
                                if BenefitAdjJnlLine.FINDFIRST then
                                    repeat
                                        PayrollStatementEmployee.RESET;
                                        PayrollStatementEmployee.SETRANGE("Payroll Statement ID", PayrollStatement."Payroll Statement ID");
                                        PayrollStatementEmployee.SETRANGE(Worker, BenefitAdjJnlLine."Employee Code");
                                        if PayrollStatementEmployee.FINDFIRST then
                                            ERROR('Payroll Statement already approved for the selected period for the employee %1', BenefitAdjJnlLine."Employee Code");
                                    until BenefitAdjJnlLine.NEXT = 0;
                            end
                            else begin
                                BenefitAdjHeader.Posted := true;
                                BenefitAdjHeader."Posted By" := USERID;
                                BenefitAdjHeader."Posted DateTime" := CURRENTDATETIME;
                                BenefitAdjHeader.MODIFY;
                            end;

                        end
                        else begin
                            ERROR('Benefit Adjustment Journal already Posted');
                        end;
                    end;
                    CurrPage.UPDATE;
                end;
            }
        }
    }

    var
        ShowRecords: Option All,"Not Confirmed",Confirmed;
        ShowUserCreatedRecordsOnly: Boolean;
        BenefitAdjHeader: Record "Benefit Adjmt. Journal header";
        PayrollStatement: Record "Payroll Statement";
        BenefitAdjJnlLine: Record "Benefit Adjmt. Journal Lines";
        PayrollStatementEmployee: Record "Payroll Statement Employee";
}

