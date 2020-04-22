page 60250 Periods
{
    PageType = List;
    SourceTable = Date;
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Period Type"; "Period Type")
                {
                    ApplicationArea = All;
                }
                field("Period Start"; "Period Start")
                {
                    ApplicationArea = All;
                }
                field("Period End"; "Period End")
                {
                    ApplicationArea = All;
                }
                field("Period No."; "Period No.")
                {
                    ApplicationArea = All;
                }
                field("Period Name"; "Period Name")
                {
                    ApplicationArea = All;
                }
            }
        }
    }


}

