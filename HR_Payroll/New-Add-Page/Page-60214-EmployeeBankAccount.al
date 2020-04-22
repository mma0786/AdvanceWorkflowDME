page 60214 "Employee Bank Account"
{
    Caption = 'Employee Bank Account';
    PageType = Card;
    SourceTable = "Employee Bank Account";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Employee Id"; "Employee Id")
                {
                    Visible = false;
                    ApplicationArea = ALL;
                }
                field("Bank Code"; "Bank Code")
                {
                    ShowMandatory = true;
                    ApplicationArea = ALL;
                }
                field("Bank Name"; "Bank Name")
                {
                    ApplicationArea = ALL;
                }
                field("Bank Name in Arabic"; "Bank Name in Arabic")
                {
                    ApplicationArea = ALL;
                    Visible = false;
                }
            }
            group("Bank Account details ")
            {
                Caption = '"Bank Account details "';
                field("Routing Number Type"; "Routing Number Type")
                {
                    ApplicationArea = ALL;
                }
                field("Routing Number"; "Routing Number")
                {
                    ApplicationArea = ALL;
                }
                field("Bank Acccount Number"; "Bank Acccount Number")
                {
                    ApplicationArea = ALL;
                }
                field("SWIFT code"; "SWIFT code")
                {
                    ApplicationArea = ALL;
                }
                field(IBAN; IBAN)
                {
                    ApplicationArea = ALL;
                    ShowMandatory = true;
                }
                field("Account Holder"; "Account Holder")
                {
                    ApplicationArea = ALL;
                }
                field("Branch Name"; "Branch Name")
                {
                    ApplicationArea = ALL;
                }
                field("Branch Number"; "Branch Number")
                {
                    ApplicationArea = ALL;
                }
                field("MOL Id"; "MOL Id")
                {
                    ApplicationArea = ALL;
                }
            }
            group("Address Details")
            {
                Caption = 'Address Details';
                field(Address; AddressText)
                {
                    ApplicationArea = ALL;
                    Caption = 'Address';
                    MultiLine = true;

                    trigger OnValidate();
                    begin
                        SetAddress(AddressText);
                    end;
                }
            }
            group("Contact Information ")
            {
                Caption = 'Contact Information';
                field("Name of Person"; "Name of Person")
                {
                    ApplicationArea = ALL;
                }
                field(Telephone; Telephone)
                {
                    ApplicationArea = ALL;
                }
                field(Extension; Extension)
                {
                    ApplicationArea = ALL;
                }
                field("Mobile Phone"; "Mobile Phone")
                {
                    ApplicationArea = ALL;
                }
                field(Fax; Fax)
                {
                    ApplicationArea = ALL;
                }
                field(Email; Email)
                {
                    ApplicationArea = ALL;
                }
                field("Internet Address"; "Internet Address")
                {
                    ApplicationArea = ALL;
                }
                field("Telex Number"; "Telex Number")
                {
                    ApplicationArea = ALL;
                }
                field(Primary; Primary)
                {
                    ApplicationArea = ALL;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetCurrRecord();
    begin
        AddressText := GetAddress;
    end;

    trigger OnAfterGetRecord();
    begin
        AddressText := GetAddress;
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean;
    begin
        if CloseAction in [ACTION::OK, ACTION::LookupOK] then begin
            EmployeeBankAccountRec_G.RESET;
            EmployeeBankAccountRec_G.SETRANGE("Employee Id", "Employee Id");
            if EmployeeBankAccountRec_G.FINDFIRST then begin
                if (EmployeeBankAccountRec_G."Bank Code" <> '') or (EmployeeBankAccountRec_G."Bank Acccount Number" <> '') then begin
                    EmployeeBankAccountRec_G.TESTFIELD("Bank Acccount Number");
                    EmployeeBankAccountRec_G.TESTFIELD(IBAN);
                end;
            end;
        end;
    end;

    var
        Test: Text;
        PositionSummarry: Text;
        AddressText: Text[1024];
        EmployeeBankAccountRec_G: Record "Employee Bank Account";
}

