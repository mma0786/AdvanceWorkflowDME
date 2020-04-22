table 60025 "Employee Bank Account"
{
    Caption = 'Employee Bank Account';
    LookupPageID = "Employee Bank Account List";

    fields
    {
        field(1; "Bank Code"; Code[20])
        {
            Caption = 'Bank Code';
            TableRelation = "Bank Master";

            trigger OnValidate()
            begin
                CLEAR("Bank Name");
                CLEAR("Bank Name in Arabic");
                if BankMRec.GET("Bank Code") then begin
                    "Bank Name" := BankMRec."Bank Name";
                    "Bank Name in Arabic" := BankMRec."Bank Name in Arabic";
                end;
            end;
        }
        field(2; "Bank Name"; Text[50])
        {
            Caption = 'Bank Name';
            Editable = false;
        }
        field(3; "Bank Name in Arabic"; Text[50])
        {
            Caption = 'Bank Name in Arabic';
            Editable = false;
        }
        field(4; "Employee Id"; Code[20])
        {
            Caption = 'Employee Id';
        }
        field(5; "Routing Number Type"; Option)
        {
            Caption = 'Routing Number Type';
            OptionCaption = 'None,at,BL,cc,CP,CH,FW,SC';
            OptionMembers = "None",at,BL,cc,CP,CH,FW,SC;
        }
        field(6; "Routing Number"; Text[50])
        {
            Caption = 'Routing Number';
        }
        field(7; "Bank Acccount Number"; Text[50])
        {
            Caption = 'Bank Acccount Number';
        }
        field(8; "SWIFT code"; Text[50])
        {
            Caption = 'SWIFT code';
        }
        field(9; IBAN; Text[50])
        {
            Caption = 'IBAN';
        }
        field(10; "Account Holder"; Text[50])
        {
            Caption = 'Account Holder';
        }
        field(11; "Branch Name"; Text[50])
        {
            Caption = 'Branch Name';
        }
        field(12; "Branch Number"; Text[50])
        {
            Caption = 'Branch Number';
        }
        field(13; "MOL Id"; Text[50])
        {
            Caption = 'MOL Id';
        }
        field(14; Address; BLOB)
        {
            Caption = 'Address';
        }
        field(15; "Name of Person"; Text[50])
        {
            Caption = 'Name of Person';
        }
        field(16; Telephone; Text[50])
        {
            Caption = 'Telephone';
        }
        field(17; Extension; Text[50])
        {
            Caption = 'Extension';
        }
        field(18; "Mobile Phone"; Text[50])
        {
            Caption = 'Mobile Phone';
        }
        field(19; Fax; Text[50])
        {
            Caption = 'Fax';
        }
        field(20; Email; Text[50])
        {
            Caption = 'Email';
        }
        field(21; "Internet Address"; Text[50])
        {
            Caption = 'Internet Address';
        }
        field(22; "Telex Number"; Text[50])
        {
            Caption = 'Telex Number';
        }
        field(23; Primary; Boolean)
        {
            Caption = 'Primary';

            trigger OnValidate()
            begin
                if Primary = true then begin
                    Rec2.RESET;
                    Rec2.SETRANGE("Employee Id", "Employee Id");
                    Rec2.SETRANGE(Primary, true);
                    Rec2.SETFILTER("Bank Acccount Number", '<>%1', "Bank Acccount Number");
                    if Rec2.FINDFIRST then begin
                        if CONFIRM('An other Bank Account is selected as Primary, do you want to change?', true) then begin
                            Rec2.Primary := false;
                            Rec2.MODIFY;
                            Primary := true;
                        end else
                            Primary := false;
                    end;
                end;
            end;
        }
    }

    keys
    {
        key(Key1; "Employee Id", "Bank Code", "Bank Acccount Number")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        BankMRec: Record "Bank Master";
        Rec2: Record "Employee Bank Account";


    procedure SetAddress(Test: Text)
    var
        OutStream: OutStream;
    begin
        CLEAR(Address);
        if Test = '' then
            exit;
        Address.CreateOutStream(OutStream, TEXTENCODING::UTF8);
        OutStream.WriteText(Test);
        Modify;

    end;


    procedure GetAddress(): Text
    var
        TypeHelper: Codeunit "Type Helper";
        InStream: InStream;
    begin
        CALCFIELDS(Address);
        if not Address.HASVALUE then
            exit('');

        CALCFIELDS(Address);
        Address.CreateInStream(InStream, TEXTENCODING::UTF8);
        exit(TypeHelper.ReadAsTextWithSeparator(InStream, TypeHelper.LFSeparator));

    end;
}

