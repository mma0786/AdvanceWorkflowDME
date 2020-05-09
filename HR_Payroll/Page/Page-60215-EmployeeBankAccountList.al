page 60215 "Employee Bank Account List"
{
    Caption = 'Employee Bank Account';
    CardPageID = "Employee Bank Account";
    Editable = false;
    PageType = List;
    SourceTable = "Employee Bank Account";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Bank Code"; "Bank Code")
                {
                    ApplicationArea = ALL;
                }
                field("Bank Name"; "Bank Name")
                {
                    ApplicationArea = ALL;
                }
                field("Branch Name"; "Branch Name")
                {
                    ApplicationArea = ALL;
                }
                field("Branch Number"; "Branch Number")
                {
                    ApplicationArea = ALL;
                }
                field("Bank Acccount Number"; "Bank Acccount Number")
                {
                    ApplicationArea = ALL;
                }
                field(IBAN; IBAN)
                {
                    ApplicationArea = ALL;
                }
                field("Account Holder"; "Account Holder")
                {
                    ApplicationArea = ALL;
                }
                field("MOL Id"; "MOL Id")
                {
                    ApplicationArea = ALL;
                }
            }
        }
    }


}

