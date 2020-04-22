page 60050 "Work Time Line Monday Subform"
{
    AutoSplitKey = true;
    DelayedInsert = true;
    PageType = ListPart;
    SourceTable = "Work Time Line";
    SourceTableView = WHERE(Weekday = CONST(Monday));

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
                Caption = 'Copy Day';
                Image = Copy;
                Promoted = true;
                ApplicationArea = All;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    WorkTimeTemplate: Record "Work Time Template";
                    CopyDay: Report "Copy Work Time Template Day";
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
        Weekday := Weekday::Monday;
    end;
}

