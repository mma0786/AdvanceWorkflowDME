page 60027 "Employee Position Assignments"//commented By Avinash 
{
    Editable = false;
    InsertAllowed = false;
    PageType = List;
    SourceTable = "Payroll Job Pos. Worker Assign";
    UsageCategory = Administration;
    ApplicationArea = All;


    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Worker; Worker)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Position ID"; "Position ID")
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
                field("Is Primary Position"; "Is Primary Position")
                {
                    ApplicationArea = All;
                    Editable = false;

                    trigger OnValidate()
                    begin
                        if "Is Primary Position" then begin
                            EmployeePostionAssingment.RESET;
                            EmployeePostionAssingment.SETRANGE("Position ID", Rec."Position ID");
                            EmployeePostionAssingment.SETRANGE(Worker, Rec.Worker);
                            EmployeePostionAssingment.SETRANGE("Is Primary Position", true);
                            if EmployeePostionAssingment.FINDFIRST then
                                ERROR('You cannot assign more than one position at a time');
                            EditAssignPrimaryPosition := true;
                        end
                        else begin
                            EditAssignPrimaryPosition := false;
                        end;
                    end;
                }
                field("Effective Start Date"; "Effective Start Date")
                {
                    ApplicationArea = All;
                }
                field("Effective End Date"; "Effective End Date")
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
            action("Assign Position")
            {
                ApplicationArea = All;
                Enabled = EditAssignPosition;
                Image = RegisterPick;
                Promoted = true;
                PromotedCategory = New;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    ///AssignNewPosition;
                    CurrPage.SETSELECTIONFILTER(PositionWorkerAssignment);
                    if PositionWorkerAssignment.FINDSET then;
                    AssignNewPosition(PositionWorkerAssignment);
                end;
            }
            action("Assign Primary Position")
            {
                ApplicationArea = All;
                Image = Register;
                Promoted = true;
                PromotedCategory = New;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    if not CONFIRM('Do you want to assign primary position ?') then
                        exit;
                    CurrPage.SETSELECTIONFILTER(PositionWorkerAssignment);
                    if PositionWorkerAssignment.FINDSET then;
                    AssignPrimaryPosition(PositionWorkerAssignment);
                    ValidateEmployee;
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        if "Is Primary Position" then
            EditAssignPrimaryPosition := true
        else
            EditAssignPrimaryPosition := false;

        CLEAR(EditAssignPosition);
        PayrollJobPosWorkerAssign.RESET;
        PayrollJobPosWorkerAssign.SETRANGE(Worker, Rec.Worker);
        PayrollJobPosWorkerAssign.SETRANGE("Is Primary Position", false);
        PayrollJobPosWorkerAssign.SETRANGE("Position Assigned", false);
        if PayrollJobPosWorkerAssign.FINDFIRST then
            EditAssignPosition := false
        else
            EditAssignPosition := true;
    end;

    trigger OnOpenPage()
    begin
        if "Is Primary Position" then
            EditAssignPrimaryPosition := true
        else
            EditAssignPrimaryPosition := false;

        CLEAR(EditAssignPosition);
        PayrollJobPosWorkerAssign.RESET;
        PayrollJobPosWorkerAssign.SETRANGE(Worker, Rec.Worker);
        PayrollJobPosWorkerAssign.SETRANGE("Is Primary Position", false);
        PayrollJobPosWorkerAssign.SETRANGE("Position Assigned", false);
        if PayrollJobPosWorkerAssign.FINDFIRST then
            EditAssignPosition := false
        else
            EditAssignPosition := true;
    end;

    var
        EmployeePostionAssingment: Record "Payroll Job Pos. Worker Assign";
        EditAssignPrimaryPosition: Boolean;
        PositionWorkerAssignment: Record "Payroll Job Pos. Worker Assign";
        PayrollPosition: Record "Payroll Position";
        [InDataSet]
        EditAssignPosition: Boolean;
        PayrollJobPosWorkerAssign: Record "Payroll Job Pos. Worker Assign";

    local procedure ValidateEmployee()
    var
        EmpRec: Record Employee;
        PositionRec: Record "Payroll Position";
        DepartmentRec: Record "Payroll Department";
        PayrollJobsRec: Record "Payroll Jobs";
    begin
        if EmpRec.GET(Worker) then begin
            if PositionRec.GET("Position ID") then begin
                EmpRec.Department := PositionRec.Department;
                EmpRec."Sub Department" := PositionRec."Sub Department";
                EmpRec."Line manager" := PositionRec."Worker Name";
                EmpRec."First Reporting ID" := PositionRec.Worker;
                EmpRec."Job Title" := PositionRec.Title;
                PayrollJobsRec.RESET;
                PayrollJobsRec.SETRANGE(Job, PositionRec.Job);
                if PayrollJobsRec.FINDFIRST then
                    EmpRec."Grade Category" := PayrollJobsRec."Grade Category";
            end;
            if DepartmentRec.GET(PositionRec.Department) then
                EmpRec.HOD := DepartmentRec."HOD Name";
            EmpRec.VALIDATE(Position, Rec."Position ID");
            EmpRec.MODIFY(true);
        end;
    end;
}

