tableextension 70000 "Ext Approval Entry" extends "Approval Entry"
{
    fields
    {
        field(70000; "Advance Date"; Date)
        {

        }
    }

    trigger OnAfterInsert()
    begin
        validate("Advance Date", Today);
        Modify();
    end;

    trigger OnAfterModify()
    begin
        validate("Advance Date", Today);
        Modify();
    end;
}