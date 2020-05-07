page 60217 "Employee Address ListPart"
{
    // version PHASE -2

    AutoSplitKey = true;
    Caption = 'Address';
    PageType = ListPart;
    SourceTable = "Employee Address Line";


    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Name or Description"; "Name or Description")
                {
                    ApplicationArea = All;
                }
                field("Country/Region Code"; "Country/Region Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Country/Region"; "Country/Region")
                {
                    ApplicationArea = All;
                    Caption = 'Country/Region Code';
                }
                field("Post Code"; "Post Code")
                {
                    ApplicationArea = All;
                }
                field(City; City)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Street; Street)
                {
                    ApplicationArea = All;
                }
                field(Primary; Primary)
                {
                    ApplicationArea = All;

                    trigger OnValidate();
                    var
                        Rec2: Record "Employee Address Line";
                    begin
                        if Rec.Primary = true then begin
                            CLEAR(Rec2);
                            Rec2.SETRANGE("Employee ID", "Employee ID");
                            Rec2.SETRANGE(Primary, true);
                            if Rec2.FINDFIRST then begin
                                if CONFIRM(Text001, false) then begin
                                    Rec.Primary := true;
                                    Rec2.Primary := false;
                                    Rec2.MODIFY;
                                end else begin
                                    Rec.Primary := false;
                                    Rec.MODIFY;
                                    CurrPage.UPDATE;
                                end
                            end;
                        end;
                    end;
                }
                field(Private; Private)
                {
                    ApplicationArea = All;
                }
                field(Purpose; Purpose)
                {
                    ApplicationArea = All;
                }
            }
        }
    }



    var
        Text001: Label 'This will unmark the current primary address. Do you want to continue?';
}

