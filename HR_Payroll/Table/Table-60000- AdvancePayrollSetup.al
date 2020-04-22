table 60000 "Advance Payroll Setup"
{

    fields
    {
        field(1; "Primart Key"; Code[10])
        {
        }
        field(5; "Job Nos"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(10; "Position No."; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(11; "Earning Code Update No. Series"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(15; "Payroll Adj Journal No. Series"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(16; "Benefit Adj journal No. Series"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(17; "Payroll Statement No. Series"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(18; "Position No. Series"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(19; "Benefit No. Series"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(20; "Enable Alternate Calendar"; Boolean)
        {
            Caption = 'Alternate Calendar';
        }
        field(21; "Employee Default Leave Type"; Code[20])
        {
        }
        field(22; "Enable Benefit Adj. Jnl WF"; Boolean)
        {
        }
        field(23; "Enable Payroll Adj. Jnl WF"; Boolean)
        {
        }
        field(24; "Enable Loan Request WF"; Boolean)
        {
        }
        field(25; "Enable Benefit claim req. WF"; Boolean)
        {
        }
        field(26; "Enable Leave Req. WF"; Boolean)
        {
        }
        field(27; "Enable Overtime Approval WF"; Boolean)
        {
        }
        field(28; "Enable Payroll Statement WF"; Boolean)
        {
        }
        field(29; "Enable Leave Resumption WF"; Boolean)
        {
        }
        field(30; "Enable Salary Advance WF"; Boolean)
        {
        }
        field(31; "Enable Full and Final Jnl WF"; Boolean)
        {
        }
        field(32; "Enable Document Req. WF"; Boolean)
        {
        }
        field(33; "Enable Payout Scheme WF"; Boolean)
        {
        }
        field(34; "Maintain Employment History"; Boolean)
        {
        }
        field(35; "Maintain Benefit History"; Boolean)
        {
        }
        field(36; "Maintain Loan History"; Boolean)
        {
        }
        field(37; "Maintain Leave History"; Boolean)
        {
        }
        field(38; "Maintain Earning History"; Boolean)
        {
        }
        field(39; "Leave Request Post"; Boolean)
        {
        }
        field(40; "Leave Resumption Post"; Boolean)
        {
        }
        field(41; "Post Leave Cancellation"; Boolean)
        {
        }
        field(42; "Post Salary Adv. on approval"; Boolean)
        {
        }
        field(43; "Salary Change Show Error"; Boolean)
        {
        }
        field(44; "Policy Change Show Error"; Boolean)
        {
        }
        field(45; Nationality; Text[50])
        {
            TableRelation = "Country/Region".Name;
        }
        field(46; "Accrual Nos."; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(47; "Payroll Job Nos."; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(48; "Leave Request Nos."; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(49; "OT Setup ID"; Code[20])
        {
            Caption = 'Over Time Setup Id';

            trigger OnValidate()
            begin
                /*
                IF xRec."OT Setup ID" <> '' THEN BEGIN
                  OTSetupRec.RESET;
                  IF OTSetupRec.FINDSET THEN
                    IF CONFIRM('Over Time setup have Records, are you sure you want to change the value',TRUE) THEN
                      "OT Setup ID" := "OT Setup ID"
                    ELSE
                    "OT Setup ID":= xRec."OT Setup ID";
                END;
                */

            end;
        }
        field(50; "Educational Claim Nos."; Code[20])
        {
            Description = 'Educational Allowance Module';
            TableRelation = "No. Series";
        }
        field(51; "Journal Template Name"; Code[20])
        {
            TableRelation = "Gen. Journal Template";
        }
        field(52; "Journal Batch Name"; Code[20])
        {
            TableRelation = "Gen. Journal Batch".Name WHERE("Journal Template Name" = FIELD("Journal Template Name"));
        }
        field(53; "FS Journal ID"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(54; "Leave Adj No Series"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(55; "Loan Type"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(56; "Delegation No."; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(100; "Accrual Effective Start Date"; Date)
        {
        }
        field(101; "Work Visa Request No."; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(110; "Loan Request ID"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(111; "IQAMA Request No."; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(112; "Loan Adj. No Series"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(113; "Mission Order No. Series"; Code[20])
        {
            Description = 'PHASE - 2';
            TableRelation = "No. Series";
        }
        field(114; "Par diem Eligiblity No. Series"; Code[20])
        {
            Description = 'PHASE - 2';
            TableRelation = "No. Series";
        }
        field(115; "Par diem Journal Template Name"; Code[20])
        {
            Description = 'PHASE - 2';
            TableRelation = "Gen. Journal Template";
        }
        field(116; "Par diem Journal Batch Name"; Code[20])
        {
            Description = 'PHASE - 2';
            TableRelation = "Gen. Journal Batch".Name WHERE("Journal Template Name" = FIELD("Par diem Journal Template Name"));
        }
        field(117; "Par diem Debit Account"; Code[20])
        {
            Description = 'PHASE - 2';
            TableRelation = "G/L Account" WHERE("Account Type" = CONST(Posting),
                                                 Blocked = CONST(false));
        }
        field(118; "Par diem Credit Account"; Code[20])
        {
            Description = 'PHASE - 2';
            TableRelation = "G/L Account" WHERE("Account Type" = CONST(Posting),
                                                 Blocked = CONST(false));
        }
        field(119; "Mo Expense Request No. Series"; Code[20])
        {
            Description = 'PHASE - 2';
            TableRelation = "No. Series";
        }
        field(120; "MOEXPREQ Journal Template Name"; Code[20])
        {
            Caption = 'MO Expence Request Journal Templae Name';
            Description = 'PHASE - 2';
            TableRelation = "Gen. Journal Template";
        }
        field(121; "MOEXPREQ Journal Batch Name"; Code[20])
        {
            Caption = 'MO Expense Request Journal Batch Name';
            Description = 'PHASE - 2';
            TableRelation = "Gen. Journal Batch".Name WHERE("Journal Template Name" = FIELD("MOEXPREQ Journal Template Name"));
        }
        field(122; "MOEXPREQ Debit Account"; Code[20])
        {
            Description = 'PHASE - 2';
            TableRelation = "G/L Account" WHERE("Account Type" = CONST(Posting),
                                                 Blocked = CONST(false));
        }
        field(123; "MOEXPREQ Credit Account"; Code[20])
        {
            Description = 'PHASE - 2';
            TableRelation = "G/L Account" WHERE("Account Type" = CONST(Posting),
                                                 Blocked = CONST(false));
        }
        field(124; "Airport Access No. Series"; Code[20])
        {
            Description = 'PHASE - 2';
            TableRelation = "No. Series";
        }
        field(125; "Leave Period Start Date"; Date)
        {
        }
        field(126; "Leave Period End Date"; Date)
        {

            trigger OnValidate()
            begin
                TESTFIELD("Leave Period Start Date");
                if "Leave Period Start Date" > "Leave Period End Date" then
                    ERROR('Leave Period End Date cannot be Leave Period Date');
            end;
        }
        field(127; "Ticketing Tool No. Series"; Code[20])
        {
            Description = 'PHASE - 2';
            TableRelation = "No. Series";
        }
        field(128; "Default Marital Status Spouse"; Text[30])
        {
            // Commented By Avinash TableRelation = Table50050;
        }
        field(129; "Medical Expenses Doc No."; Code[20])
        {
            Description = 'PHASE - 2';
            TableRelation = "No. Series";
        }
        field(130; "Medical Expenses Gen. Template"; Code[20])
        {
            Description = 'PHASE - 2';
            TableRelation = "Gen. Journal Template";
        }
        field(131; "Medical Expenses Gen. Batch"; Code[20])
        {
            Description = 'PHASE - 2';
            TableRelation = "Gen. Journal Batch".Name WHERE("Journal Template Name" = FIELD("Medical Expenses Gen. Template"));
        }
        field(132; "Medical Expenses Debit Account"; Code[20])
        {
            Description = 'PHASE - 2';
            TableRelation = "G/L Account" WHERE("Account Type" = CONST(Posting),
                                                 Blocked = CONST(false));
        }
        field(133; "Medical Expense Credit Account"; Code[20])
        {
            Description = 'PHASE - 2';
            TableRelation = "G/L Account" WHERE("Account Type" = CONST(Posting),
                                                 Blocked = CONST(false));
        }
        field(134; "Medical Expenses Claim Comp."; Code[20])
        {
            Description = 'PHASE - 2';
            TableRelation = "Payroll Earning Code";
        }
        field(135; "Performance Appraisal Ser. No."; Code[20])
        {
            Description = 'PHASE - 2';
            TableRelation = "No. Series";
        }
        field(136; "Accrual Per day Formula"; Text[250])
        {

        }
    }

    keys
    {
        key(Key1; "Primart Key")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

