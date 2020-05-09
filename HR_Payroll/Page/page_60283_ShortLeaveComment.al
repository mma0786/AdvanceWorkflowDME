page 60283 "ShortLeaveComment1"
{
    Caption = 'Short Leave Comment';
    PageType = Card;
    SourceTable = "Short Leave Comments";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Short Leave Request Id"; "Short Leave Request Id")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                label("Line Manager Comment")
                {
                    ApplicationArea = all;
                    Caption = 'Line Manager Comment';
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field(MGR; MGR)
                {
                    ApplicationArea = all;
                    Editable = EditBool;
                    MultiLine = true;

                    trigger OnValidate()
                    begin
                        SetMGR(MGR);
                    end;
                }
                label("HOD Comment")
                {
                    ApplicationArea = all;
                    Caption = 'HOD Comment';
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field(HOD; HOD)
                {
                    ApplicationArea = all;
                    Editable = EditBool;
                    MultiLine = true;

                    trigger OnValidate()
                    begin
                        SetHOD(HOD);
                    end;
                }
            }
            group("Personal Section Comments")
            {
                field(Personal; Personal)
                {
                    ApplicationArea = all;
                    Editable = EditBool;
                    MultiLine = true;

                    trigger OnValidate()
                    begin
                        SetSelf(Personal);
                    end;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetCurrRecord()
    begin

        MGR := GetMGR;
        // HOD := GetHOD;
        Personal := GetSelf;
        Editf;
    end;

    trigger OnAfterGetRecord()
    begin
        MGR := GetMGR;
        //  HOD := GetHOD;
        Personal := GetSelf;
        Editf;
    end;

    trigger OnOpenPage()
    begin
        Editf;
    end;

    var
        MGR: Text[200];
        HOD: Text[200];
        Personal: Text[500];
        [InDataSet]
        EditBool: Boolean;
        HeaderRec: Record "Short Leave Header";

    local procedure Editf()
    begin
        HeaderRec.RESET;
        HeaderRec.SETRANGE("Short Leave Request Id", "Short Leave Request Id");
        IF HeaderRec.FINDFIRST THEN BEGIN
            IF HeaderRec."WorkFlow Status" <> HeaderRec."WorkFlow Status"::Open THEN
                EditBool := FALSE
            ELSE
                EditBool := TRUE;
        END;
    end;
}

