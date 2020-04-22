table 60034 "Payroll Adjmt. Journal header"
{
    Caption = 'Payroll Adjmt. Journal header';

    fields
    {
        field(10; "Journal No."; Code[20])
        {

            trigger OnValidate()
            begin
                if Rec.Posted then
                    ERROR('You cannot modify the confirmed Journals');

                GetPayrollSetup;
                if "Journal No." = '' then
                    "Journal No." := NoSeriesManagement.GetNextNo(AdvPayrollSetup."Payroll Adj Journal No. Series", TODAY, true);
            end;
        }
        field(20; Description; Text[100])
        {

            trigger OnValidate()
            begin
                if Rec.Posted then
                    ERROR('You cannot modify the confirmed Journals');
            end;
        }
        field(30; "Pay Cycle"; Code[20])
        {
            TableRelation = "Pay Cycles"."Pay Cycle";

            trigger OnValidate()
            begin
                if Rec.Posted then
                    ERROR('You cannot modify the confirmed Journals');
            end;
        }
        field(40; "Pay Period Start"; Date)
        {

            trigger OnLookup()
            begin
                PayPeriods.FILTERGROUP(2);
                PayPeriods.RESET;
                PayPeriods.SETRANGE("Pay Cycle", Rec."Pay Cycle");
                PayPeriods.FILTERGROUP(0);

                if PAGE.RUNMODAL(60071, PayPeriods) = ACTION::LookupOK then begin
                    VALIDATE("Pay Period Start", PayPeriods."Period Start Date");
                    VALIDATE("Pay Period End", PayPeriods."Period End Date");
                end;
            end;

            trigger OnValidate()
            begin
                TESTFIELD(Posted, false);
                if Rec.Posted then
                    ERROR('You cannot modify the confirmed Journals');

                if "Pay Period Start" = 0D then
                    "Pay Period End" := 0D;

                PayPeriods.RESET;
                PayPeriods.SETRANGE("Period Start Date", "Pay Period Start");
                if not PayPeriods.FINDFIRST then
                    ERROR('Please select valid Change Pay Period from the lookup');
            end;
        }
        field(41; "Pay Period End"; Date)
        {

            trigger OnLookup()
            begin
                PayPeriods.FILTERGROUP(2);
                PayPeriods.RESET;
                PayPeriods.SETRANGE("Pay Cycle", Rec."Pay Cycle");
                PayPeriods.FILTERGROUP(0);

                if PAGE.RUNMODAL(60071, PayPeriods) = ACTION::LookupOK then begin
                    VALIDATE("Pay Period Start", PayPeriods."Period Start Date");
                    VALIDATE("Pay Period End", PayPeriods."Period End Date");
                end;
            end;

            trigger OnValidate()
            begin
                if Rec.Posted then
                    ERROR('You cannot modify the confirmed Journals');

                if "Pay Period End" <> 0D then begin
                    PayPeriods.RESET;
                    PayPeriods.SETRANGE("Period End Date", "Pay Period End");
                    if not PayPeriods.FINDFIRST then
                        ERROR('Please select valid Change Pay Period from the lookup');
                end;
            end;
        }
        field(50; "Defaualt Employee"; Code[20])
        {
            TableRelation = Employee;

            trigger OnValidate()
            begin
                if Rec.Posted then
                    ERROR('You cannot modify the confirmed Journals');
            end;
        }
        field(60; "Default Earning Code"; Code[20])
        {
            TableRelation = "Payroll Earning Code Wrkr"."Earning Code" WHERE(Worker = FIELD("Defaualt Employee"));

            trigger OnValidate()
            begin
                if Rec.Posted then
                    ERROR('You cannot modify the confirmed Journals');
            end;
        }
        field(70; "Create By"; Code[50])
        {
            TableRelation = User;

            trigger OnValidate()
            begin
                if Rec.Posted then
                    ERROR('You cannot modify the confirmed Journals');
            end;
        }
        field(80; "Created DateTime"; DateTime)
        {

            trigger OnValidate()
            begin
                if Rec.Posted then
                    ERROR('You cannot modify the confirmed Journals');
            end;
        }
        field(90; "Work Flow Status"; Option)
        {
            OptionCaption = 'Created,Not Created';
            OptionMembers = Created,"Not Created";
        }
        field(100; Posted; Boolean)
        {
            Editable = false;

            trigger OnValidate()
            begin
                if Rec.Posted then
                    ERROR('You cannot modify the confirmed Journals');
            end;
        }
        field(105; "Posted By"; Code[50])
        {
            TableRelation = User;
        }
        field(110; "Posted DateTime"; DateTime)
        {

            trigger OnValidate()
            begin
                if Rec.Posted then
                    ERROR('You cannot modify the confirmed Journals');
            end;
        }
        field(115; "Financial Dimension"; Code[20])
        {

            trigger OnValidate()
            begin
                if Rec.Posted then
                    ERROR('You cannot modify the confirmed Journals');
            end;
        }
    }

    keys
    {
        key(Key1; "Journal No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        PayrollAdjmtJournalLines.RESET;
        PayrollAdjmtJournalLines.SETRANGE("Journal No.", Rec."Journal No.");
        if PayrollAdjmtJournalLines.FINDFIRST then
            ERROR('Payroll Adj. Lines Exist');

        if Rec.Posted then
            ERROR('You cannot delete the confirmed Journals');
    end;

    trigger OnInsert()
    begin
        GetPayrollSetup;
        if "Journal No." = '' then
            "Journal No." := NoSeriesManagement.GetNextNo(AdvPayrollSetup."Payroll Adj Journal No. Series", TODAY, true);

        "Create By" := USERID;
        "Created DateTime" := CREATEDATETIME(TODAY, TIME);
    end;

    trigger OnModify()
    begin
        if Rec.Posted then
            ERROR('You cannot modify the confirmed Journals');
    end;

    var
        PayPeriods: Record "Pay Periods";
        PayCycles: Record "Pay Cycles";
        AdvPayrollSetup: Record "Advance Payroll Setup";
        PayrollSetupGet: Boolean;
        NoSeriesManagement: Codeunit NoSeriesManagement;
        PayrollAdjmtJournalLines: Record "Payroll Adjmt. Journal Lines";

    local procedure GetPayrollSetup()
    begin
        if not PayrollSetupGet then begin
            AdvPayrollSetup.GET;
            AdvPayrollSetup.TESTFIELD("Payroll Adj Journal No. Series");
            PayrollSetupGet := true;
        end;
    end;
}

