page 60267 "Evaluation Appraisal Subform"
{
    Caption = 'Evaluation Appraisal';
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = true;
    PageType = ListPart;
    SourceTable = "Evaluation Appraisal Line";


    layout
    {
        area(content)
        {
            repeater(Group)
            {
                IndentationColumn = IndentationColumn;
                IndentationControls = "Performance Appraisal Type";
                ShowAsTree = true;

                field("Appraisal Type"; TypeTextG)
                {
                    Editable = false;
                    Style = Strong;
                    StyleExpr = IntendentStyleBoolG;
                    ApplicationArea = All;
                }
                field("Performance Appraisal Type"; "Performance Appraisal Type")
                {
                    Style = Strong;
                    StyleExpr = IntendentStyleBoolG;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Performance ID"; "Performance ID")
                {
                    Style = Strong;
                    StyleExpr = IntendentStyleBoolG;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Employee Code"; "Employee Code")
                {
                    Style = Strong;
                    StyleExpr = IntendentStyleBoolG;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Line No."; "Line No.")
                {
                    Style = Strong;
                    StyleExpr = IntendentStyleBoolG;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Rating Factors"; "Rating Factors")
                {
                    Style = Strong;
                    StyleExpr = IntendentStyleBoolG;
                    ToolTip = 'ToolTips';
                    ApplicationArea = All;
                }
                field("Rating Factor Description"; "Rating Factor Description")
                {
                    MultiLine = true;
                    Style = Strong;
                    StyleExpr = IntendentStyleBoolG;
                    Visible = false;
                    ApplicationArea = All;
                }
                //commented By Avinash 
                /*
                field("Rating Factor Descriptions"; TextManagement.GetRecordErrorMessage("Rating Factor Description", '', '', ''))
                {
                    Editable = false;
                    Style = Strong;
                    StyleExpr = IntendentStyleBoolG;
                    ToolTip = 'Please clikc to Assit button to view details';

                    trigger OnAssistEdit()
                    begin
                        //commented By Avinash   ShowErrorMessage;
                    end;
                }
                */
                //commented By Avinash 
                field(IndentationColumn; IndentationColumn)
                {
                    Editable = IntendentEditBoolG;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Maximum Rating"; "Maximum Rating")
                {
                    HideValue = IndentationColumn = 1;
                    Style = Strong;
                    StyleExpr = IntendentStyleBoolG;
                    ApplicationArea = All;
                }
                field("Evaluation Rating"; "Evaluation Rating")
                {
                    Editable = true;
                    HideValue = IndentationColumn = 1;
                    Style = Strong;
                    StyleExpr = IntendentStyleBoolG;
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        CurrPage.UPDATE;
                    end;
                }
                field("Each Type"; "Each Type")
                {
                    Caption = 'Factor Total Rating';
                    HideValue = IndentationColumn = 2;
                    Style = Strong;
                    StyleExpr = IntendentStyleBoolG;
                    ApplicationArea = All;
                }
            }
            fixed(Control20)
            {
            }
            group(Control13)
            {
                field("Total Score"; SummaryTotalIntG)
                {
                    Editable = false;
                    Style = Strong;
                    StyleExpr = TRUe;
                    ApplicationArea = All;
                }
                field("Performance Rating"; PerformanceRating)
                {
                    Enabled = false;
                    Style = Strong;
                    StyleExpr = TRUe;
                    ApplicationArea = All;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        if IndentationColumn = 1 then begin
            TypeTextG := "Performance Appraisal Type";
            IntendentEditBoolG := false;
            IntendentStyleBoolG := true;
        end
        else begin
            TypeTextG := '';
            IntendentEditBoolG := true;
            IntendentStyleBoolG := false;
        end;




        ShowTotalSummary();
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        ShowTotalSummary();
    end;

    trigger OnModifyRecord(): Boolean
    begin
        ShowTotalSummary();
    end;

    trigger OnOpenPage()
    begin
        SETCURRENTKEY("Performance Appraisal Type");
        IntendentStyleBoolG := false;
        IntendentEditBoolG := false;
    end;

    var
        TypeTextG: Code[150];
        IntendentStyleBoolG: Boolean;
        IntendentEditBoolG: Boolean;
        EvaluationFactorTypeMasterRecG: Record "Evaluation Factor Type Master";
        //commented By Avinash    TextManagement: Codeunit TextManagement;
        e: Text;
        Text001: Label 'There is not Content.';
        SummaryTotalIntG: Decimal;
        EvaluationAppraisalHeaderRecG: Record "Evaluation Appraisal Header";
        PerformanceRating: Code[150];
        EvaluationRatingScaleMasterRecG: Record "Evaluation Rating Scale Master";

    //commented By Avinash  [Scope('Internal')]
    procedure ShowErrorMessage()
    var
        e: Text;
    begin
        //commented By Avinash  e := TextManagement.GetRecordErrorMessage("Rating Factor Description", '', '', '');
        if e = '' then
            e := Text001;
        MESSAGE(e);
    end;

    local procedure ShowTotalSummary()
    begin
        CLEAR(SummaryTotalIntG);
        EvaluationAppraisalHeaderRecG.RESET;
        EvaluationAppraisalHeaderRecG.SETRANGE("Performance ID", "Performance ID");
        EvaluationAppraisalHeaderRecG.SETRANGE("Employee Code", "Employee Code");
        if EvaluationAppraisalHeaderRecG.FINDFIRST then begin
            EvaluationAppraisalHeaderRecG.CALCFIELDS("Total Sum");
            SummaryTotalIntG := EvaluationAppraisalHeaderRecG."Total Sum";
        end;

        CLEAR(PerformanceRating);
        EvaluationRatingScaleMasterRecG.RESET;
        if EvaluationRatingScaleMasterRecG.FINDSET then
            repeat
                if (SummaryTotalIntG >= EvaluationRatingScaleMasterRecG.Minumum) and (SummaryTotalIntG <= EvaluationRatingScaleMasterRecG.Maximum) then
                    PerformanceRating := EvaluationRatingScaleMasterRecG.Description
            until EvaluationRatingScaleMasterRecG.NEXT = 0;
    end;
}

