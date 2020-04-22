page 60043 "HCM Benefit Wrkrs"
{
    CardPageID = "HCM Benefit Wrkr";
    Editable = false;
    PageType = List;
    SourceTable = "HCM Benefit Wrkr";
    UsageCategory = Lists;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
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
                field("Benefit Option"; "Benefit Option")
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
            }
        }
    }



    trigger OnOpenPage()
    begin
        // SETFILTER("Valid From" , '<=%1', WORKDATE);
        // SETFILTER("Valid To" , '>%1|%2', WORKDATE, 0D);
    end;
}

