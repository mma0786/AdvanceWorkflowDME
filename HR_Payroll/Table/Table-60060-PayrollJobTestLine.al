table 60060 "Payroll Job Test Line"
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
        field(3; "Test Type"; Code[20])
        {
            TableRelation = "Payroll Job Test Type";

            trigger OnValidate()
            begin
                if PayrollJobTest.GET("Test Type") then
                    Description := PayrollJobTest.Description
                else
                    Description := '';
            end;
        }
        field(4; Description; Text[100])
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
        PayrollJobTest: Record "Payroll Job Test Type";
}

