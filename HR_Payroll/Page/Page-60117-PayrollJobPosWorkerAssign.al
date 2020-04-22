page 60117 "Payroll Job Pos. Worker Assign"
{
    AutoSplitKey = true;
    Caption = 'Position Worker Assign';
    DelayedInsert = true;
    DeleteAllowed = true;
    Editable = false;
    MultipleNewLines = true;
    PageType = ListPart;
    ShowFilter = false;
    SourceTable = "Payroll Job Pos. Worker Assign";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Worker; Worker)
                {
                    ApplicationArea = All;
                }
                field("Worker Name"; EmployeeName)
                {
                    ApplicationArea = All;
                }
                field("Assignment Start"; "Assignment Start")
                {
                    ApplicationArea = All;
                }
                field("Assignment End"; "Assignment End")
                {
                    ApplicationArea = All;
                }
                field("Reason Code"; "Reason Code")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Edit)
            {
                Visible = false;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    CLEAR(AssignWoker);
                    AssignWoker.SetValues("Assignment Start", "Assignment End", "Position ID", Worker, "Line No.");
                    AssignWoker.RUNMODAL;
                end;
            }
            action("End")
            {
                Image = "Action";
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                Visible = false;

                trigger OnAction()
                begin
                    TESTFIELD("Assignment End");
                    CLEAR(AssignWoker);
                    AssignWoker.SetValues("Assignment Start", "Assignment End", "Position ID", Worker, "Line No.");
                    AssignWoker.RUNMODAL;
                end;
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        SETFILTER("Assignment Start", '<=%1', WORKDATE);
        SETFILTER("Assignment End", '>=%1|%2', WORKDATE, 0D);
    end;

    trigger OnAfterGetRecord()
    begin
        SETFILTER("Assignment Start", '<=%1', WORKDATE);
        SETFILTER("Assignment End", '>=%1|%2', WORKDATE, 0D);

        CLEAR(EmployeeName);
        if Employee.GET(Worker) then
            EmployeeName := Employee.FullName;
    end;

    trigger OnOpenPage()
    begin
        CLEAR(EmployeeName);
        if Employee.GET(Worker) then
            EmployeeName := Employee.FullName;
    end;

    var
        AssignWoker: Report "Worker Assigment";
        EmployeeName: Text;
        Employee: Record Employee;
}

