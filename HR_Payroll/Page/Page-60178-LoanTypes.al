page 60178 "Loan Types"
{
    Caption = 'Loan Type';
    CardPageID = "Loan Type Setup";
    Editable = true;
    PageType = List;
    RefreshOnActivate = true;
    SourceTable = "Loan Type Setup";
    SourceTableView = SORTING("Loan Code")
                      ORDER(Ascending);
    ApplicationArea = All;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Loan Code"; "Loan Code")
                {
                    ApplicationArea = All;
                }
                field("Loan Description"; "Loan Description")
                {
                    ApplicationArea = All;
                }
                field("Arabic Name"; "Arabic Name")
                {
                    Caption = 'Local Description';
                }
                field("Calculation Basis"; "Calculation Basis")
                {
                    ApplicationArea = All;
                }
                field("Earning Code for Principal"; "Earning Code for Principal")
                {
                    ApplicationArea = All;
                }
                field("Earning Code for Interest"; "Earning Code for Interest")
                {
                    ApplicationArea = All;
                }
                field("No. of times Earning Code"; "No. of times Earning Code")
                {
                    ApplicationArea = All;
                }
                field("Min Loan Amount"; "Min Loan Amount")
                {
                    ApplicationArea = All;
                }
                field("Max Loan Amount"; "Max Loan Amount")
                {
                    ApplicationArea = All;
                }
                field("Interest Percentage"; "Interest Percentage")
                {
                    ApplicationArea = All;
                }
                field("Allow Multiple Loans"; "Allow Multiple Loans")
                {
                    ApplicationArea = All;
                }
                field(Active; Active)
                {
                    ApplicationArea = All;
                }
            }
        }
    }


}

