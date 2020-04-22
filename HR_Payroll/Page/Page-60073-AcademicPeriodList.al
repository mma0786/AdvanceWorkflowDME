page 60073 "Academic Period List"
{
    CardPageID = "Academic Period";
    DelayedInsert = false;
    DeleteAllowed = true;
    InsertAllowed = false;
    ModifyAllowed = false;
    UsageCategory = Administration;
    // ApplicationArea = All;
    PageType = List;
    SourceTable = "Academic Period LT";
    SourceTableView = SORTING("Academic Period", "Start Date", "End Date") ORDER(Ascending);

    layout
    {
        area(content)
        {
            repeater(Group)
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
            //commented By Avinash
            if "Academic Period" <> '' then begin
                TESTFIELD("Start Date");
                TESTFIELD("End Date");
            end;
            //commented By Avinash
        end;
    end;
}

