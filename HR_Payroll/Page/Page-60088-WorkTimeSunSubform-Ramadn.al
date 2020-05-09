page 60300 "Work Time SunSubform-Ramadn"
{
    // version LT_Payroll

    AutoSplitKey = true;
    Caption = 'Work Time SunSubform-Ramadn';
    DelayedInsert = true;
    PageType = ListPart;
    SourceTable = "Work Time Line - Ramadn";
    SourceTableView = WHERE(Weekday = CONST(Sunday));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("From Time"; "From Time")
                {
                }
                field("To Time"; "To Time")
                {

                    trigger OnValidate();
                    begin
                        // CurrPage.UPDATE;
                    end;
                }
                field("Shift Split"; "Shift Split")
                {
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Copy Day")
            {
                Caption = 'Copy Day';
                Image = Copy;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction();
                var
                    WorkTimeTemplate: Record "Work Time Template - Ramadn";
                    CopyDay: Report "CopyWorkTime Templat- Ramadn";
                begin
                    WorkTimeTemplate.RESET;
                    WorkTimeTemplate.SETRANGE("Work Time ID", "Work Time ID");
                    if WorkTimeTemplate.FINDFIRST then;
                    CLEAR(CopyDay);
                    CopyDay.SetFromWeekday(Weekday, WorkTimeTemplate);
                    CopyDay.RUNMODAL;
                    CurrPage.UPDATE;
                end;
            }
        }
    }

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean;
    begin
        Weekday := Weekday::Sunday;
    end;
}

