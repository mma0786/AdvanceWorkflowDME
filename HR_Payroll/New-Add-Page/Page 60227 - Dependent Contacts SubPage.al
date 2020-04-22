page 60227 "Dependent Contacts SubPage"
{
    // version PHASE -2

    AutoSplitKey = true;
    Caption = '"Dependent Contacts "';
    PageType = ListPart;
    SourceTable = "Employee Contacts Line";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Description;Description)
                {
                    Editable = EditBool;
                }
                field(Type;Type)
                {
                    Editable = EditBool;
                }
                field("Contact Number & Address";"Contact Number & Address")
                {
                    Editable = EditBool;
                }
                field(Extension;Extension)
                {
                    Editable = EditBool;
                }
                field(Primary;Primary)
                {
                    Editable = EditBool;

                    trigger OnValidate();
                    begin
                        //CurrPage.UPDATE;
                    end;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetCurrRecord();
    begin
        Editing;
    end;

    trigger OnAfterGetRecord();
    begin
        Editing;
    end;

    trigger OnInit();
    begin
        Editing;
    end;

    var
        [InDataSet]
        EditBool : Boolean;

    local procedure Editing();
    begin
        /*DepMasterRec.RESET;
        DepMasterRec.SETRANGE("No.","Dependent ID");
        IF DepMasterRec.FINDFIRST THEN BEGIN
          IF DepMasterRec."Workflow Status" <> DepMasterRec."Workflow Status"::Open THEN
            EditBool := FALSE
          ELSE*/
        EditBool := true;
        //END;

    end;
}

