page 60226 "Employee Insurance Card"
{
    //CardPageID = "Employee Insurance Card";
    DelayedInsert = true;
    DeleteAllowed = true;
    Editable = true;
    ModifyAllowed = true;
    PageType = Card;
    ShowFilter = false;
    SourceTable = "Employee Insurance";
    SourceTableView = SORTING("Employee Id");

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Employee Id"; "Employee Id")
                {
                    ApplicationArea = All;
                }
                field(Type; Type)
                {
                    ApplicationArea = All;
                }
                field("Person Insured"; "Person Insured")
                {
                    ApplicationArea = All;
                    Enabled = Type = Type::Dependents;
                }
                field("Person Insured Name"; "Person Insured Name")
                {
                    ApplicationArea = All;
                }
                field(Relationship; Relationship)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Gender; Gender)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Date Of Birth"; "Date Of Birth")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Nationality; Nationality)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Insurance Service Provider"; "Insurance Service Provider")
                {
                    ApplicationArea = All;
                }
                field("Insurance Category"; "Insurance Category")
                {
                    ApplicationArea = All;
                }
                field("Insurance Card No"; "Insurance Card No")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field("Issue Date"; "Issue Date")
                {
                    ApplicationArea = All;
                }
                field("Expiry Date"; "Expiry Date")
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
                //PromotedCategory = Category8;
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

    trigger OnQueryClosePage(CloseAction: Action): Boolean;
    begin
        if CloseAction in [ACTION::OK, ACTION::LookupOK] then begin
            if (Type <> Type::"''") and ("Person Insured" <> '') then begin
                TESTFIELD("Insurance Card No");
                TESTFIELD("Insurance Service Provider");
                TESTFIELD("Expiry Date");
                TESTFIELD("Issue Date");
            end;
        end;
    end;
}

