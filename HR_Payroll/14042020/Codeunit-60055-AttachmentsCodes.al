codeunit 60055 "File Attachments Codes"
{

    [EventSubscriber(ObjectType::Table, 1173, 'OnBeforeInsertAttachment', '', true, true)]
    procedure OnBeforeInsertAttachment_LT(var DocumentAttachment: Record "Document Attachment"; var RecRef: RecordRef)
    var
        LeaveRequestHeaderRecL: Record "Leave Request Header";
        LRHRecRefL: RecordRef;
        FieldRef: FieldRef;
        RecNo: Code[20];
        DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order";
        LineNo: Integer;
        DocumentAttachmentRecL: Record "Document Attachment";
    begin
        case RecRef.Number of
            DATABASE::"Leave Request Header":
                begin
                    FieldRef := RecRef.Field(1);
                    RecNo := FieldRef.Value;
                    DocumentAttachment.Validate("No.", RecNo);

                    DocumentAttachmentRecL.Reset();
                    DocumentAttachmentRecL.SetRange("No.", RecNo);
                    DocumentAttachmentRecL.SetRange("Table ID", Database::"Leave Request Header");
                    if LeaveRequestHeaderRecL.FindLast() then
                        LineNo += DocumentAttachmentRecL."Line No." + 1000
                    else
                        LineNo := 1000;

                    DocumentAttachment.Validate("Line No.", LineNo);

                end;

        end;
    end;

    [EventSubscriber(ObjectType::Page, 1173, 'OnAfterOpenForRecRef', '', true, true)]
    procedure OnAfterOpenForRecRef_LT(var DocumentAttachment: Record "Document Attachment"; var RecRef: RecordRef)
    var
        FieldRef: FieldRef;
        RecNo: Code[20];
        DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order";
        LineNo: Integer;
    begin
        case RecRef.Number of
            DATABASE::"Leave Request Header":
                begin
                    FieldRef := RecRef.Field(1);
                    RecNo := FieldRef.Value;
                    DocumentAttachment.SetRange("No.", RecNo);
                    DocumentAttachment.SetRange("Table ID", Database::"Leave Request Header");

                    // // FieldRef := RecRef.Field(4);
                    // // LineNo := FieldRef.Value;
                    // // DocumentAttachment.SetRange("Line No.", LineNo);

                    // // DocumentAttachment.FlowFieldsEditable := false;
                end;
        end;
    end;
}