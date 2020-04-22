table 60075 "Payroll Department"
{
    DrillDownPageID = "Payroll Department";
    LookupPageID = "Payroll Department";

    fields
    {
        field(1; "Department ID"; Code[20])
        {
        }
        field(2; Description; Text[100])
        {
        }
        field(3; "Head Of Department"; Code[20])
        {
            TableRelation = Employee;

            trigger OnValidate()
            var
                emp: Record Employee;
            begin
                CLEAR("HOD Name");
                if EmpRec.GET("Head Of Department") then
                    "HOD Name" := EmpRec.FullName;

                if xRec."Head Of Department" <> Rec."Head Of Department" then begin
                    if CONFIRM(Text001, false) then begin
                        CLEAR(emp);
                        emp.SETRANGE(Department, Rec."Department ID");
                        if emp.FINDSET then
                            repeat
                                emp.HOD := "HOD Name";
                                emp.MODIFY;
                            until emp.NEXT = 0;
                    end;
                end;
            end;
        }
        field(4; "HOD Name"; Text[50])
        {
        }
        field(5; "Department In Arabic"; Text[150])
        {
        }
        field(81; "Shortcut Dimension 1 Code"; Code[20])
        {
            Caption = 'Deapartment Dimension';
            TableRelation = Dimension;
        }
        field(82; "Department Value"; Code[20])
        {
            TableRelation = "Dimension Value".Code WHERE(Blocked = CONST(false),
                                                          "Dimension Code" = FIELD("Shortcut Dimension 1 Code"));
        }
    }

    keys
    {
        key(Key1; "Department ID")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        EmpRec: Record Employee;
        Text001: Label 'Are you sure you want to change the HOD for all the employees that comes under this Department.';
}

