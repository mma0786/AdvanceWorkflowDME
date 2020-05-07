page 60009 "Dependent Identification"
{
    CardPageID = "Dependent Identification Card1";
    PageType = List;
    SourceTable = "Identification Master";
    // Commented By Avinash
    SourceTableView = SORTING("Employee No.")
                      ORDER(Ascending)
                      WHERE("Document Type" = CONST(Dependent));
    // Commented By Avinash
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Document Type"; "Document Type")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("No."; "No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Dependent No"; "Dependent No")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Identification Type"; "Identification Type")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Identification No."; "Identification No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Issuing Authority"; "Issuing Authority")
                {
                    ApplicationArea = All;
                }
                field("Issuing Country"; "Issuing Country")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Issue Date"; "Issue Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Issue Date (Hijiri)"; "Issue Date (Hijiri)")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Expiry Date"; "Expiry Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Expiry Date (Hijiri)"; "Expiry Date (Hijiri)")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
            }
        }
    }


}

