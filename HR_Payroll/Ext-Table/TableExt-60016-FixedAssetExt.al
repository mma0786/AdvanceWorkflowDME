tableextension 60016 FixedAssetExt extends "Fixed Asset"
{
    fields
    {
        // Add changes to table fields here
        field(50001; "FA Quantity"; Integer)
        {
            Description = 'ALFA';
            Editable = false;
        }
        field(60011; "Asset Custody"; Option)
        {
            Caption = 'Asset Custody';
            Description = 'LT_HRMS-P1-008';
            Editable = false;
            OptionCaption = 'Employer,Employee,Department';
            OptionMembers = Employer,Employee,Department;
        }
        field(60012; "Issued to Employee"; Code[20])
        {
            Caption = 'Issued to Employee';
            Description = 'LT_HRMS-P1-008';
            Editable = false;
        }
        field(60013; "Issued to Department"; Code[20])
        {
            Caption = 'Issued to Department';
            Description = 'LT_HRMS-P1-008';
            Editable = false;
        }
    }

    var
        myInt: Integer;
}