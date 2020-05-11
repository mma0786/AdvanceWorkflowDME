page 60018 "Employee Earning Code Groups"//commented By Avinash 
{
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = List;
    SourceTable = "Employee Earning Code Groups";
    UsageCategory = Administration;
    ApplicationArea = All;
    PromotedActionCategoriesML = ENU = 'New,Process,Report,Approval,'','','','',Request Approval', ESP = 'New,Process,Report,Approval,'','','','',Request Approval';
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Employee Code"; "Employee Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Grade Category"; "Grade Category")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Earning Code Group"; "Earning Code Group")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Calander; Calander)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Gross Salary"; "Gross Salary")
                {
                    ApplicationArea = All;
                }
                field("Travel Class"; "Travel Class")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Currency; Currency)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Valid From"; "Valid From")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Valid To"; "Valid To")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Position; Position)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Type; Type)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Earning Code")
            {
                ApplicationArea = All;
                Image = Production;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Payroll Earning Code Wrkr";
                RunPageLink = Worker = FIELD("Employee Code"),
                              "Earning Code Group" = FIELD("Earning Code Group");
            }
            action("Leave Type")
            {
                ApplicationArea = All;
                Image = Holiday;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "HCM Leave Types Wrkrs List";
                RunPageLink = Worker = FIELD("Employee Code"),
                              "Earning Code Group" = FIELD("Earning Code Group");
            }
            action(Benefit)
            {
                ApplicationArea = All;
                Image = CalculateLines;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "HCM Benefit Wrkrs";
                RunPageLink = Worker = FIELD("Employee Code"),
                              "Earning Code Group" = FIELD("Employee Code");
            }
            action(Loans)
            {
                ApplicationArea = All;
                Image = Loaner;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "HCM Loan Table GCC Wrkrs";
                /////////// RunPageLink = "Earning Code for Interest" = FIELD("Employee Code"), "Allow Multiple Loans" = FIELD("Earning Code Group");
            }
            action("Update/ Change Grade")
            {
                ApplicationArea = All;
                Image = Change;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    //
                end;
            }
        }
    }
}

