page 60069 "Pay Cycle Card"
{
    PageType = Document;
    SourceTable = "Pay Cycles";
    UsageCategory = Documents;
    //ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Pay Cycle"; "Pay Cycle")
                {
                    Editable = "Pay Cycle" = '';
                    ApplicationArea = All;
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                }
                field("Pay Cycle Frequency"; "Pay Cycle Frequency")
                {
                    ApplicationArea = All;
                }
            }
            part(Control6; "Pay Periods Subpage")
            {
                ApplicationArea = all;
                SubPageLink = "Pay Cycle" = FIELD("Pay Cycle");
            }
        }
    }


}

