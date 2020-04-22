table 60001 "Payroll Earning Code"
{
    Caption = 'Payroll Earning Code';
    DrillDownPageID = "Payroll Earning Codes";
    LookupPageID = "Payroll Earning Codes";

    fields
    {
        field(10; "Earning Code"; Code[20])
        {
            NotBlank = true;
        }
        field(20; Description; Text[100])
        {
        }
        field(30; "Pay Component Type"; Option)
        {
            OptionCaption = ' ,Other,Basic,HRA,Cost of Living';
            OptionMembers = " ",Other,Basic,HRA,"Cost of Living";

            trigger OnValidate()
            begin
                if not ("Pay Component Type" = "Pay Component Type"::"Cost of Living") then
                    "Cost of Living Rate" := 0;
            end;
        }
        field(40; "Fin Accrual Required"; Boolean)
        {
        }
        field(45; "FF Adjustment Required"; Boolean)
        {
        }
        field(50; "Earning Code Calc Subtype"; Option)
        {
            Caption = 'Earning Code Calculation Subtype';
            OptionCaption = ' ,Fixed,Variable';
            OptionMembers = " ","Fixed",Variable;
        }
        field(55; "Earning Code Calc Class"; Option)
        {
            Caption = 'Earning Code Calculation Class';
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

            trigger OnValidate()
            begin
                if ("Minimum Value" >= "Maximum Value") and ("Maximum Value" <> 0) then
                    ERROR('Min Value should be less than Max Value');
            end;
        }
        field(75; "Maximum Value"; Decimal)
        {

            trigger OnValidate()
            begin
                if ("Minimum Value" >= "Maximum Value") and ("Minimum Value" <> 0) then
                    ERROR('Max Value should be greater than Min Value');
            end;
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
        field(100; RefRecId; Integer)
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
            Caption = 'WPS Type';
            OptionCaption = 'Fixed Income,Vairable Income';
            OptionMembers = "Fixed Income","Vairable Income";
        }
        field(130; "Arabic name"; Text[50])
        {
        }
        field(140; "Short Name"; Code[20])
        {

            trigger OnValidate()
            begin
                if (xRec."Short Name" <> '') and (xRec."Short Name" <> "Short Name") then begin
                    DeleteEarningCodeFormulas(xRec."Short Name", 1);
                end;
                if "Short Name" <> '' then
                    InsertEarningCodeFormulas("Short Name");
            end;
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
            Caption = 'Package Calc Basis';
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
        key(Key1; "Earning Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        PayrollEarningCodeEarningGroup.RESET;
        PayrollEarningCodeEarningGroup.SETRANGE("Earning Code", "Earning Code");
        if PayrollEarningCodeEarningGroup.FINDFIRST then
            ERROR('You Cannot delete this Earning code. Earning code groups are created for this Earning code.');
    end;

    var
        PayrollFormula: Record "Payroll Formula";
        PayrollEarningCodeEarningGroup: Record "Payroll Earning Code ErnGrp";


    procedure InsertEarningCodeFormulas(ShortName: Code[20])
    begin
        FixedFormula(ShortName, 'formula for package.', 1, ShortName);
        FixedFormula('C_' + ShortName, 'formula for attendance', 1, ShortName);
        FixedFormula('C_' + ShortName + '_Days', 'formula for days', 1, ShortName);
    end;


    procedure FixedFormula(FormulaKey: Code[100]; FormulaDescription: Text[250]; FormulaKeyType: Option Parameter,"Pay Component",Benefit,"Leave Type",Custom; ShortName: Code[20])
    begin
        if FormulaKey <> '' then begin
            if not PayrollFormula.GET(FormulaKey) then begin
                PayrollFormula.INIT;
                PayrollFormula."Formula Key" := FormulaKey;
                PayrollFormula."Formula description" := FormulaDescription;
                PayrollFormula."Formula Key Type" := FormulaKeyType;
                PayrollFormula."Short Name" := ShortName;
                PayrollFormula.INSERT;
            end;
        end;
    end;


    procedure DeleteEarningCodeFormulas(ShortName: Code[20]; FormulaKeyType: Option Parameter,"Pay Component",Benefit,"Leave Type",Custom)
    begin
        PayrollFormula.RESET;
        PayrollFormula.SETCURRENTKEY("Short Name");
        PayrollFormula.SETRANGE("Short Name", ShortName);
        PayrollFormula.SETRANGE("Formula Key Type", FormulaKeyType);
        PayrollFormula.DELETEALL;
    end;

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

