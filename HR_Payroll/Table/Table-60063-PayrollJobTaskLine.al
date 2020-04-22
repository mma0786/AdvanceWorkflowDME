table 60063 "Payroll Job Task Line"
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
        field(3; "Job Task"; Code[20])
        {
            TableRelation = "Payroll Job Task";

            trigger OnValidate()
            begin
                if PayrollJobTask.GET("Job Task") then
                    Description := PayrollJobTask.Description
                else
                    Description := '';
            end;
        }
        field(4; Description; Text[100])
        {
        }
        field(5; Notes; Text[250])
        {
        }
    }

    keys
    {
        key(Key1; "Job ID", "Line  No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        PayrollJobTask: Record "Payroll Job Task";
}

