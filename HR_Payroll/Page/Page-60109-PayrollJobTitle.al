page 60109 "Payroll Job Title"
{
    PageType = List;
    SourceTable = "Payroll Job Title";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Job Title"; "Job Title")
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

