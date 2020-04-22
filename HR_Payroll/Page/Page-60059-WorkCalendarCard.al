page 60059 "Work Calendar Card"
{
    PageType = Document;
    SourceTable = "Work Calendar Header";
    UsageCategory = Documents;
    //  ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Calendar ID"; "Calendar ID")
                {
                    ApplicationArea = All;
                }
                field(Name; Name)
                {
                    ApplicationArea = All;
                }
                field("Work Time Template"; "Work Time Template")
                {
                    ApplicationArea = All;
                }
                group("Dates")
                {
                    field("From Date"; "From Date")
                    {
                        ApplicationArea = All;
                    }
                    field("To Date"; "To Date")
                    {
                        ApplicationArea = All;
                    }
                }
            }
            part("Work Calendar Date"; "Work Calendar Date")
            {
                SubPageLink = "Calendar ID" = FIELD("Calendar ID");
                ApplicationArea = All;
            }
            part("Work Cal Date Lines"; "Work Cal Date Lines")
            {
                Provider = "Work Calendar Date";
                ApplicationArea = All;
                SubPageLink = "Calendar ID" = FIELD("Calendar ID"), "Trans Date" = FIELD("Trans Date");
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("Date Calculations")
            {
                Caption = 'Date Calculations';
                Image = Calculator;

                action("Calculate Date")
                {
                    Image = Calculate;
                    Promoted = true;
                    PromotedCategory = Category4;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        CalculateDate;
                    end;
                }
                action("Update Calculation Type")
                {
                    Image = Recalculate;
                    Promoted = true;
                    PromotedCategory = Process;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        UpdateCalculationType;
                    end;
                }
                action("Ramadn Calendars")
                {
                    Image = CalendarWorkcenter;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedOnly = true;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        //commented By Avinash
                        // CLEAR(CardRamadnPage);
                        // TimeRamadanRec.RESET;
                        // TimeRamadanRec.SETRANGE("Work Time ID", Rec."Calendar ID");
                        // if not TimeRamadanRec.FINDFIRST then begin
                        //     TimeRamadanRec.INIT;
                        //     TimeRamadanRec.VALIDATE("Work Time ID", Rec."Calendar ID");
                        //     TimeRamadanRec.INSERT(true);
                        //     CardRamadnPage.SETTABLEVIEW(TimeRamadanRec);
                        // end else begin
                        //     CardRamadnPage.SETTABLEVIEW(TimeRamadanRec);
                        //     CardRamadnPage.RUNMODAL
                        // end;
                        //commented By Avinash

                    end;
                }
            }
        }
    }

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    var
        WorkCalendarDate: Record "Work Calendar Date";
    begin
        WorkCalendarDate.RESET;
        WorkCalendarDate.SETRANGE("Calendar ID", Rec."Calendar ID");
        WorkCalendarDate.SETRANGE("Has Changed", true);
        if WorkCalendarDate.FINDFIRST then begin
            ERROR('Calculation Type Modified, Please update the Employee Cacluation Type');
        end;
    end;

    var
    //commented By Avinash
    // CardRamadnPage: Page "Work Time Template CardRamadn";
    // TimeRamadanRec: Record Table50054;
    //commented By Avinash
}

