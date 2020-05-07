table 60071 "Employee Address Line"
{
    LookupPageId = "Employee Address ListPart";
    DrillDownPageId = "Employee Address ListPart";

    fields
    {
        field(1; "Employee ID"; Code[20])
        {
            Editable = false;
        }
        field(2; "Name or Description"; Text[50])
        {
        }
        field(3; Street; Text[50])
        {
        }
        field(4; City; Text[30])
        {
            Caption = 'City';
            Editable = false;
        }
        field(5; "Country/Region Code"; Code[10])
        {
            Caption = 'Country/Region Code';
            TableRelation = "Country/Region";

            trigger OnValidate()
            var
                RecCountry: Record "Country/Region";
            begin
                if (xRec."Country/Region Code" <> Rec."Country/Region Code") or ("Country/Region Code" = '') then begin
                    CLEAR(City);
                    CLEAR("Post Code");
                    CLEAR(State);
                    //Krishna
                    Clear(RecCountry);
                    RecCountry.GET("Country/Region Code");
                    "Country/Region" := RecCountry.Name;
                end;
            end;
        }
        field(6; State; Text[30])
        {
        }
        field(7; Primary; Boolean)
        {

            trigger OnValidate()
            begin
                //IF Primary = TRUE THEN
                //  PriValidation;
            end;
        }
        field(8; Private; Boolean)
        {
        }
        field(9; Purpose; Option)
        {
            OptionCaption = ' ,Home,Business,Consignment,Delivery,Others';
            OptionMembers = "''",Home,Business,Consignment,Delivery,Others;
        }
        field(10; "Line No"; Integer)
        {
            Editable = false;
        }
        field(11; "Post Code"; Code[20])
        {
            Caption = 'Post Code';
            TableRelation = IF ("Country/Region Code" = FILTER(<> '')) "Post Code" WHERE("Country/Region Code" = FIELD("Country/Region Code"));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = true;//Krishna//Enabled as per Issue Tracker 

            trigger OnValidate()
            begin
                PostCode.RESET;
                PostCode.SETRANGE(Code, "Post Code");
                if PostCode.FINDFIRST then
                    City := PostCode.City;

                if "Post Code" = '' then
                    CLEAR(City);
            end;
        }
        field(12; "Table Type Option"; Option)
        {
            Editable = false;
            OptionCaption = ' ,Employee Address Line,Employee Creation Address Line,Dependent Address Line';
            OptionMembers = " ","Employee Address Line","Employee Creation Address Line","Dependent Address Line";
        }
        field(13; "Document No"; Code[20])
        {
            Editable = false;
        }
        field(14; "Dependent ID"; Code[20])
        {
            Caption = 'Dependent ID';
            Editable = false;
        }
        //Krishna
        field(50000; "Country/Region"; Text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Country/Region";
            ValidateTableRelation = false;
            trigger OnValidate()
            var
                RecCountry: Record "Country/Region";
            begin
                Clear(RecCountry);
                RecCountry.GET("Country/Region");
                Validate("Country/Region Code", RecCountry.Code);
                "Country/Region" := RecCountry.Name;
            end;
        }
    }

    keys
    {
        key(Key1; "Table Type Option", "Employee ID", "Document No", "Dependent ID", "Line No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        Text001: Label 'This will unmark the current primary address. Do you want to continue?';
        CountryRegion: Record "Country/Region";
        PostCode: Record "Post Code";

    local procedure PriValidation()
    var
        Rec2: Record "Employee Address Line";
    begin
        /*CLEAR(Rec2);
        Rec2.SETRANGE("Employee ID","Employee ID");
        Rec2.SETRANGE(Primary,TRUE);
        IF Rec2.FINDFIRST THEN BEGIN
          IF CONFIRM(Text001,FALSE) THEN BEGIN
            Rec.Primary:=TRUE;
            Rec2.Primary:=FALSE;
            Rec2.MODIFY;
          END ELSE
            Primary:=FALSE;
            MODIFY;
        END;
        */
        /*Rec2.RESET;
        Rec2.SETRANGE("Employee ID","Employee ID");
        //Rec2.SETRANGE("Name or Description","Name or Description");
        Rec2.SETRANGE(Primary,TRUE);
        IF Rec2.FINDFIRST THEN BEGIN
          IF CONFIRM(Text001,FALSE) THEN BEGIN
            Rec.Primary := TRUE;
            Rec2.Primary := FALSE;
            Rec2.MODIFY
          END ELSE
            Primary := FALSE;
        END;
        */

    end;
}

