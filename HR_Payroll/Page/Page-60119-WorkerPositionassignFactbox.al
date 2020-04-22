page 60119 "Worker Position assign Factbox"
{
    Caption = 'Position assign Factbox';
    PageType = CardPart;
    SourceTable = "Payroll Job Pos. Worker Assign";


    layout
    {
        area(content)
        {
            field(Worker; Worker)
            {
                ApplicationArea = All;
            }
            field("Assignment Start"; "Assignment Start")
            {
                ApplicationArea = All;
            }
            field("Assignment End"; "Assignment End")
            {
                ApplicationArea = All;
            }
        }
    }


}

