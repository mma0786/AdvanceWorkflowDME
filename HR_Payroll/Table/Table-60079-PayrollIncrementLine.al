table 60079 "Payroll Increment Line"
{

    fields
    {
        field(2; "Line No."; Integer)
        {
        }
        field(3; "Grade Category"; Code[50])
        {
            TableRelation = "Payroll Grade Category";
        }
        field(4; Grade; Code[20])
        {
            TableRelation = "Earning Code Groups" WHERE("Grade Category" = FIELD("Grade Category"));
        }
        field(5; "Type of Increment"; Option)
        {
            OptionCaption = 'Gross,Earning Code';
            OptionMembers = Gross,"Earning Code";
        }
        field(6; "Increment Line No."; Integer)
        {
        }
        field(7; "Calculation Type"; Option)
        {
            OptionCaption = 'Percentage,Amount';
            OptionMembers = Percentage,Amount;
        }
        field(9; "Amount/Percentage"; Decimal)
        {
        }
        field(10; "Earning Code"; Code[20])
        {
            TableRelation = "Payroll Earning Code ErnGrp"."Earning Code" WHERE("Earning Code Group" = FIELD(Grade));

            trigger OnValidate()
            var
                PayrollIncrementLineRecL: Record "Payroll Increment Line";
            begin
                PayrollIncrementLineRecL.RESET;
                PayrollIncrementLineRecL.SETRANGE("Earning Code", "Earning Code");
                if PayrollIncrementLineRecL.FINDFIRST then
                    ERROR('Earning Code %1 cannot be repeated.');

                if PayrollEarningCode.GET("Earning Code") then
                    "Earning Code Description" := PayrollEarningCode.Description
                else
                    "Earning Code Description" := '';
            end;
        }
        field(11; "Earning Code Description"; Text[100])
        {
        }
    }

    keys
    {
        key(Key1; "Grade Category", Grade, "Increment Line No.", "Type of Increment", "Calculation Type", "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        if "Type of Increment" = "Type of Increment"::Gross then begin
            PayrollIncrementLine.RESET;
            PayrollIncrementLine.SETRANGE("Increment Line No.", "Increment Line No.");
            PayrollIncrementLine.SETRANGE("Type of Increment", PayrollIncrementLine."Type of Increment"::Gross);
            PayrollIncrementLine.SETRANGE("Grade Category", "Grade Category");
            PayrollIncrementLine.SETRANGE(Grade, Grade);
            PayrollIncrementLine.SETRANGE("Calculation Type", "Calculation Type");
            if PayrollIncrementLine.FINDSET then
                if PayrollIncrementLine.COUNT >= 1 then
                    ERROR('You Cannot insert more than one increment line for type of increment Gross');
        end;
    end;

    var
        PayrollIncrementLine: Record "Payroll Increment Line";
        PayrollEarningCode: Record "Payroll Earning Code";
}

