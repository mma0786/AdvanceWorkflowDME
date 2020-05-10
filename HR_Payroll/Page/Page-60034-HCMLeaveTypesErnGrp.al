page 60034 "HCM Leave Types ErnGrp"
{
    PageType = Card;
    SourceTable = "HCM Leave Types ErnGrp";
    UsageCategory = Documents;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group("Leave Types")
            {
                field("Earning Code Group"; "Earning Code Group")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Leave Type Id"; "Leave Type Id")
                {
                    ApplicationArea = all;
                }
                field("Earning Code"; "Earning Code")
                {
                    ApplicationArea = all;
                }
                field(Description; Description)
                {
                    ApplicationArea = all;
                }
            }
            group(General)
            {
                field("Short Name"; "Short Name")
                {
                    Editable = "Short Name" = '';
                    ApplicationArea = all;
                }
                field("Leave Type"; "Leave Type")
                {
                    ApplicationArea = all;
                }
                field("Max Times"; "Max Times")
                {
                    ApplicationArea = all;
                }
                field("Min Service Days"; "Min Service Days")
                {
                    ApplicationArea = all;
                }
                field("Min Days Before Req"; "Min Days Before Req")
                {
                    ApplicationArea = all;
                }
                field("Max Occurance"; "Max Occurance")
                {
                    ApplicationArea = all;
                }
                field("Min Days per Leave Request"; "Min Days Avail")
                {
                    ApplicationArea = all;
                }
                field("Max Days per Leave Request"; "Max Days Avail")
                {
                    ApplicationArea = all;
                }
                field("Allow Encashment"; "Allow Encashment")
                {
                    ApplicationArea = all;
                }
                field("Allow Negative"; "Allow Negative")
                {
                    ApplicationArea = all;
                }
                field("Exc Public Holidays"; "Exc Public Holidays")
                {
                    ApplicationArea = all;
                }
                field("Exc Week Offs"; "Exc Week Offs")
                {
                    ApplicationArea = all;
                }
                field("Probation Entitlement Days"; "Probation Entitlement Days")
                {
                    ApplicationArea = all;
                }
                field("Allow Half Day"; "Allow Half Day")
                {
                    ApplicationArea = all;
                }
                field("Entitlement Days"; "Entitlement Days")
                {
                    ApplicationArea = all;
                }
                field("Request Advance"; "Request Advance")
                {
                    ApplicationArea = all;
                }
                field("Allow Early Late Resumption"; "Allow Early Late Resumption")
                {
                    ApplicationArea = all;
                }
            }
            group(Setup)
            {
                field("Religion ID"; "Religion ID")
                {
                    ApplicationArea = all;
                }
                field(Nationality; Nationality)
                {
                    ApplicationArea = all;
                }
                field("Roll Over Years"; "Roll Over Years")
                {
                    ApplicationArea = all;
                }
                field("Pay Type"; "Pay Type")
                {
                    ApplicationArea = all;

                }
                field(Gender; Gender)
                {
                    ApplicationArea = all;
                }
                field("Marital Status"; "Marital Status")
                {
                    ApplicationArea = all;
                }
                field("Leave Avail Basis"; "Leave Avail Basis")
                {
                    ApplicationArea = all;
                }
            }
            group("Leave Accrual")
            {

                field("Accrual ID"; "Accrual ID")
                {
                    ApplicationArea = all;
                }
                field("Months Ahead Calculate"; "Months Ahead Calculate")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Consumption Split by Month"; "Consumption Split by Month")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Accrual Interval Basis Date"; "Accrual Interval Basis Date")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Interval Month Start"; "Interval Month Start")
                {
                    ApplicationArea = all;
                }
                field("Accrual Units Per Month"; "Accrual Units Per Month")
                {
                    ApplicationArea = all;
                }
                field("Opening Additional Accural"; "Opening Additional Accural")
                {
                    ApplicationArea = all;
                }
                field("Roll Over Period Monthly"; "Roll Over Period")
                {
                    ApplicationArea = all;
                }
                field("Max Carry Forward"; "Max Carry Forward")
                {
                    ApplicationArea = all;
                }
                field("CarryForward Lapse After Month"; "CarryForward Lapse After Month")
                {
                    ApplicationArea = all;
                }
                field("Repeat After Months"; "Repeat After Months")
                {
                    ApplicationArea = all;

                }
                field("Avail Allow Till"; "Avail Allow Till")
                {

                    ApplicationArea = all;
                }
            }
            group("Leave Benefit Setup")
            {
                field("Benefit Id"; "Benefit Id")
                {
                    ApplicationArea = all;
                }
                field("Leave Carry Over Benefit"; "Leave Carry Over Benefit")
                {
                    ApplicationArea = all;
                }
                field("Leave Classification"; "Leave Classification")
                {
                    ApplicationArea = all;
                }
            }
            group("Other Setup")
            {
                field("Is System Defined"; "Is System Defined")
                {
                    ApplicationArea = all;
                }
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
                    ApplicationArea = all;
                }
                field(Active; Active)
                {
                    ApplicationArea = all;
                }
                field(Accrued; Accrued)
                {
                    ApplicationArea = all;
                }

                field("Is Paternity Leave"; "Is Paternity Leave")
                {
                    ApplicationArea = All;

                    trigger
                              OnValidate()
                    begin
                        if "Is Compensatory Leave" then
                            ChildAgeLimitinMonthsBool := true
                        else
                            ChildAgeLimitinMonthsBool := false;

                    end;
                }
                field("Child Age Limit in Months"; "Child Age Limit in Months")
                {
                    ApplicationArea = All;
                    Editable = ChildAgeLimitinMonthsBool;
                }
                // @Avinash 10.05.2020
            }
        }
    }
    var
        ChnageBool: Boolean;
        ChildAgeLimitinMonthsBool: Boolean;
}

