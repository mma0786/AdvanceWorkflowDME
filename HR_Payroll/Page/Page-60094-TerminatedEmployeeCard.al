page 60094 "Terminated Employee Card"
{
    Caption = 'Past Employee Card';
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Card;
    SourceTable = Employee;
    UsageCategory = Documents;
    //ApplicationArea = All;


    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; "No.")
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                    ToolTip = 'Specifies a number for the employee.';

                    trigger OnAssistEdit()
                    begin
                        IF AssistEdit THEN
                            CurrPage.UPDATE;
                    end;
                }
                field(Status; Status)
                {
                    ApplicationArea = All;
                    Enabled = false;
                    Importance = Promoted;
                    ToolTip = 'Specifies the employment status of the employee.';
                }
                field("Job Title"; "Job Title")
                {
                    Caption = 'Professional Title';
                    ApplicationArea = All;
                    Editable = false;
                    Importance = Promoted;
                    ToolTip = 'Specifies the employee''s job title.';
                }
                field("First Name"; "First Name")
                {
                    Importance = Promoted;
                    ToolTip = 'Specifies the employee''s first name.';
                    ApplicationArea = All;
                }
                field("Middle Name"; "Middle Name")
                {
                    Caption = 'Middle Name';
                    ToolTip = 'Specifies the employee''s middle name.';
                    ApplicationArea = All;
                }
                field("Last Name"; "Last Name")
                {
                    ToolTip = 'Specifies the employee''s last name.';
                    ApplicationArea = All;
                }
                field(Initials; Initials)
                {
                    Caption = 'Initials';
                    ToolTip = 'Specifies the employee''s initials.';
                    ApplicationArea = All;
                }
                field("Marital Status"; "Marital Status")
                {
                }
                field("Last Date Modified"; "Last Date Modified")
                {
                    Importance = Promoted;
                    ToolTip = 'Specifies the last day this entry was modified.';
                    ApplicationArea = All;
                }
                field("Joining Date"; "Joining Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Probation Period"; "Probation Period")
                {
                    ApplicationArea = All;
                }
                field(Department; Department)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Sub Department"; "Sub Department")
                {
                    Caption = 'Sub Department';
                    ApplicationArea = All;
                    Editable = false;
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
            }


            part("Address Part "; "Employee Address ListPart")
            {
                Caption = 'Address';
                SubPageLink = "Employee ID" = FIELD("No.");
            }
            part(Contacts; "Employee Contacts SubPage")
            {
                Caption = 'Contacts';
                SubPageLink = "Employee ID" = FIELD("No.");
            }

            group("Address & Contact")
            {
                field(Address; Address)
                {
                    ToolTip = 'Specifies the employee''s address.';
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Address 2"; "Address 2")
                {
                    ToolTip = 'Specifies another line of the address.';
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Post Code"; "Post Code")
                {
                    ToolTip = 'Specifies the postal code of the address.';
                    Visible = false;
                    ApplicationArea = All;
                }
                field(City; City)
                {
                    ToolTip = 'Specifies the city of the address.';
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Country/Region Code"; "Country/Region Code")
                {
                    ToolTip = 'Specifies the country/region code.';
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Phone No."; "Phone No.")
                {
                    Importance = Promoted;
                    ToolTip = 'Specifies the employee''s telephone number.';
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Search Name"; "Search Name")
                {
                    ToolTip = 'Specifies a search name for the employee.';
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Alt. Address Code"; "Alt. Address Code")
                {
                    ToolTip = 'Specifies a code for an alternate address.';
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Alt. Address Start Date"; "Alt. Address Start Date")
                {
                    ToolTip = 'Specifies the starting date when the alternate address is valid.';
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Alt. Address End Date"; "Alt. Address End Date")
                {
                    ToolTip = 'Specifies the last day when the alternate address is valid.';
                    Visible = false;
                    ApplicationArea = All;
                }
            }
            group(Communication)
            {
                Caption = 'Communication';
                Visible = false;
                field(Extension; Extension)
                {
                    Importance = Promoted;
                    ToolTip = 'Specifies the employee''s telephone extension.';
                    ApplicationArea = All;
                }
                field("Mobile Phone No."; "Mobile Phone No.")
                {
                    Importance = Promoted;
                    ToolTip = 'Specifies the employee''s mobile telephone number.';
                    ApplicationArea = All;
                }
                field(Pager; Pager)
                {
                    ToolTip = 'Specifies the employee''s pager number.';
                    ApplicationArea = All;
                }
                field("Phone No.2"; "Phone No.")
                {
                    ToolTip = 'Specifies the employee''s telephone number.';
                    ApplicationArea = All;
                }
                field("E-Mail"; "E-Mail")
                {
                    Importance = Promoted;
                    ToolTip = 'Specifies the employee''s email address.';
                    ApplicationArea = All;
                }
                field("Company E-Mail"; "Company E-Mail")
                {
                    ToolTip = 'Specifies the employee''s email address at the company.';
                    ApplicationArea = All;
                }
            }
            group(Administration)
            {
                Caption = 'Administration';
                field("Employment Date"; "Employment Date")
                {
                    Importance = Promoted;
                    ToolTip = 'Specifies the date when the employee began to work for the company.';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Employment End Date"; "Employment End Date")
                {
                    ApplicationArea = All;
                }
                field("Employment Type"; "Employment Type")
                {
                    ApplicationArea = All;
                }
                field("Inactive Date"; "Inactive Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the date when the employee became inactive, due to disability or maternity leave, for example.';
                }
                field("Cause of Inactivity Code"; "Cause of Inactivity Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies a code for the cause of inactivity by the employee.';
                }
                field("Termination Date"; "Termination Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the date when the employee was terminated, due to retirement or dismissal, for example.';
                }
                field("Seperation Reason"; "Seperation Reason")
                {
                    ApplicationArea = All;
                }
                field("Grounds for Term. Code"; "Grounds for Term. Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies a termination code for the employee who has been terminated.';
                    Visible = false;
                }
                field("Emplymt. Contract Code"; "Emplymt. Contract Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the employment contract code for the employee.';
                    Visible = false;
                }
                field("Statistics Group Code"; "Statistics Group Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies a statistics group code to assign to the employee for statistical purposes.';
                    Visible = false;
                }
                field("Resource No."; "Resource No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies a resource number for the employee, if the employee is a resource in Resources Planning.';
                    Visible = false;
                }
                field("Salespers./Purch. Code"; "Salespers./Purch. Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies a salesperson or purchaser code for the employee, if the employee is a salesperson or purchaser in the company.';
                    Visible = false;
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
                    ApplicationArea = All;
                    Editable = false;
                }
            }
            group(Personal)
            {
                Caption = 'Personal';
                field("Birth Date"; "Birth Date")
                {
                    Importance = Promoted;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the employee''s date of birth.';
                }
                field("Age As Of Date"; "Age As Of Date")
                {
                    ApplicationArea = All;
                }
                field(Religion; "Employee Religion")
                {
                    ApplicationArea = All;
                }
                field(Gender; Gender)
                {
                    ToolTip = 'Specifies the employee''s gender.';
                    ApplicationArea = All;
                }
                field(Nationality; Nationality)
                {
                }
                field("Nationality In Arabic"; "Nationality In Arabic")
                {
                    ApplicationArea = All;
                }
                field("Social Security No."; "Social Security No.")
                {
                    Importance = Promoted;
                    ToolTip = 'Specifies the Social Security number of the employee.';
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Union Code"; "Union Code")
                {
                    ToolTip = 'Specifies the employee''s labor union membership code.';
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Union Membership No."; "Union Membership No.")
                {
                    ToolTip = 'Specifies the employee''s labor union membership number.';
                    Visible = false;
                    ApplicationArea = All;
                }
            }
            group(Control5)
            {
                //commented By Avinash
                //commented By Avinash
                /*
                field("Earning Code Group"; "Earning Code Group")
                {
                    Editable = false;
                }
                field("Grade Category"; "Grade Category")
                {
                }
                */
                //commented By Avinash
                //commented By Avinash
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
            group(Contractw)//commented By Avinash
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
                    ApplicationArea = All;
                }
            }
        }
        area(factboxes)
        {
            part(Control3; "Employee Picture")
            {
                ApplicationArea = Basic, Suite;
                SubPageLink = "No." = FIELD("No.");
            }
            systempart(Control1900383207; Links)
            {
                Visible = false;
                ApplicationArea = All;
            }
            systempart(Control1905767507; Notes)
            {
                Visible = true;
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        area(navigation)
        {
            group("E&mployee")
            {
                Caption = 'E&mployee';
                Image = Employee;
                action("Co&mments")
                {
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page "Human Resource Comment Sheet";
                    RunPageLink = "Table Name" = CONST(Employee),
                                  "No." = FIELD("No.");
                }
                action(Dimensions)
                {
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    RunObject = Page "Default Dimensions";
                    RunPageLink = "Table ID" = CONST(5200),
                                  "No." = FIELD("No.");
                    ShortCutKey = 'Shift+Ctrl+D';
                    ToolTip = 'View or edit dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.';
                }
                action("&Picture")
                {
                    Caption = '&Picture';
                    Image = Picture;
                    RunObject = Page "Employee Picture";
                    RunPageLink = "No." = FIELD("No.");
                }
                action(AlternativeAddresses)
                {
                    Caption = '&Alternative Addresses';
                    Image = Addresses;
                    RunObject = Page "Alternative Address List";
                    RunPageLink = "Employee No." = FIELD("No.");
                }
                action("&Relatives")
                {
                    Caption = '&Relatives';
                    Image = Relatives;
                    RunObject = Page "Employee Relatives";
                    RunPageLink = "Employee No." = FIELD("No.");
                }
                action("Mi&sc. Article Information")
                {
                    Caption = 'Mi&sc. Article Information';
                    Image = Filed;
                    RunObject = Page "Misc. Article Information";
                    RunPageLink = "Employee No." = FIELD("No.");
                }
                action("&Confidential Information")
                {
                    Caption = '&Confidential Information';
                    Image = Lock;
                    RunObject = Page "Confidential Information";
                    RunPageLink = "Employee No." = FIELD("No.");
                }
                action("Q&ualifications")
                {
                    Caption = 'Q&ualifications';
                    Image = Certificate;
                    RunObject = Page "Employee Qualifications";
                    RunPageLink = "Employee No." = FIELD("No.");
                }
                action("A&bsences")
                {
                    Caption = 'A&bsences';
                    Image = Absence;
                    RunObject = Page "Employee Absences";
                    RunPageLink = "Employee No." = FIELD("No.");
                }
                separator(Separator23)
                {
                }
                action("Absences by Ca&tegories")
                {
                    Caption = 'Absences by Ca&tegories';
                    Image = AbsenceCategory;
                    RunObject = Page "Empl. Absences by Categories";
                    RunPageLink = "No." = FIELD("No."),
                                  "Employee No. Filter" = FIELD("No.");
                }
                action("Misc. Articles &Overview")
                {
                    Caption = 'Misc. Articles &Overview';
                    Image = FiledOverview;
                    RunObject = Page "Misc. Articles Overview";
                }
                action("Co&nfidential Info. Overview")
                {
                    Caption = 'Co&nfidential Info. Overview';
                    Image = ConfidentialOverview;
                    RunObject = Page "Confidential Info. Overview";
                }
                separator(Separator61)
                {
                }
                action("Online Map")
                {
                    Caption = 'Online Map';
                    Image = Map;

                    trigger OnAction();
                    begin
                        DisplayMap;
                    end;
                }
                // // // action(Insurance)
                // // // {
                // // //     Caption = 'Insurance';
                // // //     Image = BankAccount;
                // // //     Promoted = true;
                // // //     PromotedCategory = Process;
                // // //     PromotedIsBig = true;
                // // //     RunObject = Page Page50056;
                // // //     RunPageLink = Field1 = FIELD("No.");
                // // //     RunPageView = SORTING(Field1);
                // // //     Scope = Repeater;
                // // // }
                // // // action("New Insurance")
                // // // {
                // // //     Caption = 'New Insurance';
                // // //     Image = BankAccount;
                // // //     Promoted = true;
                // // //     PromotedCategory = Process;
                // // //     PromotedIsBig = true;
                // // //     RunObject = Page Page50057;
                // // //     RunPageLink = Field1 = FIELD("No.");
                // // // }
            }
        }
        area(processing)
        {
            //Caption = 'Advance Payroll';
            Description = 'Advance Payroll';
            action("Earning Code")
            {
                Image = Production;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction();
                begin
                    EmployeeEarningCodeGroup.RESET;
                    EmployeeEarningCodeGroup.SETRANGE("Employee Code", "No.");
                    EmployeeEarningCodeGroup.SETFILTER("Valid From", '<=%1', WORKDATE);
                    EmployeeEarningCodeGroup.SETFILTER("Valid To", '>%1|%2', WORKDATE, 0D);
                    if EmployeeEarningCodeGroup.FINDFIRST then;
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
                Image = Holiday;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction();
                begin
                    EmployeeEarningCodeGroup.RESET;
                    EmployeeEarningCodeGroup.SETRANGE("Employee Code", "No.");
                    EmployeeEarningCodeGroup.SETFILTER("Valid From", '<=%1', WORKDATE);
                    EmployeeEarningCodeGroup.SETFILTER("Valid To", '>%1|%2', WORKDATE, 0D);
                    if EmployeeEarningCodeGroup.FINDFIRST then;
                    HCMLeaveTypesWrkr.RESET;
                    HCMLeaveTypesWrkr.FILTERGROUP(2);
                    HCMLeaveTypesWrkr.SETRANGE(Worker, "No.");
                    HCMLeaveTypesWrkr.SETRANGE("Earning Code Group", EmployeeEarningCodeGroup."Earning Code Group");
                    HCMLeaveTypesWrkr.FILTERGROUP(0);
                    PAGE.RUNMODAL(60039, HCMLeaveTypesWrkr);
                end;
            }
            action(Benefit)
            {
                Image = CalculateLines;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction();
                begin
                    EmployeeEarningCodeGroup.RESET;
                    EmployeeEarningCodeGroup.SETRANGE("Employee Code", "No.");
                    EmployeeEarningCodeGroup.SETFILTER("Valid From", '<=%1', WORKDATE);
                    EmployeeEarningCodeGroup.SETFILTER("Valid To", '>%1|%2', WORKDATE, 0D);
                    if EmployeeEarningCodeGroup.FINDFIRST then;
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

                trigger OnAction();
                begin
                    EmployeeEarningCodeGroup.RESET;
                    EmployeeEarningCodeGroup.SETRANGE("Employee Code", "No.");
                    EmployeeEarningCodeGroup.SETFILTER("Valid From", '<=%1', WORKDATE);
                    EmployeeEarningCodeGroup.SETFILTER("Valid To", '>%1|%2', WORKDATE, 0D);
                    if EmployeeEarningCodeGroup.FINDFIRST then;

                    HCMLoanTableGCCWrkr.RESET;
                    //HCMLoanTableGCCWrkr.FILTERGROUP(2);
                    HCMLoanTableGCCWrkr.SETRANGE(Worker, "No.");
                    HCMLoanTableGCCWrkr.SETRANGE("Earning Code Group", EmployeeEarningCodeGroup."Earning Code Group");
                    //HCMLoanTableGCCWrkr.FILTERGROUP(0);
                    PAGE.RUNMODAL(60045, HCMLoanTableGCCWrkr);
                end;
            }
            action("Earning Code Group")
            {
                Image = PaymentJournal;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Employee Earning Code Groups";
                RunPageLink = "Earning Code Group" = FIELD("Earning Code Group"), "Employee Code" = field("No.");

            }
            action("Accrual Components")
            {
                Caption = 'Accrual Components';
                Image = Agreement;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Accrual Components Workers-2";
                RunPageLink = "Worker ID" = FIELD("No.");
            }
            action("Employee Position Assignment")
            {
                Image = Position;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Employee Position Assignments";
                RunPageLink = Worker = FIELD("No.");
            }
            action("Employee Work Date")
            {
                Image = Workdays;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Employee Position Assignments";
                RunPageLink = Worker = FIELD("No.");
                RunPageMode = View;
                Scope = Repeater;
            }
            action("Employee Dependents")
            {
                Image = Delegate;
                Promoted = true;
                PromotedIsBig = true;
                RunObject = Page "Employee Dependent List";
                RunPageLink = "Employee ID" = FIELD("No.");

                trigger OnAction();
                begin


                end;
            }
            action("Employee Identification")
            {
                Image = Document;
                Promoted = true;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                PromotedCategory = Process;
                //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                PromotedIsBig = true;
                RunObject = Page "Employee Identification_MS-1";
                RunPageLink = "Employee No." = FIELD("No."), "No." = FILTER(<> '');
            }
            action("Asset Assignment Register")
            {
                Image = FixedAssets;
                Promoted = true;
                //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                PromotedIsBig = true;
                RunObject = Page "Asset Assignment Register List";
                RunPageLink = "Issue to/Return by" = FIELD("No."),
                              Posted = FILTER(true);
            }


            action("Employee Bank Details")
            {
                Caption = 'Employee Bank Details';
                Image = BankAccount;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Employee Bank Account List";
                RunPageLink = "Employee Id" = FIELD("No.");
            }

            action("Employee Termination")
            {
                Image = TerminationDescription;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction();
                begin
                    CLEAR(EmployeeTermination);
                    EmployeeTermination.SetValues("No.");
                    EmployeeTermination.RUNMODAL;
                    CurrPage.UPDATE;
                end;
            }
        }
    }

    trigger OnAfterGetCurrRecord();
    begin
        //LT_05052019 >>
        //Find Active Earning Code Group
        EmplErngCodegrp.RESET;
        EmplErngCodegrp.SETCURRENTKEY("Employee Code", "Valid From", "Valid To");
        EmplErngCodegrp.SETRANGE("Employee Code", "No.");
        EmplErngCodegrp.SETFILTER("Valid From", '<=%1', WORKDATE);
        EmplErngCodegrp.SETFILTER("Valid To", '>=%1|%2', WORKDATE, 0D);
        if EmplErngCodegrp.FINDFIRST then
            "Earning Code Group" := EmplErngCodegrp."Earning Code Group";
        //LT_05052019 <<

        CLEAR("Age As Of Date");
        CLEAR(Age);
        if "Birth Date" <> 0D then begin
            Age := -("Birth Date" - TODAY);
            if Age <> 0 then
                "Age As Of Date" := FORMAT(ROUND((Age / 365.27), 0.1));
        end;
    end;

    trigger OnAfterGetRecord();
    begin
        CLEAR("Age As Of Date");
        CLEAR(Age);
        if "Birth Date" <> 0D then begin
            Age := -("Birth Date" - TODAY);
            if Age <> 0 then
                "Age As Of Date" := FORMAT(ROUND((Age / 365.27), 0.1));
        end;
    end;



    var
        EmplErngCodegrp: Record "Employee Earning Code Groups";
        PayrollEarningCodeWrkr: Record "Payroll Earning Code Wrkr";
        HCMLeaveTypesWrkr: Record "HCM Leave Types Wrkr";
        HCMBenefitWrkr: Record "HCM Benefit Wrkr";
        HCMLoanTableGCCWrkr: Record "HCM Loan Table GCC Wrkr";
        EmpDepMasterRec: Record "Employee Dependents Master";
        EmployeeRec2: Record Employee;
        EmployeeDependentPage: Page "Employee Dependent List";
        EmployeeEarningCodeGroup: Record "Employee Earning Code Groups";

        Age: Decimal;
        EmployeeTermination: Report "Employee Termination";
}


