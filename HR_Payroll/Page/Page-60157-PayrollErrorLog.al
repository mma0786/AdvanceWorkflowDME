page 60157 "Payroll Error Log"
{
    Editable = false;
    PageType = List;
    SourceTable = "Payroll Error Log";
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Payroll Statement ID"; "Payroll Statement ID")
                {
                    ApplicationArea = All;
                }
                field("HCM Worker"; "HCM Worker")
                {
                    ApplicationArea = All;
                }
                field(Error; Error)
                {
                    ApplicationArea = All;
                }
            }
        }
    }


}

