table 60138 "Short Leave Comments"
{
    Caption = 'Short leave Comment';
    LookupPageID = ShortLeaveComment1;

    fields
    {
        field(11; "Short Leave Request Id"; Code[20])
        {
            Caption = 'Short Leave Request Id';
        }
        field(12; "Line Manager Comment"; BLOB)
        {
            Caption = 'Line Manager Comment';
        }
        field(13; "HOD Comment"; BLOB)
        {
            Caption = 'HOD Comment';
        }
        field(14; "Personal Section Commentts"; BLOB)
        {
            Caption = 'Personal Section Commentts';
        }
    }

    keys
    {
        key(Key1; "Short Leave Request Id")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
    procedure SetMGR(NewWorkDescription: Text)
    var
        OutStream: OutStream;
    begin
        CLEAR("Line Manager Comment");
        if NewWorkDescription = '' then
            exit;
        "Line Manager Comment".CreateOutStream(OutStream, TEXTENCODING::UTF8);
        OutStream.WriteText(NewWorkDescription);
        Modify;

    end;

    procedure GetMGR(): Text
    var
        TypeHelper: Codeunit "Type Helper";
        InStream: InStream;
    begin
        CALCFIELDS("Line Manager Comment");
        if not "Line Manager Comment".HASVALUE then
            exit('');

        CALCFIELDS("Line Manager Comment");
        "Line Manager Comment".CreateInStream(InStream, TEXTENCODING::UTF8);
        exit(TypeHelper.ReadAsTextWithSeparator(InStream, TypeHelper.LFSeparator));
    end;

    //[Scope('Internal')]
    /*procedure SetMGR(Test: Text)
    var
        TempBlob: Record TempBlob temporary;
    begin
        CLEAR("Line Manager Comment");
        IF Test = '' THEN
            EXIT;
        TempBlob.Blob := "Line Manager Comment";
        TempBlob.WriteAsText(Test, TEXTENCODING::Windows);
        "Line Manager Comment" := TempBlob.Blob;
        MODIFY;
    end;

    //  [Scope('Internal')]
    procedure GetMGR(): Text
    var
        TempBlob: Record "TempBlob" temporary;
        CR: Text[1];
    begin
        CALCFIELDS("Line Manager Comment");
        IF NOT "Line Manager Comment".HASVALUE THEN
            EXIT('');
        CR[1] := 10;
        TempBlob.Blob := "Line Manager Comment";
        EXIT(TempBlob.ReadAsText(CR, TEXTENCODING::Windows));
    end;*/
    procedure SetHod(NewWorkDescription: Text)
    var
        OutStream: OutStream;
    begin
        CLEAR("HOD Comment");
        if NewWorkDescription = '' then
            exit;
        "HOD Comment".CreateOutStream(OutStream, TEXTENCODING::UTF8);
        OutStream.WriteText(NewWorkDescription);
        Modify;
    end;

    procedure GetHOD(): Text
    var
        TypeHelper: Codeunit "Type Helper";
        InStream: InStream;
    begin
        CALCFIELDS("HOD Comment");
        if not "HOD Comment".HASVALUE then
            exit('');
        CALCFIELDS("HOD Comment");
        "HOD Comment".CreateInStream(InStream, TEXTENCODING::UTF8);
        exit(TypeHelper.ReadAsTextWithSeparator(InStream, TypeHelper.LFSeparator));
    end;

    // [Scope('Internal')]
    /*procedure SetHOD(Test: Text)
    var
        TempBlob: Record "TempBlob" temporary;
    begin
        CLEAR("HOD Comment");
        IF Test = '' THEN
            EXIT;
        TempBlob.Blob := "HOD Comment";
        TempBlob.WriteAsText(Test, TEXTENCODING::Windows);
        "HOD Comment" := TempBlob.Blob;
        MODIFY;
    end;

    [Scope('Internal')]
    procedure GetHOD(): Text
    var
        TempBlob: Record "TempBlob" temporary;
        CR: Text[1];
    begin
        CALCFIELDS("HOD Comment");
        IF NOT "HOD Comment".HASVALUE THEN
            EXIT('');
        CR[1] := 10;
        TempBlob.Blob := "HOD Comment";
        EXIT(TempBlob.ReadAsText(CR, TEXTENCODING::Windows));
    end;
*/
    procedure SetSelf(NewWorkDescription: Text)
    var
        OutStream: OutStream;
    begin
        CLEAR("Personal Section Commentts");
        if NewWorkDescription = '' then
            exit;
        "Personal Section Commentts".CreateOutStream(OutStream, TEXTENCODING::UTF8);
        OutStream.WriteText(NewWorkDescription);
        Modify;

    end;

    procedure GetSelf(): Text
    var
        TypeHelper: Codeunit "Type Helper";
        InStream: InStream;
    begin
        CALCFIELDS("Personal Section Commentts");
        if not "Personal Section Commentts".HASVALUE then
            exit('');

        CALCFIELDS("Personal Section Commentts");
        "Personal Section Commentts".CreateInStream(InStream, TEXTENCODING::UTF8);
        exit(TypeHelper.ReadAsTextWithSeparator(InStream, TypeHelper.LFSeparator));
    end;

    // [Scope('Internal')]
    /*procedure SetSelf(Test: Text)
    var
        TempBlob: Record "TempBlob" temporary;
    begin
        CLEAR("Personal Section Commentts");
        IF Test = '' THEN
            EXIT;
        TempBlob.Blob := "Personal Section Commentts";
        TempBlob.WriteAsText(Test, TEXTENCODING::Windows);
        "Personal Section Commentts" := TempBlob.Blob;
        MODIFY;
    end;

    //  [Scope('Internal')]
    procedure GetSelf(): Text
    var
        TempBlob: Record "TempBlob" temporary;
        CR: Text[1];
    begin
        CALCFIELDS("Personal Section Commentts");
        IF NOT "Personal Section Commentts".HASVALUE THEN
            EXIT('');
        CR[1] := 10;
        TempBlob.Blob := "Personal Section Commentts";
        EXIT(TempBlob.ReadAsText(CR, TEXTENCODING::Windows));
    end;*/
}

