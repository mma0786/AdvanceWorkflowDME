table 60089 Sector
{
    LookupPageID = "Sector List";

    fields
    {
        field(1; "Sector ID"; Code[20])
        {
            Caption = 'Sector ID';
            Editable = false;

            trigger OnValidate()
            begin
                if "Sector ID" <> xRec."Sector ID" then begin
                    HrSetupRec.GET;
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "Sector Name"; Text[50])
        {
            Caption = 'Sector Name';
        }
        field(3; "Country/Region Code"; Code[20])
        {
            Caption = 'Country/Region Code';
            TableRelation = "Country/Region";

            trigger OnValidate()
            begin
                if CountryRegionRec.GET("Country/Region Code") then
                    "Country/Region Code" := CountryRegionRec.Name;
            end;
        }
        field(4; "First Class Adult Ticket Fare"; Decimal)
        {
            Caption = 'First Class Adult Ticket Fare';
        }
        field(5; "First Class Infant Ticket Fare"; Decimal)
        {
            Caption = 'First Class Infant Ticket Fare';
        }
        field(6; "First Class Child Ticket Fare"; Decimal)
        {
            Caption = 'First Class Child Ticket Fare';
        }
        field(7; "Business Adult Ticket Fare"; Decimal)
        {
            Caption = 'Business Adult Ticket Fare';
        }
        field(8; "Business Infant Ticket Fare"; Decimal)
        {
            Caption = 'Business Infant Ticket Fare';
        }
        field(9; "Business Child Ticket Fare"; Decimal)
        {
            Caption = 'Business Child Ticket Fare';
        }
        field(10; "Economy Adult Ticket Fare"; Decimal)
        {
            Caption = 'Economy Adult Ticket Fare';
        }
        field(11; "Economy Infant Ticket Fare"; Decimal)
        {
            Caption = 'Economy Infant Ticket Fare';
        }
        field(12; "Economy Child Ticket Fare"; Decimal)
        {
            Caption = 'Economy Child Ticket Fare';
        }
        field(13; Currency; Code[20])
        {
            Caption = 'Currency';
            TableRelation = Currency.Code;
        }
        field(14; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
    }

    keys
    {
        key(Key1; "Sector ID")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Sector ID", "Sector Name", "Country/Region Code", Currency)
        {
        }
    }

    trigger OnDelete()
    begin
        EmployeeRec_G.RESET;
        EmployeeRec_G.SETRANGE("Sector ID", "Sector ID");
        if EmployeeRec_G.FINDFIRST then
            ERROR('Sector cannot be deleted while dependent employee exist. Cannot delete.');
    end;

    trigger OnInsert()
    begin
        INITINSERT
    end;

    var
        HrSetupRec: Record "Human Resources Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        CountryRegionRec: Record "Country/Region";
        EmployeeRec_G: Record Employee;

    local procedure INITINSERT()
    begin
        HrSetupRec.GET;
        if "Sector ID" = '' then;
        NoSeriesMgt.InitSeries(HrSetupRec."Sector ID", xRec."Sector ID", TODAY(), "Sector ID", HrSetupRec."Sector ID")
    end;
}

