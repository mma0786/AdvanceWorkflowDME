page 60008 "Employee Identification List"
{
    CardPageID = "Employee Identification Card";
    UsageCategory = Lists;
    ApplicationArea = All;
    PageType = List;
    SourceTable = "Identification Master";
    SourceTableView = SORTING("Employee No.")
                      ORDER(Ascending)
                      WHERE("Document Type" = CONST(Employee));




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



    trigger OnAfterGetCurrRecord()
    begin
        if RecEmployee.GET("Employee No.") then begin
            FILTERGROUP(2);
            SETRANGE("Employee No.", RecEmployee."No.");
            FILTERGROUP(0);
        end;
    end;

    trigger OnAfterGetRecord()
    begin
        if RecEmployee.GET("Employee No.") then begin
            FILTERGROUP(2);
            SETRANGE("Employee No.", RecEmployee."No.");
            FILTERGROUP(0);
        end;
    end;

    trigger OnOpenPage()
    begin
        if RecEmployee.GET("Employee No.") then begin
            FILTERGROUP(2);
            SETRANGE("Employee No.", RecEmployee."No.");
            FILTERGROUP(0);
        end;
    end;

    var
        RecEmployee: Record Employee;
}

