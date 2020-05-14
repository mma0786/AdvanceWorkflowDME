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
                    Caption = 'Department In Arabic';
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
                RunObject = Page "Asset Assignment Register List";
                RunPageLink = "Issue to/Return by" = FIELD("Department ID"), Posted = FILTER(true);
            }
        }
    }
}

