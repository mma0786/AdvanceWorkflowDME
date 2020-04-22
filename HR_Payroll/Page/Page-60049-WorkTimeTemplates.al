page 60049 "Work Time Templates"
{
    CardPageID = "Work Time Template Card";
    Editable = false;
    PageType = List;
    SourceTable = "Work Time Template";
    UsageCategory = Lists;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Work Time ID"; "Work Time ID")
                {
                    ApplicationArea = All;
                }
                field("Template Name"; "Template Name")
                {
                    ApplicationArea = All;
                }
            }
        }
    }


}

