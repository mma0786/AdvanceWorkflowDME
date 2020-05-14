tableextension 60014 EmployeeExt extends Employee
{

    fields
    {
        // Add changes to table fields here
        modify(Initials)
        {
            TableRelation = Initials;
            trigger OnAfterValidate()
            begin
                "Search Name" := Initials + ' ' + "First Name" + ' ' + "Middle Name" + ' ' + "Last Name";
            end;
        }

        field(60000; "Earning Code Group"; Code[20])
        {

            trigger OnValidate()
            var
                EarningCodeGrps: Record "Earning Code Groups";
                PayrollEarningCodeErnGrp: Record "Payroll Earning Code ErnGrp";
                HCMLeaveTypesErnGrp: Record "HCM Leave Types ErnGrp";
                HCMLoanTableGCCErnGrp: Record "HCM Loan Table GCC ErnGrp";
                HCMBenefitErnGrp: Record "HCM Benefit ErnGrp";
            begin
                IF (xRec."Earning Code Group" <> "Earning Code Group") AND
                    ("Earning Code Group" = '') THEN
                    DeleteEarningGroupsData(xRec."Earning Code Group");

                IF "Earning Code Group" <> '' THEN
                    InsertEarningGroupData;
            end;

        }
        field(60001; "Joining Date"; Date)
        {

            trigger OnValidate()
            begin
                // Converting Date of Joining to Hijiri Date
                // Hijiri_Date_Converter_Dll_G := Hijiri_Date_Converter_Dll_G.Class1();
                //  "D.O.J Hijiri" := Hijiri_Date_Converter_Dll_G.GregToHijri(FORMAT("Joining Date", 10, '<Year4>/<Month,2>/<Day,2>'));
                IF "Joining Date" <> 0D THEN BEGIN
                    PayrollJobPosWorkerAssign.RESET;
                    PayrollJobPosWorkerAssign.SETRANGE(Worker, Rec."No.");
                    PayrollJobPosWorkerAssign.SETRANGE("Position Assigned", FALSE);
                    IF PayrollJobPosWorkerAssign.FINDFIRST THEN BEGIN
                        PayrollJobPosWorkerAssign.VALIDATE("Assignment Start", "Joining Date");
                        PayrollJobPosWorkerAssign.MODIFY(TRUE);
                    END;
                END;
            end;

        }
        field(60002; "Probation Period"; Date)
        {

            trigger OnValidate()
            begin
                TESTFIELD("Joining Date");
                IF "Probation Period" <> 0D THEN
                    IF "Probation Period" <= "Joining Date" THEN
                        ERROR('Probation Period should be greater than Joining Date');
            end;
        }
        field(60003; "Employee Religion"; Code[20])
        {
            TableRelation = "Payroll Religion";
        }
        field(60004; Nationality; Text[50])
        {
            Caption = 'Nationality';
            TableRelation = "Country/Region";

            trigger OnValidate()
            var
                CountryRegion: Record 9;
            begin
                // Start 18.04.2020
                "Emp National Code" := Nationality;
                // Stop 18.04.2020
                CountryRegion.RESET;
                IF CountryRegion.GET(Nationality) THEN
                    Nationality := CountryRegion.Name;
            end;
        }
        field(60005; "Marital Status"; Text[30])
        {
            TableRelation = "Marital Status";
        }
        field(60006; "Seperation Reason"; Text[250])
        {
            TableRelation = "Seperation Master"."Seperation Reason";
        }
        field(60007; "Hold Payment from Date"; Date)
        {
        }
        field(60008; Type; Option)
        {
            OptionMembers = " ","New Addition","Request Change","Delete Dependent";
        }
        field(60009; Remarks; Text[50])
        {
        }
        field(60010; "Increment Step Number"; Integer)
        {
        }
        field(60011; "Unsatisfactory Grade"; Integer)
        {
            Caption = 'No of Years with Unsatisfactory Grade';
        }
        field(60012; "Seperation Reason Code"; Integer)
        {
        }
        field(60013; "Employee Request No."; Code[20])
        {
        }
        field(60014; "Employee Name in Arabic"; Text[250])
        {
        }
        field(60015; "Grade Category"; Code[50])
        {
            TableRelation = "Payroll Grade Category";
        }
        field(60016; Grade; Code[20])
        {
        }
        field(60017; "Sub Grade"; Code[20])
        {
        }
        field(60018; "Employment End Date"; Date)
        {
        }
        field(60019; Position; Code[20])
        {
            TableRelation = "Payroll Position";
        }
        field(60020; "Position Assignment Date"; Date)
        {
        }
        field(60021; "Identification Type"; Code[20])
        {
        }
        field(60022; "Identification No."; Code[20])
        {
        }
        field(60023; "Issue Date"; Date)
        {
        }
        field(60024; "Expiry Date"; Date)
        {
        }
        field(60025; "Issuing Country"; Code[20])
        {
        }
        field(60026; Department; Code[20])
        {
            Caption = 'Department';
            TableRelation = "Payroll Department";
        }
        field(60027; "Line manager"; Text[50])
        {
            Caption = 'Line Manager';
        }
        field(60028; HOD; Text[50])
        {
            Caption = 'HOD';
        }
        field(60029; "Contract No"; Code[20])
        {
            Editable = false;
        }
        field(60030; "Contract Version No."; Code[20])
        {
            Editable = false;
        }
        field(60031; "Registry Reference No."; Code[20])
        {
            Editable = false;
        }
        field(60032; "Employment Type"; Code[20])
        {
            Caption = 'Employment Type';
            TableRelation = "Employment Type";
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                IF EmplTypeREc.GET("Employment Type") THEN
                    "Employment Type" := EmplTypeREc."Employment Type";
            end;
        }
        field(60033; "Sub Department"; Code[20])
        {
            Caption = 'Sub Department';
            TableRelation = "Sub Department" WHERE("Department ID" = FIELD(Department));
        }
        field(60034; "Age As Of Date"; Text[30])
        {
            Caption = 'Age As Of Date';
        }
        field(60035; Region; Text[35])
        {
            Caption = 'Region';
            TableRelation = Region;
        }
        field(60036; "Work Location"; Text[50])
        {
            Caption = 'Work Location';
            TableRelation = "Work Location";
        }
        field(60037; "Position Name In Arabic"; Text[50])
        {
            Caption = 'Position Name In Arabic';
        }
        field(60038; "Nationality In Arabic"; Text[50])
        {
            Caption = 'Nationality In Arabic';
        }
        field(60039; "Job Title as per Iqama"; Text[50])
        {
            Caption = 'Job Title as per Iqama';
        }
        field(60040; "Sector ID"; Code[20])
        {
            Caption = 'Sector ID';
            TableRelation = Sector;

            trigger OnValidate()
            begin
                CLEAR("Search Name");
                IF SectorRec.GET("Sector ID") THEN
                    "Sector Name" := SectorRec."Sector Name";
            end;

        }
        field(60041; "Sector Name"; Text[50])
        {
        }
        field(60042; "Old Employee ID"; Code[20])
        {
            Editable = false;
        }
        field(60043; "Employee Full Name In Arabic"; Text[150])
        {
        }
        field(60044; "Personal   Title in Arabic"; Text[30])
        {
        }
        field(60045; "First Reporting ID"; Code[20])
        {
        }
        field(60046; "Employee Copy"; Boolean)
        {
        }
        field(60047; "Increment step"; Code[20])
        {

            trigger OnLookup()
            var
            // PayrollIncStepsRec: Record "Payroll Increment Steps";
            begin
                /* PayrollIncStepsRec.RESET;
                 PayrollIncStepsRec.SETRANGE(Grade, "Earning Code Group");
                 PayrollIncStepsRec.SETRANGE("Grade Category", "Grade Category");
                 IF PAGE.RUNMODAL(PAGE::"Payroll Increment Steps", PayrollIncStepsRec) = ACTION::LookupOK THEN BEGIN
                     "Increment step" := FORMAT(PayrollIncStepsRec.Steps);
                     "Sub Grade" := FORMAT(PayrollIncStepsRec.Steps);
                     "Increment Step Number" := PayrollIncStepsRec.Steps;
                 END;*/
            end;

            trigger OnValidate()
            begin
                IF "Increment step" = '' THEN
                    "Increment Step Number" := 0;
            end;
        }
        field(60048; "Professional Title in Arabic"; Text[80])
        {
        }
        field(60049; "D.O.J Hijiri"; Text[50])
        {
            Description = '#WFLevtech';
            Editable = false;
        }
        field(60050; "B.O.D Hijiri"; Text[50])
        {
            Description = '#WFLevtech';
            Editable = false;
        }
        field(60051; "Emp National Code"; Code[20])
        {

            Editable = false;
        }
        field(60052; "Blood Group"; Option)
        {
            OptionMembers = " ","O−","O+","A−","A+","B−","B+","AB−","AB+";
        }

        field(60053; "Employee Notice Period In Days"; Integer)
        {

        }
        field(60054; "Sponcer"; Code[250])
        {
            TableRelation = Company;
            trigger
            OnValidate()
            var
                CompanyRecL: Record Company;
            begin
                CompanyRecL.Reset();
                if CompanyRecL.Get(Sponcer) then
                    Sponcer := UpperCase(CompanyRecL.Name);

            end;
        }

        field(60055; "Probation Months"; Integer)
        {

            trigger OnValidate()
            var
                AdvPayrollSetupRecL: Record "Advance Payroll Setup";
                DateExpr: Text;
            begin
                AdvPayrollSetupRecL.Reset();
                AdvPayrollSetupRecL.Get();
                if "Probation Months" > AdvPayrollSetupRecL."Probation Months" then
                    Error('Probation  Mothas cannoot greater than %1', AdvPayrollSetupRecL."Probation Months");

                //DateExpr := '<' + Format("Joining Date") + '+' + Format("Probation Months") + 'M';

                DateExpr := '<' + Format("Probation Months") + 'M>';

                "Probation Period" := CalcDate(dateExpr, "Joining Date");
            end;
        }

        modify("First Name")
        {
            trigger OnAfterValidate()
            begin
                "Search Name" := Initials + ' ' + "First Name" + ' ' + "Middle Name" + ' ' + "Last Name";
            end;
        }
        modify("Last Name")
        {
            trigger OnAfterValidate()
            begin
                "Search Name" := Initials + ' ' + "First Name" + ' ' + "Middle Name" + ' ' + "Last Name";
            end;
        }
        modify("Birth Date")
        {
            trigger OnAfterValidate()
            var
            begin
                CLEAR(Age);
                Age := -("Birth Date" - TODAY);
                VALIDATE("Age As Of Date", FORMAT(ROUND(Age / 365.27)));
            end;
        }
    }
    trigger OnBeforeDelete()
    var
        EmpPos: Record "Payroll Job Pos. Worker Assign";
    begin
        EmpPos.Reset();
        EmpPos.SetRange(Worker, "No.");
        EmpPos.SetRange("Is Primary Position", true);
        if EmpPos.FindFirst() then
            Error('Primary Position already been assigned to the Employee, Cannot be deleted.');

    end;



    local procedure DeleteEarningGroupsData(ErngGrp_p: Code[20])
    var
        EarningCodeGroups: Record "Earning Code Groups";
        PayrollEarningCodeWrkr: Record "Payroll Earning Code Wrkr";
        HCMLeaveTypesWrkr: Record "HCM Leave Types Wrkr";
        HCMBenefitWrkr: Record "HCM Benefit Wrkr";
        HCMLoanTableGCCWrkr: Record "HCM Loan Table GCC Wrkr";
    begin
        EarningCodeGroups.RESET;
        EarningCodeGroups.GET(ErngGrp_p);
        PayrollEarningCodeWrkr.RESET;
        PayrollEarningCodeWrkr.SETRANGE("Earning Code", EarningCodeGroups."Earning Code Group");
    end;

    local procedure InsertEarningGroupData()
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
    begin
        //LT_Payroll_04Apr2019 >>
        EarningCodeGroups.RESET;
        EarningCodeGroups.GET("Earning Code Group");

        PayrollEarningCodeErnGrp.RESET;
        PayrollEarningCodeErnGrp.SETRANGE(PayrollEarningCodeErnGrp."Earning Code Group", Rec."Earning Code Group");
        IF PayrollEarningCodeErnGrp.FINDSET THEN
            REPEAT
                PayrollEarningCodeWrkr.RESET;
                IF NOT PayrollEarningCodeWrkr.GET("No.", PayrollEarningCodeErnGrp."Earning Code") THEN BEGIN
                    PayrollEarningCodeWrkr.INIT;
                    PayrollEarningCodeWrkr.TRANSFERFIELDS(PayrollEarningCodeErnGrp);
                    PayrollEarningCodeWrkr.Worker := Rec."No.";
                    PayrollEarningCodeWrkr."Earning Code Group" := "Earning Code Group";
                    PayrollEarningCodeWrkr.INSERT;
                END
                ELSE BEGIN
                    PayrollEarningCodeWrkr.TRANSFERFIELDS(PayrollEarningCodeErnGrp);
                    PayrollEarningCodeWrkr."Earning Code Group" := "Earning Code Group";
                    PayrollEarningCodeWrkr.Worker := Rec."No.";
                    PayrollEarningCodeWrkr.MODIFY;
                END;
            UNTIL PayrollEarningCodeErnGrp.NEXT = 0;

        HCMLeaveTypesErnGrp.RESET;
        HCMLeaveTypesErnGrp.SETRANGE(HCMLeaveTypesErnGrp."Earning Code Group", Rec."Earning Code Group");
        IF HCMLeaveTypesErnGrp.FINDSET THEN
            REPEAT
                HCMLeaveTypesWrkr.RESET;
                IF NOT HCMLeaveTypesWrkr.GET("No.", HCMLeaveTypesErnGrp."Leave Type Id") THEN BEGIN
                    HCMLeaveTypesWrkr.INIT;
                    HCMLeaveTypesWrkr.TRANSFERFIELDS(HCMLeaveTypesErnGrp);
                    HCMLeaveTypesWrkr.Worker := Rec."No.";
                    HCMLeaveTypesWrkr."Earning Code Group" := "Earning Code Group";
                    HCMLeaveTypesWrkr.INSERT;
                END
                ELSE BEGIN
                    HCMLeaveTypesWrkr.TRANSFERFIELDS(HCMLeaveTypesErnGrp);
                    HCMLeaveTypesWrkr."Earning Code Group" := "Earning Code Group";
                    HCMLeaveTypesWrkr.Worker := Rec."No.";
                    HCMLeaveTypesWrkr.MODIFY;
                END;
            UNTIL HCMLeaveTypesErnGrp.NEXT = 0;

        HCMLoanTableGCCErnGrp.RESET;
        HCMLoanTableGCCErnGrp.SETRANGE(HCMLoanTableGCCErnGrp."Earning Code for Interest", Rec."Earning Code Group");
        IF HCMLoanTableGCCErnGrp.FINDSET THEN
            REPEAT
                HCMLoanTableGCCWrkr.RESET;
                IF NOT HCMLoanTableGCCWrkr.GET("No.", HCMLoanTableGCCErnGrp."Interest Percentage") THEN BEGIN
                    HCMLoanTableGCCWrkr.INIT;
                    HCMLoanTableGCCWrkr.TRANSFERFIELDS(HCMLoanTableGCCErnGrp);
                    HCMLoanTableGCCWrkr."Earning Code Group" := Rec."No.";
                    HCMLoanTableGCCWrkr.Worker := "Earning Code Group";
                    HCMLoanTableGCCWrkr.INSERT;
                END
                ELSE BEGIN
                    HCMLoanTableGCCWrkr.TRANSFERFIELDS(HCMLoanTableGCCErnGrp);
                    HCMLoanTableGCCWrkr.Worker := "Earning Code Group";
                    HCMLoanTableGCCWrkr."Earning Code Group" := Rec."No.";
                    HCMLoanTableGCCWrkr.MODIFY;
                END;
            UNTIL HCMLoanTableGCCErnGrp.NEXT = 0;

        HCMBenefitErnGrp.RESET;
        HCMBenefitErnGrp.SETRANGE(HCMBenefitErnGrp."Earning Code Group", Rec."Earning Code Group");
        IF HCMBenefitErnGrp.FINDSET THEN
            REPEAT
                HCMBenefitWrkr.RESET;
                IF NOT HCMBenefitWrkr.GET("No.", HCMBenefitErnGrp."Benefit Id") THEN BEGIN
                    HCMBenefitWrkr.INIT;
                    HCMBenefitWrkr.TRANSFERFIELDS(HCMBenefitErnGrp);
                    HCMBenefitWrkr.Worker := Rec."No.";
                    HCMBenefitWrkr.INSERT;
                END
                ELSE BEGIN
                    HCMBenefitWrkr.TRANSFERFIELDS(HCMBenefitErnGrp);
                    HCMBenefitWrkr.Worker := Rec."No.";
                    HCMBenefitWrkr.MODIFY;
                END;
            UNTIL HCMBenefitErnGrp.NEXT = 0;
        //LT_Payroll_04Apr2019 <<
    end;

    var
        HumanResSetup: Record "Human Resources Setup";
        Employee: Record "Employee";
        Res: Record "Resource";
        PostCode: Record "Post Code";
        AlternativeAddr: Record "Alternative Address";
        EmployeeQualification: Record "Employee Qualification";
        Relative: Record "Employee Relative";
        EmployeeAbsence: Record "Employee Absence";
        MiscArticleInformation: Record "Misc. Article Information";
        ConfidentialInformation: Record "Confidential Information";
        HumanResComment: Record "Human Resource Comment Line";
        SalespersonPurchaser: Record "Salesperson/Purchaser";
        NoSeriesMgt: Codeunit "NoSeriesManagement";
        EmployeeResUpdate: Codeunit "Employee/Resource Update";
        EmployeeSalespersonUpdate: Codeunit "Employee/Salesperson Update";
        DimMgt: Codeunit DimensionManagement;
        Text000: Label 'Before you can use Online Map, you must fill in the Online Map Setup window.\See Setting Up Online Map in Help.';
        EmplTypeREc: Record "Employment Type";
        InitialsRec: Record "Initials";
        Age: Integer;
        SectorRec: Record "Sector";
        PayrollJobPosRec: Record "Payroll Job Pos. Worker Assign";
        Error001: Label 'Selected Employee cannot be deleted.';
        ////[RunOnClient]
        ////Hijiri_Date_Converter_Dll_G: DotNet Class1;
        PayrollJobPosWorkerAssign: Record "Payroll Job Pos. Worker Assign";
        CountryRegion: Record "Country/Region";

}