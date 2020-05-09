page 60282 "Short Leave Request SubPage"
{
    Caption = 'Short Leave Request Line';
    PageType = ListPart;
    SourceTable = "Short Leave Line";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Employee Id"; "Employee Id")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Employee Name"; "Employee Name")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Leave Type"; "Leave Type")
                {
                    ApplicationArea = all;
                    Enabled = false;
                    ShowMandatory = true;
                }
                field("Requesht Date"; "Requesht Date")
                {
                    ApplicationArea = all;
                    Editable = VisibBool;
                    ShowMandatory = true;
                }
                field("Day Type"; "Day Type")
                {
                    ApplicationArea = all;
                    ShowMandatory = true;
                    Style = Strong;
                }
                field("Req. Start Time"; "Req. Start Time")
                {
                    ApplicationArea = all;
                    Editable = VisibBool;
                    ShowMandatory = true;
                }
                field("Req. End Time"; "Req. End Time")
                {
                    ApplicationArea = all;
                    Editable = VisibBool;
                    ShowMandatory = true;
                }
                field("No Hours Requested"; "No Hours Requested")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field(Reason; Reason)
                {
                    ApplicationArea = all;
                    Editable = VisibBool;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetCurrRecord()
    begin
        IF "Employee Id" = '' THEN
            Rec.DELETE;
        ControleVisib;
    end;

    trigger OnAfterGetRecord()
    begin
        IF "Employee Id" = '' THEN
            Rec.DELETE;
        ControleVisib;
    end;

    var
        [InDataSet]
        VisibBool: Boolean;
        HeadRec: Record "Short Leave Header";

    local procedure ControleVisib()
    begin
        HeadRec.RESET;
        HeadRec.SETRANGE("Short Leave Request Id", "Short Leave Request Id");
        IF HeadRec.FINDFIRST THEN
            IF HeadRec.Posted = TRUE THEN
                VisibBool := FALSE
            ELSE
                VisibBool := TRUE;
    end;
}

