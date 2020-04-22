table 60096 "Temp Datatable Data"
{

    fields
    {
        field(1; "Entry No."; Integer)
        {
            AutoIncrement = true;
        }
        field(2; "Parameter ID"; Text[50])
        {
        }
        field(3; "Parameter Value"; Text[250])
        {
        }
        field(4; "Parameter Datatype"; Text[20])
        {
        }
        field(5; "Benefit Code"; Text[20])
        {
        }
        field(6; "Unit Formula"; Text[250])
        {
        }
        field(7; "Value Formula"; Text[250])
        {
        }
        field(8; "Encashment Formula"; Text[250])
        {
        }
        field(9; "Paycomponent Code"; Text[20])
        {
        }
        field(10; "Formula For Attendance"; Text[250])
        {
        }
        field(11; "Formula for Days"; Text[250])
        {
        }
        field(12; "Paycomponent Type"; Text[20])
        {
        }
        field(13; "PayComp Unit Formula"; Text[250])
        {
        }
        field(14; "Result Formula Type"; Text[250])
        {
        }
        field(15; "Result Base Code"; Text[100])
        {
        }
        field(16; "Result Fornula ID1"; Text[250])
        {
        }
        field(17; Result1; Text[100])
        {
        }
        field(18; "Result Fornula ID2"; Text[250])
        {
        }
        field(19; Result2; Text[100])
        {
        }
        field(20; "Result Fornula ID3"; Text[250])
        {
        }
        field(21; Result3; Text[100])
        {
        }
        field(22; "Error Log"; BLOB)
        {
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    // [Scope('Internal')]
    procedure SetFormulaForErrorLog(NewWorkDescription: Text)
    var
        OutStream: OutStream;
    begin

        CLEAR("Error Log");
        if NewWorkDescription = '' then
            exit;
        "Error Log".CreateOutStream(OutStream, TEXTENCODING::UTF8);
        OutStream.WriteText(NewWorkDescription);
        Modify;
    end;

    //   [Scope('Internal')]
    procedure GetFormulaForErrorLog(): Text
    var
        TypeHelper: Codeunit "Type Helper";
        InStream: InStream;
    begin
        CALCFIELDS("Error Log");
        if not "Error Log".HASVALUE then
            exit('');
        CALCFIELDS("Error Log");
        "Error Log".CreateInStream(InStream, TEXTENCODING::UTF8);
        exit(TypeHelper.ReadAsTextWithSeparator(InStream, TypeHelper.LFSeparator));

    end;
}

