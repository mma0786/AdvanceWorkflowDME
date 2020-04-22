table 60026 "Educational Allowance LT"
{

    fields
    {
        field(1; "Grade Category"; Code[50])
        {
            TableRelation = "Payroll Grade Category";
        }
        field(2; "Earnings Code Group"; Code[20])
        {
            TableRelation = "Earning Code Groups";
        }
        field(21; Description; Text[50])
        {
        }
        field(22; "Edu. Allow. Eligible Amount"; Decimal)
        {
        }
        field(23; "Edu. Allow. Min Age"; Integer)
        {
        }
        field(24; "Edu. Allow. Max Age"; Integer)
        {
        }
        field(25; "Count of children eligible"; Integer)
        {
        }
        field(26; "Education Type - Full time"; Boolean)
        {
        }
        field(27; "Book Allow. Elemantary School"; Decimal)
        {
        }
        field(28; "Book Allow. Secondary Level"; Decimal)
        {
        }
        field(29; "Book Allow. University Level"; Decimal)
        {
        }
        field(30; "Special Applicable"; Boolean)
        {
        }
        field(31; "Special Eligible Amount"; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "Grade Category", "Earnings Code Group")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        ERROR('You cannot delete any records for Education Allowance');
    end;
}

