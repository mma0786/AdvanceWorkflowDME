table 70004 "Emp. Earning Code  List Table"
{
    // version BC DLL


    fields
    {
        field(1; "Entry No."; Integer)
        {
            AutoIncrement = true;
        }
        field(2; EECList__Paycomponentcode; Text[250])
        {
        }
        field(3; EECList__UnitFormula; Blob)
        {
        }
        field(4; EECList__Formulaforattendance; Blob)
        {
        }
        field(5; EECList__Formulafordays; Blob)
        {
        }
        field(6; EECList__Paycomponenttype; Text[250])
        {
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
        }
    }

    // #==========START======================== EECList__UnitFormula Blob =================================
    procedure SETFormulaEECList__UnitFormula(EECList__UnitFormulaP: Text)
    var
        OutStream: OutStream;
    begin
        CLEAR(EECList__UnitFormula);
        if EECList__UnitFormulaP = '' then
            exit;
        EECList__UnitFormula.CreateOutStream(OutStream, TEXTENCODING::UTF8);
        OutStream.WriteText(EECList__UnitFormulaP);
        Modify;
    end;

    procedure GETFormulaEECList__UnitFormula(): Text
    var
        TypeHelper: Codeunit "Type Helper";
        InStream: InStream;
    begin
        CALCFIELDS(EECList__UnitFormula);
        if not EECList__UnitFormula.HASVALUE then
            exit('');

        CALCFIELDS(EECList__UnitFormula);
        EECList__UnitFormula.CreateInStream(InStream, TEXTENCODING::UTF8);
        exit(TypeHelper.ReadAsTextWithSeparator(InStream, TypeHelper.LFSeparator));
    end;
    // #==========STOP======================== EECList__UnitFormula Blob =================================
}

