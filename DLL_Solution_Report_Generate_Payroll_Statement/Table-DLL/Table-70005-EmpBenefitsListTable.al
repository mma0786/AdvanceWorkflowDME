table 70005 "Emp. Benefits List Table"
{
    // version BC DLL


    fields
    {
        field(1; "Entry No."; Integer)
        {
            AutoIncrement = true;
        }
        field(2; EBList__Benefitcode; Text[250])
        {
        }
        field(3; EBList__UnitFormula; Blob)
        {
        }
        field(4; EBList__ValueFormula; Text[250])
        {
        }
        field(5; EBList__EncashmentFormula; Blob)
        {
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

