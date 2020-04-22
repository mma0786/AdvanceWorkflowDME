page 60225 "Employee Insurance List"
{
    CardPageID = "Employee Insurance Card";
    Editable = false;
    PageType = List;
    SourceTable = "Employee Insurance";
    UsageCategory = Lists;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Employee Id"; "Employee Id")
                {
                    ApplicationArea = All;
                }
                field(Type; Type)
                {
                    ApplicationArea = All;
                }
                field("Person Insured"; "Person Insured")
                {
                    ApplicationArea = All;
                }
                field(Relationship; Relationship)
                {
                    ApplicationArea = All;
                }
                field(Gender; Gender)
                {
                    ApplicationArea = All;
                }
                field("Date Of Birth"; "Date Of Birth")
                {
                    ApplicationArea = All;
                }
                field(Nationality; Nationality)
                {
                    ApplicationArea = All;
                }
                field("Insurance Service Provider"; "Insurance Service Provider")
                {
                    ApplicationArea = All;
                }
                field("Insurance Card No"; "Insurance Card No")
                {
                    ApplicationArea = All;
                }
                field("Issue Date"; "Issue Date")
                {
                    ApplicationArea = All;
                }
                field("Expiry Date"; "Expiry Date")
                {
                    ApplicationArea = All;
                }
            }
        }
    }


    trigger OnOpenPage();
    begin
        if "Employee Id" <> '' then
            FILTERGROUP(2);
        SETRANGE("Employee Id", "Employee Id");
        FILTERGROUP(0);
    end;

    var
        CardRec: Page "Asset Assignment Register_List";
        TRec: Record "Employee Insurance";
        EmployeeInsuranceRec_G: Record "Employee Insurance";
}

