page 60136 "Accrual Component Emp. Card"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    SourceTable = "Accrual Components Employee";
    // ApplicationArea = All;
    UsageCategory = Documents;

    layout
    {
        area(content)
        {
            field("Accrual ID"; "Accrual ID")
            {
                ApplicationArea = All;
            }
            field(Description; Description)
            {
                ApplicationArea = All;
                trigger OnValidate()
                begin
                    TESTFIELD("Accrual ID");
                    if (xRec.Description <> '') and (xRec.Description <> Rec.Description) then
                        ERROR('You Cannot modify Accrual description');
                end;
            }
            group("Accrual Details")
            {
                field("Worker ID"; "Worker ID")
                {
                    ApplicationArea = All;
                }
                field("Accrual Interval Basis Date"; "Accrual Interval Basis Date")
                {
                    ApplicationArea = All;
                }
                field("Months Ahead Calculate"; "Months Ahead Calculate")
                {
                    ApplicationArea = All;
                }
                field("Consumption Split by Month"; "Consumption Split by Month")
                {
                    ApplicationArea = All;
                }
                field("Accrual Basis Date"; "Accrual Basis Date")
                {
                    ApplicationArea = All;
                }
                field("Interval Month Start"; "Interval Month Start")
                {
                    ApplicationArea = All;
                }
                field("Accrual Units Per Month"; "Accrual Units Per Month")
                {
                    ApplicationArea = All;
                }
                field("Opening Additional Accural"; "Opening Additional Accural")
                {
                    Visible = false;
                }
                field("Max Carry Forward"; "Max Carry Forward")
                {
                    ApplicationArea = All;
                }
                field("CarryForward Lapse After Month"; "CarryForward Lapse After Month")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Repeat After Months"; "Repeat After Months")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Avail Allow Till"; "Avail Allow Till")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Allow Negative"; "Allow Negative")
                {
                    ApplicationArea = All;
                }
            }
            part(Control13; "Interim Accruals Workers Subpg")
            {
                ApplicationArea = All;
                Editable = false;
                SubPageLink = "Accrual ID" = FIELD("Accrual ID"),
                              "Worker ID" = FIELD("Worker ID");
            }
        }
    }



    trigger OnClosePage()
    begin
        MandatoryFields;
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        MandatoryFields;
    end;

    var
        AccrualDateVisiible: Boolean;

    local procedure MandatoryFields()
    begin
        if "Accrual ID" <> '' then begin
            TESTFIELD("Accrual Interval Basis Date");
        end;
    end;
}

