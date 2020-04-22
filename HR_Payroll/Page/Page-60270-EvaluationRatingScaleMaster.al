page 60270 "Evaluation Rating Scale Master"
{
    AutoSplitKey = false;
    PageType = List;
    RefreshOnActivate = true;
    SourceTable = "Evaluation Rating Scale Master";
    UsageCategory = Administration;
    ApplicationArea = All;


    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Code)
                {
                    ApplicationArea = All;
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                }
                field(Minumum; Minumum)
                {
                    ApplicationArea = All;
                }
                field(Maximum; Maximum)
                {
                    ApplicationArea = All;
                }
            }
        }
    }



    trigger OnOpenPage()
    begin
        SETCURRENTKEY(Minumum, Maximum);
    end;

    var
        Text0001: Label 'Rating Factor should not be overlap.';
        FirstRecords: Boolean;
        EvaluationRatingScaleMasterRecG: Record "Evaluation Rating Scale Master";
        EvaluationRatingScaleMasterRec2G: Record "Evaluation Rating Scale Master";
}

