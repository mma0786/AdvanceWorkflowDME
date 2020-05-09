table 60103 "Approval Level Setup"
{

    fields
    {
        field(1; "Advance Payrolll Type"; Option)
        {
            OptionCaption = ',Loan,Leaves,Benifit,Asset Issue,Employee Contracts,Asset Return,Duty Resumption,Pre Approval Overtime Request,Overtime Benefit Claim,Cancel Leave Requests';
            OptionMembers = ,Loan,Leaves,Benifit,"Asset Issue","Employee Contracts","Asset Return","Duty Resumption","Pre Approval Overtime Request","Overtime Benefit Claim","Cancel Leave Requests";
        }
        field(2; Level; Integer)
        {
        }
        field(3; "Finance User ID"; Code[50])
        {
            TableRelation = "User Setup";
        }
        field(4; "Direct Approve By Finance"; Boolean)
        {
        }
        field(5; "Finance User ID 2"; Code[50])
        {
            TableRelation = "User Setup";
        }
    }

    keys
    {
        key(Key1; "Advance Payrolll Type")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

