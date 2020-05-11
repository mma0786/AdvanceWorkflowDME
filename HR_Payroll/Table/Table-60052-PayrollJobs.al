table 60052 "Payroll Jobs"
{
    DataCaptionFields = Job, "Job Description";
    DrillDownPageID = "Payroll Jobs";
    LookupPageID = "Payroll Jobs";

    fields
    {
        field(1; Job; Code[20])
        {

            trigger OnValidate()
            begin
                if Job <> xRec.Job then begin
                    AdvancePayrollSetup.GET;
                    //NoSeriesMngmnt.TestManual(AdvancePayrollSetup."Payroll Job Nos.");
                    AdvancePayrollSetup.TestField("Payroll Job Nos.");
                    Job := NoSeriesMngmnt.GetNextNo(AdvancePayrollSetup."Payroll Job Nos.", Today, true);
                end;
            end;
        }
        field(2; "Job Description"; Text[100])
        {

            trigger OnValidate()
            begin
                if "Job Description" <> '' then begin
                    PayrollJob.RESET;
                    PayrollJob.SETRANGE("Job Description", Rec."Job Description");
                    if PayrollJob.FINDFIRST then
                        ERROR('Payroll Job already exist with Job Name %1', PayrollJob."Job Description");
                end;
            end;
        }
        field(3; "Earning Code Group"; Code[20])
        {
            TableRelation = "Earning Code Groups" WHERE("Grade Category" = FIELD("Grade Category"));
        }
        field(4; "Job Title"; Code[20])
        {
            TableRelation = "Payroll Job Title";
        }
        field(5; "Full Time Equivalent"; Decimal)
        {
            MinValue = 1;
        }
        field(6; "Maximum Positions"; Boolean)
        {
        }
        field(7; Unlimited; Boolean)
        {
        }
        field(8; "Max. No Of Positions"; Integer)
        {
        }
        field(9; Description; Text[250])
        {
        }
        field(10; "Low Threshold"; Decimal)
        {
            Description = 'Free fields';

            trigger OnValidate()
            begin
                if ("High Threshlod" <> 0) and ("Low Threshold" > "High Threshlod") then
                    ERROR('Low Threshold should be lower than High Threshold');

                if ("Control Point" <> 0) and ("Low Threshold" > "Control Point") then
                    ERROR('Low Threshold should be smaller than Control Point');
            end;
        }
        field(11; "Control Point"; Decimal)
        {
            Description = 'Free fields';

            trigger OnValidate()
            begin
                if ("Low Threshold" <> 0) and ("High Threshlod" <> 0) and
                   (("Control Point" < "Low Threshold") or ("Control Point" > "High Threshlod")) then
                    ERROR('Control point should be in between Low Threshold and High Threshold');


                if (("Low Threshold" <> 0) and ("Control Point" < "Low Threshold")) or
                   (("High Threshlod" <> 0) and ("Control Point" > "High Threshlod")) then
                    ERROR('Control point should be in between Low Threshold and High Threshold');
            end;
        }
        field(12; "High Threshlod"; Decimal)
        {
            Description = 'Free fields';

            trigger OnValidate()
            begin
                if ("Low Threshold" <> 0) and ("Low Threshold" > "High Threshlod") then
                    ERROR('High Threshold should be larger than Low Threshold');

                if ("Control Point" <> 0) and ("High Threshlod" < "Control Point") then
                    ERROR('High Threshold should be larger than Control Point');
            end;
        }
        field(13; "Job Function"; Code[20])
        {
            Description = 'Free fields';
        }
        field(14; "Job Type"; Code[20])
        {
            Description = 'Free fields';
        }
        field(15; "Job Level"; Code[20])
        {
            Description = 'Free fields';
        }
        field(16; "Grade Category"; Code[50])
        {
            TableRelation = "Payroll Grade Category";
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                if xRec."Grade Category" <> Rec."Grade Category" then
                    "Earning Code Group" := '';
            end;
        }
    }

    keys
    {
        key(Key1; Job)
        {
            Clustered = true;
        }
        key(Key2; "Job Description")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; Job, "Job Description")
        {
        }
        fieldgroup(Brick; Job, "Job Description")
        {
        }
    }

    trigger OnInsert()
    begin
        Unlimited := true;
        "Full Time Equivalent" := 1;


        if Job = '' then begin
            AdvancePayrollSetup.GET;
            AdvancePayrollSetup.TESTFIELD("Payroll Job Nos.");
            Job := NoSeriesMngmnt.GetNextNo(AdvancePayrollSetup."Payroll Job Nos.", TODAY, true);
        end;
    end;

    var
        AdvancePayrollSetup: Record "Advance Payroll Setup";
        NoSeriesMngmnt: Codeunit NoSeriesManagement;
        PayrollJob: Record "Payroll Jobs";
}

