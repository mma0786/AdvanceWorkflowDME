table 60013 "Employee Earning Code Groups"
{
    Caption = 'Employee Earning Code Groups';

    fields
    {
        field(5; "Employee Code"; Code[20])
        {
        }
        field(6; RecrefId; Integer)
        {
            AutoIncrement = true;
        }
        field(10; "Earning Code Group"; Code[20])
        {
            NotBlank = true;
            TableRelation = "Earning Code Groups";
        }
        field(15; Description; Text[100])
        {
        }
        field(20; Calander; Code[20])
        {
            TableRelation = "Work Calendar Header";
        }
        field(30; "Gross Salary"; Decimal)
        {
        }
        field(40; "Travel Class"; Option)
        {
            OptionCaption = 'Economy,Business';
            OptionMembers = Economy,Business;
        }
        field(50; Currency; Code[20])
        {
            TableRelation = Currency;
        }
        field(51; "Grade Category"; Code[50])
        {
            TableRelation = "Payroll Grade Category";
        }
        field(55; "Valid From"; Date)
        {
        }
        field(60; "Valid To"; Date)
        {
        }
        field(65; Position; Code[20])
        {
        }
        field(70; "Original Calander Id"; Code[20])
        {
        }
        field(75; "Benefit Template Id"; Code[20])
        {
        }
        field(76; "Earning Template Id"; Code[20])
        {
        }
        field(77; "Loan Template Id"; Code[20])
        {
        }
        field(78; "Leave Template Id"; Code[20])
        {
        }
        field(80; Type; Option)
        {
            OptionCaption = 'Original,Salary Change,Policy Change,Currency Change,Earning Code Formula Update';
            OptionMembers = Original,"Salary Change","Policy Change","Currency Change","Earning Code Formula Update";
        }
        field(81; "Employee Pos. Assgn. Line No."; Integer)
        {
        }
        field(100; "Insurance Service Provider"; Code[20])
        {
            // Commented By Avinash TableRelation = Table50033.Field1;
        }
        field(101; "Edit Service Package"; Boolean)
        {
        }
        field(500; "Max No. Goals per Dimension"; Integer)
        {
            Description = 'PMS';
            NotBlank = true;

            trigger OnValidate()
            begin
                if "Max No. Goals per Dimension" < "Min No. Goals per Dimension" then
                    ERROR('Min No. of Goals per Dimension should not be greater than Max No. of Goals per Dimension');
            end;
        }
        field(501; "Min No. Goals per Dimension"; Integer)
        {
            Description = 'PMS';
            NotBlank = true;

            trigger OnValidate()
            begin
                if "Max No. Goals per Dimension" < "Min No. Goals per Dimension" then
                    ERROR('Min No. of Goals per Dimension should not be greater than Max No. of Goals per Dimension');
            end;
        }
        field(502; "Max No. KPI Per Goal"; Integer)
        {
            Description = 'PMS';
            NotBlank = true;

            trigger OnValidate()
            begin
                if "Max No. KPI Per Goal" < "Min No. KPI per Goal" then
                    ERROR('Min No. of KPI per Goal should not be greater than Max No. of KPI per Goal');
            end;
        }
        field(503; "Min No. KPI per Goal"; Integer)
        {
            Description = 'PMS';
            NotBlank = true;

            trigger OnValidate()
            begin
                if "Max No. KPI Per Goal" < "Min No. KPI per Goal" then
                    ERROR('Min No. of KPI per Goal should not be greater than Max No. of KPI per Goal');
            end;
        }
        field(504; "Max No. of Weight per KPI"; Integer)
        {
            Description = 'PMS';
            NotBlank = true;

            trigger OnValidate()
            begin
                if "Max No. of Weight per KPI" < "Min No. of Weight per KPI" then
                    ERROR('Min No. of Weight per KPI should not be greater than Max No. of Weight per KPI');
            end;
        }
        field(505; "Min No. of Weight per KPI"; Integer)
        {
            Description = 'PMS';

            trigger OnValidate()
            begin
                if "Max No. of Weight per KPI" < "Min No. of Weight per KPI" then
                    ERROR('Min No. of Weight per KPI should not be greater than Max No. of Weight per KPI');
            end;
        }
        field(506; "Self Rating"; Boolean)
        {
            Description = 'PMS';
        }
        field(507; "Emp.Comp.Req.In Perf.Appr."; Boolean)
        {
            Description = 'PMS';
        }
    }

    keys
    {
        key(Key1; "Earning Code Group", RecrefId, "Employee Code")
        {
            Clustered = true;
        }
        key(Key2; "Valid From")
        {
        }
    }

    fieldgroups
    {
    }
    procedure OpenEarningCodes()
    var
        PayrollEarningCodeErnGrp: Record "Payroll Earning Code ErnGrp";
    begin

        PayrollEarningCodeErnGrp.RESET;
        PayrollEarningCodeErnGrp.FILTERGROUP(10);
        PayrollEarningCodeErnGrp.SETRANGE("Earning Code Group", Rec."Earning Code Group");
        PayrollEarningCodeErnGrp.FILTERGROUP(0);

        PAGE.RUNMODAL(60031, PayrollEarningCodeErnGrp);
    end;
}

