table 60129 "Evaluation Setup"
{

    fields
    {
        field(1; "Grade Category"; Code[50])
        {
            TableRelation = "Payroll Grade Category";
        }
        field(2; "Earning Code Group"; Code[20])
        {
            TableRelation = "Earning Code Groups"."Earning Code Group" WHERE("Grade Category" = FIELD("Grade Category"));
        }
        field(3; "Performance Appraisal Type"; Code[20])
        {
            TableRelation = "Evaluation Factor Type Master";
        }
        field(4; Weightage; Decimal)
        {

            trigger OnValidate()
            begin
                /*
                CLEAR(EvaluationSetupRecG);
                EvaluationSetupRecG.RESET;
                EvaluationSetupRecG.SETRANGE("Earning Code Group","Earning Code Group");
                EvaluationSetupRecG.SETRANGE("Grade Category","Grade Category");
                IF EvaluationSetupRecG.FINDSET THEN
                  REPEAT
                      SumOfTotalG += EvaluationSetupRecG.Weightage ;
                  UNTIL EvaluationSetupRecG.NEXT = 0;
                
                  SumOfTotalG+=Weightage;
                
                
                  IF  SumOfTotalG  > 100 THEN
                  */

            end;
        }
        field(5; "Group Total Weightage"; Decimal)
        {
            CalcFormula = Sum ("Evaluation Setup".Weightage WHERE("Grade Category" = FIELD("Grade Category"),
                                                                  "Earning Code Group" = FIELD("Earning Code Group")));
            Editable = false;
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Grade Category", "Earning Code Group", "Performance Appraisal Type")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        UserSetupRecG.RESET;
        UserSetupRecG.SETRANGE("User ID", USERID);
        if UserSetupRecG.FINDFIRST then;
        if not UserSetupRecG."HR Manager" then
            ERROR(Test0002);

        EvaluationRQSubMasterRecG.RESET;
        EvaluationRQSubMasterRecG.SETCURRENTKEY("Performance Appraisal Type", "Earning Code Group");
        EvaluationRQSubMasterRecG.SETRANGE("Performance Appraisal Type", "Performance Appraisal Type");
        EvaluationRQSubMasterRecG.SETRANGE("Earning Code Group", "Earning Code Group");
        if EvaluationRQSubMasterRecG.FINDFIRST then
            ERROR(Test0003);
    end;

    trigger OnModify()
    begin
        UserSetupRecG.RESET;
        UserSetupRecG.SETRANGE("User ID", USERID);
        if UserSetupRecG.FINDFIRST then;
        if not UserSetupRecG."HR Manager" then
            ERROR(Test0002);

        EvaluationRQSubMasterRecG.RESET;
        EvaluationRQSubMasterRecG.SETCURRENTKEY("Performance Appraisal Type", "Earning Code Group");
        EvaluationRQSubMasterRecG.SETRANGE("Performance Appraisal Type", "Performance Appraisal Type");
        EvaluationRQSubMasterRecG.SETRANGE("Earning Code Group", "Earning Code Group");
        if EvaluationRQSubMasterRecG.FINDFIRST then
            ERROR(Test0003);
    end;

    var
        EvaluationSetupRecG: Record "Evaluation Setup";
        SumOfTotalG: Integer;
        Test0001: Label 'Maximum 100 Allow only.';
        UserSetupRecG: Record "User Setup";
        Test0002: Label 'You don''t have valid permission.';
        EvaluationRQSubMasterRecG: Record "Evaluation RQ Sub Master";
        Test0003: Label 'Records already used by Setup.';
}

