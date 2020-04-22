pageextension 60009 UserSetupExt extends "User Setup"
{
    layout
    {
        // Add changes to page layout here
        addlast(Control1)
        {
            field("Employee Id"; "Employee Id")
            {
                ApplicationArea = All;
            }
            field("HR Manager"; "HR Manager")
            {
                ApplicationArea = All;
            }
        }

    }

    actions
    {
        addlast(Navigation)
        {
            group("E-signatures")
            {
                Caption = 'E-signature';
                Image = Register;
                Visible = false;
                action("E-signature")
                {
                    Caption = 'E-signature';
                    Image = UserCertificate;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    // RunObject = Page 50000;
                    //               RunPageLink = Field1 = FIELD(User ID);
                }
            }
        }
    }

    var
        myInt: Integer;
}