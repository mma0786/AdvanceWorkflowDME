table 60056 "Payroll Job Skill Line"
{

    fields
    {
        field(1; "Job ID"; Code[20])
        {
            TableRelation = "Payroll Jobs";
        }
        field(2; "Line  No."; Integer)
        {
        }
        field(3; Skill; Code[20])
        {
            TableRelation = "Payroll Job Skill Master";

            trigger OnValidate()
            begin
                if PayrollJobSkill.GET(Skill) then
                    Description := PayrollJobSkill.Description
                else
                    Description := '';
            end;
        }
        field(4; Description; Text[150])
        {
        }
        field(5; Level; Code[20])
        {
            TableRelation = "Payroll Skill Level";
        }
        field(6; Importance; Option)
        {
            OptionCaption = 'None,1-Least,2,3,4,5,6-Most';
            OptionMembers = "None","1-Least","2","3","4","5","6-Most";
        }
        field(7; "Emp ID"; Code[20])
        {
            Editable = false;
            TableRelation = Employee;

            trigger OnValidate()
            begin
                EmployeeRecG.RESET;
                if EmployeeRecG.GET("Emp ID") then
                    "Emp Full Name" := EmployeeRecG.FullName;
            end;
        }
        field(8; "Emp Full Name"; Text[150])
        {
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "Job ID", "Emp ID", "Line  No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        PayrollJobSkill: Record "Payroll Job Skill Master";
        EmployeeRecG: Record Employee;
}

