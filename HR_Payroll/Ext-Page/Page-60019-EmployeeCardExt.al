pageextension 60019 EmployeeCardExt extends "Employee Card"
{
    layout
    {
        // Add changes to page layout here
        addlast(General)
        {
            field("Professional Title in Arabic"; "Professional Title in Arabic")
            {
                ApplicationArea = All;
            }
            field("Personal   Title in Arabic"; "Personal   Title in Arabic")
            {
                Caption = 'Personal  Title in Arabic';
                ApplicationArea = All;
            }
            field("Employee Name in Arabic"; "Employee Name in Arabic")
            {
                ApplicationArea = All;
            }
            field("Marital Status"; "Marital Status")
            {
                ShowMandatory = true;
                ApplicationArea = All;
            }

            field("Joining Date"; "Joining Date")
            {
                Editable = EditAssignPosition;
                ShowMandatory = true;
                ApplicationArea = All;

            }
            field("Joining Date - Hijiri"; "D.O.J Hijiri")
            {
                ApplicationArea = All;
                Visible = false;
            }
            field("Probation Period"; "Probation Period")
            {
                ApplicationArea = All;
            }
            field(Department; Department)
            {
                Editable = false;
            }
            field("Sub Department"; "Sub Department")
            {
                Caption = 'Sub Department';
                Editable = false;
                ApplicationArea = All;
            }
            field("Line manager"; "Line manager")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field(HOD; HOD)
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("Blood Group"; "Blood Group")
            {
                ApplicationArea = All;
            }

        }
        addafter(General)
        {
            part("Address Part "; "Employee Address ListPart")
            {
                Caption = 'Address';
                ApplicationArea = All;
                SubPageLink = "Employee ID" = FIELD("No."), "Table Type Option" = FILTER("Employee Address Line");
            }
            part(Contacts; "Employee Contacts SubPage")
            {
                Caption = 'Contacts';
                ApplicationArea = All;
                SubPageLink = "Employee ID" = FIELD("No."), "Table Type Option" = FILTER("Employee Contacts Line");
            }
        }

        addlast(Administration)
        {
            field("Employment Start Date"; "Employment Date")
            {
                Caption = 'Employment Start Date';
                Importance = Promoted;
                ToolTip = 'Specifies the date when the employee began to work for the company.';
                Visible = false;
                ApplicationArea = All;
            }
            field("Employment End Date"; "Employment End Date")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("Employment Type"; "Employment Type")
            {
                ApplicationArea = All;
            }
            field("Seperation Reason"; "Seperation Reason")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("Unsatisfactory Grade"; "Unsatisfactory Grade")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field(Region; Region)
            {
                ApplicationArea = All;
            }
            field("Work Location"; "Work Location")
            {
                ApplicationArea = All;
            }
            field("Position Name In Arabic"; "Position Name In Arabic")
            {
                ApplicationArea = All;
            }
            field("Job Title as per Iqama"; "Job Title as per Iqama")
            {
                ApplicationArea = All;

            }
            field("Sector ID"; "Sector ID")
            {
                ApplicationArea = All;
            }
            field("Sector Name"; "Sector Name")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("Old Employee ID"; "Old Employee ID")
            {
                ApplicationArea = All;
            }
            field(Type; Type)
            {
                Visible = false;
                ApplicationArea = All;
            }
            field(Remarks; Remarks)
            {
                Visible = false;
                ApplicationArea = All;
            }

        }
        addlast(Personal)
        {
            field("Birth Date - Hijiri"; "B.O.D Hijiri")
            {
                ApplicationArea = All;
                Visible = false;
            }
            field("Age As Of Date"; "Age As Of Date")
            {
                Editable = false;
            }
            field(Religion; "Employee Religion")
            {
                ShowMandatory = true;
            }
            field(Nationality; Nationality)
            {
                ApplicationArea = All;
                ShowMandatory = true;
            }
            field("Nationality In Arabic"; "Nationality In Arabic")
            {
                ApplicationArea = All;
            }
        }
        addafter(Personal)
        {
            group("Employee Grade Details")
            {
                Caption = 'Employee Grade Details';
                field("Grade Category"; "Grade Category")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Increment step"; "Increment step")
                {
                    ApplicationArea = All;
                }
            }
            group(Identification)
            {
                Visible = false;
                field("Identification Type"; "Identification Type")
                {
                    ApplicationArea = All;
                }
                field("Identification No."; "Identification No.")
                {
                    ApplicationArea = All;
                }
                field("Issue Date"; "Issue Date")
                {
                    ApplicationArea = All;
                }
                field("Expiry Date"; "Expiry Date")
                {
                    ApplicationArea = All;
                }
                field("Issuing Country"; "Issuing Country")
                {
                    ApplicationArea = All;
                }
            }
            group(Contract_)
            {
                Caption = 'Contract';
                field("Contract No"; "Contract No")
                {
                    ApplicationArea = All;
                }
                field("Contract Version No."; "Contract Version No.")
                {
                    ApplicationArea = All;
                }
                field("Registry Reference No."; "Registry Reference No.")
                {
                    Visible = false;
                }
            }
        }
        modify("Address & Contact")
        {
            Visible = false;
        }
        modify("Job Title")
        {
            Editable = false;
        }
        modify("Employment Date")
        {
            ShowMandatory = true;
        }
        modify(Gender)
        {
            ShowMandatory = true;
        }
        modify("Birth Date")
        {
            ShowMandatory = true;
        }



    }

    actions
    {
        // Add changes to page actions here
        addafter("E&mployee")
        {
            group(processing)
            {
                Description = 'Advance Payroll';
                group("Other Actions")
                {
                    Caption = 'Other Actions';
                    Image = LotInfo;
                    action("Accrual Components")
                    {
                        Caption = 'Accrual Components';
                        Image = Agreement;
                        ApplicationArea = All;
                        Promoted = true;
                        PromotedCategory = Process;
                        RunObject = Page "Accrual Components Workers-2";
                        RunPageLink = "Worker ID" = FIELD("No.");
                    }
                    action(Contract)
                    {
                        /*
                        Employee Contracts is not a part of BC HR & Payroll upgrade
                        */
                        Caption = 'Employee Contracts';
                        Image = Certificate;
                        Visible = false;
                        ApplicationArea = All;
                        Promoted = true;
                        PromotedIsBig = true;
                        PromotedCategory = Process;
                        // RunObject = Page "Employee Contacts Line";
                        //RunPageLink = Field3 = FIELD(No.);
                    }
                    action("Asset Assignment Register")
                    {
                        Caption = 'Asset Register';
                        Gesture = LeftSwipe;
                        Image = FixedAssets;
                        ApplicationArea = All;
                        Promoted = true;
                        PromotedCategory = Process;
                        PromotedIsBig = true;
                        RunObject = Page "Asset Assignment Register_List";
                        RunPageLink = "Issue to/Return by" = FIELD("No."), Posted = FILTER(true);
                    }
                    action("Employee Termination")
                    {
                        Caption = 'Employee Separation';
                        Image = Absence;
                        ApplicationArea = All;
                        Promoted = true;
                        PromotedCategory = Process;
                        PromotedIsBig = true;

                        trigger OnAction()
                        begin
                            CLEAR(EmployeeTermination);
                            EmployeeTermination.SetValues("No.");
                            EmployeeTermination.RUNMODAL;
                            CurrPage.UPDATE;
                        end;
                    }
                    action("Employee Education")
                    {
                        Image = EmployeeAgreement;
                        ApplicationArea = All;
                        Promoted = true;
                        PromotedCategory = Process;
                        RunObject = Page "Employee Education List";
                        RunPageLink = "Emp ID" = FIELD("No.");
                    }
                    action("Employee Skills")
                    {
                        Image = Skills;
                        Promoted = true;
                        ApplicationArea = All;
                        PromotedCategory = Process;
                        RunObject = Page "Employee Skills List";
                        RunPageLink = "Emp ID" = FIELD("No.");
                    }
                    action("Employee Certificate")
                    {
                        Image = Certificate;
                        ApplicationArea = All;
                        Promoted = true;
                        PromotedCategory = Process;
                        RunObject = Page "Employee Certificates List";
                        RunPageLink = "Emp ID" = FIELD("No.");
                    }
                    action("Employee Professional Exp.")
                    {
                        Image = EmployeeAgreement;
                        ApplicationArea = All;
                        Promoted = true;
                        PromotedCategory = Process;
                        RunObject = Page "Employee Prof. Exp. List";
                        RunPageLink = "Emp No." = FIELD("No.");
                        ToolTip = 'Employee Professional Exprience of Last Employer';
                    }

                    // Avinash 05.05.2020
                    action("Attachment")
                    {
                        ApplicationArea = All;
                        Image = Attachments;
                        Promoted = true;
                        Caption = 'Attachment';
                        //PromotedCategory = Category8;
                        ToolTip = 'Add a file as an attachment. You can attach images as well as documents.';
                        trigger
                        OnAction()
                        var
                            DocumentAttachmentDetails: Page "Document Attachment Details";
                            RecRef: RecordRef;
                        begin
                            RecRef.GETTABLE(Rec);
                            DocumentAttachmentDetails.OpenForRecRef(RecRef);
                            DocumentAttachmentDetails.RUNMODAL;
                        end;
                    }
                    // Avinash 05.05.2020
                }
                group("Home Actions")
                {
                    Caption = 'Home Actions';
                    action("Earning Code Group")
                    {
                        Image = PaymentJournal;
                        Promoted = true;
                        PromotedCategory = Process;
                        PromotedIsBig = true;
                        ApplicationArea = All;
                        RunObject = Page "Employee Earning Code Groups";
                        RunPageLink = "Earning Code Group" = FIELD("Earning Code Group"), "Employee Code" = field("No.");
                    }
                    action("Earning Code")
                    {
                        Caption = 'Earning Codes';
                        Image = Production;
                        Promoted = true;
                        PromotedCategory = Process;
                        PromotedIsBig = true;
                        ApplicationArea = All;
                        trigger OnAction()
                        begin
                            EmployeeEarningCodeGroup.RESET;
                            EmployeeEarningCodeGroup.SETRANGE("Employee Code", "No.");
                            EmployeeEarningCodeGroup.SETFILTER("Valid From", '<=%1', WORKDATE);
                            EmployeeEarningCodeGroup.SETFILTER("Valid To", '>%1|%2', WORKDATE, 0D);
                            IF EmployeeEarningCodeGroup.FINDFIRST THEN;
                            PayrollEarningCodeWrkr.RESET;
                            PayrollEarningCodeWrkr.FILTERGROUP(2);
                            PayrollEarningCodeWrkr.SETRANGE(Worker, "No.");
                            PayrollEarningCodeWrkr.SETRANGE("Earning Code Group", EmployeeEarningCodeGroup."Earning Code Group");
                            PayrollEarningCodeWrkr.FILTERGROUP(0);
                            PAGE.RUNMODAL(60041, PayrollEarningCodeWrkr);
                        end;
                    }
                    action("Leave Type")
                    {
                        Caption = 'Leaves';
                        Image = Holiday;
                        Promoted = true;
                        PromotedCategory = Process;
                        PromotedIsBig = true;
                        ApplicationArea = All;
                        trigger OnAction()
                        begin
                            EmployeeEarningCodeGroup.RESET;
                            EmployeeEarningCodeGroup.SETRANGE("Employee Code", "No.");
                            EmployeeEarningCodeGroup.SETFILTER("Valid From", '<=%1', WORKDATE);
                            EmployeeEarningCodeGroup.SETFILTER("Valid To", '>%1|%2', WORKDATE, 0D);
                            IF EmployeeEarningCodeGroup.FINDFIRST THEN;
                            //Message('before No -----  %1   ECG ---- %2', "No.", "Earning Code Group");
                            HCMLeaveTypesWrkr.RESET;
                            HCMLeaveTypesWrkr.FILTERGROUP(2);
                            HCMLeaveTypesWrkr.SETRANGE(Worker, "No.");
                            HCMLeaveTypesWrkr.SETRANGE("Earning Code Group", EmployeeEarningCodeGroup."Earning Code Group");
                            HCMLeaveTypesWrkr.FILTERGROUP(0);
                            if HCMLeaveTypesWrkr.FindSet() then begin
                                // Message('after No -----  %1   ECG ---- %2', "No.", "Earning Code Group");
                                PAGE.RUNMODAL(60039, HCMLeaveTypesWrkr);
                            end;
                        end;
                    }
                    action(Benefit)
                    {
                        Caption = 'Benefits';
                        Image = CalculateLines;
                        Promoted = true;
                        PromotedCategory = Process;
                        PromotedIsBig = true;
                        ApplicationArea = All;
                        trigger OnAction()
                        begin
                            EmployeeEarningCodeGroup.RESET;
                            EmployeeEarningCodeGroup.SETRANGE("Employee Code", "No.");
                            EmployeeEarningCodeGroup.SETFILTER("Valid From", '<=%1', WORKDATE);
                            EmployeeEarningCodeGroup.SETFILTER("Valid To", '>%1|%2', WORKDATE, 0D);
                            IF EmployeeEarningCodeGroup.FINDFIRST THEN;
                            HCMBenefitWrkr.RESET;
                            HCMBenefitWrkr.FILTERGROUP(2);
                            HCMBenefitWrkr.SETRANGE(Worker, "No.");
                            HCMBenefitWrkr.SETRANGE("Earning Code Group", EmployeeEarningCodeGroup."Earning Code Group");
                            HCMBenefitWrkr.FILTERGROUP(0);
                            PAGE.RUNMODAL(60043, HCMBenefitWrkr);
                        end;
                    }
                    action(Loans)
                    {
                        Image = Loaner;
                        Promoted = true;
                        PromotedCategory = Process;
                        PromotedIsBig = true;
                        ApplicationArea = All;
                        trigger OnAction()
                        begin
                            EmployeeEarningCodeGroup.RESET;
                            EmployeeEarningCodeGroup.SETRANGE("Employee Code", "No.");
                            EmployeeEarningCodeGroup.SETFILTER("Valid From", '<=%1', WORKDATE);
                            EmployeeEarningCodeGroup.SETFILTER("Valid To", '>%1|%2', WORKDATE, 0D);
                            IF EmployeeEarningCodeGroup.FINDFIRST THEN;

                            HCMLoanTableGCCWrkr.RESET;
                            HCMLoanTableGCCWrkr.FILTERGROUP(2);
                            HCMLoanTableGCCWrkr.SETRANGE(Worker, "No.");
                            HCMLoanTableGCCWrkr.SETRANGE("Earning Code Group", EmployeeEarningCodeGroup."Earning Code Group");
                            HCMLoanTableGCCWrkr.FILTERGROUP(0);
                            PAGE.RUNMODAL(60045, HCMLoanTableGCCWrkr);
                        end;
                    }
                    action("Employee Position Assignment")
                    {
                        Caption = 'Position Assignment';
                        Image = Position;
                        Promoted = true;
                        PromotedCategory = Process;
                        PromotedIsBig = true;
                        ApplicationArea = All;
                        RunObject = Page "Employee Position Assignments";
                        RunPageLink = Worker = FIELD("No.");
                    }
                    action("Employee Work Date")
                    {
                        Caption = 'Work Calendar';
                        Image = Workdays;
                        Promoted = true;
                        PromotedCategory = Process;
                        PromotedIsBig = true;
                        ApplicationArea = All;
                        RunObject = Page "Employee Work Dates";
                        RunPageLink = "Employee Code" = FIELD("No.");
                        RunPageMode = View;
                        Scope = Repeater;
                    }
                    action("Employee Dependents")
                    {
                        Caption = 'Dependents';
                        Image = Relatives;
                        Promoted = true;
                        PromotedCategory = Process;
                        PromotedIsBig = true;
                        ApplicationArea = All;
                        RunObject = Page "Employee Dependent List";
                        RunPageLink = "Employee ID" = FIELD("No.");


                    }
                    action("Employee Identification")
                    {
                        Caption = 'Identifications';
                        Image = ContactPerson;
                        Promoted = true;
                        PromotedCategory = Process;
                        PromotedIsBig = true;
                        ApplicationArea = All;
                        RunObject = Page "Employee Identification_MS-1";
                        RunPageLink = "Employee No." = FIELD("No."), "No." = FILTER(<> '');
                    }
                    action("Employee Bank Details")
                    {
                        Caption = 'Bank Details';
                        Image = Bank;
                        Promoted = true;
                        PromotedCategory = Process;
                        PromotedIsBig = true;
                        ApplicationArea = All;
                        RunObject = Page "Employee Bank Account List";
                        RunPageLink = "Employee Id" = FIELD("No.");
                    }
                    Action(Test_Short_Leave)
                    {
                        Caption = 'SL_lEAVE';
                        Image = Holiday;
                        Promoted = true;
                        PromotedOnly = true;
                        Visible = false; // Avinash 14.04.2020
                        RunObject = Page "Short Leave Request List";
                        ApplicationArea = ALL;

                    }
                    action(Insurance)
                    {
                        Caption = 'Insurance';
                        Image = TotalValueInsured;
                        Promoted = true;
                        PromotedCategory = Process;
                        PromotedIsBig = true;
                        ApplicationArea = All;
                        RunObject = Page "Employee Insurance List";
                        RunPageLink = "Employee Id" = FIELD("No.");
                    }
                    action("Employee Delegation")
                    {
                        Caption = 'Delegate Workflow';
                        Image = ChangeCustomer;
                        Promoted = true;
                        PromotedCategory = Process;
                        PromotedIsBig = true;
                        ApplicationArea = All;
                        Visible = true;
                        RunObject = Page "Employee Delegation List";
                        RunPageLink = "Employee Code" = FIELD("No.");

                        trigger OnAction()
                        begin
                            /*
                            ApprovalLevelSetupRec_G.RESET;
                            ApprovalLevelSetupRec_G.GET;

                            DelegateWFLTRec_G.RESET;
                            DelegateWFLTRec_G.INIT;
                            DelegateWFLTRec_G.VALIDATE("Delegate No.",NoSeriesManagement.GetNextNo(ApprovalLevelSetupRec_G
                            DelegateWFLTRec_G.VALIDATE("Employee Code","No.");
                            //UserSetupRec_G.RESET;
                            //UserSetupRec_G.SETRANGE("Employee Id","No.");
                            //IF NOT UserSetupRec_G.FINDFIRST THEN
                              //UserSetupRec_G.TESTFIELD("Employee Id");

                            //DelegateWFLTRec_G.VALIDATE("Employee ID",UserSetupRec_G."User ID");
                            IF DelegateWFLTRec_G.INSERT THEN BEGIN
                              COMMIT;
                              PAGE.RUNMODAL(50601,DelegateWFLTRec_G);
                            END
                            ELSE BEGIN
                            DelegateWFLTRec_G.RESET;
                            DelegateWFLTRec_G.SETRANGE("Employee Code","No.");
                            IF DelegateWFLTRec_G.FINDFIRST THEN
                              COMMIT;
                              PAGE.RUNMODAL(50601,DelegateWFLTRec_G);
                            END;
                            */

                        end;
                    }
                    action("Contract List")
                    {
                        Caption = 'Employee Contracts List';
                        Image = ListPage;
                        ApplicationArea = All;
                        //RunObject = Page 50029;
                        //RunPageLink = Field7 = FIELD(No.);
                        Visible = false;
                    }
                }
            }
        }

    }

    trigger OnAfterGetRecord()
    var
        myInt: Integer;
    begin
        //LT_05052019 >>
        //Find Active Earning Code Group
        EmplErngCodegrp.RESET;
        EmplErngCodegrp.SETCURRENTKEY("Employee Code", "Valid From", "Valid To");
        EmplErngCodegrp.SETRANGE("Employee Code", "No.");
        EmplErngCodegrp.SETFILTER("Valid From", '<=%1', WORKDATE);
        EmplErngCodegrp.SETFILTER("Valid To", '>=%1|%2', WORKDATE, 0D);
        IF EmplErngCodegrp.FINDFIRST THEN BEGIN
            "Earning Code Group" := EmplErngCodegrp."Earning Code Group";
            MODIFY;
            COMMIT;
        END;
        //LT_05052019 <<
        // Start 07.05.2020 @Avinash
        CLEAR("Age As Of Date");
        CLEAR(Age);
        IF "Birth Date" <> 0D THEN BEGIN
            Age := -("Birth Date" - TODAY);
            IF Age <> 0 THEN
                "Age As Of Date" := FORMAT(ROUND((Age / 365.27), 0.1));
        END;
        // Stop 07.05.2020 @Avinash
    end;

    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        CLEAR(EditAssignPosition);
        PayrollJobPosWorkerAssign.RESET;
        PayrollJobPosWorkerAssign.SETRANGE(Worker, "No.");
        PayrollJobPosWorkerAssign.SETRANGE("Position Assigned", TRUE);
        IF PayrollJobPosWorkerAssign.FINDFIRST THEN
            EditAssignPosition := FALSE
        ELSE
            EditAssignPosition := TRUE;
    end;

    local procedure CheckMand()
    begin
        TESTFIELD("Marital Status");
        IF Gender = Gender::" " THEN
            ERROR('Please select Gender');
        TESTFIELD("Birth Date");
        TESTFIELD("Employee Religion");
        //
        TestField("Joining Date");
        TestField("Employee Religion");
        TestField(Nationality);
    end;

    trigger OnClosePage()
    begin
        //To check mandatory fields while closing it
        CheckMand();
    end;

    var
        EmplErngCodegrp: Record "Employee Earning Code Groups";
        PayrollEarningCodeWrkr: Record "Payroll Earning Code Wrkr";
        HCMLeaveTypesWrkr: Record "HCM Leave Types Wrkr";
        HCMBenefitWrkr: Record "HCM Benefit Wrkr";
        HCMLoanTableGCCWrkr: Record "HCM Loan Table GCC Wrkr";
        EmpDepMasterRec: Record "Employee Dependents Master";
        EmployeeRec2: Record Employee;
        EmployeeDependentPage: Page "HCM Benefit Wrkr";
        EmployeeEarningCodeGroup: Record "Employee Earning Code Groups";
        AssetAssigntReg: Record "Asset Assignment Register";
        Age: Decimal;
        EmployeeTermination: Report "Employee Termination";
        DelegateWFLTRec_G: Record "Delegate - WFLT";
        UserSetupRec_G: Record "User Setup";

        PayrollJobPosWorkerAssign: Record "Payroll Job Pos. Worker Assign";
        EditAssignPosition: Boolean;
}