table 70000 "ParamList Data Table"
{
    // version BC DLL


    fields
    {
        field(1;"Entry No.";Integer)
        {
            AutoIncrement = true;
        }
        field(2;ParamList__KeyId;Text[250])
        {
        }
        field(3;ParamList__KeyValue;Text[250])
        {
        }
        field(4;ParamList__DataType;Text[250])
        {
        }
    }

    keys
    {
        key(Key1;"Entry No.")
        {
        }
    }

    fieldgroups
    {
    }
}

