page 60024 "Dependent Address ListPart1"
{
    AutoSplitKey = true;
    Caption = 'Dependent Address ';
    PageType = ListPart;
    SourceTable = "Employee Address Line";
    UsageCategory = Administration;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Name or Description"; "Name or Description")
                {
                    ApplicationArea = All;

                    Editable = EditBool;
                }
                field("Country/Region Code"; "Country/Region Code")
                {
                    ApplicationArea = All;

                    Editable = EditBool;
                }
                field(State; State)
                {
                    ApplicationArea = All;

                    Editable = EditBool;
                    Visible = false;
                }
                field("Post Code"; "Post Code")
                {
                    ApplicationArea = All;

                }
                field(City; City)
                {
                    ApplicationArea = All;

                }
                field(Street; Street)
                {
                    ApplicationArea = All;

                    Editable = EditBool;
                }
                field(Primary; Primary)
                {
                    ApplicationArea = All;

                    Editable = EditBool;

                    trigger OnValidate()
                    begin
                        if Primary = true then
                            PriValidation;
                        CurrPage.UPDATE(true);
                    end;
                }
                field(Private; Private)
                {
                    ApplicationArea = All;

                    Editable = EditBool;
                }
                field(Purpose; Purpose)
                {
                    ApplicationArea = All;

                    Editable = EditBool;
                }
            }
        }
    }


    trigger OnAfterGetCurrRecord()
    begin
        Editing;
    end;

    trigger OnAfterGetRecord()
    begin
        Editing;
    end;

    trigger OnInit()
    begin
        Editing;
    end;

    var
        [InDataSet]
        EditBool: Boolean;

    local procedure Editing()
    var
    //DepMasterRec: Record "Employee Dependents Master";
    begin
        /*DepMasterRec.RESET;
        DepMasterRec.SETRANGE("No.","Dependent ID");
        IF DepMasterRec.FINDFIRST THEN BEGIN
          IF DepMasterRec."Workflow Status" <> DepMasterRec."Workflow Status"::Open THEN
            EditBool := FALSE
          ELSE*/
        EditBool := true;
        /*END;*/

    end;

    local procedure PriValidation()
    var
        Rec2: Record "Employee Address Line";
    begin
        Rec2.RESET;
        Rec2.SETRANGE("Dependent ID", "Dependent ID");
        //Rec2.SETRANGE("Name or Description","Name or Description");
        Rec2.SETRANGE(Primary, true);
        if Rec2.FINDFIRST then begin
            if CONFIRM(' A Address type has already marked as Primary. Do you want to change the primary? \Click Yes to Continue, No to Cancel.', true) then begin
                Rec.Primary := true;
                Rec2.Primary := false;
                Rec2.MODIFY;
            end else
                Primary := false;

        end;
    end;
}

