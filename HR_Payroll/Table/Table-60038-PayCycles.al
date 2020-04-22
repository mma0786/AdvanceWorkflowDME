table 60038 "Pay Cycles"
{
    DrillDownPageID = "Pay Cycles";
    LookupPageID = "Pay Cycles";

    fields
    {
        field(1; "Pay Cycle"; Code[20])
        {
        }
        field(2; Description; Text[100])
        {
        }
        field(3; "Pay Cycle Frequency"; Option)
        {
            OptionCaption = 'Daily,Weekly,Monthly,Quarterly,Anually';
            OptionMembers = Daily,Weekly,Monthly,Quarterly,Anually;

            trigger OnValidate()
            begin
                if "Pay Cycle Frequency" <> xRec."Pay Cycle Frequency" then begin
                    PayPeriods.RESET;
                    PayPeriods.SETRANGE("Pay Cycle", "Pay Cycle");
                    if PayPeriods.FINDSET then
                        ERROR('Pay periods are generated for Pay Cycle %1. You cannnot modify pay cycle frequency', "Pay Cycle");
                end;
            end;
        }
    }

    keys
    {
        key(Key1; "Pay Cycle")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin

        PayrollPositions.RESET;
        PayrollPositions.SETRANGE("Pay Cycle", "Pay Cycle");
        if PayrollPositions.FINDFIRST then
            ERROR('You cannot delete this pay cycle as it is assigned to position %1.', PayrollPositions."Position ID");


    end;

    trigger OnModify()
    begin

        PayrollPositions.RESET;
        PayrollPositions.SETRANGE("Pay Cycle", "Pay Cycle");
        if PayrollPositions.FINDFIRST then
            ERROR('You cannot modify this pay cycle as it is assigned to position %1.', PayrollPositions."Position ID");


    end;

    var
        PayPeriods: Record "Pay Periods";
        PayrollPositions: Record "Payroll Position";
}

