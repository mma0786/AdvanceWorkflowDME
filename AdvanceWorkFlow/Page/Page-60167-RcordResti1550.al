page 60167 "Rcord Resti - 1550"
{
    PageType = List;
    SourceTable = "Restricted Record";
    ApplicationArea = All;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(ID; ID)
                {
                    ApplicationArea = All;
                }
                field("FORMAT(""Record ID"",0,1)"; FORMAT("Record ID", 0, 1))
                {
                    ApplicationArea = All;
                }
                field(Details; Details)
                {
                    ApplicationArea = All;
                }
            }
        }
    }


}

