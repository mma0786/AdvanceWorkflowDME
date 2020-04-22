tableextension 60012 ResourcesSetup extends "Resources Setup"
{
    fields
    {
        // Add changes to table fields here
        field(60000; "HR Email ID"; Text[150])
        {
            Description = 'LT';
        }
    }

    var
        myInt: Integer;
}