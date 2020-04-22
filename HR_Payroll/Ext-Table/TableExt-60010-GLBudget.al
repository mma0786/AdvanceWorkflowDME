tableextension 60010 GLBudget extends "G/L Budget Entry"
{
    fields
    {
        // Add changes to table fields here

        field(50000; "Employee Code"; Code[20])
        {
            Description = 'ALFA';
            Editable = false;
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = CONST('EMPLOYEE'));
        }
        field(50001; "Member State Code"; Code[20])
        {
            Description = 'ALFA';
            Editable = false;
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = CONST('MEMBER STATES'));
        }
    }

    var
        myInt: Integer;
}