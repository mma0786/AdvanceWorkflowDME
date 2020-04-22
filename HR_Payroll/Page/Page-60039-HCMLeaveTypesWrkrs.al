page 60039 "HCM Leave Types Wrkrs List"
{
    CardPageID = "HCM Leave Types Wrkr";
    Editable = false;
    PageType = List;
    SourceTable = "HCM Leave Types Wrkr";
    UsageCategory = Lists;
    //ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
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
                field("Short Name"; "Short Name")
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
                field("Min Days Avail"; "Min Days Avail")
                {
                    ApplicationArea = all;
                }
                field("Max Days Avail"; "Max Days Avail")
                {
                    ApplicationArea = all;
                }
                field("Carry Over Days"; "Carry Over Days")
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
                field("Allow Half Day"; "Allow Half Day")
                {
                    ApplicationArea = all;
                }
                field("Allow Excess Days"; "Allow Excess Days")
                {
                    ApplicationArea = all;
                }
                field("Excess Days Action"; "Excess Days Action")
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
                field("Religion ID"; "Religion ID")
                {
                    ApplicationArea = all;
                }
                field(Nationality; Nationality)
                {
                    ApplicationArea = all;
                }
                field("Balance RoundOff Type"; "Balance RoundOff Type")
                {
                    ApplicationArea = all;
                }
                field("Leave Avail Basis"; "Leave Avail Basis")
                {
                    ApplicationArea = all;
                }
                field(Gender; Gender)
                {
                    ApplicationArea = all;
                }
                field("Pay Type"; "Pay Type")
                {
                    ApplicationArea = all;
                }
                field("Leave Type"; "Leave Type")
                {
                    ApplicationArea = all;
                }
                field(Accrued; Accrued)
                {
                    ApplicationArea = all;
                }
                field("Max Days Accrual"; "Max Days Accrual")
                {
                    ApplicationArea = all;
                }
                field("Leave Accrual"; "Leave Accrual")
                {
                    ApplicationArea = all;
                }
                field(Active; Active)
                {
                    ApplicationArea = all;
                }
                field("IsSystem Defined"; "IsSystem Defined")
                {
                    ApplicationArea = all;
                }
                field("WorkFlow Required"; "WorkFlow Required")
                {
                    ApplicationArea = all;
                }
                field("Attachment Mandate"; "Attachment Mandate")
                {
                    ApplicationArea = all;
                }
                field("Benefit Id"; "Benefit Id")
                {
                    ApplicationArea = all;
                }
                field("LTA Claim"; "LTA Claim")
                {
                    ApplicationArea = all;
                }
                field("Leave Classification"; "Leave Classification")
                {
                    ApplicationArea = all;
                }
                field("Allow Negative"; "Allow Negative")
                {
                    ApplicationArea = ALL;

                }
                field("Benefit LTA"; "Benefit LTA")
                {
                    ApplicationArea = ALL;
                }
                field("HCM Leave Id GCC"; "HCM Leave Id GCC")
                {
                    ApplicationArea = ALL;
                }
                field("Allow Early Late Resumption"; "Allow Early Late Resumption")
                {
                    ApplicationArea = ALL;
                }
                field("Roll Over Years"; "Roll Over Years")
                {
                    ApplicationArea = ALL;
                }
                field("Benefit Id Leave Carry Over"; "Benefit Id Leave Carry Over")
                {
                    ApplicationArea = ALL;
                }
                field("Probation Entitlement Days"; "Probation Entitlement Days")
                {
                    ApplicationArea = ALL;
                }
                field("Attachment Mandatory Days"; "Attachment Mandatory Days")
                {
                    ApplicationArea = ALL;
                }
            }
        }
    }



    trigger OnOpenPage()
    begin
        // // // //     SETFILTER("Valid From", '<=%1', WORKDATE);
        // // // //     SETFILTER("Valid To", '>%1|%2', WORKDATE, 0D);
    end;
}

