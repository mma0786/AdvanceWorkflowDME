page 60275 "Document Request List"
{
    Caption = 'Document Request List';
    Editable = false;
    PageType = List;
    SourceTable = "Document Request";
    CardPageId = "Document request Card";
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Document Request ID"; "Document Request ID")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Employee ID"; "Employee ID")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Employee Name"; "Employee Name")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field(Addressee; Addressee)
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Document format ID"; "Document format ID")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Document Title"; "Document Title")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Request Date"; "Request Date")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Document Date"; "Document Date")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field("WorkFlow Status"; "WorkFlow Status")
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }
}

