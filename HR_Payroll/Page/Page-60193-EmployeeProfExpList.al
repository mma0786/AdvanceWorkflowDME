page 60193 "Employee Prof. Exp. List"
{
    CardPageID = "Employee Prof. Exp Card";
    Editable = false;
    InsertAllowed = false;
    PageType = List;
    SourceTable = "Employee Prof. Exp.";
    UsageCategory = Lists;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
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

    actions
    {
        area(creation)
        {
            action(NEW)
            {
                //commented By Avinash Image = NEW;
                Promoted = true;
                PromotedCategory = New;
                PromotedIsBig = true;
                ApplicationArea = All;
                trigger OnAction()
                begin
                    CLEAR(LineNoG);
                    LineNoG := GetNewLineNumber("Emp No.");
                    EmployeeProfExpRecG.INIT;
                    EmployeeProfExpRecG.VALIDATE("Emp No.", "Emp No.");
                    EmployeeProfExpRecG.VALIDATE("Line No.", LineNoG);
                    EmployeeProfExpRecG.INSERT(true);
                    COMMIT;
                    PAGE.RUNMODAL(60194, EmployeeProfExpRecG);
                end;
            }
        }
    }

    var
        EmployeeProfExpRecG: Record "Employee Prof. Exp.";
        LineNoG: Integer;

    local procedure GetNewLineNumber(EmplNo: Code[20]): Integer
    var
        EmployeeProfExpRecL: Record "Employee Prof. Exp.";
    begin
        EmployeeProfExpRecL.RESET;
        EmployeeProfExpRecL.SETRANGE("Emp No.", EmplNo);
        if not EmployeeProfExpRecL.FINDLAST then
            exit(10000)
        else begin
            exit(EmployeeProfExpRecL."Line No." + 10000);
        end;
    end;
}

