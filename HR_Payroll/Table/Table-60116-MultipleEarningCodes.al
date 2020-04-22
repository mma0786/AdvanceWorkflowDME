table 60116 "Multiple Earning Codes"
{
    // Commented By Avinash  
    DrillDownPageID = "Multiple Earning Codes";
    // Commented By Avinash  
    LookupPageID = "Multiple Earning Codes";

    fields
    {
        field(1; "Loan Code"; Code[50])
        {
        }
        field(2; "Earning Code"; Code[50])
        {
            TableRelation = "Payroll Earning Code"."Earning Code";
        }
        field(3; Percentage; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "Loan Code", "Earning Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

