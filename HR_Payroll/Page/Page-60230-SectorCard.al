page 60230 "Sector Card"
{
    Caption = 'Sector Card';
    PageType = Card;
    SourceTable = Sector;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Sector ID"; "Sector ID")
                {
                    ApplicationArea = All;
                }
                field("Sector Name"; "Sector Name")
                {
                    ApplicationArea = All;
                }
                field("Country/Region Code"; "Country/Region Code")
                {
                    ApplicationArea = All;
                }
                field("First Class Adult Ticket Fare"; "First Class Adult Ticket Fare")
                {
                    ApplicationArea = All;
                }
                field("First Class Infant Ticket Fare"; "First Class Infant Ticket Fare")
                {
                    ApplicationArea = All;
                }
                field("First Class Child Ticket Fare"; "First Class Child Ticket Fare")
                {
                    ApplicationArea = All;
                }
                field("Business Adult Ticket Fare"; "Business Adult Ticket Fare")
                {
                    ApplicationArea = All;
                }
                field("Business Infant Ticket Fare"; "Business Infant Ticket Fare")
                {
                    ApplicationArea = All;
                }
                field("Business Child Ticket Fare"; "Business Child Ticket Fare")
                {
                    ApplicationArea = All;
                }
                field("Economy Adult Ticket Fare"; "Economy Adult Ticket Fare")
                {
                    ApplicationArea = All;
                }
                field("Economy Infant Ticket Fare"; "Economy Infant Ticket Fare")
                {
                    ApplicationArea = All;
                }
                field("Economy Child Ticket Fare"; "Economy Child Ticket Fare")
                {
                    ApplicationArea = All;
                }
                field(Currency; Currency)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("E&mployee")
            {
                Caption = 'E&mployee';
                Image = Employee;
                action(Activate)
                {
                    Promoted = true;
                    ApplicationArea = All;
                }
            }
        }
    }
}

