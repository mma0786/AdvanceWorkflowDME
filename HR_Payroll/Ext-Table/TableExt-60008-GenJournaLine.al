tableextension 60008 GenJournaLine extends "Gen. Journal Line"
{
    fields
    {
        // Add changes to table fields here
        modify(Amount)
        {
            trigger OnAfterValidate()
            var
                GLSetup: Record "General Ledger Setup";
            begin
                //ALFA
                IF ("Account Type" = "Account Type"::"Fixed Asset") AND ("FA Posting Type" = "FA Posting Type"::"Acquisition Cost") THEN BEGIN
                    TESTFIELD("FA Quantity");
                    IF "FA Quantity" <> 0 THEN BEGIN
                        "FA Unit Amount" := Amount / "FA Quantity";
                        //VALIDATE("Unit Amount");
                        //ReadGLSetup();
                        GLSetup.GET;
                        "FA Unit Amount" := ROUND("FA Unit Amount", GLSetup."Unit-Amount Rounding Precision");
                    END;
                END;
                //ALFA
            end;
        }
        field(50055; "FA Quantity"; Integer)
        {
            Caption = 'FA Quantity';
            Description = 'ALFA';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if ("FA Posting Type" = "FA Posting Type"::"Acquisition Cost") then
                    Error('FA Posting type shoulb be Acquisition Cost');

                // TESTFIELD("FA Posting Type", "FA Posting Type"::"Acquisition Cost"); .. @avinash
                UpdateAmount;
            end;
        }
        field(50051; "FA Unit Amount"; Decimal)
        {
            Caption = 'FA Unit Amount';
            Description = 'ALFA';

            trigger OnValidate()
            begin
                //  TESTFIELD("FA Posting Type", "FA Posting Type"::"Acquisition Cost"); .. @Avinash
                if ("FA Posting Type" = "FA Posting Type"::"Acquisition Cost") then
                    Error('FA Posting type shoulb be Acquisition Cost');
                UpdateAmount();
            end;
        }
        field(50052; "Total Amount"; Decimal)
        {
            CalcFormula = Sum ("Gen. Journal Line"."Amount (LCY)" WHERE("Document No." = FIELD("Document No."),
                                                                        "Amount (LCY)" = FILTER(> 0)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50053; "Total Amount LCY"; Decimal)
        {
        }
        field(50054; "Shortcut Dimension 3 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 3 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3),
                                                          Blocked = CONST(false));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(3, "Shortcut Dimension 3 Code");

            end;
        }
    }

    var
        myInt: Integer;

    local procedure UpdateAmount()
    begin
        IF "Account Type" = "Account Type"::"Fixed Asset" THEN BEGIN
            Amount := ROUND("FA Quantity" * "FA Unit Amount");
            VALIDATE(Amount);
        END;
    end;

}