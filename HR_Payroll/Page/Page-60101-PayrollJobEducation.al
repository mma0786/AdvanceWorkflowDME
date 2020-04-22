page 60101 "Payroll Job Education"
{
    PageType = List;
    SourceTable = "Payroll Job Education";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Education Code"; "Education Code")
                {
                    ApplicationArea = All;
                }
                field("Education Level"; "Education Level")
                {
                    ApplicationArea = All;
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                }
                field("Education Stream"; "Education Stream")
                {
                    ApplicationArea = All;
                    Caption = 'Specialization';
                }
            }
        }
    }


}

