page 60078 "Benefit Adjmt. Lines"
{
    AutoSplitKey = true;
    DelayedInsert = true;
    LinksAllowed = false;
    MultipleNewLines = true;
    PageType = List;
    SourceTable = "Benefit Adjmt. Journal Lines";
    UsageCategory = Lists;
    // ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
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
                    ApplicationArea = All;
                    Visible = false;
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
                field(Benefit; Benefit)
                {
                    ShowMandatory = true;
                    ApplicationArea = All;
                }
                field("Benefit Description"; "Benefit Description")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Calculation Units"; "Calculation Units")
                {
                    ShowMandatory = true;
                    ApplicationArea = All;
                }
                field(Amount; Amount)
                {
                    ApplicationArea = All;
                }
                field("Financial Dimension"; "Financial Dimension")
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
                    BenefitLineImportXmlport: XmlPort "Benefit Admnt Line Xmlport";
                    BenefitHeaderRecL: Record "Benefit Adjmt. Journal header";
                begin
                    BenefitHeaderRecL.Reset();
                    BenefitHeaderRecL.SetRange("Journal No.", "Journal No.");
                    if BenefitHeaderRecL.FindFirst() then
                        if BenefitHeaderRecL.Posted then
                            Error('Journal already confirmed.');

                    Clear(BenefitLineImportXmlport);
                    BenefitLineImportXmlport.SetJournNo("Journal No.");
                    BenefitLineImportXmlport.Run();

                end;
            }
        }
    }

    var
        PayperiodCodeandLineNo: Code[40];
}

