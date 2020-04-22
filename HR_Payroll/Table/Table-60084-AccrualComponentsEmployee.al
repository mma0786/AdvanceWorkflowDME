table 60084 "Accrual Components Employee"
{

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
        }
        field(3; "Accrual Interval Basis"; Option)
        {
            OptionCaption = ' ,Fixed,Employee Joining Date,Probation End/Confirm,Original Hire Date,Define Per Employee';
            OptionMembers = " ","Fixed","Employee Joining Date","Probation End/Confirm","Original Hire Date","Define Per Employee";
        }
        field(4; "Accrual Frequency"; Option)
        {
            OptionCaption = ' ,Daily,Weekly,Monthly,Annually';
            OptionMembers = " ",Daily,Weekly,Monthly,Annually;
        }
        field(5; "Accrual Policy Enrollment"; Option)
        {
            OptionCaption = ' ,Prorated,Full Accural,No Accural';
            OptionMembers = " ",Prorated,"Full Accural","No Accural";
        }
        field(6; "Accrual Award Date"; Option)
        {
            OptionCaption = ' ,Accural Period Start,Accural Period End';
            OptionMembers = " ","Accural Period Start","Accural Period End";
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
        field(11; "Worker ID"; Code[20])
        {
            TableRelation = Employee;
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
        field(301; "Carryforward Date"; Date)
        {
        }
        field(350; "Roll Over Period"; Integer)
        {
        }
    }

    keys
    {
        key(Key1; "Accrual ID", "Worker ID")
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
            "Accrual ID" := NoSeriesMngmnt.GetNextNo(AdvancePayrollSetup."Accrual Nos.", TODAY, true);
        end;
    end;

    var
        AdvancePayrollSetup: Record "Advance Payroll Setup";
        NoSeriesMngmnt: Codeunit NoSeriesManagement;
}

