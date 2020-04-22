page 60025 "Posted Issue Register-1"
{
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "Asset Assignment Register";
    SourceTableView = WHERE("Transaction Type" = FILTER(Issue),
                            Posted = FILTER(true));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Transaction Type"; "Transaction Type")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Posting Date"; "Posting Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Posted Issue Document No"; "Posted Issue Document No")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Issue Document No."; "Issue Document No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("FA No"; "FA No")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Return Date"; "Return Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Posted; Posted)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Asset Custody Type"; "Asset Custody Type")
                {
                    Editable = false;
                }
            }
        }
    }


}

