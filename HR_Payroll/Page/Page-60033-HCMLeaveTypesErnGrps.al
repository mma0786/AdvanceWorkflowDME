page 60033 "HCM Leave Types ErnGrps"
{
    CardPageID = "HCM Leave Types ErnGrp";
    Editable = false;
    PageType = List;
    SourceTable = "HCM Leave Types ErnGrp";
    UsageCategory = Lists;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Earning Code Group"; "Earning Code Group")
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
                field("Short Name"; "Short Name")
                {
                    ApplicationArea = All;
                }
                field("Max Days"; "Max Days")
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
                field("Min Days Avail"; "Min Days Avail")
                {
                    ApplicationArea = All;
                }
                field("Max Days Avail"; "Max Days Avail")
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
                field("Allow Half Day"; "Allow Half Day")
                {
                    ApplicationArea = All;
                }
                field("Allow Excess Days"; "Allow Excess Days")
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
                field("Religion ID"; "Religion ID")
                {
                    ApplicationArea = All;
                }
                field(Nationality; Nationality)
                {
                    ApplicationArea = All;
                }
                field("Balance RoundOff Type"; "Balance RoundOff Type")
                {
                    ApplicationArea = All;
                }
                field("Leave Avail Basis"; "Leave Avail Basis")
                {
                    ApplicationArea = All;
                }
                field(Gender; Gender)
                {
                    ApplicationArea = All;
                }
                field("Pay Type"; "Pay Type")
                {
                    ApplicationArea = All;
                }
                field("Leave Type"; "Leave Type")
                {
                    ApplicationArea = All;
                }
                field(Accrued; Accrued)
                {
                    ApplicationArea = All;
                }
                field("Max Days Accrual"; "Max Days Accrual")
                {
                    ApplicationArea = All;
                }
                field(Active; Active)
                {
                    ApplicationArea = All;
                }
                field("Is System Defined"; "Is System Defined")
                {
                    ApplicationArea = All;
                }
                field("WorkFlow Required"; "WorkFlow Required")
                {
                    ApplicationArea = All;
                }

                field("Benefit Id"; "Benefit Id")
                {
                    ApplicationArea = All;
                }
                field("Leave Classification"; "Leave Classification")
                {
                    ApplicationArea = All;
                }
                field("Allow Negative"; "Allow Negative")
                {
                    ApplicationArea = All;
                }
                field("Allow Early Late Resumption"; "Allow Early Late Resumption")
                {
                    ApplicationArea = All;
                }
                field("Roll Over Years"; "Roll Over Years")
                {
                    ApplicationArea = All;
                }
                field("Probation Entitlement Days"; "Probation Entitlement Days")
                {
                    ApplicationArea = All;
                }
                field("Attachment Mandatory Days"; "Attachment Mandatory Days")
                {
                    ApplicationArea = All;
                }
                // @Avinash 08.05.2020
                field("Attachment Mandate"; "Attachment Mandate")
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
            }
        }
    }
    var
        ChnageBool: Boolean;


}

