page 60268 "Evaluation Setup"
{
    DelayedInsert = true;
    PageType = List;
    RefreshOnActivate = true;
    SourceTable = "Evaluation Setup";
    UsageCategory = Tasks;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater("Weightage Factor")
            {
                field("Grade Category"; "Grade Category")
                {
                    ApplicationArea = All;
                }
                field("Earning Code Group"; "Earning Code Group")
                {
                    Caption = 'Performance Appraisal Type';
                    ApplicationArea = All;
                }
                field("Performance Appraisal Type"; "Performance Appraisal Type")
                {
                    Caption = 'Appraisal Weightage';
                    ApplicationArea = All;
                }
                field(Weightage; Weightage)
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        CurrPage.UPDATE;

                        CALCFIELDS("Group Total Weightage");
                        if "Group Total Weightage" > 100 then
                            ERROR(Test0001);
                    end;
                }
                field("Group Total Weightage"; "Group Total Weightage")
                {
                    ApplicationArea = All;
                    Style = Strong;
                    StyleExpr = TRUE;
                }
            }
        }
    }



    trigger OnOpenPage()
    begin
        SETCURRENTKEY("Group Total Weightage");
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        if "Grade Category" <> '' then begin
            CALCFIELDS("Group Total Weightage");
            TESTFIELD("Group Total Weightage", 100);
        end;
    end;

    var
        Test0001: Label 'Maximum 100 Allow only.';
}

