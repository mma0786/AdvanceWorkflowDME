page 60204 "Dependen Request"
{
    CardPageID = "Dependent New Card";
    Editable = false;
    PageType = List;
    SourceTable = "Employee Dependents New";
    UsageCategory = Lists;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(No2; No2)
                {
                    Caption = 'Request ID';
                    ApplicationArea = All;
                }
                field("Employee ID"; "Employee ID")
                {
                    ApplicationArea = All;
                }
                field("Employee Name"; "Employee Name")
                {
                    ApplicationArea = All;
                }
                field("Dependen Full Name"; "Full Name")
                {
                    Caption = 'Dependent Name';
                    ApplicationArea = All;
                }
                field("Request Type"; "Request Type")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

}

