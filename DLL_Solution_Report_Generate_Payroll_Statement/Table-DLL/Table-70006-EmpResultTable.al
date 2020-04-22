table 70006 "Emp. Result Table"
{
    // version BC DLL


    fields
    {
        field(1; "Entry No."; Integer)
        {
            AutoIncrement = true;
            DataClassification = ToBeClassified;
        }
        field(2; FormulaType; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(3; BaseCode; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(4; FormulaID1; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(5; Result1; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(6; FormulaID2; Text[250])
        {
        }
        field(7; Result2; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(8; FormulaID3; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(9; Result3; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Error Log"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
        }
    }

    fieldgroups
    {
    }
}

