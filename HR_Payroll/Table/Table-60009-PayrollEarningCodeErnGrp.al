table 60009 "Payroll Earning Code ErnGrp"
{
    Caption = 'Payroll Earning Code';
    DrillDownPageID = "Payroll Earning Code ErnGrps";
    LookupPageID = "Payroll Earning Code ErnGrps";

    fields
    {
        field(5; "Earning Code Group"; Code[20])
        {
            TableRelation = "Earning Code Groups";
        }
        field(10; "Earning Code"; Code[20])
        {
            NotBlank = true;
            TableRelation = "Payroll Earning Code" WHERE(Active = CONST(true));

            trigger OnValidate()
            var
                PayrollEarningCode: Record "Payroll Earning Code";
            begin
                if "Earning Code" = '' then
                    PayrollEarningCode.RESET;
                PayrollEarningCode.GET("Earning Code");

                PayrollEarningCode.CALCFIELDS("Formula For Atttendance");
                Rec.TRANSFERFIELDS(PayrollEarningCode);
            end;
        }
        field(20; Description; Text[100])
        {
        }
        field(30; "Pay Component Type"; Option)
        {
            OptionCaption = ' ,Other,Basic,HRA,Cost of Living';
            OptionMembers = " ",Other,Basic,HRA,"Cost of Living";
        }
        field(40; "Fin Accrual Required"; Boolean)
        {
        }
        field(45; "FF Adjustment Required"; Boolean)
        {
        }
        field(50; "Earning Code Calc Subtype"; Option)
        {
            OptionCaption = ' ,Fixed,Variable';
            OptionMembers = " ","Fixed",Variable;
        }
        field(55; "Earning Code Calc Class"; Option)
        {
            OptionCaption = ' ,Payroll,NonPayroll';
            OptionMembers = " ",Payroll,NonPayroll;
        }
        field(60; "Rounding Method"; Option)
        {
            OptionCaption = 'Normal,Downward,RoundUp';
            OptionMembers = Normal,Downward,RoundUp;
        }
        field(65; "Decimal Rounding"; Boolean)
        {
        }
        field(70; "Minimum Value"; Decimal)
        {
        }
        field(75; "Maximum Value"; Decimal)
        {
        }
        field(80; IsSysComponent; Boolean)
        {
        }
        field(85; Active; Boolean)
        {
        }
        field(90; "Formula For Package"; Text[250])
        {
        }
        field(95; "Formula For Atttendance"; BLOB)
        {
        }
        field(105; RefTableId; Integer)
        {
        }
        field(110; "Formula For Days"; Text[30])
        {
        }
        field(120; WPSType; Option)
        {
            OptionCaption = 'FixedIncome,VairableIncome';
            OptionMembers = FixedIncome,VairableIncome;
        }
        field(130; "Arabic name"; Text[50])
        {
        }
        field(140; "Short Name"; Code[20])
        {
        }
        field(141; "Unit Of Measure"; Option)
        {
            OptionCaption = ' ,Hours,Pieces,Each';
            OptionMembers = " ",Hours,Pieces,Each;
        }
        field(142; "Earning Code Type"; Option)
        {
            OptionCaption = ' ,Pay Component,Benefit,Loan,Leave,Other';
            OptionMembers = " ","Pay Component",Benefit,Loan,Leave,Other;
        }
        field(143; Type; Option)
        {
            OptionCaption = 'Monthly,Annual';
            OptionMembers = Monthly,Annual;
        }
        field(144; "Package Amount"; Decimal)
        {
        }
        field(203; "Main Account Type"; Option)
        {
            OptionCaption = 'G/L Account,Customer,Vendor,Bank Account,Fixed Asset,IC Partner';
            OptionMembers = "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner";
        }
        field(204; "Main Account No."; Code[20])
        {
            TableRelation = IF ("Main Account Type" = CONST("G/L Account")) "G/L Account" WHERE("Account Type" = CONST(Posting),
                                                                                               Blocked = CONST(false))
            ELSE
            IF ("Main Account Type" = CONST(Customer)) Customer
            ELSE
            IF ("Main Account Type" = CONST(Vendor)) Vendor
            ELSE
            IF ("Main Account Type" = CONST("Bank Account")) "Bank Account"
            ELSE
            IF ("Main Account Type" = CONST("Fixed Asset")) "Fixed Asset"
            ELSE
            IF ("Main Account Type" = CONST("IC Partner")) "IC Partner";
        }
        field(205; "Offset Account Type"; Option)
        {
            OptionCaption = 'G/L Account,Customer,Vendor,Bank Account,Fixed Asset,IC Partner';
            OptionMembers = "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner";
        }
        field(206; "Offset Account No."; Code[20])
        {
            TableRelation = IF ("Offset Account Type" = CONST("G/L Account")) "G/L Account" WHERE("Account Type" = CONST(Posting),
                                                                                                 Blocked = CONST(false))
            ELSE
            IF ("Offset Account Type" = CONST(Customer)) Customer
            ELSE
            IF ("Offset Account Type" = CONST(Vendor)) Vendor
            ELSE
            IF ("Offset Account Type" = CONST("Bank Account")) "Bank Account"
            ELSE
            IF ("Offset Account Type" = CONST("Fixed Asset")) "Fixed Asset"
            ELSE
            IF ("Offset Account Type" = CONST("IC Partner")) "IC Partner";
        }
        field(207; "Cost of Living Rate"; Decimal)
        {
            DecimalPlaces = 2 : 3;
        }
        field(250; "Package Calc Type"; Option)
        {
            OptionCaption = 'Amount,Percentage';
            OptionMembers = Amount,Percentage;
        }
        field(251; "Package Percentage"; Decimal)
        {
        }
        field(252; "Calc Accrual"; Boolean)
        {
        }
        field(253; "Calc. Payroll Adj."; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; "Earning Code Group", "Earning Code")
        {
        }
        key(Key2; "Earning Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    procedure SetFormulaForAttendance(NewWorkDescription: Text)
    var
        OutStream: OutStream;
    begin

        CLEAR("Formula For Atttendance");
        if NewWorkDescription = '' then
            exit;
        "Formula For Atttendance".CreateOutStream(OutStream, TEXTENCODING::UTF8);
        OutStream.WriteText(NewWorkDescription);
        Modify;
    end;


    procedure GetFormulaForAttendance(): Text
    var
        TypeHelper: Codeunit "Type Helper";
        InStream: InStream;
    begin
        CALCFIELDS("Formula For Atttendance");
        if not "Formula For Atttendance".HASVALUE then
            exit('');

        CALCFIELDS("Formula For Atttendance");
        "Formula For Atttendance".CreateInStream(InStream, TEXTENCODING::UTF8);
        exit(TypeHelper.ReadAsTextWithSeparator(InStream, TypeHelper.LFSeparator));

    end;
}

