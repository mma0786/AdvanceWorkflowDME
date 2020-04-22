page 60269 "Evaluation Appraisal List"
{
    CardPageID = "Evaluation Appraisal Card";
    Caption = 'Evaluation Appraisal List';
    PageType = List;
    SourceTable = "Evaluation Appraisal Header";
    UsageCategory = Lists;
    ApplicationArea = All;


    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Performance ID"; "Performance ID")
                {
                    ApplicationArea = All;
                }
                field("Employee Code"; "Employee Code")
                {
                    ApplicationArea = All;
                }
                field("Employee Name"; "Employee Name")
                {
                    ApplicationArea = All;
                }
                field(Department; Department)
                {
                    ApplicationArea = All;
                }
                field(Position; Position)
                {
                    ApplicationArea = All;
                }
            }
        }
    }


}

