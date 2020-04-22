report 60009 "Copy Earning Code Group"
{
    // version LT_Payroll

    ProcessingOnly = true;

    dataset
    {
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field("Copy To Grade Category"; GradeCategory)
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Copy To Earning Code Group"; EarningCodeGroup)
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Copy From Grade Category"; ToGradeCategory)
                {
                    ApplicationArea = all;
                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        RecGradeCategory.RESET;
                        if PAGE.RUNMODAL(0, RecGradeCategory) = ACTION::LookupOK then begin
                            ToGradeCategory := RecGradeCategory."Grade Category ID";
                        end;
                    end;
                }
                field("Copy From Earning Code Group"; ToEarningCodeGroup)
                {
                    ApplicationArea = all;
                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        if ToGradeCategory = '' then
                            ERROR('Select To Grade Category');
                        RecEarningCodeGroup.RESET;
                        RecEarningCodeGroup.SETRANGE("Grade Category", ToGradeCategory);
                        RecEarningCodeGroup.SETFILTER("Earning Code Group", '<>%1', EarningCodeGroup);
                        if PAGE.RUNMODAL(0, RecEarningCodeGroup) = ACTION::LookupOK then begin
                            ToEarningCodeGroup := RecEarningCodeGroup."Earning Code Group";
                        end;
                    end;
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPostReport();
    begin
        MESSAGE('Earning Code Group Copied Successfully');
    end;

    trigger OnPreReport();
    begin
        if (ToGradeCategory <> '') and (ToEarningCodeGroup <> '') then begin
            InsertEarningGroupData(ToEarningCodeGroup, ToGradeCategory);
        end;
    end;

    var
        GradeCategory: Code[50];
        EarningCodeGroup: Code[20];
        RecEarningCodeGroup: Record "Earning Code Groups";
        ToGradeCategory: Code[50];
        ToEarningCodeGroup: Code[20];
        RecGradeCategory: Record "Payroll Grade Category";
        CopyFromEarningCdoe: Boolean;
        CopyFromMaster: Boolean;

    procedure SetValues(l_EarningCodeGroup: Code[20]; l_GradeCategory: Code[50]);
    begin
        EarningCodeGroup := l_EarningCodeGroup;
        GradeCategory := l_GradeCategory;
    end;

    local procedure InsertEarningGroupData(EarningGrp_p: Code[20]; l_GradeCategory: Code[50]);
    var
        EarningCodeGroups: Record "Earning Code Groups";
        PayrollEarningCodeWrkr: Record "Payroll Earning Code Wrkr";
        HCMLeaveTypesWrkr: Record "HCM Leave Types Wrkr";
        HCMBenefitWrkr: Record "HCM Benefit Wrkr";
        HCMLoanTableGCCWrkr: Record "HCM Loan Table GCC Wrkr";
        PayrollEarningCodeErnGrp: Record "Payroll Earning Code ErnGrp";
        HCMLeaveTypesErnGrp: Record "HCM Leave Types ErnGrp";
        HCMLoanTableGCCErnGrp: Record "HCM Loan Table GCC ErnGrp";
        HCMBenefitErnGrp: Record "HCM Benefit ErnGrp";
        PayrollEarningCode: Record "Payroll Earning Code ErnGrp";
        PayrollLeaveTypes: Record "HCM Leave Types ErnGrp";
        PayrollLoan: Record "HCM Loan Table GCC ErnGrp";
        PayrollBenifit: Record "HCM Benefit ErnGrp";
        PayrollEarningCode2: Record "Payroll Earning Code ErnGrp";
        PayrollBenifit2: Record "HCM Benefit ErnGrp";
        PayrollLoan2: Record "HCM Loan Table GCC ErnGrp";
        PayrollLeaveTypes2: Record "HCM Leave Types ErnGrp";
        AccrualComponent: Record "Accrual Components";
        AccrualComponentLines: Record "Accrual Component Lines";
    begin
        /*
        PayrollEarningCode.RESET;
        PayrollEarningCode.SETRANGE(PayrollEarningCode."Earning Code Group" ,EarningGrp_p);
        IF PayrollEarningCode.FINDSET THEN
          REPEAT
            PayrollEarningCode2.RESET;
            PayrollEarningCode2.SETRANGE("Earning Code", PayrollEarningCode."Earning Code");
            PayrollEarningCode2.SETRANGE("Earning Code Group",EarningCodeGroup);
            IF NOT PayrollEarningCode2.FINDFIRST THEN BEGIN
              PayrollEarningCode2.INIT;
              PayrollEarningCode2.CALCFIELDS("Formula For Atttendance");
              PayrollEarningCode2.TRANSFERFIELDS(PayrollEarningCode);
              PayrollEarningCode2."Earning Code Group" := EarningCodeGroup;
              PayrollEarningCode2.INSERT;
            END;
          UNTIL PayrollEarningCode.NEXT = 0;
        
        
        PayrollLeaveTypes.RESET;
        PayrollLeaveTypes.SETRANGE(PayrollLeaveTypes."Earning Code Group" , EarningGrp_p);
        IF PayrollLeaveTypes.FINDSET THEN
          REPEAT
            PayrollLeaveTypes2.RESET;
            PayrollLeaveTypes2.SETRANGE("Leave Type Id" , PayrollLeaveTypes."Leave Type Id");
            IF NOT PayrollLeaveTypes2.FINDFIRST THEN BEGIN
              PayrollLeaveTypes2.INIT;
              PayrollLeaveTypes2.TRANSFERFIELDS(PayrollLeaveTypes);
              PayrollLeaveTypes2."Earning Code Group" := EarningCodeGroup;
              PayrollLeaveTypes2.INSERT;
            END;
          UNTIL PayrollLeaveTypes.NEXT = 0;
        
        PayrollLoan.RESET;
        PayrollLoan.SETRANGE(PayrollLoan."Earning Code Group" , EarningGrp_p);
        IF PayrollLoan.FINDSET THEN
          REPEAT
            PayrollLoan2.RESET;
            PayrollLoan2.SETRANGE("Loan Code",PayrollLoan."Loan Code");
            IF NOT PayrollLoan2.FINDFIRST THEN BEGIN
              PayrollLoan2.INIT;
              PayrollLoan2.TRANSFERFIELDS(PayrollLoan);
              PayrollLoan2."Earning Code for Interest" := EarningCodeGroup;
              PayrollLoan2.INSERT;
            END;
          UNTIL PayrollLoan.NEXT = 0;
        
        PayrollBenifit.RESET;
        PayrollBenifit.SETRANGE(PayrollBenifit."Earning Code Group" , EarningGrp_p);
        IF PayrollBenifit.FINDSET THEN
          REPEAT
            PayrollBenifit2.RESET;
            PayrollBenifit2.SETRANGE("Benefit Id" , PayrollBenifit."Benefit Id");
            IF NOT PayrollBenifit2.FINDFIRST THEN BEGIN
              PayrollBenifit2.INIT;
              PayrollBenifit2.CALCFIELDS("Encashment Formula","Unit Calc Formula","Amount Calc Formula");
              PayrollBenifit2.TRANSFERFIELDS(PayrollBenifit);
              PayrollBenifit2."Earning Code Group" := EarningCodeGroup;
              PayrollBenifit2.INSERT;
            END;
          UNTIL PayrollBenifit.NEXT = 0;
          */

    end;
}

