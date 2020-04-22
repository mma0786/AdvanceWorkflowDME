table 60105 "Payroll RTC Cue"
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
            // Commented By Avinash   CalcFormula = Count (Table51000 WHERE (Field37 = FIELD (User_ID_Srch)));
            FieldClass = FlowField;
        }
        field(4; "Car Registration Request"; Integer)
        {
            // Commented By Avinash  CalcFormula = Count (Table51002 WHERE (Field37 = FIELD (User_ID_Srch)));
            FieldClass = FlowField;
        }
        field(5; "Company directory"; Integer)
        {
            CalcFormula = Count (Employee WHERE("First Name" = FILTER(<> '')));
            FieldClass = FlowField;
        }
        field(6; "Visa Request"; Integer)
        {
            // Commented By Avinash  CalcFormula = Count (Table51016 WHERE(Field14 = FIELD(User_ID_Srch)));
            FieldClass = FlowField;
        }
        field(7; "IQAMA Request"; Integer)
        {
            // Commented By Avinash  CalcFormula = Count (Table51019 WHERE(Field13 = FIELD(User_ID_Srch)));
            FieldClass = FlowField;
        }
        field(8; "OT Requset"; Integer)
        {
            // Commented By Avinash  CalcFormula = Count (Table50008 WHERE(Field16 = FIELD(User_ID_Srch)));
            FieldClass = FlowField;
        }
        field(9; "Benefit Climb"; Integer)
        {
            // Commented By Avinash   CalcFormula = Count (Table50010 WHERE(Field22 = FIELD(User_ID_Srch)));
            FieldClass = FlowField;
        }
        field(10; "Education Claim"; Integer)
        {
            // Commented By Avinash   CalcFormula = Count (Table50027 WHERE(Field26 = FIELD(User_ID_Srch)));
            FieldClass = FlowField;
        }
        field(11; "Leave Request"; Integer)
        {
            // CalcFormula = Count ("Leave Request Header" WHERE(User_ID = FIELD(User_ID_Srch)));
            //FieldClass = FlowField;
        }
        field(12; "Dependent Request"; Integer)
        {
            CalcFormula = Count ("Employee Dependents New" WHERE(User_ID = FIELD(User_ID_Srch)));
            FieldClass = FlowField;
        }
        field(50; User_ID_Srch; Code[20])
        {
        }
        field(51; "Airport Access Authoriz Req."; Integer)
        {
            // Commented By Avinash CalcFormula = Count (Table51022 WHERE(Field6 = FIELD(User_ID_Srch)));
            FieldClass = FlowField;
        }
        field(52; "Short Leave Request"; Integer)
        {
            // Commented By Avinash  CalcFormula = Count (Table50043 WHERE(Field26 = FIELD(User_ID_Srch)));
            FieldClass = FlowField;
        }
        field(53; "Per Diem Claim"; Integer)
        {
            // Commented By Avinash  CalcFormula = Count ("Loan Request" WHERE(Field25 = FIELD(User_ID_Srch)));
            FieldClass = FlowField;
        }
        field(54; "Expense Request"; Integer)
        {
            // Commented By Avinash CalcFormula = Count ("Loan Installment Generation" WHERE(Field23 = FIELD(User_ID_Srch)));
            FieldClass = FlowField;
        }
        field(55; "Medical Expense Claim"; Integer)
        {
            // Commented By Avinash  CalcFormula = Count (Table60130 WHERE(Field18 = FIELD(User_ID_Srch)));
            FieldClass = FlowField;
        }
        field(56; "Ticketing Request"; Integer)
        {
            CalcFormula = Count ("Loan Adjustment Header" WHERE("Employee Name" = FIELD(User_ID_Srch)));
            FieldClass = FlowField;
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

