table 60111 "Summary Payroll Cue"
{
    Caption = 'Employee Details';

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
        }
        field(2; "Requests to Approve"; Integer)
        {
            CalcFormula = Count ("Approval Entry" WHERE("Approver ID" = FIELD(User_ID_Srch),
                                                        Status = FILTER(Created)));
            FieldClass = FlowField;
        }
        field(3; "Driving Licence Request"; Integer)
        {
            // Commented By Avinash  CalcFormula = Count (Table51000 WHERE (Field37 = FIELD (User_ID_Srch)));
            FieldClass = FlowField;
        }
        field(4; "Car Registration Request"; Integer)
        {
            // Commented By Avinash   CalcFormula = Count (Table51002 WHERE (Field37 = FIELD (User_ID_Srch)));
            FieldClass = FlowField;
        }
        field(5; "Company directory"; Integer)
        {
            CalcFormula = Count (Employee WHERE("First Name" = FILTER(<> '')));
            FieldClass = FlowField;
        }
        field(6; "Visa Request"; Integer)
        {
            FieldClass = FlowField;
        }
        field(7; "IQAMA Request"; Integer)
        {
            FieldClass = FlowField;
        }
        field(50; User_ID_Srch; Code[20])
        {
        }
    }

    keys
    {
        key(Key1; "Primary Key")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

