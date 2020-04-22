tableextension 60018 FASetupExt extends "FA Setup"
{
    fields
    {
        // Add changes to table fields here
        field(60000; "Issue Document No."; Code[20])
        {
            Description = 'LT_HRMS-P1-008';
            TableRelation = "No. Series";
        }
        field(60001; "Posted Issue Document No"; Code[20])
        {
            Description = 'LT_HRMS-P1-008';
            TableRelation = "No. Series";
        }
        field(60002; "Posted Return Document No"; Code[20])
        {
            Description = 'LT_HRMS-P1-008';
            TableRelation = "No. Series";
        }
        field(60003; "Return Document No."; Code[20])
        {
            Description = 'LT_HRMS-P1-008';
            TableRelation = "No. Series";
        }
    }

    var
        myInt: Integer;
}
