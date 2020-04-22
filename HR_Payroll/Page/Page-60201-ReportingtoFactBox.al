page 60201 "Reporting to FactBox"
{
    Caption = 'Employee Details';
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = CardPart;
    ShowFilter = false;
    SourceTable = Employee;

    layout
    {
        area(content)
        {
            field("No."; "No.")
            {
                ApplicationArea = All;
            }
            field("First Name"; "First Name")
            {
                ApplicationArea = All;
            }
            field("Middle Name"; "Middle Name")
            {
                ApplicationArea = All;
            }
            field("Last Name"; "Last Name")
            {
                ApplicationArea = All;
            }
            field("Joining Date"; "Joining Date")
            {
                ApplicationArea = All;
            }
            field("Service Year"; ServiceYearTxt)
            {
                ApplicationArea = All;
            }
            field("Earning Code Group"; "Earning Code Group")
            {
                ApplicationArea = All;
            }
            field("Grade Category"; "Grade Category")
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        CLEAR(ServiceYear);
        CLEAR(ServiceYearTxt);
        if "Joining Date" <> 0D then begin
            ServiceYear := -("Joining Date" - TODAY);
            if ServiceYear <> 0 then
                ServiceYearTxt := FORMAT(ROUND((ServiceYear / 365.27), 0.1));
        end;
    end;

    var
        ServiceYear: Integer;
        ServiceYearTxt: Text;
}

