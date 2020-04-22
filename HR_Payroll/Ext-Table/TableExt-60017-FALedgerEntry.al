tableextension 60017 FALedgerEntry extends "FA Ledger Entry"
{
    fields
    {
        // Add changes to table fields here
        field(50000; "FA Quantity"; Integer)
        {
            Caption = 'FA Quantity';
            Description = 'ALFA';
        }
        field(50001; "FA Unit Amount"; Decimal)
        {
            Caption = 'FA Unit Amount';
            Description = 'ALFA';
        }
    }

    var
        myInt: Integer;
}