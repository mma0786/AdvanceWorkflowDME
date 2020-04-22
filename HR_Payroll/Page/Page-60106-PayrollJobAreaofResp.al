page 60106 "Payroll Job Area of Resp."
{
    PageType = List;
    SourceTable = "Payroll Job Area Of Resp.";
    UsageCategory = Lists;
    ApplicationArea = All;


    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Area of Responsibility"; "Area of Responsibility")
                {
                    ApplicationArea = All;
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                }
                field(Notes; Notes)
                {
                    ApplicationArea = All;
                }
            }
        }
    }


}

