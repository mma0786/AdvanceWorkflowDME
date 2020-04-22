page 60163 "Records Link Page"
{
    PageType = List;
    SourceTable = "Record Link";
    ApplicationArea = All;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Link ID"; "Link ID")
                {
                    ApplicationArea = All;
                }
                field("Record ID"; "Record ID")
                {
                    ApplicationArea = All;
                }
                field("Records ID"; FORMAT("Record ID", 0, 1))
                {
                    ApplicationArea = All;
                }
                field(URL1; URL1)
                {
                    ApplicationArea = All;
                }
                //commented By Avinash
                // field(URL2; URL2)
                // {
                // }
                // field(URL3; URL3)
                // {
                // }
                // field(URL4; URL4)
                // {
                // }
                //commented By Avinash
                field(Description; Description)
                {
                    ApplicationArea = All;
                }
                field(Type; Type)
                {
                    ApplicationArea = All;
                }
                field(Note; Note)
                {
                    ApplicationArea = All;
                }
                field(Created; Created)
                {
                    ApplicationArea = All;
                }
                field("User ID"; "User ID")
                {
                    ApplicationArea = All;
                }
                field(Company; Company)
                {
                    ApplicationArea = All;
                }
                field(Notify; Notify)
                {
                    ApplicationArea = All;
                }
                field("To User ID"; "To User ID")
                {
                    ApplicationArea = All;
                }
            }
        }
    }


}

