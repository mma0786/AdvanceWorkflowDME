page 60111 "Payroll Job Position Card"
{
    Caption = 'Position Card';
    PageType = Card;
    SourceTable = "Payroll Position";
    UsageCategory = Documents;
    // ApplicationArea = All;


    layout
    {
        area(content)
        {
            group(General)
            {
                field("Position ID"; "Position ID")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Job; Job)
                {
                    ShowMandatory = true;
                    ApplicationArea = All;
                }
                field("Position Description"; Description)
                {
                    ShowMandatory = true;
                    ApplicationArea = All;
                }
                field("Job Description"; "Job Description")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field(Department; Department)
                {
                    ShowMandatory = true;
                    ApplicationArea = All;
                }
                field("Sub Department"; "Sub Department")
                {
                    ApplicationArea = All;
                }
                field(Title; Title)
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field("Position Type"; "Position Type")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field("Full Time Equivalent"; "Full Time Equivalent")
                {
                    ApplicationArea = All;
                }
                field("Available for Assignment"; "Available for Assignment")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field("Final authority"; "Final authority")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        if "Final authority" then begin
                            CLEAR("Reports to Position");
                            CLEAR(Worker);
                            CLEAR("Worker Name");

                            CLEAR("Second Reports to Position");
                            CLEAR("Second Worker");
                            CLEAR("Second Worker Name");
                            FinalAuthBool_G := false;
                            CurrPage.UPDATE(true);//(FALSE);
                        end else
                            FinalAuthBool_G := true;
                    end;
                }
            }
            group(" Position Summary")
            {
                grid(Control27)
                {
                    group(Control26)
                    {
                        Caption = '';
                        field("Position Summarry"; PositionSummarry)
                        {
                            ApplicationArea = All;
                            MultiLine = true;
                            Width = 1000;

                            trigger OnValidate()
                            begin
                                SetPositionSummary(PositionSummarry);
                            end;
                        }
                    }
                }
            }
            part("Payroll Duration"; "Payroll Position Duration")
            {
                SubPageLink = "Positin ID" = FIELD("Position ID");
                ApplicationArea = All;
            }
            part("Worker Assignment"; "Payroll Job Pos. Worker Assign")
            {
                Editable = false;
                ShowFilter = true;
                SubPageLink = "Position ID" = FIELD("Position ID");
                ApplicationArea = All;
            }
            group("Reports to ")
            {
                label("First Reports to")
                {
                    Caption = 'First Reports to';
                    ApplicationArea = All;
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field("Reports to Position"; "Reports to Position")
                {
                    Editable = FinalAuthBool_G;
                    ApplicationArea = All;
                }
                field(Worker; Worker)
                {
                    Editable = false;
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field("Worker Name"; "Worker Name")
                {
                    Editable = false;
                    ApplicationArea = All;
                    Style = Standard;
                    StyleExpr = TRUE;
                }
                label("Second Reports to")
                {
                    ApplicationArea = All;
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field("Second Reports to Position"; "Second Reports to Position")
                {
                    Editable = FinalAuthBool_G;
                    ApplicationArea = All;
                }
                field("Second Worker"; "Second Worker")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field("Second Worker Name"; "Second Worker Name")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
            }
            group(Payroll)
            {
                field("Pay Cycle"; "Pay Cycle")
                {
                    ShowMandatory = true;
                    ApplicationArea = All;
                }
                field("Paid By"; "Paid By")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
            }
            group(Realtionships)
            {

            }
        }
        area(factboxes)
        {
            part(Control21; "Payroll Pos. Dur. Factbox")
            {
                Provider = "Payroll Duration";
                SubPageLink = "Positin ID" = FIELD("Positin ID");
                ApplicationArea = All;
            }
            // // // part(Control39; "Worker Position assign Factbox")
            // // // {
            // // //     Provider = "Worker Assignment";
            // // //     SubPageLink = "Position ID" = FIELD("Position ID"),
            // // //                   "Line No." = FIELD("Line No.");
            // // // }
        }
    }

    actions
    {
    }

    trigger OnAfterGetCurrRecord()
    begin
        if "Final authority" then
            FinalAuthBool_G := false
        else
            FinalAuthBool_G := true;
    end;

    trigger OnAfterGetRecord()
    begin
        if "Union Agreement Needed" then
            EditLabourUnion := true
        else
            EditLabourUnion := false;
        PositionSummarry := GetPositionSummary;

        UpdateOpenPositions;
        CheckPositionActive;

        if "Final authority" then
            FinalAuthBool_G := false
        else
            FinalAuthBool_G := true;
    end;

    trigger OnClosePage()
    begin
        MandatoryFields;
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        PayrollJobPosWorkerAssign.RESET;
        PayrollJobPosWorkerAssign.SETRANGE("Position ID", "Position ID");
        if PayrollJobPosWorkerAssign.FINDFIRST then
            ERROR('Worker Already assign , you cannot delete this document.');
    end;

    trigger OnOpenPage()
    begin
        if "Final authority" then
            FinalAuthBool_G := false
        else
            FinalAuthBool_G := true;
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        MandatoryFields;
        //MODIFY;
    end;

    var
        EditLabourUnion: Boolean;
        PayrollPosDuration: Record "Payroll Position Duration";
        PositionSummarry: Text;
        PayrollPosition: Record "Payroll Position";
        PayrollWorkedAssign: Record "Payroll Job Pos. Worker Assign";
        PayrollPositionRec_G: Record "Payroll Position";
        PayrollJobPosWorkerAssign: Record "Payroll Job Pos. Worker Assign";
        FinalAuthBool_G: Boolean;

    local procedure MandatoryFields()
    begin
        PayrollPositionRec_G.RESET;
        PayrollPositionRec_G.SETRANGE("Position ID", "Position ID");
        if PayrollPositionRec_G.FINDFIRST then begin
            //IF "Position ID" <> '' THEN BEGIN
            TESTFIELD(Job);
            TESTFIELD(Description);
            TESTFIELD("Available for Assignment");
            TESTFIELD(Department);
            TESTFIELD("Pay Cycle");
            TestField("Position Type");
            TestField(Title);
        end;
    end;
}

