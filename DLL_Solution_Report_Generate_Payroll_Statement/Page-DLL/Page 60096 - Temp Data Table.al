page 70008 "Temp Data Table List"
{
    PageType = List;
    SourceTable = "Temp Datatable Data";
    ApplicationArea = All;
    UsageCategory = Lists;
    ModifyAllowed = false;
    InsertAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Entry No."; "Entry No.")
                {
                    ApplicationArea = All;
                }
                field("Parameter ID"; "Parameter ID")
                {
                    ApplicationArea = All;
                }
                field("Parameter Value"; "Parameter Value")
                {
                    ApplicationArea = All;
                }
                field("Parameter Datatype"; "Parameter Datatype")
                {
                    ApplicationArea = All;
                }
                field("Benefit Code"; "Benefit Code")
                {
                    ApplicationArea = All;
                }
                field("Unit Formula"; "Unit Formula")
                {
                }
                field("Value Formula"; "Value Formula")
                {
                    ApplicationArea = All;
                }
                field("Encashment Formula"; "Encashment Formula")
                {
                    ApplicationArea = All;
                }
                field("Paycomponent Code"; "Paycomponent Code")
                {
                    ApplicationArea = All;
                }
                field("Formula For Attendance"; "Formula For Attendance")
                {
                    ApplicationArea = All;
                }
                field("Formula for Days"; "Formula for Days")
                {
                    ApplicationArea = All;
                }
                field("Paycomponent Type"; "Paycomponent Type")
                {
                    ApplicationArea = All;
                }
                field("PayComp Unit Formula"; "PayComp Unit Formula")
                {
                    ApplicationArea = All;
                }
                field("Result Formula Type"; "Result Formula Type")
                {
                    ApplicationArea = All;
                }
                field("Result Base Code"; "Result Base Code")
                {
                    ApplicationArea = All;
                }
                field("Result Fornula ID1"; "Result Fornula ID1")
                {
                    ApplicationArea = All;
                }
                field(Result1; Result1)
                {
                    ApplicationArea = All;
                }
                field("Result Fornula ID2"; "Result Fornula ID2")
                {
                    ApplicationArea = All;
                }
                field(Result2; Result2)
                {
                    ApplicationArea = All;
                }
                field("Result Fornula ID3"; "Result Fornula ID3")
                {
                    ApplicationArea = All;
                }
                field(Result3; Result3)
                {
                    ApplicationArea = All;
                }
                field("Error Log"; "Error Log")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}

