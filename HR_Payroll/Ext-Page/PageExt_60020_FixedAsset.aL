pageextension 60020 Ext_Fixed_Asset extends "Fixed Asset Card"
{
    layout
    {
        addafter(Maintenance)
        {
            group("Asset_Custody")
            {

                Caption = 'Asset Custody';

                field("Asset Custody"; "Asset Custody")
                {
                    ApplicationArea = all;
                }
                field("Issued to Employee"; "Issued to Employee")
                {
                    ApplicationArea = all;
                }
                field("Issued to Department"; "Issued to Department")
                {
                    ApplicationArea = all;

                }
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