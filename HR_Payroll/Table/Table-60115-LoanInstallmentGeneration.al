table 60115 "Loan Installment Generation"
{

    fields
    {
        field(1; "Entry No."; Integer)
        {
            AutoIncrement = true;
        }
        field(2; "Loan Request ID"; Code[50])
        {
        }
        field(3; Loan; Code[50])
        {
        }
        field(4; "Loan Description"; Text[50])
        {
        }
        field(5; "Employee ID"; Code[50])
        {
        }
        field(6; "Employee Name"; Text[250])
        {
        }
        field(7; "Installament Date"; Date)
        {
        }
        field(8; "Principal Installment Amount"; Decimal)
        {
        }
        field(9; "Interest Installment Amount"; Decimal)
        {
        }
        field(10; Currency; Code[50])
        {
            TableRelation = Currency.Code;
        }
        field(11; Status; Option)
        {
            OptionCaption = ',Unrecovered,Recovered,Adjusted';
            OptionMembers = ,Unrecovered,Recovered,Adjusted;
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
}

