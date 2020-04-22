page 60091 "Payroll Job Card"
{
    PageType = Document;
    SourceTable = "Payroll Jobs";
    UsageCategory = Documents;
    //  ApplicationArea = All;


    layout
    {
        area(content)
        {
            group(General)
            {
                field(Job; Job)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Job Description"; "Job Description")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field("Grade Category"; "Grade Category")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field("Earning Code Group"; "Earning Code Group")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field("Job Title"; "Job Title")
                {
                    ApplicationArea = All;
                }
                field("Full Time Equivalent"; "Full Time Equivalent")
                {
                    ApplicationArea = All;
                }
                field("Maximum Positions"; "Maximum Positions")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        if "Maximum Positions" then begin
                            Unlimited := false;
                            VisibleMaxPositions := true;
                        end
                        else begin
                            Unlimited := true;
                            VisibleMaxPositions := false;
                        end;
                    end;
                }
                field(Unlimited; Unlimited)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        if Unlimited then begin
                            "Maximum Positions" := false;
                            VisibleMaxPositions := false;
                        end
                        else begin
                            "Maximum Positions" := true;
                            VisibleMaxPositions := true;
                        end;
                    end;
                }
                field("Max. No Of Positions"; "Max. No Of Positions")
                {
                    ApplicationArea = All;
                    Editable = VisibleMaxPositions;
                }
                field("Job Type"; "Job Type")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
            }
            group("Description.")
            {
                Caption = 'Description';
                grid(Control26)
                {
                    group(Control29)
                    {
                        Caption = '';
                        field(Description; Description)
                        {
                            ApplicationArea = All;
                            MultiLine = true;
                            Width = 1000;
                        }
                    }
                }
            }
            group("Job Classification")
            {
                Visible = false;
                field("Job Function"; "Job Function")
                {
                    ApplicationArea = All;
                }
            }
            part(Skills; "Payroll Job Skills Subpage")
            {
                SubPageLink = "Job ID" = FIELD(Job);
                ApplicationArea = All;
            }
            part(Certificate; "Payroll Job Certificate Subpag")
            {
                SubPageLink = "Job ID" = FIELD(Job);
                ApplicationArea = All;
            }
            part(Tests; "Payroll Job Tests Subpage")
            {
                SubPageLink = "Job ID" = FIELD(Job);
                ApplicationArea = All;
            }
            part(Education; "Payroll Job Education Subpage")
            {
                SubPageLink = "Job ID" = FIELD(Job);
                ApplicationArea = All;
            }
            part(Screenings; "Payroll Job Screening Subpage")
            {
                SubPageLink = "Job ID" = FIELD(Job);
                ApplicationArea = All;
            }
            part("Job Tasks"; "Payroll Job Tasks Subpage")
            {
                SubPageLink = "Job ID" = FIELD(Job);
                ApplicationArea = All;
            }
            part("Area Of Responsibility"; "Payroll Job Area of Resp. Subp")
            {
                SubPageLink = "Job ID" = FIELD(Job);
                ApplicationArea = All;
            }
        }
    }



    trigger OnAfterGetRecord()
    begin
        if "Maximum Positions" then
            VisibleMaxPositions := true
        else
            VisibleMaxPositions := false;
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        PayrollPosition.RESET;
        PayrollPosition.SETRANGE(Job, Job);
        if PayrollPosition.FINDFIRST then
            ERROR(Erro001);
    end;

    trigger OnOpenPage()
    begin
        if "Maximum Positions" then
            VisibleMaxPositions := true
        else
            VisibleMaxPositions := false;
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        if Job <> '' then begin
            TESTFIELD("Job Description");
            TESTFIELD("Grade Category");
            TESTFIELD("Earning Code Group");
        end;
    end;

    var
        VisibleMaxPositions: Boolean;
        PayrollJobs: Record "Payroll Jobs";
        PayrollPosition: Record "Payroll Position";
        Erro001: Label 'Position has already been created for the selected job. Cannot be deleted.';
}

