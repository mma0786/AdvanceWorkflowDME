/*page 60125 "Payroll Increment Steps"
{
    AutoSplitKey = true;
    DelayedInsert = true;
    PageType = List;
    SourceTable = "Payroll Increment Steps";
    ApplicationArea = All;
    UsageCategory = Lists;
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
                field("Grade Category"; "Grade Category")
                {
                    ApplicationArea = All;
                }
                field(Grade; Grade)
                {
                    Caption = 'Earning Code Group';
                    ApplicationArea = All;
                }
                field(Steps; Steps)
                {
                    ApplicationArea = All;
                }
                field("Type of Increment"; "Type of Increment")
                {
                    ApplicationArea = All;
                }
                field("Calculation Type"; "Calculation Type")
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
            group(Line)
            {
                Caption = 'Line';
                action("Increment Lines")
                {
                    Image = Line;
                    Promoted = true;
                    PromotedCategory = Process;
                    ShortCutKey = 'Ctrl+i';
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        PayrollIncrementLineSubpage: Page "Payroll Increment Line Subpage";
                        IncrementLine: Record "Payroll Increment Line";
                    begin
                        TESTFIELD("Grade Category");
                        TESTFIELD(Grade);
                        TESTFIELD("Line No.");

                        IncrementLine.RESET;
                        IncrementLine.FILTERGROUP(2);
                        IncrementLine.SETRANGE("Grade Category", "Grade Category");
                        IncrementLine.SETRANGE(Grade, Grade);
                        IncrementLine.SETRANGE("Increment Line No.", "Line No.");
                        IncrementLine.SETRANGE("Type of Increment", "Type of Increment");
                        IncrementLine.SETRANGE("Calculation Type", "Calculation Type");

                        IncrementLine.FILTERGROUP(0);
                        PayrollIncrementLineSubpage.SETTABLEVIEW(IncrementLine);
                        PayrollIncrementLineSubpage.RUNMODAL;
                    end;
                }
                action("Update Increment Amount")
                {
                    Image = UpdateUnitCost;
                    Promoted = true;
                    PromotedCategory = Process;
                    ApplicationArea = All;
                    trigger OnAction()
                    var
                        UpdateIncSteps: Report "Update Increment Amount";
                    begin
                        CLEAR(UpdateIncSteps);
                        if not CONFIRM('Do you want to update increment steps for all Employees?', false) then
                            exit;
                        UpdateIncSteps.RUNMODAL;
                    end;
                }
            }
        }
    }

    var
        AmountVisible: Boolean;
}

*/