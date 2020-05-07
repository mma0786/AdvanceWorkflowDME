page 60061 "Employee Work Dates" //commented By Avinash 
{
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = EmployeeWorkDate_GCC;
    UsageCategory = Administration;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Employee Code"; "Employee Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Trans Date"; "Trans Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Day Name"; "Day Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Month Name"; "Month Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Week No."; "Week No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Alternate Date"; "Alternate Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Stop Payroll"; "Stop Payroll")
                {
                    ApplicationArea = All;
                }
                field("Calander id"; "Calander id")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Calculation Type"; "Calculation Type")
                {
                    ApplicationArea = All;
                }
                field("Employee Earning Group"; "Employee Earning Group")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("First Half Leave Type"; "First Half Leave Type")
                {
                    ApplicationArea = All;
                }
                field("Second Half Leave Type"; "Second Half Leave Type")
                {
                    ApplicationArea = All;
                }
                field("Payroll Statement id"; "Payroll Statement id")
                {
                    ApplicationArea = All;
                }
                field("Temporary Payroll Hold"; "Temporary Payroll Hold")
                {
                    ApplicationArea = All;
                }
                field("Original Calander id"; "Original Calander id")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Remarks; Remarks)
                {
                    ApplicationArea = All;
                    Editable = false;
                }

            }
        }
    }

}

