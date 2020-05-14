page 70029 "Approval Entrty Transcation"
{
    SourceTable = "Approval Entrty Transcation";
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Trans ID"; "Trans ID")
                {
                    ApplicationArea = All;
                }
                field("Advance Payrolll Type"; "Advance Payrolll Type")
                {
                    ApplicationArea = All;

                }
                field("Employee ID - Sender"; "Employee ID - Sender")
                {
                    ApplicationArea = All;

                }
                field("Reporting ID - Approver"; "Reporting ID - Approver")
                {
                    ApplicationArea = All;

                }
                field("Delegate ID"; "Delegate ID")
                {
                    ApplicationArea = All;

                }
                field("Sequence No."; "Sequence No.")
                {
                    ApplicationArea = All;

                }
                field(DocRedID; DocRedID)
                {
                    ApplicationArea = All;


                }
            }
        }
    }

    trigger
    OnAfterGetRecord()
    begin
        DocRedID := Format("Document RecordsID", 0, 1);
    end;

    var
        DocRedID: Text;
}