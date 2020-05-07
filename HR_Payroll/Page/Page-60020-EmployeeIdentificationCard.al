page 60020 "Employee Identification Card"
{
    PageType = Card;
    SourceTable = "Identification Master";

    SourceTableView = SORTING("Employee No.")
                      ORDER(Ascending)
                      WHERE("Document Type" = CONST(Employee));

    UsageCategory = Administration;
    // ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Document Type"; "Document Type")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("No."; "No.")
                {
                    ApplicationArea = All;
                    Editable = false;

                    trigger OnValidate()
                    begin
                        if "No." <> xRec."No." then begin
                            HrSetup.GET;
                            "No. Series" := '';
                        end;
                    end;
                }
                field("Identification Type"; "Identification Type")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;

                    trigger OnValidate()
                    begin
                        NoValidate := "No.";

                        EditDocumentType;
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
                    Editable = EditDocType;
                    ShowMandatory = true;
                }
                field("Visa Type"; "Visa Type")
                {
                    ApplicationArea = All;
                    Editable = VisaTypeBoolG;
                }
                field("Identification No."; "Identification No.")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;

                    trigger OnValidate()
                    begin
                        NoValidate := "No.";
                    end;
                }
                field("Issuing Authority"; "Issuing Authority")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field("Issuing Authority Description"; "Issuing Authority Description")
                {
                    ApplicationArea = All;
                    Editable = false;

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
                    Visible = false;
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
                    Visible = false;
                }
                field("Active Document"; "Active Document")
                {
                    ApplicationArea = All;
                }
            }
        }

    }
    actions
    {
        area(processing)
        {
            // Avinash 05.05.2020
            action("Attachment")
            {
                ApplicationArea = All;
                Image = Attachments;
                Promoted = true;
                Caption = 'Attachment';
                ToolTip = 'Add a file as an attachment. You can attach images as well as documents.';
                trigger
                OnAction()
                var
                    DocumentAttachmentDetails: Page "Document Attachment Details";
                    RecRef: RecordRef;
                begin
                    RecRef.GETTABLE(Rec);
                    DocumentAttachmentDetails.OpenForRecRef(RecRef);
                    DocumentAttachmentDetails.RUNMODAL;
                end;
            }
            // Avinash 05.05.2020
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
        EditDocumentType;
    end;

    trigger OnOpenPage()
    begin
        EditDocumentType;
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
        ID_Master: Record "Identification Master";
        HrSetup: Record "Human Resources Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        NoValidate: Text;
        IdDocTypeRec: Record "Identification Doc Type Master";
        [InDataSet]
        EditDocType: Boolean;
        VisaTypeBoolG: Boolean;

    local procedure EditDocumentType()
    begin
        if IdDocTypeRec.GET("Identification Type") then begin
            if IdDocTypeRec."Maintain Document Type" = true then
                EditDocType := true
            else begin
                EditDocType := false;
                CLEAR("ID Document Type");
            end;
        end;

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

