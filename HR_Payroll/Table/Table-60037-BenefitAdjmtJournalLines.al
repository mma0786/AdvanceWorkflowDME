table 60037 "Benefit Adjmt. Journal Lines"
{
    Caption = 'Benefit Adjmt. Journal Lines';

    fields
    {
        field(10; "Journal No."; Code[20])
        {
        }
        field(20; "Line No."; Integer)
        {
        }
        field(30; "Employee Code"; Code[20])
        {
            TableRelation = Employee;

            trigger OnValidate()
            begin
                if "Employee Code" <> '' then begin
                    Employee.RESET;
                    Employee.GET("Employee Code");
                    "Employee Name" := Employee."First Name";
                end
                else
                    "Employee Name" := '';
            end;
        }
        field(40; "Employee Name"; Text[100])
        {
        }
        field(50; "Earning Code"; Code[20])
        {
            TableRelation = "Payroll Earning Code Wrkr"."Earning Code" WHERE(Worker = FIELD("Employee Code"));

            trigger OnValidate()
            begin
                if "Earning Code" <> '' then begin

                    PayrllErngCode.RESET;
                    PayrllErngCode.SETRANGE("Earning Code", "Earning Code");
                    if PayrllErngCode.FINDFIRST then
                        "Earning Code Description" := PayrllErngCode.Description;

                end
                else
                    "Earning Code Description" := '';
            end;
        }
        field(60; "Earning Code Description"; Text[100])
        {
        }
        field(70; "Voucher Description"; Text[250])
        {
        }
        field(80; Amount; Decimal)
        {
        }
        field(90; "Financial Dimension"; Code[20])
        {
        }
        field(100; Benefit; Code[20])
        {
            TableRelation = "HCM Benefit Wrkr"."Benefit Id" WHERE(Worker = FIELD("Employee Code"));

            trigger OnValidate()
            var
                HCMBenefitWrkr: Record "HCM Benefit Wrkr";
            begin
                if Benefit <> '' then begin
                    HCMBenefitWrkr.RESET;
                    HCMBenefitWrkr.SETRANGE(Worker, "Employee Code");
                    HCMBenefitWrkr.SETRANGE("Benefit Id", Benefit);
                    if HCMBenefitWrkr.FINDFIRST then
                        "Benefit Description" := HCMBenefitWrkr.Description;
                end
                else begin
                    "Benefit Description" := '';
                end;
            end;
        }
        field(110; "Benefit Description"; Text[100])
        {
        }
        field(111; "Calculation Units"; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "Journal No.", "Line No.")
        {
            Clustered = true;
        }
        key(Key2; "Journal No.", "Employee Code", Benefit)
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        BenefitAdjmtJournalheader.GET("Journal No.");
        if BenefitAdjmtJournalheader.Posted then
            ERROR('You cannot delete confirmed journals');
    end;

    trigger OnModify()
    begin
        BenefitAdjmtJournalheader.GET("Journal No.");
        if BenefitAdjmtJournalheader.Posted then
            ERROR('You cannot modify confirmed journals');
    end;

    var
        Employee: Record Employee;
        AdvancePayrollSetup: Record "Advance Payroll Setup";
        NoSeriesManagement: Codeunit NoSeriesManagement;
        PayrllErngCode: Record "Payroll Earning Code";
        BenefitAdjmtJournalheader: Record "Benefit Adjmt. Journal header";
}

