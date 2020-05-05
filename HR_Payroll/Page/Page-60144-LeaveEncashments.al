page 60144 "Leave Encashments"
{
    Editable = false;
    PageType = ListPart;
    SourceTable = "Leave Encashment";
    ApplicationArea = All;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Journal ID"; "Journal ID")
                {
                    ApplicationArea = All;
                }
                field("Employee No."; "Employee No.")
                {
                    ApplicationArea = All;
                }
                field("Employee Name"; "Employee Name")
                {
                    ApplicationArea = All;
                }
                field("Leave Units"; "Leave Units")
                {
                    ApplicationArea = All;
                }
                field("Leave Encashment Amount"; "Leave Encashment Amount")
                {
                    ApplicationArea = All;
                }
            }
        }
    }


}

