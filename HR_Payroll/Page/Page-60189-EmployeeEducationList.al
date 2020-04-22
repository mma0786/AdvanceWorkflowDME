page 60189 "Employee Education List"
{
    CardPageID = "Employee Education Card";
    Editable = false;
    PageType = List;
    SourceTable = "Payroll Job Education Line";
    UsageCategory = Administration;
    ApplicationArea = All;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Line  No."; "Line  No.")
                {
                    ApplicationArea = All;
                }
                field("Emp ID"; "Emp ID")
                {
                    ApplicationArea = All;
                }
                field("Emp Full Name"; "Emp Full Name")
                {
                    ApplicationArea = All;
                }
                field("Education Level"; "Education Level")
                {
                    ApplicationArea = All;
                }
                field(Education; Education)
                {
                    ApplicationArea = All;
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                }
                field("Grade Pass"; "Grade Pass")
                {
                    ApplicationArea = All;
                }
                field("Passing Year"; "Passing Year")
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
                ApplicationArea = all;
                Image = New;

                trigger OnAction()
                begin
                    CLEAR(LineNoG);
                    LineNoG := GetNewLineNumber("Emp ID");
                    PayrollJobEducationLineRecG.INIT;
                    PayrollJobEducationLineRecG.VALIDATE("Emp ID", "Emp ID");
                    PayrollJobEducationLineRecG.VALIDATE("Line  No.", LineNoG);
                    PayrollJobEducationLineRecG.INSERT(true);
                    COMMIT;
                    PAGE.RUNMODAL(60192, PayrollJobEducationLineRecG);
                end;
            }
        }
    }

    var
        PayrollJobEducationLineRecG: Record "Payroll Job Education Line";
        LineNoG: Integer;

    local procedure GetNewLineNumber(EmplNo: Code[20]): Integer
    var
        PayrollJobEducationLineRecL: Record "Payroll Job Education Line";
    begin
        PayrollJobEducationLineRecL.RESET;
        PayrollJobEducationLineRecL.SETRANGE("Emp ID", EmplNo);
        if not PayrollJobEducationLineRecL.FINDLAST then
            exit(10000)
        else begin
            exit(PayrollJobEducationLineRecL."Line  No." + 10000);
        end;
    end;
}

