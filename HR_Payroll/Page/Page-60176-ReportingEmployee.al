page 60176 "Reporting Employee"
{
    //CardPageID = "Reporting Employee Card";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    RefreshOnActivate = true;
    SourceTable = Employee;
    ApplicationArea = All;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; "No.")
                {
                    ApplicationArea = All;
                }
                field("Employee Name"; "First Name")
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
            }
        }
        area(factboxes)
        {
            //commented By Avinash 
            //commented By Avinash 
            /*
            part(Control9; "Employee Picture")
            {
                ApplicationArea = Basic, Suite;
                SubPageLink = "No." = FIELD ("No.");
            }
            part("Employee Details"; "Reporting to FactBox")
            {
                SubPageLink = "No." = FIELD ("No.");
            }
            */
            //commented By Avinash 
            //commented By Avinash 
        }
    }



    trigger OnInit()
    begin
        UserSetupRec.RESET;
        UserSetupRec.SETRANGE("User ID", USERID);
        if UserSetupRec.FINDFIRST then begin
            PayrollPosRec.RESET;
            //commented By Avinash   PayrollPosRec.SETRANGE(Worker, UserSetupRec."Employee Id");
            PayrollPosRec.SETRANGE("Is Primary Position", true);
            if PayrollPosRec.FINDFIRST then begin
                repeat
                    RepPosRec2.RESET;
                    RepPosRec2.SETRANGE("Reports to Position", PayrollPosRec."Position ID");
                    if RepPosRec2.FINDSET then begin
                        PayrollPosRec2.RESET;
                        PayrollPosRec2.SETRANGE("Position ID", RepPosRec2."Position ID");
                        if PayrollPosRec2.FINDFIRST then begin
                            if Rec.GET(PayrollPosRec2.Worker) then
                                Rec.MARK(true);
                        end;
                    end;
                until PayrollPosRec.NEXT = 0;
            end;
        end;


        /*
        RepPosRec2.RESET;
        RepPosRec2.SETRANGE("Reports to Position",RepPosRec."Position ID");
        IF RepPosRec2.FINDSET THEN BEGIN
          REPEAT
            PayrollPosRec.RESET;
            PayrollPosRec.SETRANGE("Position ID",RepPosRec2."Position ID");
            IF PayrollPosRec.FINDSET THEN BEGIN
              IF Rec.GET(PayrollPosRec.Worker) THEN
              Rec.MARK(TRUE);
            END;
          UNTIL RepPosRec2.NEXT = 0;
        END;
        */

    end;

    trigger OnOpenPage()
    begin
        Rec.MARKEDONLY(true);
    end;

    var
        UserEmployee: Text;
        UserSetupRec: Record "User Setup";
        EmpRec: Record Employee;
        EmpRec2: Record Employee;
        PayrollPosRec: Record "Payroll Job Pos. Worker Assign";
        RepPosRec: Record "Payroll Position";
        PayrollPosRec2: Record "Payroll Job Pos. Worker Assign";
        RepPosRec2: Record "Payroll Position";
}

