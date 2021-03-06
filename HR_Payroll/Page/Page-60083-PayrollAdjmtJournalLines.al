page 60083 "Payroll Adjmt. Journal Lines"
{
    AutoSplitKey = true;
    PageType = List;
    SourceTable = "Payroll Adjmt. Journal Lines";
    UsageCategory = Lists;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Line No."; "Line No.")
                {
                    Editable = false;
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
                field("Earning Code"; "Earning Code")
                {
                    ShowMandatory = true;
                    ApplicationArea = All;
                }
                field("Earning Code Description"; "Earning Code Description")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Voucher Description"; "Voucher Description")
                {
                    ApplicationArea = All;
                }
                field(Amount; Amount)
                {
                    ShowMandatory = true;
                    ApplicationArea = All;
                }
                field("Financial Dimension"; "Financial Dimension")
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
            action("Import Lines")
            {
                Caption = 'Imports Lines';
                ApplicationArea = All;
                Image = Line;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                trigger
                OnAction()
                var
                    PayrollAdjmtJournalLinesXmlport: XmlPort "Payroll Adjmt. Journal Lines";
                    PayrollAdjmtJournalheaderRecL: Record "Payroll Adjmt. Journal header";
                begin
                    PayrollAdjmtJournalheaderRecL.Reset();
                    PayrollAdjmtJournalheaderRecL.SetRange("Journal No.", "Journal No.");
                    if PayrollAdjmtJournalheaderRecL.FindFirst() then
                        if PayrollAdjmtJournalheaderRecL.Posted then
                            Error('Journal already confirmed.');

                    Clear(PayrollAdjmtJournalLinesXmlport);
                    PayrollAdjmtJournalLinesXmlport.SetJournNo("Journal No.");
                    PayrollAdjmtJournalLinesXmlport.Run();

                end;
            }
        }
    }


}

