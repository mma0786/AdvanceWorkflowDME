page 60192 "Employee Education Card"
{
    InsertAllowed = false;
    PageType = Card;
    SourceTable = "Payroll Job Education Line";
    ///UsageCategory = Administration;
    //ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Emp ID"; "Emp ID")
                {
                    ApplicationArea = All;
                }
                field("Emp Full Name"; "Emp Full Name")
                {
                    ApplicationArea = All;
                }
                field("Education Level"; "Education Level")
                {
                    ApplicationArea = All;
                }
                field(Education; Education)
                {
                    ApplicationArea = All;
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                }
                field("Grade Pass"; "Grade Pass")
                {
                    ApplicationArea = All;
                }
                field("Passing Year"; "Passing Year")
                {
                    ApplicationArea = All;
                }
                field(Importance; Importance)
                {
                    Visible = false;
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
}

