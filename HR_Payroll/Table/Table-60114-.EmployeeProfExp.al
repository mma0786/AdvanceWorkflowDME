table 60114 "Employee Prof. Exp."
{

    fields
    {
        field(1; "Emp No."; Code[20])
        {
            Editable = false;
            TableRelation = Employee;

            trigger OnValidate()
            begin
                EmployeeRecG.RESET;
                if EmployeeRecG.GET("Emp No.") then
                    "Emp FullName" := EmployeeRecG.FullName;
            end;
        }
        field(2; "Line No."; Integer)
        {
            Editable = false;
        }
        field(3; "Emp FullName"; Text[150])
        {
            Editable = false;
        }
        field(4; Employer; Code[250])
        {
        }
        field(5; Position; Code[110])
        {
        }
        field(6; "Internet Address"; Code[120])
        {
        }
        field(7; Telephone; Code[15])
        {
        }
        field(8; Location; Code[50])
        {
        }
        field(9; "Start Date"; Date)
        {
        }
        field(10; "End Date"; Date)
        {
        }
    }

    keys
    {
        key(Key1; "Emp No.", "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        EmployeeRecG: Record Employee;
}

