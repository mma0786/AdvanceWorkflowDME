table 60006 "Identification Doc Type Master"
{
    Caption = 'Identification Doc Type Master';
    LookupPageID = "Idetification DocType List";

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
        }
        field(2; Description; Text[50])
        {
            Caption = 'Description';

            trigger OnValidate()
            begin
                TESTFIELD(Code);
            end;
        }
        field(3; "Maintain Document Type"; Boolean)
        {
        }
        field(4; "Required For Visa Request"; Boolean)
        {
            Description = '#Visa&IqamaProcess';
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        IdentificationMaster.RESET;
        IdentificationMaster.SETRANGE("Identification Type", Code);
        if IdentificationMaster.FINDFIRST then
            ERROR('Identification Document Type cannot be deleted.');

        /*
        EmpCreationtMaster.RESET;
        EmpCreationtMaster.SETRANGE("Identification Type",Code);
        IF EmpCreationtMaster.FINDFIRST THEN
          ERROR('Identification Document Type cannot be deleted.');
          */

    end;

    var
        IdentificationMaster: Record "Identification Master";
}

