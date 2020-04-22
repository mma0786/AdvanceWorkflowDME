table 60086 "Work Location"
{
    Caption = 'Work Location';
    LookupPageID = "Work Location";

    fields
    {
        field(1; "Work Location Code"; Code[20])
        {
            Caption = 'Work Location Code';
        }
        field(2; "Work Location Name"; Text[50])
        {
            Caption = 'Work Location Name';
        }
    }

    keys
    {
        key(Key1; "Work Location Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Work Location Code", "Work Location Name")
        {
        }
    }

    trigger OnDelete()
    begin
        EmployeeRec_G.RESET;
        EmployeeRec_G.SETRANGE("Work Location", "Work Location Code");
        if EmployeeRec_G.FINDFIRST then
            ERROR('Work Location cannot be deleted while dependent employee exist. Cannot delete.');
    end;

    var
        EmployeeRec_G: Record Employee;
}

