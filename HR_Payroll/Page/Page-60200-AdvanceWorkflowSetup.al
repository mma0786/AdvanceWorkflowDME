page 60200 "Advance Workflow Setup"
{
    PageType = List;
    SourceTable = "Approval Level Setup";
    UsageCategory = Lists;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Advance Payrolll Type"; "Advance Payrolll Type")
                {
                    ApplicationArea = All;
                }
                field(Level; Level)
                {
                    ApplicationArea = All;
                }
                field("Finance User ID"; "Finance User ID")
                {
                    ApplicationArea = All;
                }
                field("Finance User ID 2"; "Finance User ID 2")
                {
                    ApplicationArea = All;
                }
                field("Direct Approve By Finance"; "Direct Approve By Finance")
                {
                    ApplicationArea = All;
                }
            }
        }
    }


}

