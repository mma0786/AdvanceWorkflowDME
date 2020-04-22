table 60057 "Payroll Job Certificate"
{
    DrillDownPageID = "Payroll Job Certificates";
    LookupPageID = "Payroll Job Certificates";

    fields
    {
        field(1; "Certificate Type"; Code[20])
        {
        }
        field(2; Description; Text[100])
        {
        }
    }

    keys
    {
        key(Key1; "Certificate Type")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

