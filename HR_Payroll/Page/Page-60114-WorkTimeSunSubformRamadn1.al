page 60114 "Work Time SunSubform-Ramadn1"
{
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
                    ApplicationArea = All;
                }
                field("To Time"; "To Time")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        CurrPage.UPDATE;
                    end;
                }
                field("Shift Split"; "Shift Split")
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
            action("Copy Day")
            {
                ApplicationArea = All;
                Caption = 'Copy Day';
                Image = Copy;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    WorkTimeTemplate: Record "Work Time Template - Ramadn";
                    CopyDay: Report "CopyWorkTime Templat- Ramadn";
                begin
                    WorkTimeTemplate.RESET;
                    WorkTimeTemplate.SETRANGE("Work Time ID", "Work Time ID");
                    if WorkTimeTemplate.FINDFIRST then;
                    //commented By Avinash

                    CLEAR(CopyDay);
                    CopyDay.SetFromWeekday(Weekday, WorkTimeTemplate);
                    CopyDay.RUNMODAL;
                    CurrPage.UPDATE;
                end;
            }
        }
    }

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Weekday := Weekday::Sunday;
    end;
}

