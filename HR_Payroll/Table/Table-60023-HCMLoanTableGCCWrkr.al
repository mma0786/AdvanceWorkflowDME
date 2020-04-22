table 60023 "HCM Loan Table GCC Wrkr"
{
    DataCaptionFields = "Loan Code", "Loan Description";
    DrillDownPageID = "HCM Loan Table GCC Wrkrs";
    LookupPageID = "HCM Loan Table GCC Wrkrs";

    fields
    {
        field(1; "Loan Code"; Code[50])
        {
            TableRelation = "Loan Type Setup"."Loan Code" WHERE(Active = FILTER(true));

            trigger OnValidate()
            begin
                if LoanTypeSetup.GET("Loan Code") then
                    Rec.TRANSFERFIELDS(LoanTypeSetup);
            end;
        }
        field(2; "Loan Description"; Text[50])
        {
        }
        field(3; "Arabic Name"; Text[250])
        {
        }
        field(4; "Earning Code for Principal"; Code[20])
        {
            TableRelation = "Payroll Earning Code"."Earning Code";
        }
        field(5; "Earning Code for Interest"; Code[20])
        {
            TableRelation = "Payroll Earning Code"."Earning Code";
        }
        field(6; "Earning Code Selection"; Integer)
        {
        }
        field(7; "No. of times Earning Code"; Integer)
        {
        }
        field(8; "Min Loan Amount"; Decimal)
        {

            trigger OnValidate()
            begin
                if "Min Loan Amount" > "Max Loan Amount" then
                    ERROR(Text50003, "Min Loan Amount", "Max Loan Amount");
            end;
        }
        field(9; "Max Loan Amount"; Decimal)
        {

            trigger OnValidate()
            begin
                if "Max Loan Amount" < "Min Loan Amount" then
                    ERROR(Text50002, "Max Loan Amount", "Min Loan Amount");

            end;
        }
        field(10; "Interest Percentage"; Decimal)
        {
        }
        field(11; "Allow Multiple Loans"; Boolean)
        {
        }
        field(12; Active; Boolean)
        {
        }
        field(13; "Calculation Basis"; Option)
        {
            OptionCaption = ',Multiple Earning Code,Min/Max Amount';
            OptionMembers = ,"Multiple Earning Code","Min/Max Amount";

            trigger OnValidate()
            begin
                if "Calculation Basis" = "Calculation Basis"::"Min/Max Amount" then begin
                    "No. of times Earning Code" := 0;
                    MultipleEarningCodes.SETRANGE("Loan Code", "Loan Code");
                    if MultipleEarningCodes.FINDSET then
                        repeat

                            MultipleEarningCodes.DELETE;
                        until MultipleEarningCodes.NEXT = 0;
                end;

                if "Calculation Basis" = "Calculation Basis"::"Multiple Earning Code" then begin
                    "Min Loan Amount" := 0;
                    "Max Loan Amount" := 0;
                end;
            end;
        }
        field(21; "Number of Installment"; Integer)
        {
        }
        field(90; Worker; Code[20])
        {
            TableRelation = Employee."No.";
        }
        field(91; "Earning Code Group"; Code[20])
        {
            NotBlank = true;
            TableRelation = "Earning Code Groups";
        }
    }

    keys
    {
        key(Key1; "Loan Code", "Earning Code Group", Worker)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        LoanTypeSetup: Record "Loan Type Setup";
        NoSeriesManagement: Codeunit NoSeriesManagement;
        LoanRequest: Record "Loan Request";
        MultipleEarningCodes: Record "Multiple Earning Codes";
        Text50001: Label 'Loan Type Setup cannot be deleted since Loan Request exists for this Loan Type %1';
        Text50002: Label 'Maximum Loan Amount %1 cannot be less than Minimum Loan Amount %2 !';
        Text50003: Label 'Minimum Loan Amount %1 cannot be greater than Maximum Loan Amount %2 !';

    local procedure Initialise()
    begin
        "Loan Code" := NoSeriesManagement.GetNextNo('LOAN TYPE', WORKDATE, true);
    end;

    local procedure existLoanRequest()
    begin
        LoanRequest.SETRANGE("Loan Type", "Loan Code");
        if LoanRequest.FINDFIRST then
            ERROR(Text50001, "Loan Code");
    end;
}

