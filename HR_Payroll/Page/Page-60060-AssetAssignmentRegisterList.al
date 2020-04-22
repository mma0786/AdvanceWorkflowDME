page 60060 "Asset Assignment Register_List"
{
    DelayedInsert = false;
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Asset Assignment Register";
    SourceTableView = WHERE(Posted = FILTER(true));
    UsageCategory = Administration;
    ApplicationArea = All;
    CardPageId = "Asset Assignment Register Card";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("FA No"; "FA No")
                {
                    ApplicationArea = All;
                }
                field("FA Description"; "FA Description")
                {
                    ApplicationArea = All;
                }
                field("Asset Custody Type"; "Asset Custody Type")
                {
                    ApplicationArea = All;
                }
                field(Name; Name)
                {
                    ApplicationArea = All;
                    Caption = 'Employee Name / Department Name';
                }
                field("Sub Department"; "Sub Department")
                {
                    ApplicationArea = All;
                }
                field("Issue Document No."; "Issue Document No.")
                {
                    ApplicationArea = All;
                }
                field("Posted Issue Document No"; "Posted Issue Document No")
                {
                    ApplicationArea = All;
                }
                field("Issue Date"; "Issue Date")
                {
                    ApplicationArea = All;
                }
                field("Return Document No."; "Return Document No.")
                {
                    ApplicationArea = All;
                }
                field("Posted Return Document No"; "Posted Return Document No")
                {
                    ApplicationArea = All;
                }
                field("Asset Owner"; "Asset Owner")
                {
                    ApplicationArea = All;
                    Caption = 'Asset Owner No.';
                }
                field("Issue to/Return by"; "Issue to/Return by")
                {
                    ApplicationArea = All;
                    Caption = 'Employee No / Department ID';
                }
                field("Return Date"; "Return Date")
                {
                    ApplicationArea = All;
                }
                field(Status; Status)
                {
                    ApplicationArea = All;
                }
            }
        }
    }


}

