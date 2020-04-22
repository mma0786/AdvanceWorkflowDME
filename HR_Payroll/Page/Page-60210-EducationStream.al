page 60210 "Education Stream"
{
    PageType = List;
    SourceTable = "Education Stream";
    UsageCategory = Lists;
    ApplicationArea = All;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Stream Code"; "Stream Code")
                {
                    ApplicationArea = All;
                }
                field("Stream Description"; "Stream Description")
                {
                    ApplicationArea = All;
                }
            }
        }
    }


}

