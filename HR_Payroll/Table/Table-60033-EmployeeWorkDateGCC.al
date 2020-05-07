table 60033 EmployeeWorkDate_GCC
{

    fields
    {
        field(10; "Employee Code"; Code[20])
        {
        }
        field(15; "Trans Date"; Date)
        {
        }
        field(20; "Day Name"; Text[100])
        {
        }
        field(30; "Month Name"; Text[100])
        {
        }
        field(40; "Week No."; Integer)
        {
        }
        field(50; "Alternate Date"; Date)
        {
        }
        field(60; "Stop Payroll"; Boolean)
        {
        }
        field(70; "Calander id"; Code[20])
        {
            TableRelation = "Work Calendar Header";
        }
        field(80; "Calculation Type"; Option)
        {
            OptionCaption = 'Working Day,Weekly Off,Public Holiday';
            OptionMembers = "Working Day","Weekly Off","Public Holiday";
        }
        field(90; "Employee Earning Group"; Code[20])
        {
            TableRelation = "Earning Code Groups";
        }
        field(95; "First Half Leave Type"; Code[20])
        {
        }
        field(100; "Second Half Leave Type"; Code[20])
        {
        }
        field(110; "Payroll Statement id"; Code[20])
        {
        }
        field(120; "Temporary Payroll Hold"; Boolean)
        {
        }
        field(130; "Original Calander id"; Code[20])
        {
            TableRelation = "Work Calendar Header";
        }
        field(131; Remarks; Text[100])
        {
        }
    }

    keys
    {
        key(Key1; "Employee Code", "Trans Date")
        {
            Clustered = true;
        }
        key(Key2; "Employee Code", "First Half Leave Type", "Trans Date")
        {
        }
        key(Key3; "Employee Code", "Second Half Leave Type", "Trans Date")
        {
        }
        key(Key4; "Employee Code", "First Half Leave Type", "Calculation Type", "Trans Date")
        {
        }
        key(Key5; "Employee Code", "Second Half Leave Type", "Calculation Type", "Trans Date")
        {
        }
    }

    fieldgroups
    {
    }
}

