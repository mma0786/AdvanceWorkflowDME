page 60218 "Insurance Servicec Prov. List"
{
    Caption = 'Insurance Service Providers';
    PageType = List;
    SourceTable = "Insurance Service Provider";
    UsageCategory = Lists;
    ApplicationArea = All;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Insurance Provider Code"; "Insurance Provider Code")
                {
                    ApplicationArea = All;
                }
                field("Insurance Service Provider"; "Insurance Service Provider")
                {
                    ApplicationArea = All;
                }
                field(Address; Address)
                {
                    ApplicationArea = All;
                }
                field("Contact Person"; "Contact Person")
                {
                    ApplicationArea = All;
                }
                field(Email; Email)
                {
                    ApplicationArea = All;
                }
                field(Telephone; Telephone)
                {
                    ApplicationArea = All;
                }
                field(Website; Website)
                {
                    ApplicationArea = All;
                }
                field(Active; Active)
                {
                    ApplicationArea = All;
                }
                field("Insurance Type"; "Insurance Type")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

}