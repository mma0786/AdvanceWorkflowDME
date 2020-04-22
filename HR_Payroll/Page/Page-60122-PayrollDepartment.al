page 60122 "Payroll Department"
{
    PageType = List;
    SourceTable = "Payroll Department";
    ApplicationArea = All;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Department ID"; "Department ID")
                {
                    ApplicationArea = All;
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                }
                field("Head Of Department"; "Head Of Department")
                {
                    ApplicationArea = All;
                }
                field("HOD Name"; "HOD Name")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Department In Arabic"; "Department In Arabic")
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 1 Code"; "Shortcut Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Department Value"; "Department Value")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Asset)
            {
                Caption = 'Asset';
                Image = Employee;
            }
            action("Asset Assignment Register")
            {
                Image = Database;
                Promoted = true;
                //commented By AvinashRunObject = Page "Asset Assignment RegisterList";
                //commented By Avinash  RunPageLink = Field10 = FIELD ("Department ID"),
                //commented By Avinash             Field25 = FILTER (true);
            }
        }
    }
}

