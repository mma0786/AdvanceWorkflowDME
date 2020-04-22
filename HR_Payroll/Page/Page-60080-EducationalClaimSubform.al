page 60080 "Educational Claim Subform"
{
    AutoSplitKey = true;
    PageType = ListPart;
    SourceTable = "Educational Claim Lines LT";
    SourceTableView = SORTING("Claim ID", "Employee No.", "Line No.")
                      ORDER(Ascending);
    // // UsageCategory = Administration;
    // // ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Claim ID"; "Claim ID")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Employee No."; "Employee No.")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Allowance Type"; "Allowance Type")
                {
                    Editable = EditBool;
                    ApplicationArea = All;
                }
                field("Dependent ID"; "Dependent ID")
                {
                    Editable = EditBool;
                    ApplicationArea = All;
                    ShowMandatory = true;

                    trigger OnValidate()
                    begin
                        /*MODIFY;
                        CLEAR(CountofChil);
                        EmpRecL.GET("Employee No.");
                        EducationalAllowanceLT.RESET;
                        EducationalAllowanceLT.SETRANGE("Earnings Code Group",EmpRecL."Earning Code Group");
                        EducationalAllowanceLT.SETRANGE("Grade Category",EmpRecL."Grade Category");
                        IF EducationalAllowanceLT.FINDFIRST THEN BEGIN
                          CountofChil := EducationalAllowanceLT."Count of children eligible";
                        END;


                        CLEAR( EduClaim_L);
                        CLEAR(DepID);
                        //EduClaim_L.SETCURRENTKEY("Claim ID","Employee No.","Line No.");
                        EduClaim_L.RESET;
                        EduClaim_L.SETCURRENTKEY("Dependent ID");
                        EduClaim_L.SETASCENDING("Dependent ID",FALSE);
                        EduClaim_L.SETRANGE("Claim ID",Rec."Claim ID");
                        EduClaim_L.SETRANGE("Employee No.",Rec."Employee No.");
                        //EduClaim_L.SETRANGE("Dependent ID",Rec."Dependent ID");
                        IF EduClaim_L.FINDFIRST THEN BEGIN

                          REPEAT
                            {IF DepID = '' THEN
                              DepID := EduClaim_L."Dependent ID" ;}

                            //IF (DepID <> '') AND (EduClaim_L."Dependent ID" <> DepID) THEN BEGIN
                            IF EduClaim_L."Dependent ID" <> DepID THEN BEGIN
                              NOcount += 1;
                              DepID := EduClaim_L."Dependent ID";
                            END;

                          UNTIL EduClaim_L.NEXT = 0;

                        END;
                        IF NOcount > CountofChil THEN
                         ERROR('Not allowed');
                        */

                    end;
                }
                field("Dependent Name"; "Dependent Name")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Claim Date"; "Claim Date")
                {
                    Editable = EditBool;
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Fee Description"; "Fee Description")
                {
                    Editable = EditBool;
                    ApplicationArea = All;
                }
                field("Level of Education"; "Level of Education")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Institution Name"; "Institution Name")
                {
                    Editable = EditBool;
                    ApplicationArea = All;
                }
                field(Grade; Grade)
                {
                    Editable = EditBool;
                    ApplicationArea = All;
                }
                field("Period Start Date"; "Period Start Date")
                {
                    Editable = EditBool;
                    ApplicationArea = All;
                }
                field("Period End Date"; "Period End Date")
                {
                    Editable = EditBool;
                    ApplicationArea = All;
                }
                field("Eligible Amount"; "Eligible Amount")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Utilized Amount"; "Utilized Amount")
                {
                    ApplicationArea = All;
                }
                field("Balance Amount"; "Balance Amount")
                {
                    ApplicationArea = All;
                }
                field("Selected Currency"; "Selected Currency")
                {
                    ShowMandatory = true;
                    ApplicationArea = All;
                }
                field("Selected Claim Amount"; "Selected Claim Amount")
                {
                    ShowMandatory = true;
                    ApplicationArea = All;
                }
                field("Current Claim Amount"; "Current Claim Amount")
                {
                    Editable = EditBool;
                    ApplicationArea = All;
                }
                field("Academic year"; "Academic year")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
            }
        }
    }



    trigger OnAfterGetCurrRecord()
    begin
        EditFields;
    end;

    trigger OnAfterGetRecord()
    begin
        EditFields;
    end;

    trigger OnInit()
    begin
        EditFields;
    end;

    var
        EditBool: Boolean;
        EduClaim_L: Record "Educational Claim Lines LT";
        EmpRecL: Record Employee;
        EducationalAllowanceLT: Record "Educational Allowance LT";
        CountofChil: Integer;
        DepID: Code[20];
        NOcount: Integer;
        EduClamLineRecL: Record "Educational Claim Lines LT";

    local procedure EditFields()
    var
        HeadRec: Record "Educational Claim Header LT";
    begin
        HeadRec.RESET;
        HeadRec.SETRANGE("Claim ID", Rec."Claim ID");
        HeadRec.SETRANGE("Employee No.", "Employee No.");
        if HeadRec.FINDFIRST then begin
            if HeadRec."Approval Status" <> HeadRec."Approval Status"::Open then
                EditBool := false
            else
                EditBool := true;
        end;
    end;
}

