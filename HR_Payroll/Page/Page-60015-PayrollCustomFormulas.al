page 60015 "Payroll Custom Formulas"
{
    CardPageID = "Payroll Custom Formula Card";
    PageType = List;
    SourceTable = "Payroll Formula";
    SourceTableView = WHERE("Formula Key Type" = CONST(Custom));
    UsageCategory = Lists;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
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


}

