table 60119 "Dependent New Contacts Line"
{

    fields
    {
        field(1; "Dependent ID"; Code[20])
        {
            Caption = 'Dependent ID';
        }
        field(2; Description; Text[50])
        {
        }
        field(3; Type; Option)
        {
            OptionCaption = ' ,Phone,Email,Tele, Fax, Facebook,Twitter, Linkdln';
            OptionMembers = "''",Phone,Email,Tele," Fax"," Facebook",Twitter," Linkdln";
        }
        field(4; "Contact Number & Address"; Text[50])
        {
        }
        field(5; Extension; Text[30])
        {
        }
        field(6; Primary; Boolean)
        {

            trigger OnValidate()
            begin
                if Primary = true then
                    PriValidation;
            end;
        }
        field(7; "Line No"; Integer)
        {
        }
        field(20; No2; Code[20])
        {
        }
    }

    keys
    {
        key(Key1; No2, "Line No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    local procedure PriValidation()
    var
        Rec2: Record "Employee Contacts Line";
    begin

        Rec2.RESET;
        Rec2.SETRANGE("Dependent ID", "Dependent ID");
        Rec2.SETRANGE(Type, Type);
        Rec2.SETRANGE(Primary, true);
        if Rec2.FINDFIRST then begin
            if CONFIRM(' A Contact type has already marked as Primary. Do you want to change the primary, Click Yes to Continue?', true) then begin
                Rec.Primary := true;
                Rec2.Primary := false;
                Rec2.MODIFY
            end else
                Primary := false;
        end;
    end;
}

