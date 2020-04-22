page 60082 "Payroll Adjmt. Journal Card"
{
    DataCaptionFields = "Journal No.", Description;
    PageType = Document;
    SourceTable = "Payroll Adjmt. Journal header";
    UsageCategory = Documents;
    //ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Journal No."; "Journal No.")
                {
                    ApplicationArea = All;
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                }
                field("Pay Cycle"; "Pay Cycle")
                {
                    ApplicationArea = All;
                }
                field("Pay Period Start"; "Pay Period Start")
                {
                    ApplicationArea = All;
                }
                field("Pay Period End"; "Pay Period End")
                {
                    ApplicationArea = All;
                }
                field("Defaualt Employee"; "Defaualt Employee")
                {
                    ApplicationArea = All;
                }
                field("Default Earning Code"; "Default Earning Code")
                {
                    ApplicationArea = All;
                }
                field("Create By"; "Create By")
                {
                    ApplicationArea = All;
                }
                field("Created DateTime"; "Created DateTime")
                {
                    ApplicationArea = All;
                }
                field("Work Flow Status"; "Work Flow Status")
                {
                    ApplicationArea = All;
                }
                field(Posted; Posted)
                {
                    ApplicationArea = All;
                }
                field("Posted By"; "Posted By")
                {
                    ApplicationArea = All;
                }
                field("Posted DateTime"; "Posted DateTime")
                {
                    ApplicationArea = All;
                }
                field("Financial Dimension"; "Financial Dimension")
                {
                    ApplicationArea = All;
                }
                // part(Control17; "Payroll Adjmt. Journal Lines")
                // {
                //     SubPageLink = "Journal No." = FIELD ("Journal No.");
                // }
            }
        }
    }


}

