table 60062 "Payroll Job Education Line"
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
        field(3; Education; Code[20])
        {
            TableRelation = "Payroll Job Education";

            trigger OnValidate()
            begin
                if PayrollJobEducation.GET(Education) then
                    Description := PayrollJobEducation.Description
                else
                    Description := '';
            end;
        }
        field(4; Description; Text[100])
        {
        }
        field(5; Importance; Option)
        {
            OptionCaption = 'None,1-Least,2,3,4,5,6-Most';
            OptionMembers = "None","1-Least","2","3","4","5","6-Most";
        }
        field(6; "Emp ID"; Code[20])
        {
            Description = 'PHASE -2';
            Editable = false;
            TableRelation = Employee;

            trigger OnValidate()
            begin
                EmployeeRecG.RESET;
                if EmployeeRecG.GET("Emp ID") then
                    "Emp Full Name" := EmployeeRecG.FullName;
            end;
        }
        field(7; "Emp Full Name"; Text[150])
        {
            Description = 'PHASE -2';
            Editable = false;
        }
        field(8; "Grade Pass"; Text[150])
        {
            Description = 'PHASE -2';
        }
        field(9; "Passing Year"; Integer)
        {
            Description = 'PHASE -2';
        }
        field(10; "Education Level"; Code[20])
        {
            Description = 'PHASE -2';
            TableRelation = "Education Level Master";

            trigger OnValidate()
            begin
                if xRec."Education Level" <> "Education Level" then begin
                    CLEAR(Description);
                    CLEAR(Education);
                    CLEAR("Grade Pass");
                    CLEAR("Passing Year");
                end;
            end;
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
        PayrollJobEducation: Record "Payroll Job Education";
        EmployeeRecG: Record Employee;
}

