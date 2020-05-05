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
            // Start 05.05.2020 "Loan Request"            
            DATABASE::"Loan Request":
                begin
                    FieldRef := RecRef.Field(1);
                    RecNo := FieldRef.Value;
                    DocumentAttachment.Validate("No.", RecNo);

                    DocumentAttachmentRecL.Reset();
                    DocumentAttachmentRecL.SetRange("No.", RecNo);
                    DocumentAttachmentRecL.SetRange("Table ID", Database::"Loan Request");
                    if LeaveRequestHeaderRecL.FindLast() then
                        LineNo += DocumentAttachmentRecL."Line No." + 1000
                    else
                        LineNo := 1000;
                    DocumentAttachment.Validate("Line No.", LineNo);
                end;
            // Stop 05.05.2020 "Loan Request"  
            // Start 05.05.2020 "Identification Master"            
            DATABASE::"Identification Master":
                begin
                    FieldRef := RecRef.Field(1);
                    RecNo := FieldRef.Value;
                    DocumentAttachment.Validate("No.", RecNo);
                    DocumentAttachmentRecL.Reset();
                    DocumentAttachmentRecL.SetRange("No.", RecNo);
                    DocumentAttachmentRecL.SetRange("Table ID", Database::"Identification Master");
                    if LeaveRequestHeaderRecL.FindLast() then
                        LineNo += DocumentAttachmentRecL."Line No." + 1000
                    else
                        LineNo := 1000;
                    DocumentAttachment.Validate("Line No.", LineNo);
                end;
            // Stop 05.05.2020 "Identification Master"  

            // Start 05.05.2020 Employee            
            DATABASE::Employee:
                begin
                    FieldRef := RecRef.Field(1);
                    RecNo := FieldRef.Value;
                    DocumentAttachment.Validate("No.", RecNo);
                    DocumentAttachmentRecL.Reset();
                    DocumentAttachmentRecL.SetRange("No.", RecNo);
                    DocumentAttachmentRecL.SetRange("Table ID", Database::Employee);
                    if LeaveRequestHeaderRecL.FindLast() then
                        LineNo += DocumentAttachmentRecL."Line No." + 1000
                    else
                        LineNo := 1000;
                    DocumentAttachment.Validate("Line No.", LineNo);
                end;
            // Stop 05.05.2020 Employee  

            // Start 05.05.2020 "Employee Insurance"            
            DATABASE::"Employee Insurance":
                begin
                    FieldRef := RecRef.Field(1);
                    RecNo := FieldRef.Value;
                    DocumentAttachment.Validate("No.", RecNo);
                    DocumentAttachmentRecL.Reset();
                    DocumentAttachmentRecL.SetRange("No.", RecNo);
                    DocumentAttachmentRecL.SetRange("Table ID", Database::"Employee Insurance");
                    if LeaveRequestHeaderRecL.FindLast() then
                        LineNo += DocumentAttachmentRecL."Line No." + 1000
                    else
                        LineNo := 1000;
                    DocumentAttachment.Validate("Line No.", LineNo);
                end;
            // Stop 05.05.2020 "Employee Insurance"  

            // Start 05.05.2020 "Payroll Job Education Line"            
            DATABASE::"Payroll Job Education Line":
                begin
                    FieldRef := RecRef.Field(1);
                    RecNo := FieldRef.Value;
                    DocumentAttachment.Validate("No.", RecNo);
                    DocumentAttachmentRecL.Reset();
                    DocumentAttachmentRecL.SetRange("No.", RecNo);
                    DocumentAttachmentRecL.SetRange("Table ID", Database::"Payroll Job Education Line");
                    if LeaveRequestHeaderRecL.FindLast() then
                        LineNo += DocumentAttachmentRecL."Line No." + 1000
                    else
                        LineNo := 1000;
                    DocumentAttachment.Validate("Line No.", LineNo);
                end;
            // Stop 05.05.2020 "Employee Insurance"  


            // Start 05.05.2020 "Payroll Job Certificate Line"           
            DATABASE::"Payroll Job Certificate Line":
                begin
                    FieldRef := RecRef.Field(1);
                    RecNo := FieldRef.Value;
                    DocumentAttachment.Validate("No.", RecNo);
                    DocumentAttachmentRecL.Reset();
                    DocumentAttachmentRecL.SetRange("No.", RecNo);
                    DocumentAttachmentRecL.SetRange("Table ID", Database::"Payroll Job Certificate Line");
                    if LeaveRequestHeaderRecL.FindLast() then
                        LineNo += DocumentAttachmentRecL."Line No." + 1000
                    else
                        LineNo := 1000;
                    DocumentAttachment.Validate("Line No.", LineNo);
                end;
            // Stop 05.05.2020 "Payroll Job Certificate Line"  

            // Start 05.05.2020 "Payroll Job Skill Line"           
            DATABASE::"Payroll Job Skill Line":
                begin
                    FieldRef := RecRef.Field(1);
                    RecNo := FieldRef.Value;
                    DocumentAttachment.Validate("No.", RecNo);
                    DocumentAttachmentRecL.Reset();
                    DocumentAttachmentRecL.SetRange("No.", RecNo);
                    DocumentAttachmentRecL.SetRange("Table ID", Database::"Payroll Job Skill Line");
                    if LeaveRequestHeaderRecL.FindLast() then
                        LineNo += DocumentAttachmentRecL."Line No." + 1000
                    else
                        LineNo := 1000;
                    DocumentAttachment.Validate("Line No.", LineNo);
                end;
            // Stop 05.05.2020 "Payroll Job Skill Line"

            // Start 05.05.2020  "Employee Bank Account"         
            DATABASE::"Employee Bank Account":
                begin
                    FieldRef := RecRef.Field(1);
                    RecNo := FieldRef.Value;
                    DocumentAttachment.Validate("No.", RecNo);
                    DocumentAttachmentRecL.Reset();
                    DocumentAttachmentRecL.SetRange("No.", RecNo);
                    DocumentAttachmentRecL.SetRange("Table ID", Database::"Employee Bank Account");
                    if LeaveRequestHeaderRecL.FindLast() then
                        LineNo += DocumentAttachmentRecL."Line No." + 1000
                    else
                        LineNo := 1000;
                    DocumentAttachment.Validate("Line No.", LineNo);
                end;
            // Stop 05.05.2020  "Employee Bank Account"


            // Start 05.05.2020  "Full and Final Calculation"       
            DATABASE::"Full and Final Calculation":
                begin
                    FieldRef := RecRef.Field(1);
                    RecNo := FieldRef.Value;
                    DocumentAttachment.Validate("No.", RecNo);
                    DocumentAttachmentRecL.Reset();
                    DocumentAttachmentRecL.SetRange("No.", RecNo);
                    DocumentAttachmentRecL.SetRange("Table ID", Database::"Full and Final Calculation");
                    if LeaveRequestHeaderRecL.FindLast() then
                        LineNo += DocumentAttachmentRecL."Line No." + 1000
                    else
                        LineNo := 1000;
                    DocumentAttachment.Validate("Line No.", LineNo);
                end;
        // Stop 05.05.2020  "Full and Final Calculation"



        end;
    end;



    ////####################################################################################################################


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
                end;
            // Start 05.05.2020 "Loan Request"
            DATABASE::"Loan Request":
                begin
                    FieldRef := RecRef.Field(1);
                    RecNo := FieldRef.Value;
                    DocumentAttachment.SetRange("No.", RecNo);
                    DocumentAttachment.SetRange("Table ID", Database::"Loan Request");
                end;
            // Stop 05.05.2020 "Loan Request" 
            // Start 05.05.2020 "Identification Master"
            DATABASE::"Identification Master":
                begin
                    FieldRef := RecRef.Field(1);
                    RecNo := FieldRef.Value;
                    DocumentAttachment.SetRange("No.", RecNo);
                    DocumentAttachment.SetRange("Table ID", Database::"Identification Master");
                end;
            // Stop 05.05.2020 "Identification Master" 
            // Start 05.05.2020 Employee
            DATABASE::Employee:
                begin
                    FieldRef := RecRef.Field(1);
                    RecNo := FieldRef.Value;
                    DocumentAttachment.SetRange("No.", RecNo);
                    DocumentAttachment.SetRange("Table ID", Database::Employee);
                end;
            // Stop 05.05.2020 Employee 
            // Start 05.05.2020 "Employee Insurance"
            DATABASE::"Employee Insurance":
                begin
                    FieldRef := RecRef.Field(1);
                    RecNo := FieldRef.Value;
                    DocumentAttachment.SetRange("No.", RecNo);
                    DocumentAttachment.SetRange("Table ID", Database::"Employee Insurance");
                end;
            // Stop 05.05.2020 "Employee Insurance" 

            // Start 05.05.2020 "Payroll Job Education Line"
            DATABASE::"Payroll Job Education Line":
                begin
                    FieldRef := RecRef.Field(1);
                    RecNo := FieldRef.Value;
                    DocumentAttachment.SetRange("No.", RecNo);
                    DocumentAttachment.SetRange("Table ID", Database::"Payroll Job Education Line");
                end;
            // Stop 05.05.2020 "Payroll Job Education Line"

            // Start 05.05.2020 "Payroll Job Certificate Line"
            DATABASE::"Payroll Job Certificate Line":
                begin
                    FieldRef := RecRef.Field(1);
                    RecNo := FieldRef.Value;
                    DocumentAttachment.SetRange("No.", RecNo);
                    DocumentAttachment.SetRange("Table ID", Database::"Payroll Job Certificate Line");
                end;
            // Stop 05.05.2020 "Payroll Job Certificate Line"

            // Start 05.05.2020 "Payroll Job Skill Line"
            DATABASE::"Payroll Job Skill Line":
                begin
                    FieldRef := RecRef.Field(1);
                    RecNo := FieldRef.Value;
                    DocumentAttachment.SetRange("No.", RecNo);
                    DocumentAttachment.SetRange("Table ID", Database::"Payroll Job Skill Line");
                end;
            // Stop 05.05.2020 "Payroll Job Skill Line"
            // Start 05.05.2020  "Employee Bank Account"
            DATABASE::"Employee Bank Account":
                begin
                    FieldRef := RecRef.Field(1);
                    RecNo := FieldRef.Value;
                    DocumentAttachment.SetRange("No.", RecNo);
                    DocumentAttachment.SetRange("Table ID", Database::"Employee Bank Account");
                end;
            // Stop 05.05.2020  "Employee Bank Account"
            // Start 05.05.2020  "Full and Final Calculation"
            DATABASE::"Full and Final Calculation":
                begin
                    FieldRef := RecRef.Field(1);
                    RecNo := FieldRef.Value;
                    DocumentAttachment.SetRange("No.", RecNo);
                    DocumentAttachment.SetRange("Table ID", Database::"Full and Final Calculation");
                end;
        // Stop 05.05.2020  "Full and Final Calculation"


        end;
    end;
}