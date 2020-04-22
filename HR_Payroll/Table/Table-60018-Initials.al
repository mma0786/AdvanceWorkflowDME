table 60018 Initials
{
    Caption = 'Initials';
    // Commented By Avinash  
    LookupPageID = Initials;

    fields
    {
        field(1; "Initials Code"; Code[20])
        {
            Caption = 'Initials Code';
        }
        field(2; Initials; Text[30])
        {
        }
    }

    keys
    {
        key(Key1; "Initials Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        EmpRec.RESET;
        EmpRec.SETRANGE(Initials, "Initials Code");
        if EmpRec.FINDFIRST then
            ERROR(Error001);
    end;

    var
        EmpRec: Record Employee;
        Error001: Label 'Initials cannot be deleted.';
}

