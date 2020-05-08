page 60040 "HCM Leave Types Wrkr"
{
    PageType = Card;
    SourceTable = "HCM Leave Types Wrkr";
    UsageCategory = Documents;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group("Leave Types")
            {
                field(Worker; Worker)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Leave Type Id"; "Leave Type Id")
                {
                    ApplicationArea = All;
                }
                field("Earning Code"; "Earning Code")
                {
                    ApplicationArea = All;
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                }
                field("Earning Code Group"; "Earning Code Group")
                {
                    ApplicationArea = All;
                }
            }
            group(General)
            {
                field("Short Name"; "Short Name")
                {
                    ApplicationArea = All;
                    Editable = "Short Name" = '';
                }
                field("Leave Type"; "Leave Type")
                {
                    ApplicationArea = All;
                }
                field("Max Times"; "Max Times")
                {
                    ApplicationArea = All;
                }
                field("Min Service Days"; "Min Service Days")
                {
                    ApplicationArea = All;
                }
                field("Min Days Before Req"; "Min Days Before Req")
                {
                    ApplicationArea = All;
                }
                field("Max Occurance"; "Max Occurance")
                {
                    ApplicationArea = All;
                }
                field("Allow Negative"; "Allow Negative")
                {
                    ApplicationArea = All;
                }
                field("Min Days per Leave Request"; "Min Days Avail")
                {
                    ApplicationArea = All;
                }
                field("Max Days per Leave Request"; "Max Days Avail")
                {
                    ApplicationArea = All;
                }
                field("Exc Public Holidays"; "Exc Public Holidays")
                {
                    ApplicationArea = All;
                }
                field("Exc Week Offs"; "Exc Week Offs")
                {
                    ApplicationArea = All;
                }
                field("Probation Entitlement Days"; "Probation Entitlement Days")
                {
                    ApplicationArea = All;
                }
                field("Allow Half Day"; "Allow Half Day")
                {
                    ApplicationArea = All;
                }
                field("Entitlement Days"; "Entitlement Days")
                {
                    ApplicationArea = All;
                }
                field("Request Advance"; "Request Advance")
                {
                    ApplicationArea = All;
                }
                field("Allow Early Late Resumption"; "Allow Early Late Resumption")
                {
                    ApplicationArea = All;
                }
                field("IsSystem Defined"; "IsSystem Defined")
                {
                    ApplicationArea = All;
                }
            }
            group(Setup)
            {
                field("Religion ID"; "Religion ID")
                {
                    ApplicationArea = All;
                }
                field(Nationality; Nationality)
                {
                    ApplicationArea = All;
                }
                field("Roll Over Years"; "Roll Over Years")
                {
                    ApplicationArea = All;
                }
                field("Pay Type"; "Pay Type")
                {
                    ApplicationArea = All;
                }
                field(Gender; Gender)
                {
                    ApplicationArea = All;
                }
                field("Marital Status"; "Marital Status")
                {
                    ApplicationArea = All;
                }
                field("Leave Avail Basis"; "Leave Avail Basis")
                {
                    ApplicationArea = All;
                }
            }
            group("Leave Accrual")
            {
                field("Accrual ID"; "Accrual ID")
                {
                    ApplicationArea = All;
                }
                field("Months Ahead Calculate"; "Months Ahead Calculate")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Consumption Split by Month"; "Consumption Split by Month")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Accrual Interval Basis Date"; "Accrual Interval Basis Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Interval Month Start"; "Interval Month Start")
                {
                    ApplicationArea = All;
                }
                field("Accrual Units Per Month"; "Accrual Units Per Month")
                {
                    ApplicationArea = All;
                }
                field("Opening Additional Accural"; "Opening Additional Accural")
                {
                    ApplicationArea = All;
                }
                field("Roll Over Period Monthly"; "Roll Over Period")
                {
                    ApplicationArea = All;
                }
                field("Max Carry Forward"; "Max Carry Forward")
                {
                    ApplicationArea = All;
                }
                field("CarryForward Lapse After Month"; "CarryForward Lapse After Month")
                {
                    ApplicationArea = All;
                }
                field("Repeat After Months"; "Repeat After Months")
                {
                    ApplicationArea = All;
                }
                field("Avail Allow Till"; "Avail Allow Till")
                {
                    ApplicationArea = All;
                }
            }
            group("Leave Benefit Setup")
            {
                field("Benefit Id"; "Benefit Id")
                {
                    ApplicationArea = All;
                }
                field("Leave Classification"; "Leave Classification")
                {
                    ApplicationArea = All;
                }
            }
            group("Other Setup")
            {

                // @Avinash 08.05.2020
                field("Is Attachment Mandatory"; "Attachment Mandate")
                {
                    ApplicationArea = All;
                    trigger
                   OnValidate()
                    begin
                        if "Attachment Mandate" then
                            ChnageBool := true
                        else
                            ChnageBool := false;
                    end;
                }
                field("Attachments After Days"; "Attachments After Days")
                {
                    ApplicationArea = All;
                    Editable = ChnageBool;
                }
                field("Is Compensatory Leave"; "Is Compensatory Leave")
                {
                    ApplicationArea = All;

                }
                // @Avinash 08.05.2020
                field("WorkFlow Required"; "WorkFlow Required")
                {
                    ApplicationArea = All;
                }
                field(Active; Active)
                {
                    ApplicationArea = All;
                }
                field(Accrued; Accrued)
                {
                    ApplicationArea = All;
                }

            }
        }
    }

    var
        ChnageBool: Boolean;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        //  Message('%1', Rec."Earning Code Group");
        "Earning Code Group" := Rec."Earning Code Group";
    end;

    trigger OnOpenPage()
    begin
        // SETFILTER("Valid From" , '<=%1', WORKDATE);
        // SETFILTER("Valid To" , '>%1|%2', WORKDATE, 0D);
    end;
}

