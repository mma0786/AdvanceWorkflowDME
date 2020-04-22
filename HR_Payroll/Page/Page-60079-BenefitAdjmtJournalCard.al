page 60079 "Benefit Adjmt. Journal Card"
{
    PageType = Card;
    SourceTable = "Benefit Adjmt. Journal header";
    UsageCategory = Administration;
    // ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Journal No."; "Journal No.")
                {
                    Editable = false;
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
                    Editable = false;
                }
                field("Defaualt Employee"; "Defaualt Employee")
                {
                    ApplicationArea = All;
                }
                field("Default Benefit"; "Default Benefit")
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
            }
        }
    }

    actions
    {
    }
}

