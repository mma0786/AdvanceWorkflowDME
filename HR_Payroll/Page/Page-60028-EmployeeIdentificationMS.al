page 60028 "Employee Identification_MS-1"
{
    CardPageID = "Employee Identification Card";
    PageType = List;
    SourceTable = "Identification Master";

    SourceTableView = SORTING("Employee No.")
                      ORDER(Ascending)
                      WHERE("Document Type" = CONST(Employee));

    UsageCategory = Administration;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; "No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Employee No."; "Employee No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Identification Type"; "Identification Type")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Identification No."; "Identification No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                    Editable = false;
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
                field("Expiry Date"; "Expiry Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
    }



    var
        RecEmployee: Record Employee;
}

