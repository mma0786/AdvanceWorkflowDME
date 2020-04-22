page 60110 "Payroll Job Postions"
{
    Caption = 'All Positions';
    CardPageID = "Payroll Job Position Card";
    PageType = List;
    SourceTable = "Payroll Position";
    UsageCategory = Lists;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Position ID"; "Position ID")
                {
                    ApplicationArea = All;
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                }
                field("Assigned Employee"; AssignedEmployee)
                {
                    ApplicationArea = All;
                }
                field("Assigned Employee Name"; AssignedEmployeeName)
                {
                    ApplicationArea = All;
                }
                field(Job; Job)
                {
                    ApplicationArea = All;
                }
                field(Title; Title)
                {
                    ApplicationArea = All;
                }
                field(Department; Department)
                {
                    ApplicationArea = All;
                }
                field("Reports to Position"; "Reports to Position")
                {
                    ApplicationArea = All;
                }
                field("Earning Code Group"; "Earning Code Group")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field(Worker; Worker)
                {
                    ApplicationArea = All;
                }
            }
        }
    }



    trigger OnAfterGetRecord()
    begin
        UpdateOpenPositions;
        CheckPositionActive;
        GetAssignedEmployee;
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        PayrollJobPosWorkerAssign.RESET;
        PayrollJobPosWorkerAssign.SETRANGE("Position ID", "Position ID");
        if PayrollJobPosWorkerAssign.FINDFIRST then
            ERROR('Worker Already assign , you cannot delete this document.');
    end;

    trigger OnOpenPage()
    begin
        GetAssignedEmployee
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        //MODIFY;
    end;

    var
        PayrollPosDuration: Record "Payroll Position Duration";
        PayrollJobPosWorkerAssign: Record "Payroll Job Pos. Worker Assign";
        AssignedEmployee: Code[20];
        AssignedEmployeeName: Text;

    local procedure GetAssignedEmployee()
    var
        RepPosRec: Record "Payroll Position";
        PayrollPosRec: Record "Payroll Job Pos. Worker Assign";
        Employee: Record Employee;
    begin
        CLEAR(AssignedEmployee);
        CLEAR(AssignedEmployeeName);
        PayrollPosRec.RESET;
        PayrollPosRec.SETRANGE("Position ID", "Position ID");
        if PayrollPosRec.FINDFIRST then begin
            if Employee.GET(PayrollPosRec.Worker) then begin
                AssignedEmployee := Employee."No.";
                AssignedEmployeeName := Employee.FullName;
            end;
        end;
    end;
}

