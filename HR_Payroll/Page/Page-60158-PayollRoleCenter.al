page 60158 "Payoll Role Center"
{
    Caption = 'Employee';
    PageType = RoleCenter;
    ApplicationArea = All;
    UsageCategory = Administration;
    layout
    {
        area(rolecenter)
        {
            group(Control1900724808)
            {
            }
            //commented By Avinash part("Emp Logo 2"; "Employee Picture - test")
            //commented By Avinash {
            //commented By Avinash  }
            group(Control5)
            {
                group(Control7)
                {
                }
                //commented By Avinash  part(Control1; "RequeststoApprove cue-Old")
                //commented By Avinash  {
                //commented By Avinash  }
                part(Control2; "Employee Request")
                {
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("My Personal Info")
            {
                Image = Employee;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                //commented By Avinash   RunObject = Page "Edit Employee Details";
                RunPageOnRec = true;
                ApplicationArea = All;
            }
        }
    }

    var
        useridG: Code[20];
        SummaryPayrollCue: Record "Summary Payroll Cue";
}

