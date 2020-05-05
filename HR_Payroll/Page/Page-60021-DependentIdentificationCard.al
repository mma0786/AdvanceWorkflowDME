page 60021 "Dependent Identification Card1"
{
    PageType = Card;
    SourceTable = "Identification Master";
    //commented By Avinash
    SourceTableView = SORTING("Employee No.")
                      ORDER(Ascending)
                      WHERE("Document Type" = CONST(Dependent));
    //commented By Avinash
    UsageCategory = Administration;
    // ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                label("Please select Identification Type first.")
                {
                    ApplicationArea = All;
                    Caption = 'Please select Identification Type first.';
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field("No."; "No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Dependent No"; "Dependent No")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Document Type"; "Document Type")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Identification Type"; "Identification Type")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        NoValidate := "No.";
                        EditDocumentType;
                        CurrPage.UPDATE;
                    end;
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("ID Document Type"; "ID Document Type")
                {
                    ApplicationArea = All;
                    Enabled = EditDocType;
                }
                field("Visa Type"; "Visa Type")
                {
                    ApplicationArea = All;
                    Editable = VisaTypeBoolG;
                }
                field("Identification No."; "Identification No.")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        NoValidate := "No.";
                    end;
                }
                field("Issuing Authority"; "Issuing Authority")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Issuing Authority Description"; "Issuing Authority Description")
                {
                    ApplicationArea = All;
                    Caption = 'Issuing Authority';
                }
                field("Issuing Country"; "Issuing Country")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        NoValidate := "No.";
                    end;
                }
                field("Issue Date"; "Issue Date")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        NoValidate := "No.";
                    end;
                }
                field("Issue Date (Hijiri)"; "Issue Date (Hijiri)")
                {
                    ApplicationArea = All;
                }
                field("Expiry Date"; "Expiry Date")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        NoValidate := "No.";
                    end;
                }
                field("Expiry Date (Hijiri)"; "Expiry Date (Hijiri)")
                {
                    ApplicationArea = All;
                }
                field("Active Document"; "Active Document")
                {
                    ApplicationArea = All;
                }
            }
        }
    }



    trigger OnAfterGetCurrRecord()
    begin
        EditDocumentType;
    end;

    trigger OnAfterGetRecord()
    begin
        EditDocumentType;
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        NoValidate := '';
    end;

    trigger OnInit()
    begin
        //EditDocumentType;
    end;

    trigger OnOpenPage()
    begin
        //EditDocumentType;
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        if NoValidate <> '' then begin
            TESTFIELD("Identification No.");
            TESTFIELD("Identification Type");
            TESTFIELD("Issuing Country");
            //TESTFIELD("Issue Date");
            //TESTFIELD("Expiry Date");
        end
    end;

    var
        NoValidate: Code[30];
        IdDocTypeRec: Record "Identification Doc Type Master";
        [InDataSet]
        EditDocType: Boolean;
        VisaTypeBoolG: Boolean;

    local procedure EditDocumentType()
    begin
        if "Identification Type" = '' then
            WarningMsg := 'Please select a Identification Type'
        else
            WarningMsg := '';

        IdDocTypeRec.GET("Identification Type");
        if IdDocTypeRec."Maintain Document Type" then
            EditDocType := true;

        /*
        EmployeeRequestFormRecG.RESET;
        IF EmployeeRequestFormRecG.GET(50009,1) THEN BEGIN
          IF "Identification Type" = EmployeeRequestFormRecG."Process Identification Master" THEN
            VisaTypeBoolG := TRUE
          ELSE BEGIN
            VisaTypeBoolG := FALSE;
            CLEAR("Visa Type");
          END;
        END;
        */

    end;
}

