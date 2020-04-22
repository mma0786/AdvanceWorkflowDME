table 60019 "Sub Department"
{
    // Commented By Avinash  
    //LookupPageID = "Sub Department";

    fields
    {
        field(1; "Department ID"; Code[20])
        {
            TableRelation = "Payroll Department";
        }
        field(2; "Sub Department ID"; Code[20])
        {
        }
        field(3; Description; Text[100])
        {
        }
    }

    keys
    {
        key(Key1; "Department ID", "Sub Department ID")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

