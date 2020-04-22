table 60068 "Payroll Position"
{
    DrillDownPageID = "Payroll Job Postions";
    LookupPageID = "Payroll Job Postions";

    fields
    {
        field(1; "Position ID"; Code[20])
        {

            trigger OnValidate()
            begin
                if "Position ID" <> xRec."Position ID" then begin
                    AdvancePayrollSetup.GET;
                    NoSeriesMngmnt.TestManual(AdvancePayrollSetup."Position No. Series");
                    AdvancePayrollSetup."Position No. Series" := '';
                end;
            end;
        }
        field(2; Description; Text[100])
        {
        }
        field(3; Job; Code[20])
        {
            TableRelation = "Payroll Jobs";

            trigger OnValidate()
            begin
                if PayrollJobs.GET(Job) then
                    "Job Description" := PayrollJobs."Job Description"
                else
                    "Job Description" := '';

                CheckJobPosition_LT(Job);
            end;
        }
        field(4; Department; Code[20])
        {
            TableRelation = "Payroll Department";
        }
        field(5; Title; Code[20])
        {
            TableRelation = "Payroll Job Title";
        }
        field(6; "Position Type"; Option)
        {
            Description = 'PHASE 2 changes';
            OptionCaption = ' ,Full-Time,Part-Time';
            OptionMembers = " ","Full-Time","Part-Time";
        }
        field(7; "Full Time Equivalent"; Decimal)
        {

            trigger OnValidate()
            begin
                if "Full Time Equivalent" < 1 then
                    ERROR('Full time equivalent min value is 1');
            end;
        }
        field(8; "Compensation Region"; Code[20])
        {
        }
        field(9; "Available for Assignment"; Date)
        {
        }
        field(10; "Pay Cycle"; Code[20])
        {
            TableRelation = "Pay Cycles";
        }
        field(11; "Work Cycle"; Code[20])
        {
        }
        field(12; "Paid By"; Code[20])
        {
        }
        field(13; "Organizational Officer"; Boolean)
        {
        }
        field(14; "Annual Regular Hours"; Decimal)
        {
        }
        field(15; "Pay Period Overtime Hours"; Decimal)
        {
        }
        field(16; "Generate Salary"; Boolean)
        {
        }
        field(17; "Generate Earning from Schedule"; Boolean)
        {
        }
        field(18; Schedule; Code[20])
        {
            TableRelation = "Work Calendar Header";
        }
        field(19; "General Liability Insurance"; Code[20])
        {
        }
        field(20; "Default Earning Code"; Code[20])
        {
            TableRelation = "Payroll Earning Code";
        }
        field(21; "Union Agreement Needed"; Boolean)
        {
        }
        field(22; "Union Agreement"; Code[20])
        {
        }
        field(23; "Labour Union"; Code[20])
        {
            TableRelation = "Employee Contacts Line";

            trigger OnValidate()
            begin
                /*
                IF LaborUnion.GET("Labour Union") THEN BEGIN
                   "Agreement Description" := LaborUnion."Agreement Description";
                    "Legal Entity" := LaborUnion."Legal Entity";
                    "Union Agreement" := LaborUnion."Union Agreement";
                END
                ELSE BEGIN
                    "Agreement Description" := '';
                    "Legal Entity" := '';
                    "Union Agreement" := '';
                END;
                */

            end;
        }
        field(24; "Agreement Description"; Text[100])
        {
        }
        field(25; "Legal Entity"; Text[100])
        {
            TableRelation = Company;
        }
        field(26; "Valid From"; Date)
        {
        }
        field(27; "Valid To"; Date)
        {
        }
        field(28; "Reports to Position"; Code[20])
        {
            Caption = '1st Reporting';
            // Commented By Avinash  TableRelation = IF ("Position ID" = FILTER(<> POSITION ID)) "Payroll Position";

            trigger OnLookup()
            var
                emp: Record Employee;
            begin
                ReportsToPosition.RESET;
                ReportsToPosition.FILTERGROUP(2);
                ReportsToPosition.SETFILTER("Position ID", '<>%1', "Position ID");
                ReportsToPosition.FILTERGROUP(0);
                if PAGE.RUNMODAL(0, ReportsToPosition) = ACTION::LookupOK then begin
                    "Reports to Position" := ReportsToPosition."Position ID";
                end;
                PosWorkerAssignment.RESET;
                PosWorkerAssignment.SETRANGE("Position ID", "Reports to Position");
                PosWorkerAssignment.SETFILTER("Assignment Start", '<=%1', WORKDATE);
                PosWorkerAssignment.SETFILTER("Assignment End", '>=%1|%2', WORKDATE, 0D);
                if PosWorkerAssignment.FINDFIRST then
                    Worker := PosWorkerAssignment.Worker;
                VALIDATE(Worker, PosWorkerAssignment.Worker);


                //Updating the Line manager in Emp Master for assigned Emp
                CLEAR(PosWorkerAssignment2);
                PosWorkerAssignment2.SETRANGE(PosWorkerAssignment2."Position ID", "Position ID");
                PosWorkerAssignment2.SETFILTER("Assignment Start", '<=%1', WORKDATE);
                PosWorkerAssignment2.SETFILTER("Assignment End", '>=%1|%2', WORKDATE, 0D);
                if PosWorkerAssignment2.FINDFIRST then begin
                    CLEAR(emp);
                    emp.SETRANGE("No.", PosWorkerAssignment2.Worker);
                    if emp.FINDFIRST then begin
                        emp."Line manager" := "Worker Name";
                        emp.MODIFY(true);
                    end;
                end;
            end;

            trigger OnValidate()
            var
                emp: Record Employee;
            begin
                //
                PosWorkerAssignment.RESET;
                PosWorkerAssignment.SETRANGE("Position ID", "Reports to Position");
                PosWorkerAssignment.SETFILTER("Assignment Start", '<=%1', WORKDATE);
                PosWorkerAssignment.SETFILTER("Assignment End", '>=%1|%2', WORKDATE, 0D);
                if PosWorkerAssignment.FINDFIRST then begin
                    VALIDATE(Worker, PosWorkerAssignment.Worker);
                end;

                //Updating the Line manager in Emp Master for assigned Emp
                CLEAR(PosWorkerAssignment2);
                PosWorkerAssignment2.SETRANGE(PosWorkerAssignment2."Position ID", "Position ID");
                PosWorkerAssignment2.SETFILTER("Assignment Start", '<=%1', WORKDATE);
                PosWorkerAssignment2.SETFILTER("Assignment End", '>=%1|%2', WORKDATE, 0D);
                if PosWorkerAssignment2.FINDFIRST then begin
                    CLEAR(emp);
                    emp.SETRANGE("No.", PosWorkerAssignment2.Worker);
                    if emp.FINDFIRST then begin
                        emp."Line manager" := "Worker Name";
                        emp.MODIFY(true);
                    end;
                end;
            end;
        }
        field(29; "Earning Code Group"; Code[20])
        {
            TableRelation = "Earning Code Groups";
        }
        field(30; Worker; Code[20])
        {
            Caption = 'Employee No.';
            Editable = false;
            TableRelation = Employee;

            trigger OnValidate()
            begin
                if Employee.GET(Worker) then
                    "Worker Name" := Employee."First Name" + ' ' + Employee."Last Name"
                else
                    "Worker Name" := '';
            end;
        }
        field(31; "Job Description"; Text[100])
        {
            Caption = 'Job Name';
        }
        field(32; Effective; Date)
        {
        }
        field(33; Expiration; Date)
        {
        }
        field(34; "Second Reporting"; Code[20])
        {
            TableRelation = Employee;
        }
        field(35; "Open Position"; Boolean)
        {
        }
        field(36; "Inactive Position"; Boolean)
        {
        }
        field(37; "Worker Name"; Text[100])
        {
            Caption = 'Employee Name';
        }
        field(38; "Position Summary"; BLOB)
        {
        }
        field(39; "Sub Department"; Code[20])
        {
            // Commented By Avinash TableRelation = Table50019.Field2 WHERE(Field1 = FIELD(Department));
        }
        field(40; "Second Reports to Position"; Code[20])
        {
            Caption = '2nd Reporting';
            // Commented By Avinash  TableRelation = IF ("Position ID" = FILTER(<> POSITION ID)) "Payroll Position";

            trigger OnLookup()
            begin
                ReportsToPosition.RESET;
                ReportsToPosition.FILTERGROUP(2);
                ReportsToPosition.SETFILTER("Position ID", '<>%1', "Position ID");
                ReportsToPosition.FILTERGROUP(0);
                if PAGE.RUNMODAL(0, ReportsToPosition) = ACTION::LookupOK then begin
                    "Second Reports to Position" := ReportsToPosition."Position ID";
                end;
                PosWorkerAssignment.RESET;
                PosWorkerAssignment.SETRANGE("Position ID", "Second Reports to Position");
                PosWorkerAssignment.SETFILTER("Assignment Start", '<=%1', WORKDATE);
                PosWorkerAssignment.SETFILTER("Assignment End", '>=%1|%2', WORKDATE, 0D);
                if PosWorkerAssignment.FINDFIRST then
                    "Second Worker" := PosWorkerAssignment.Worker;
                VALIDATE("Second Worker", PosWorkerAssignment.Worker);
            end;

            trigger OnValidate()
            begin

                PosWorkerAssignment.RESET;
                PosWorkerAssignment.SETRANGE("Position ID", "Second Reports to Position");
                PosWorkerAssignment.SETFILTER("Assignment Start", '<=%1', WORKDATE);
                PosWorkerAssignment.SETFILTER("Assignment End", '>=%1|%2', WORKDATE, 0D);
                if PosWorkerAssignment.FINDFIRST then begin
                    VALIDATE("Second Worker", PosWorkerAssignment.Worker);
                end;
            end;
        }
        field(41; "Second Worker"; Code[20])
        {
            Caption = 'Employee No.';
            Editable = false;
            TableRelation = Employee;

            trigger OnValidate()
            begin
                if Employee.GET("Second Worker") then
                    "Second Worker Name" := Employee."First Name" + ' ' + Employee."Last Name"
                else
                    "Second Worker Name" := '';
            end;
        }
        field(42; "Second Worker Name"; Text[100])
        {
            Caption = 'Employee Name';
        }
        field(43; "Final authority"; Boolean)
        {
            Description = '#WFLevtech';
        }
    }

    keys
    {
        key(Key1; "Position ID")
        {
            Clustered = true;
        }
        key(Key2; Description)
        {
        }
        key(Key3; "Available for Assignment")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Position ID", Description, "Available for Assignment")
        {
        }
    }

    trigger OnDelete()
    begin
        PosWorkerAssignment.RESET;
        PosWorkerAssignment.SETRANGE("Position ID", "Position ID");
        if PosWorkerAssignment.FINDFIRST then
            ERROR(Error001);

        EmployeeEarningCodeGroupsRec.RESET;
        EmployeeEarningCodeGroupsRec.SETRANGE(Position, "Position ID");
        if EmployeeEarningCodeGroupsRec.FINDFIRST then
            ERROR(Error001);
        /*
        EmployeeCreateReqRec.RESET;
        EmployeeCreateReqRec.SETRANGE(Position,"Position ID");
        IF EmployeeCreateReqRec.FINDFIRST THEN
          ERROR(Error001);
          */

    end;

    trigger OnInsert()
    begin
        if "Position ID" = '' then begin
            AdvancePayrollSetup.GET;
            AdvancePayrollSetup.TESTFIELD("Position No. Series");
            "Position ID" := NoSeriesMngmnt.GetNextNo(AdvancePayrollSetup."Position No. Series", TODAY, true);
        end;
        "Full Time Equivalent" := 1;

        "Open Position" := true;
    end;

    var
        PayrollJobs: Record "Payroll Jobs";
        AdvancePayrollSetup: Record "Advance Payroll Setup";
        NoSeriesMngmnt: Codeunit NoSeriesManagement;
        ReportsToPosition: Record "Payroll Position";
        PosWorkerAssignment: Record "Payroll Job Pos. Worker Assign";
        Employee: Record Employee;
        PayrollPosition: Record "Payroll Position";
        PayrollPosDuration: Record "Payroll Position Duration";
        PayrollJobsRec_G: Record "Payroll Jobs";
        PayrollPositionRec_G: Record "Payroll Position";
        CountPosition_G: Integer;
        Error001: Label 'Position has already been created for the selected job. Cannot be deleted.';
        EmployeeEarningCodeGroupsRec: Record "Employee Earning Code Groups";
        PosWorkerAssignment2: Record "Payroll Job Pos. Worker Assign";

    // Commented By Avinash [Scope('Internal')]
    procedure SetPositionSummary(NewWorkDescription: Text)
    var
        OutStream: OutStream;
    begin

        CLEAR("Position Summary");
        if NewWorkDescription = '' then
            exit;

        "Position Summary".CreateOutStream(OutStream, TEXTENCODING::UTF8);
        OutStream.WriteText(NewWorkDescription);
        Modify;
    end;

    // Commented By Avinash [Scope('Internal')]
    procedure GetPositionSummary(): Text
    var
        TypeHelper: Codeunit "Type Helper";
        InStream: InStream;
    begin
        CALCFIELDS("Position Summary");
        if not "Position Summary".HASVALUE then
            exit('');
        CALCFIELDS("Position Summary");
        "Position Summary".CreateInStream(InStream, TEXTENCODING::UTF8);
        exit(TypeHelper.ReadAsTextWithSeparator(InStream, TypeHelper.LFSeparator));

    end;

    // Commented By Avinash [Scope('Internal')]
    procedure UpdateOpenPositions()
    var
        PayrollWorkerAssign: Record "Payroll Job Pos. Worker Assign";
    begin
        PayrollWorkerAssign.RESET;
        PayrollWorkerAssign.SETRANGE("Position ID", Rec."Position ID");
        PayrollWorkerAssign.SETFILTER(Worker, '<>%1', '');
        if PayrollWorkerAssign.FINDFIRST then begin
            "Open Position" := false;
        end
        else begin
            "Open Position" := true;
        end;
    end;

    // Commented By Avinash [Scope('Internal')]
    procedure CheckPositionActive()
    begin
        PayrollPosDuration.RESET;
        PayrollPosDuration.SETRANGE("Positin ID", Rec."Position ID");
        PayrollPosDuration.SETFILTER(Activation, '<=%', WORKDATE);
        PayrollPosDuration.SETFILTER(Retirement, '>=%1|%2', WORKDATE, 0D);
        if PayrollPosDuration.FINDFIRST then begin
            "Inactive Position" := false;
        end else begin
            "Inactive Position" := true;
        end;
    end;

    local procedure CheckJobPosition_LT(JobNo: Code[30])
    begin
        PayrollJobsRec_G.RESET;
        PayrollJobsRec_G.SETRANGE(Job, JobNo);
        if PayrollJobsRec_G.FINDFIRST then
            if PayrollJobsRec_G."Maximum Positions" then begin
                //MESSAGE('%1',JobNo);
                PayrollPositionRec_G.RESET;
                PayrollPositionRec_G.SETRANGE(Job, PayrollJobsRec_G.Job);
                if PayrollPositionRec_G.FINDSET then
                    repeat
                        CountPosition_G += 1;
                    until PayrollPositionRec_G.NEXT = 0;

                if CountPosition_G >= PayrollJobsRec_G."Max. No Of Positions" then
                    ERROR('Job %1 has reach maximum number of Count is %2', JobNo, PayrollJobsRec_G."Max. No Of Positions");
            end;
        //MESSAGE('%1   %1',PayrollJobsRec_G."Max. No Of Positions",CountPosition_G);
    end;
}

