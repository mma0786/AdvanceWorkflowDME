page 60090 "Payroll Jobs"
{
    CardPageID = "Payroll Job Card";
    PageType = List;
    SourceTable = "Payroll Jobs";
    UsageCategory = Lists;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Job; Job)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Job Description"; "Job Description")
                {
                    ApplicationArea = All;
                }
                field("Job Title"; "Job Title")
                {
                    ApplicationArea = All;
                }
                field("Full Time Equivalent"; "Full Time Equivalent")
                {
                    ApplicationArea = All;
                }
                field("Job Function"; "Job Function")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Grade Category"; "Grade Category")
                {
                    ApplicationArea = All;
                }
                field("Earning Code Group"; "Earning Code Group")
                {
                    ApplicationArea = All;
                }
            }
        }
    }



    trigger OnDeleteRecord(): Boolean
    begin
        PayrollPosition.RESET;
        PayrollPosition.SETRANGE(Job, Job);
        if PayrollPosition.FINDFIRST then
            ERROR(Erro001);
    end;

    var
        PayrollPosition: Record "Payroll Position";
        Erro001: Label 'Position has already been created for the selected job. Cannot be deleted"';
}

