page 60211 "Marital Status"
{
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "Marital Status";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Marital Status Code"; "Marital Status Code")
                {
                    ApplicationArea = All;
                }
                field("Marital Status Description"; "Marital Status Description")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

}