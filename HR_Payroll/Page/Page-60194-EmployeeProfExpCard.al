page 60194 "Employee Prof. Exp Card"
{
    InsertAllowed = false;
    PageType = Card;
    SourceTable = "Employee Prof. Exp.";
    UsageCategory = Administration;
    //ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Emp No."; "Emp No.")
                {
                    ApplicationArea = All;
                }
                field("Emp FullName"; "Emp FullName")
                {
                    ApplicationArea = All;
                }
                field(Employer; Employer)
                {
                    ApplicationArea = All;
                }
                field(Position; Position)
                {
                    ApplicationArea = All;
                }
            }
            group("Communication Details")
            {
                field("Internet Address"; "Internet Address")
                {
                    ApplicationArea = All;
                }
                field(Telephone; Telephone)
                {
                    ApplicationArea = All;
                }
                field(Location; Location)
                {
                    ApplicationArea = All;
                }
                field("Start Date"; "Start Date")
                {
                    ApplicationArea = All;
                }
                field("End Date"; "End Date")
                {
                    ApplicationArea = All;
                }
            }
        }
    }


}

