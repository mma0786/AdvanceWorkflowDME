table 60128 "Evaluation Appraisal Line"
{

    fields
    {
        field(1; "Performance ID"; Code[20])
        {
            Editable = false;
        }
        field(2; "Employee Code"; Code[20])
        {
            Editable = false;
        }
        field(3; "Line No."; Integer)
        {
            Editable = false;
        }
        field(4; "Performance Appraisal Type"; Code[20])
        {
            Editable = false;
        }
        field(5; "Rating Factors"; Text[250])
        {
            Editable = false;
        }
        field(11; IndentationColumn; Integer)
        {
            Editable = false;
        }
        field(12; "Rating Factor Description"; Text[250])
        {
            Editable = false;
        }
        field(13; "Evaluation Rating"; Decimal)
        {

            trigger OnValidate()
            begin
                if "Evaluation Rating" > "Maximum Rating" then
                    ERROR(Text00001);
            end;
        }
        field(14; "Maximum Rating"; Decimal)
        {
            Editable = false;
        }
        field(15; "Each Type"; Decimal)
        {
            CalcFormula = Sum ("Evaluation Appraisal Line"."Evaluation Rating" WHERE("Performance Appraisal Type" = FIELD("Performance Appraisal Type"),
                                                                                     "Performance ID" = FIELD("Performance ID")));
            Editable = false;
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Performance ID", "Employee Code", "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        EvaluationFactorTypeMasterRecG: Record "Evaluation Factor Type Master";
        Text00001: Label 'Evaluation Rating cannot be greater than Maximum Rating.';
}

