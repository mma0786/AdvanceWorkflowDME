page 60127 "Payroll Religions"
{
    PageType = List;
    SourceTable = "Payroll Religion";
    ApplicationArea = All;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Religion ID"; "Religion ID")
                {
                    ApplicationArea = All;
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                }
            }
        }
    }


}

