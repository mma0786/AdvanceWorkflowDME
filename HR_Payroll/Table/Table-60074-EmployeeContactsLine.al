table 60074 "Employee Contacts Line"
{

    fields
    {
        field(1; "Employee ID"; Code[20])
        {
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
        field(8; "Table Type Option"; Option)
        {
            OptionCaption = ' ,Employee Contacts Line,Employee Creatio Contacts Line,Dependent Contacts Line';
            OptionMembers = " ","Employee Contacts Line","Employee Creatio Contacts Line","Dependent Contacts Line";
        }
        field(10; "Document No"; Code[20])
        {
        }
        field(11; "Dependent ID"; Code[20])
        {
            Caption = 'Dependent ID';
        }
        field(12; "Emergency Contact"; Boolean)
        {

        }
    }

    keys
    {
        key(Key1; "Table Type Option", "Employee ID", "Document No", "Dependent ID", "Line No")
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
        Rec2.SETRANGE("Employee ID", "Employee ID");
        Rec2.SETRANGE(Type, Type);
        Rec2.SETRANGE(Primary, true);
        if Rec2.FINDFIRST then begin
            if CONFIRM('This is unmark the current primary contact, do you want to continue?', true) then begin
                Rec.Primary := true;
                Rec2.Primary := false;
                Rec2.MODIFY
            end else
                Primary := false;
        end;
    end;
}

