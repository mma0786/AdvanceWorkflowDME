pageextension 60021 Ext_Fa_Setup extends "Fixed Asset Setup"
{
    layout
    {
        addafter("Insurance Nos.")
        {
            field("Issue Document No."; "Issue Document No.")
            {
                ApplicationArea = all;
            }
            field("Return Document No."; "Return Document No.")
            {
                ApplicationArea = all;
            }
            field("Posted Issue Document No"; "Posted Issue Document No")
            {
                ApplicationArea = all;
            }
            field("Posted Return Document No"; "Posted Return Document No")
            {
                ApplicationArea = all;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}