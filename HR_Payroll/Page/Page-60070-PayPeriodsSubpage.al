page 60070 "Pay Periods Subpage"
{
    AutoSplitKey = true;
    InsertAllowed = false;
    PageType = ListPart;
    SourceTable = "Pay Periods";

    layout
    {
        area(content)
        {
            field(FilterPeriods; FilterPeriods)
            {
                ApplicationArea = All;

                trigger OnValidate()
                begin
                    if FilterPeriods = FilterPeriods::"View Open Periods" then begin
                        RESET;
                        SETRANGE(Status, Status::Open);
                    end
                    else
                        if FilterPeriods = FilterPeriods::"View Closed Periods" then begin
                            RESET;
                            SETRANGE(Status, Status::Closed);
                        end else
                            SETRANGE(Status);
                    CurrPage.UPDATE;
                end;
            }
            repeater(Group)
            {
                Editable = false;
                field("Period Start Date"; "Period Start Date")
                {
                    ApplicationArea = All;
                }
                field("Period End Date"; "Period End Date")
                {
                    ApplicationArea = All;
                }
                field(Year; Year)
                {
                    ApplicationArea = All;
                }
                field(Month; Month)
                {
                    ApplicationArea = All;
                }
                field(Status; Status)
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
            action(Generate)
            {
                Caption = 'Generate';
                ApplicationArea = All;

                trigger OnAction()
                var
                    PayPeriodProcess: Report "Pay Period Process";
                    PayCycleHeader: Record "Pay Cycles";
                begin
                    if PayCycleHeader.GET("Pay Cycle") then begin
                        PayPeriodProcess.SetValues(PayCycleHeader."Pay Cycle Frequency", 0, 0D, 0D, "Pay Cycle");
                        PayPeriodProcess.RUNMODAL;
                    end;
                    CurrPage.UPDATE;
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        if FilterPeriods = FilterPeriods::"View Open Periods" then begin
            RESET;
            SETRANGE(Status, Status::Open);
        end
        else
            if FilterPeriods = FilterPeriods::"View Closed Periods" then begin
                RESET;
                SETRANGE(Status, Status::Closed);
            end else begin
                SETRANGE(Status);
            end;
    end;

    var
        FilterPeriods: Option "View All Periods","View Open Periods","View Closed Periods";
}

