page 60174 "Edit User Details"
{
    Editable = false;
    PageType = Card;
    SourceTable = Employee;
    UsageCategory = Administration;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                Visible = false;
                field("No."; "No.")
                {
                    ApplicationArea = All;
                }
            }
            group(Control4)
            {
            }
            //commented By Avinash  part("Address "; "Employee Address ListPart")
            //commented By Avinash  {
            //commented By Avinash    SubPageLink = Field1 = FIELD("No.");
            //commented By Avinash  }
            group(Control5)
            {
            }
            //commented By Avinash  part(Contact; "Employee Contacts SubPage")
            //commented By Avinash  {
            //commented By Avinash  SubPageLink = Field1 = FIELD("No.");
            //commented By Avinash  }
        }
        area(factboxes)
        {
            part(Details; "My Profile FactBox")
            {
                Caption = 'Details';
                SubPageLink = "No." = FIELD("No.");
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Bank Details")
            {
                Image = Bank;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                //commented By Avinash RunObject = Page "Employee Bank Account List";
                //commented By Avinash  RunPageLink = Field4 = FIELD("No.");
                RunPageMode = View;
                ApplicationArea = All;
            }
            action("Personal Contact")
            {
                Image = Comment;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                //commented By Avinash RunObject = Page "Employee Dependent List";
                //commented By Avinash  RunPageLink = Field2 = FIELD("No.");
                RunPageMode = View;
                ApplicationArea = All;
            }
            action(Identification)
            {
                Image = Invoice;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = All;
                //commented By Avinash RunObject = Page "Employee Identification - Old";
                //commented By Avinash   RunPageLink = "Employee No." = FIELD("No.");
            }
            action(Education)
            {
                Image = Certificate;
                Promoted = true;
                PromotedCategory = Process;
                // RunObject = Page "Employee Education List";
                // RunPageLink = "Emp ID" = FIELD("No.");
                ApplicationArea = All;
            }
            action(Experience)
            {
                Image = Accounts;
                Promoted = true;
                PromotedCategory = Process;
                // RunObject = Page "Employee Education List";
                // RunPageLink = "Emp ID" = FIELD("No.");
                ApplicationArea = All;
            }
            action(Skills)
            {
                Image = Skills;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Employee Skills List";
                RunPageLink = "Emp ID" = FIELD("No.");
                ApplicationArea = All;
            }
            action(Certificates)
            {
                Image = Certificate;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Employee Certificates List";
                RunPageLink = "Emp ID" = FIELD("No.");
                ApplicationArea = All;
            }
            action(Insurance)
            {
                Image = Insurance;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;
                //commented By Avinash RunObject = Page "Employee Insurance List";
                //commented By Avinash RunPageLink = Field1 = FIELD("No.");
            }
            action("My Attendance")
            {
                Image = "Report";
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;
                trigger OnAction()
                var
                //commented By Avinash  EmployeeAttendance: Report "Employee Attendance";
                begin
                    //
                    //commented By Avinash   TimeAttendanceDetails.RESET;
                    //commented By Avinash   TimeAttendanceDetails.SETRANGE("Employee ID", "No.");
                    //commented By Avinash     if TimeAttendanceDetails.FINDFIRST then begin
                    //commented By Avinash    CLEAR(EmployeeAttendance);
                    //commented By Avinash      EmployeeAttendance.SETTABLEVIEW(TimeAttendanceDetails);
                    //commented By Avinash      EmployeeAttendance.RUNMODAL;
                    //commented By Avinash  end
                    //commented By Avinash   else
                    //commented By Avinash     MESSAGE('Attendance details not available');
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        UserSetupRec_G.RESET;
        UserSetupRec_G.SETRANGE("User ID", USERID);
        if UserSetupRec_G.FINDFIRST then;
        //commented By Avinash SETRANGE("No.", UserSetupRec_G."Employee Id");
    end;

    var
        UserSetupRec_G: Record "User Setup";
    //commented By Avinash   TimeAttendanceDetails: Record Table55016;
}

