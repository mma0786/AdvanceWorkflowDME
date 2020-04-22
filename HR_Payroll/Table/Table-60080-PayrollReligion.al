table 60080 "Payroll Religion"
{
    DrillDownPageID = "Payroll Religions";
    LookupPageID = "Payroll Religions";

    fields
    {
        field(1; "Religion ID"; Code[20])
        {
        }
        field(2; Description; Text[100])
        {
        }
    }

    keys
    {
        key(Key1; "Religion ID")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        EmployeeRec_G.RESET;
        EmployeeRec_G.SETRANGE("Employee Religion", "Religion ID");
        //ERROR('%1',"Religion ID");
        if EmployeeRec_G.FINDFIRST then
            ERROR('Religion cannot be deleted while dependent employee exist. Cannot delete.');

        LeaveTypesRec.RESET;
        LeaveTypesRec.SETRANGE("Religion ID", "Religion ID");
        if LeaveTypesRec.FINDFIRST then
            ERROR('Religion cannot be deleted');
        //ERROR('%1',"Religion ID");
    end;

    var
        EmployeeRec_G: Record Employee;
        LeaveTypesRec: Record "HCM Leave Types";
}

