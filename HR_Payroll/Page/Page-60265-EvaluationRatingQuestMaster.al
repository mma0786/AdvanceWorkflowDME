page 60265 "Evaluation Rating/Quest Master"
{
    AutoSplitKey = true;
    DelayedInsert = true;
    PageType = List;
    SourceTable = "Evaluation Rating/Quest Master";
    // // // UsageCategory = Lists;
    // // // ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Serial No."; "Serial No.")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Evaluation Factor Type"; "Evaluation Factor Type")
                {
                    Editable = CheckEditiableBooleanG;
                    ApplicationArea = All;
                }
                field("Rating Factor"; "Rating Factor")
                {
                    Editable = CheckEditiableBooleanG;
                    ApplicationArea = All;
                }
                field("Rating Factor Description"; "Rating Factor Description")
                {
                    ApplicationArea = All;
                }
                field("Inserted Bool"; "Inserted Bool")
                {
                    Visible = IfOpenWithEarningCodeBoolG;
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Select All Question")
            {
                Image = SelectEntries;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Select all Questions';

                trigger OnAction()
                begin
                    Rec.MODIFYALL("Inserted Bool", true);
                    CurrPage.UPDATE;
                end;
            }
            action("De-Select All Question")
            {
                Image = UnApply;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Un Check All question';

                trigger OnAction()
                begin
                    Rec.MODIFYALL("Inserted Bool", false);
                    CurrPage.UPDATE;
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        SETCURRENTKEY("Evaluation Factor Type");

        //commented By Avinash
        if EvaluationMasterSingleCUG.GetEarningCodeGroup <> '' then begin
            CheckEditiableBooleanG := false;
            IfOpenWithEarningCodeBoolG := true;
        end
        else begin
            CheckEditiableBooleanG := true;
            IfOpenWithEarningCodeBoolG := false;
        end;
        //commented By Avinash
    end;

    var
        CheckEditiableBooleanG: Boolean;
        EvaluationMasterSingleCUG: Codeunit "Evaluation Master Single CU";
        IfOpenWithEarningCodeBoolG: Boolean;
}

