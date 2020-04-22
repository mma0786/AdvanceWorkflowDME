table 60082 "Accrual Components"
{
    LookupPageId = "Accrual Component List";
    fields
    {
        field(1; "Accrual ID"; Code[20])
        {

            trigger OnValidate()
            begin
                if "Accrual ID" <> xRec."Accrual ID" then begin
                    AdvancePayrollSetup.GET;
                    NoSeriesMngmnt.TestManual(AdvancePayrollSetup."Accrual Nos.");
                    AdvancePayrollSetup."Accrual Nos." := '';
                end;
            end;
        }
        field(2; Description; Text[100])
        {
            trigger OnValidate()
            begin
                if "Accrual ID" = '' then begin
                    AdvancePayrollSetup.GET;
                    AdvancePayrollSetup.TESTFIELD("Accrual Nos.");
                    //Message(AdvancePayrollSetup."Accrual Nos.");
                    "Accrual ID" := NoSeriesMngmnt.GetNextNo(AdvancePayrollSetup."Accrual Nos.", TODAY, true);
                end;
            eND;
        }
        field(7; "Months Ahead Calculate"; Integer)
        {
        }
        field(8; "Consumption Split by Month"; Boolean)
        {
        }
        field(9; "Accrual Interval Basis Date"; Date)
        {
        }
        field(10; "Accrual Basis Date"; Date)
        {
        }
        field(21; "Interval Month Start"; Integer)
        {
        }
        field(22; "Accrual Units Per Month"; Decimal)
        {
        }
        field(23; "Opening Additional Accural"; Decimal)
        {
        }
        field(24; "Max Carry Forward"; Decimal)
        {
        }
        field(25; "CarryForward Lapse After Month"; Decimal)
        {
        }
        field(26; "Repeat After Months"; Decimal)
        {
        }
        field(27; "Avail Allow Till"; Option)
        {
            OptionCaption = 'Accrual Till Date,End of Period';
            OptionMembers = "Accrual Till Date","End of Period";
        }
        field(300; "Allow Negative"; Boolean)
        {
        }
        field(350; "Roll Over Period"; Integer)
        {
        }
    }

    keys
    {
        key(Key1; "Accrual ID")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        if "Accrual ID" = '' then begin
            AdvancePayrollSetup.GET;
            AdvancePayrollSetup.TESTFIELD("Accrual Nos.");
            //Message(AdvancePayrollSetup."Accrual Nos.");
            "Accrual ID" := NoSeriesMngmnt.GetNextNo(AdvancePayrollSetup."Accrual Nos.", TODAY, true);
        end;
    end;

    var
        AdvancePayrollSetup: Record "Advance Payroll Setup";
        NoSeriesMngmnt: Codeunit NoSeriesManagement;
}

