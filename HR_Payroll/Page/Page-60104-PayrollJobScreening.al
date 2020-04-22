page 60104 "Payroll Job Screening"
{
    PageType = List;
    SourceTable = "Payroll Job Screening";
    UsageCategory = Lists;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Screening Type"; "Screening Type")
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

