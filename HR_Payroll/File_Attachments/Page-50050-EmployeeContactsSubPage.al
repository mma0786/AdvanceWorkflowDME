page 50050 "Employee Contacts SubPage"
{
    // version PHASE -2

    AutoSplitKey = true;
    Caption = 'Contacts';
    PageType = ListPart;
    SourceTable = "Employee Contacts Line";
    UsageCategory = Lists;


    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Description; Description)
                {
                    ApplicationArea = All;
                }
                field(Type; Type)
                {
                    ApplicationArea = All;
                }
                field("Contact Number & Address"; "Contact Number & Address")
                {
                    ApplicationArea = All;
                }
                field(Extension; Extension)
                {
                    ApplicationArea = All;
                }
                field(Primary; Primary)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}

