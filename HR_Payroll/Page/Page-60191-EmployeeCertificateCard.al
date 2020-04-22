page 60191 "Employee Certificate Card"
{
    InsertAllowed = false;
    PageType = Card;
    SourceTable = "Payroll Job Certificate Line";
    UsageCategory = Administration;
    // ApplicationArea = All;
    layout
    {
        area(content)
        {
            group(General)
            {
                field("Emp ID"; "Emp ID")
                {
                    ApplicationArea = All;
                }
                field("Emp Full Name"; "Emp Full Name")
                {
                    ApplicationArea = All;
                }
                field("Certficate Type"; "Certficate Type")
                {
                    ApplicationArea = All;
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                }
                field(Importance; Importance)
                {
                    ApplicationArea = All;
                }
            }
        }
    }



    local procedure GetNewLineNumber(EmplNo: Code[20]): Integer
    var
        PayrollJobCertificateLineRec_L: Record "Payroll Job Certificate Line";
    begin
        PayrollJobCertificateLineRec_L.RESET;
        PayrollJobCertificateLineRec_L.SETRANGE("Emp ID", EmplNo);
        if not PayrollJobCertificateLineRec_L.FINDLAST then
            exit(10000)
        else begin
            exit(PayrollJobCertificateLineRec_L."Line  No." + 10000);
        end;
    end;
}

