page 60206 "Dependent Req Address"
{
    AutoSplitKey = true;
    Caption = 'Dependent Address';
    PageType = ListPart;
    SourceTable = "Dependent New Address Line";
    UsageCategory = Administration;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Request No"; No2)
                {
                    ApplicationArea = All;
                }
                field("Name or Description"; "Name or Description")
                {
                    Caption = 'Name or Description';
                    ApplicationArea = All;
                }
                field(Street; Street)
                {
                    ApplicationArea = All;
                }
                field(City; City)
                {
                    ApplicationArea = All;
                }
                field("Country/Region Code"; "Country/Region Code")
                {
                    ApplicationArea = All;
                }
                field(State; State)
                {
                    ApplicationArea = All;
                }
                field(Primary; Primary)
                {
                    ApplicationArea = All;
                }
                field(Private; Private)
                {
                    ApplicationArea = All;
                }
                field(Purpose; Purpose)
                {
                    ApplicationArea = All;
                }
                field("Line No"; "Line No")
                {
                    ApplicationArea = All;
                }
                field("Post Code"; "Post Code")
                {
                    ApplicationArea = All;
                }
            }
        }
    }


}

