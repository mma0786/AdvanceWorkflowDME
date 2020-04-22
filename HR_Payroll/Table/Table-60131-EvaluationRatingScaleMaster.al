table 60131 "Evaluation Rating Scale Master"
{

    fields
    {
        field(1; "Code"; Code[20])
        {
        }
        field(2; Description; Text[80])
        {
        }
        field(3; "Rating Code"; Code[50])
        {
        }
        field(4; Minumum; Decimal)
        {

            trigger OnValidate()
            begin
                ValidateMinimum;
            end;
        }
        field(5; Maximum; Decimal)
        {

            trigger OnValidate()
            begin
                if Maximum < Minumum then
                    ERROR(Text00004);
                ValidateMaximum;
            end;
        }
    }

    keys
    {
        key(Key1; "Code")
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
            ERROR(Text00001);

    end;

    trigger OnModify()
    begin
        UserSetupRecG.RESET;
        UserSetupRecG.SETRANGE("User ID", USERID);
        if UserSetupRecG.FINDFIRST then;

        if not UserSetupRecG."HR Manager" then
            ERROR(Text00002);

    end;

    var
        UserSetupRecG: Record "User Setup";
        Text00001: Label 'You Don''t have permission to delete Records, please contact to Admin.';
        Text00002: Label 'You Don''t have permission to Modify Records, please contact to Admin.';
        EvaluationRatingScaleMasterRec2G: Record "Evaluation Rating Scale Master";
        Text00003: Label 'Minimum Range should not be overlap.';
        Text00004: Label 'Maximum Range should not  be overlap.';

    local procedure ValidateMinimum()
    var
        EvaluationRatingScaleMasterRecL: Record "Evaluation Rating Scale Master";
    begin
        EvaluationRatingScaleMasterRecL.RESET;
        EvaluationRatingScaleMasterRecL.SETFILTER(Minumum, '<%1', Minumum);
        EvaluationRatingScaleMasterRecL.SETFILTER(Maximum, '>=%1', Minumum);
        if EvaluationRatingScaleMasterRecL.FINDFIRST then
            ERROR(Text00003);
    end;

    local procedure ValidateMaximum()
    var
        EvaluationRatingScaleMasterRecL: Record "Evaluation Rating Scale Master";
    begin
        EvaluationRatingScaleMasterRecL.RESET;
        EvaluationRatingScaleMasterRecL.SETFILTER(Minumum, '>%1', Maximum);
        EvaluationRatingScaleMasterRecL.SETFILTER(Maximum, '<=%1', Maximum);
        if EvaluationRatingScaleMasterRecL.FINDFIRST then
            ERROR(Text00004);
    end;
}

