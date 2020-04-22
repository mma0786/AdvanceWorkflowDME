page 60056 "Work Calendars"
{
    CardPageID = "Work Calendar Card";
    Editable = false;
    PageType = List;
    SourceTable = "Work Calendar Header";
    UsageCategory = Lists;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Calendar ID"; "Calendar ID")
                {
                    ApplicationArea = All;
                }
                field(Name; Name)
                {
                    ApplicationArea = All;
                }
                field("Alternative Calendar"; "Alternative Calendar")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Working Times")
            {
                Caption = 'Working Times';
                ApplicationArea = All;
                Image = Workdays;
                Promoted = true;
                PromotedCategory = Category4;
            }
        }
    }
}

