page 60067 "Academic Period"
{
    DelayedInsert = true;
    DeleteAllowed = false;
    // UsageCategory = Administration;
    // ApplicationArea = All;
    PageType = Card;
    SourceTable = "Academic Period LT";
    SourceTableView = SORTING("Academic Period", "Start Date", "End Date") ORDER(Ascending);

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Academic Period"; "Academic Period")
                {
                    ApplicationArea = All;
                }
                field("Start Date"; "Start Date")
                {
                    ApplicationArea = All;
                }
                field("End Date"; "End Date")
                {
                    ApplicationArea = All;
                }
                field(Closed; Closed)
                {
                    ApplicationArea = All;
                }
            }
        }
    }



    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        if CloseAction in [ACTION::OK, ACTION::LookupOK] then begin
            if "Academic Period" <> '' then begin
                TESTFIELD("Start Date");
                TESTFIELD("End Date");
            end;
        end;
    end;
}

