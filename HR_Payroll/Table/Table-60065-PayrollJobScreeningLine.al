table 60065 "Payroll Job Screening Line"
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
        field(3; "Screening Type"; Code[20])
        {
            TableRelation = "Payroll Job Screening";

            trigger OnValidate()
            begin
                if PayrollJobScreening.GET("Screening Type") then
                    Description := PayrollJobScreening.Description
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
        PayrollJobScreening: Record "Payroll Job Screening";
}

