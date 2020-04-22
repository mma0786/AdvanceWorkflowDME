page 60063 "Leave Extension Lines"
{
    Caption = 'Leave Extension Lines';
    AutoSplitKey = true;
    DeleteAllowed = true;
    LinksAllowed = false;
    MultipleNewLines = true;
    PageType = ListPart;
    SourceTable = "Leave Extension";
    SourceTableView = SORTING("Leave Request ID", "Line No")
                      ORDER(Ascending);

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                Editable = ControlEditable;
                field("Leave Request ID"; "Leave Request ID")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Personnel Number"; "Personnel Number")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Employee Name"; "Employee Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Leave Type"; "Leave Type")
                {
                    ApplicationArea = All;
                    Editable = ControlEditable;
                }
                field("Short Name"; "Short Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Start Date"; "Start Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Alternative Start Date"; "Alternative Start Date")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Leave Start Day Type"; "Leave Start Day Type")
                {
                    ApplicationArea = All;
                    Editable = ControlEditable;
                }
                field("End Date"; "End Date")
                {
                    ApplicationArea = All;
                    Editable = ControlEditable;

                    trigger OnValidate()
                    begin
                        TESTFIELD("Start Date");
                        if xRec."End Date" <> 0D then begin
                            if "End Date" = xRec."End Date" then
                                ERROR('Invalid date');
                        end;

                        if DutyResume.GET("Leave Request ID") then begin
                            if "End Date" <> 0D then begin
                                if ("End Date" >= DutyResume."Resumption Date") then
                                    ERROR('End date %1 can not be greater than or equal to Resumption date %2', "End Date", DutyResume."Resumption Date");
                            end;
                        end;
                    end;
                }
                field("Alternative End Date"; "Alternative End Date")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Leave End Day Type"; "Leave End Day Type")
                {
                    ApplicationArea = All;
                    Editable = ControlEditable;
                }
                field("Leave Days"; "Leave Days")
                {
                    ApplicationArea = All;
                    Editable = ControlEditable;
                }
                field("Leave Remarks"; "Leave Remarks")
                {
                    ApplicationArea = All;
                    Editable = ControlEditable;
                }
                field("Cover Resource"; "Cover Resource")
                {
                    ApplicationArea = All;
                    Editable = ControlEditable;
                }
                field("Submission Date"; "Submission Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Posted; Posted)
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Leave Cancelled"; "Leave Cancelled")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Leave Planner ID"; "Leave Planner ID")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Created By"; "Created By")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Created Date Time"; "Created Date Time")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Resumption Type"; "Resumption Type")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                }
                field("Resumption Date"; "Resumption Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                }
                field("Net Leave Days"; "Net Leave Days")
                {
                    ApplicationArea = All;
                    Editable = ControlEditable;
                }
                field("Created Date"; "Created Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Earning Code Group"; "Earning Code Group")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
            }
        }
    }



    trigger OnAfterGetCurrRecord()
    begin
        ControlVisiblie;
    end;

    trigger OnAfterGetRecord()
    begin
        ControlVisiblie;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        if DutyResume.GET(Rec."Leave Request ID") then;

        if xRec."Personnel Number" <> '' then
            VALIDATE("Personnel Number", xRec."Personnel Number");

        if (xRec."Start Date" <> 0D) or (xRec."End Date" <> 0D) then begin
            if xRec."End Date" + 1 < DutyResume."Resumption Date" then
                VALIDATE("Start Date", xRec."End Date" + 1);
        end;
    end;

    trigger OnOpenPage()
    begin
        ControlVisiblie;
    end;

    var
        DutyResume: Record "Duty Resumption";
        ControlEditable: Boolean;

    local procedure ControlVisiblie()
    begin
        if DutyResume.GET(Rec."Leave Request ID") then begin
            if DutyResume."Workflow Status" <> DutyResume."Workflow Status"::Open then
                ControlEditable := false
            else
                ControlEditable := true;
        end;
    end;
}

