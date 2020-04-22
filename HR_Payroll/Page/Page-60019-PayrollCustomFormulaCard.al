page 60019 "Payroll Custom Formula Card"
{
    PageType = Card;
    SourceTable = "Payroll Formula";
    SourceTableView = WHERE("Formula Key Type" = CONST(Custom));
    UsageCategory = Lists;
    // ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Formula Key"; "Formula Key")
                {
                    ApplicationArea = All;
                }
                field("Formula description"; "Formula description")
                {
                    ApplicationArea = All;
                }
                field("Formula Key Type"; "Formula Key Type")
                {
                    ApplicationArea = All;
                }
                field(Formula; Formula)
                {
                    ApplicationArea = All;
                }
            }
        }
    }



    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        if "Formula Key" <> '' then
            if "Formula Key Type" = "Formula Key Type"::Parameter then
                ERROR('You Cannot Create Parameter Formula Key Type Manually');
    end;
}

