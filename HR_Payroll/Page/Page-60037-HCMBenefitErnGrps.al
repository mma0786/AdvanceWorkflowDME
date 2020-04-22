page 60037 "HCM Benefit ErnGrp"
{
    CardPageID = "HCM Benefit ErnGrp";
    PageType = List;
    SourceTable = "HCM Benefit ErnGrp";
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
                field("Benefit Id"; "Benefit Id")
                {
                    ApplicationArea = All;
                }
                field("Fin Accrual Required"; "Fin Accrual Required")
                {
                    ApplicationArea = All;
                }
                field("Max Units"; "Max Units")
                {
                    ApplicationArea = All;
                }
                field("Benefit Accrual Frequency"; "Benefit Accrual Frequency")
                {
                    ApplicationArea = All;
                }
                field("Unit Calc Formula"; "Unit Calc Formula")
                {
                    ApplicationArea = All;
                }
                field("Amount Calc Formula"; "Amount Calc Formula")
                {
                    ApplicationArea = All;
                }
                field("Allow Encashment"; "Allow Encashment")
                {
                    ApplicationArea = All;
                }
                field("Encashment Formula"; "Encashment Formula")
                {
                    ApplicationArea = All;
                }
                field("Payroll Earning Code"; "Payroll Earning Code")
                {
                    ApplicationArea = All;
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                }
                field(Active; Active)
                {
                    ApplicationArea = All;
                }
                field("Adjust in Salary Grade Change"; "Adjust in Salary Grade Change")
                {
                    ApplicationArea = All;
                }
                field("Calculate in Final Period ofFF"; "Calculate in Final Period ofFF")
                {
                    ApplicationArea = All;
                }
                field("Benefit Type"; "Benefit Type")
                {
                    ApplicationArea = All;
                }
                field("Arabic Name"; "Arabic Name")
                {
                    ApplicationArea = All;
                }
                field("Short Name"; "Short Name")
                {
                    ApplicationArea = All;
                }
                field("Earning Code"; "Earning Code")
                {
                    ApplicationArea = All;
                }
                field("Benefit Entitlement Days"; "Benefit Entitlement Days")
                {
                    ApplicationArea = All;
                }
                field("Main Account Type"; "Main Account Type")
                {
                    ApplicationArea = All;
                }
                field("Main Account No."; "Main Account No.")
                {
                    ApplicationArea = All;
                }
                field("Offset Account Type"; "Offset Account Type")
                {
                    ApplicationArea = All;
                }
                field("Offset Account No."; "Offset Account No.")
                {
                    ApplicationArea = All;
                }
            }
        }
    }


}

