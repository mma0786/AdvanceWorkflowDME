page 60139 "Seperation List"
{
    PageType = List;
    SourceTable = "Seperation Master";
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Seperation Code"; "Seperation Code")
                {
                    ApplicationArea = All;
                }
                field("Seperation Reason"; "Seperation Reason")
                {
                    ApplicationArea = All;
                }
                field("Sepration Reason Code"; "Sepration Reason Code")
                {
                    ApplicationArea = All;
                }
            }
        }
    }


}

