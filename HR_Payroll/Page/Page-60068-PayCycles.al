page 60068 "Pay Cycles"
{
    CardPageID = "Pay Cycle Card";
    PageType = List;
    SourceTable = "Pay Cycles";
    UsageCategory = Lists;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Pay Cycle"; "Pay Cycle")
                {
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
        }
    }

}

