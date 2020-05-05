page 60143 "FS Loans"
{
    PageType = ListPart;
    SourceTable = "FS Loans";
    ApplicationArea = All;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Loan Request ID"; "Loan Request ID")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Loan; Loan)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Installment Date"; "Installment Date")
                {
                    ApplicationArea = All;
                }
                field("Installement Amount"; "EMI Amount")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Interest Amount"; "Interest Amount")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Amount be Recovered"; "Installment Amount")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field(Currency; Currency)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
            }
        }
    }


}

