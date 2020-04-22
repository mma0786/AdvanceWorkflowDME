page 60108 "Terminated Employee Card1"
{
    Caption = 'Past Employee Card';
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Card;
    SourceTable = Employee;
    UsageCategory = Documents;
    // ApplicationArea = All;


    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; "No.")
                {
                    Importance = Promoted;
                    ToolTip = 'Specifies a number for the employee.';
                    ApplicationArea = All;

                    trigger OnAssistEdit()
                    begin
                        //commented By Avinash
                        if AssistEdit then
                            CurrPage.UPDATE;
                        //commented By Avinash
                    end;
                }
                field(Status; Status)
                {
                    Enabled = false;
                    Importance = Promoted;
                    ToolTip = 'Specifies the employment status of the employee.';
                    ApplicationArea = All;
                }
                field("Job Title"; "Job Title")
                {
                    Caption = 'Professional Title';
                    Editable = false;
                    Importance = Promoted;
                    ToolTip = 'Specifies the employee''s job title.';
                    ApplicationArea = All;
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
                    ApplicationArea = All;
                }
                field("Last Date Modified"; "Last Date Modified")
                {
                    Importance = Promoted;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the last day this entry was modified.';
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
            //commented By Avinash
            // part("Address Part "; "Employee Address ListPart")
            // {
            //     Caption = 'Address';
            //     SubPageLink = Field1 = FIELD("No.");
            // }
            // part(Contacts; "Employee Contacts SubPage")
            // {
            //     Caption = 'Contacts';
            //     SubPageLink = Field1 = FIELD("No.");
            // }
            //commented By Avinash
            group("Address & Contact")
            {
                field(Address; Address)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the employee''s address.';
                    Visible = false;
                }
                field("Address 2"; "Address 2")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies another line of the address.';
                    Visible = false;
                }
                field("Post Code"; "Post Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the postal code of the address.';
                    Visible = false;
                }
                field(City; City)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the city of the address.';
                    Visible = false;
                }
                field("Country/Region Code"; "Country/Region Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the country/region code.';
                    Visible = false;
                }
                field("Phone No."; "Phone No.")
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                    ToolTip = 'Specifies the employee''s telephone number.';
                    Visible = false;
                }
                field("Search Name"; "Search Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies a search name for the employee.';
                    Visible = false;
                }
                field("Alt. Address Code"; "Alt. Address Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies a code for an alternate address.';
                    Visible = false;
                }
                field("Alt. Address Start Date"; "Alt. Address Start Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the starting date when the alternate address is valid.';
                    Visible = false;
                }
                field("Alt. Address End Date"; "Alt. Address End Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the last day when the alternate address is valid.';
                    Visible = false;
                }
            }
            group(Communication)
            {
                Caption = 'Communication';
                Visible = false;
                field(Extension; Extension)
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                    ToolTip = 'Specifies the employee''s telephone extension.';
                }
                field("Mobile Phone No."; "Mobile Phone No.")
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                    ToolTip = 'Specifies the employee''s mobile telephone number.';
                }
                field(Pager; Pager)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the employee''s pager number.';
                }
                field("Phone No.2"; "Phone No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the employee''s telephone number.';
                }
                field("E-Mail"; "E-Mail")
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                    ToolTip = 'Specifies the employee''s email address.';
                }
                field("Company E-Mail"; "Company E-Mail")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the employee''s email address at the company.';
                }
            }
            group(Administration)
            {
                Caption = 'Administration';
                field("Employment Date"; "Employment Date")
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                    ToolTip = 'Specifies the date when the employee began to work for the company.';
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
                    ApplicationArea = All;
                    Importance = Promoted;
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
                    ApplicationArea = All;
                    ToolTip = 'Specifies the employee''s gender.';
                }
                field(Nationality; Nationality)
                {
                    ApplicationArea = All;
                }
                field("Nationality In Arabic"; "Nationality In Arabic")
                {
                    ApplicationArea = All;
                }
                field("Social Security No."; "Social Security No.")
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                    ToolTip = 'Specifies the Social Security number of the employee.';
                    Visible = false;
                }
                field("Union Code"; "Union Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the employee''s labor union membership code.';
                    Visible = false;
                }
                field("Union Membership No."; "Union Membership No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the employee''s labor union membership number.';
                    Visible = false;
                }
            }
            group(Control5)
            {
                //commented By Avinash
                // field("Earning Code Group"; "Earning Code Group")
                // {
                //     Editable = false;
                // }
                //commented By Avinash
                field("Grade Category"; "Grade Category")
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
            group(Contracts)//commented By Avinash
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
                ApplicationArea = All;
                Visible = false;
            }
            systempart(Control1905767507; Notes)
            {
                ApplicationArea = All;
                Visible = true;
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
                    ApplicationArea = All;
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
                    ApplicationArea = All;
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
                    ApplicationArea = All;
                    RunPageLink = "No." = FIELD("No.");
                }
                action(AlternativeAddresses)
                {
                    Caption = '&Alternative Addresses';
                    ApplicationArea = All;
                    Image = Addresses;
                    RunObject = Page "Alternative Address List";
                    RunPageLink = "Employee No." = FIELD("No.");
                }
                action("&Relatives")
                {
                    Caption = '&Relatives';
                    ApplicationArea = All;
                    Image = Relatives;
                    RunObject = Page "Employee Relatives";
                    RunPageLink = "Employee No." = FIELD("No.");
                }
                action("Mi&sc. Article Information")
                {
                    Caption = 'Mi&sc. Article Information';
                    ApplicationArea = All;
                    Image = Filed;
                    RunObject = Page "Misc. Article Information";
                    RunPageLink = "Employee No." = FIELD("No.");
                }
                action("&Confidential Information")
                {
                    Caption = '&Confidential Information';
                    ApplicationArea = All;
                    Image = Lock;
                    RunObject = Page "Confidential Information";
                    RunPageLink = "Employee No." = FIELD("No.");
                }
                action("Q&ualifications")
                {
                    Caption = 'Q&ualifications';
                    ApplicationArea = All;
                    Image = Certificate;
                    RunObject = Page "Employee Qualifications";
                    RunPageLink = "Employee No." = FIELD("No.");
                }
                action("A&bsences")
                {
                    Caption = 'A&bsences';
                    ApplicationArea = All;
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
                    ApplicationArea = All;
                    Image = AbsenceCategory;
                    RunObject = Page "Empl. Absences by Categories";
                    RunPageLink = "No." = FIELD("No."),
                                  "Employee No. Filter" = FIELD("No.");
                }
                action("Misc. Articles &Overview")
                {
                    Caption = 'Misc. Articles &Overview';
                    ApplicationArea = All;
                    Image = FiledOverview;
                    // RunObject = Page "Misc. Articles Overview";
                }
                action("Co&nfidential Info. Overview")
                {
                    Caption = 'Co&nfidential Info. Overview';
                    ApplicationArea = All;
                    Image = ConfidentialOverview;
                    RunObject = Page "Confidential Info. Overview";
                }
                separator(Separator61)
                {
                }
                action("Online Map")
                {
                    Caption = 'Online Map';
                    ApplicationArea = All;
                    Image = Map;

                    trigger OnAction()
                    begin
                        DisplayMap;
                    end;
                }
                action(Insurance)
                {
                    Caption = 'Insurance';
                    ApplicationArea = All;
                    Image = BankAccount;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    //commented By Avinash
                    // RunObject = Page "Employee Insurance List";
                    // RunPageLink = Field1 = FIELD("No.");
                    // RunPageView = SORTING(Field1);
                    //commented By Avinash
                    Scope = Repeater;
                }
                action("New Insurance")
                {
                    Caption = 'New Insurance';
                    ApplicationArea = All;
                    Image = BankAccount;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    //commented By Avinash
                    // RunObject = Page "Employee Insurance Card";
                    // RunPageLink = Field1 = FIELD("No.");
                    //commented By Avinash
                }
            }
        }
        area(processing)
        {
            Description = 'Advance Payroll';
            action("Earning Code")
            {
                Image = Production;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    //commented By Avinash
                    EmployeeEarningCodeGroup.RESET;
                    EmployeeEarningCodeGroup.SETRANGE("Employee Code", "No.");
                    EmployeeEarningCodeGroup.SETFILTER("Valid From", '<=%1', WORKDATE);
                    EmployeeEarningCodeGroup.SETFILTER("Valid To", '>%1|%2', WORKDATE, 0D);
                    if EmployeeEarningCodeGroup.FINDFIRST then;
                    //commented By Avinash
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
                ApplicationArea = All;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    //commented By Avinash
                    EmployeeEarningCodeGroup.RESET;
                    EmployeeEarningCodeGroup.SETRANGE("Employee Code", "No.");
                    EmployeeEarningCodeGroup.SETFILTER("Valid From", '<=%1', WORKDATE);
                    EmployeeEarningCodeGroup.SETFILTER("Valid To", '>%1|%2', WORKDATE, 0D);
                    if EmployeeEarningCodeGroup.FINDFIRST then;
                    //commented By Avinash
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
                ApplicationArea = All;

                trigger OnAction()
                begin
                    //commented By Avinash
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
                ApplicationArea = All;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    //commented By Avinash
                    //commented By Avinash
                    EmployeeEarningCodeGroup.RESET;
                    EmployeeEarningCodeGroup.SETRANGE("Employee Code", "No.");
                    EmployeeEarningCodeGroup.SETFILTER("Valid From", '<=%1', WORKDATE);
                    EmployeeEarningCodeGroup.SETFILTER("Valid To", '>%1|%2', WORKDATE, 0D);
                    if EmployeeEarningCodeGroup.FINDFIRST then;
                    //commented By Avinash
                    //commented By Avinash

                    HCMLoanTableGCCWrkr.RESET;
                    HCMLoanTableGCCWrkr.FILTERGROUP(2);
                    HCMLoanTableGCCWrkr.SETRANGE(Worker, "No.");
                    HCMLoanTableGCCWrkr.SETRANGE("Earning Code Group", EmployeeEarningCodeGroup."Earning Code Group");
                    HCMLoanTableGCCWrkr.FILTERGROUP(0);
                    PAGE.RUNMODAL(60045, HCMLoanTableGCCWrkr);
                end;
            }
            action("Earning Code Group")
            {
                Image = PaymentJournal;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;
                PromotedIsBig = true;
                //commented By Avinash
                // RunObject = Page "Employee Earning Code Group";
                // RunPageLink = "Employee Code" = FIELD("No.");
                //commented By Avinash
            }
            action("Accrual Components")
            {
                Caption = 'Accrual Components';
                Image = Agreement;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;
                //commented By Avinash
                // RunObject = Page "Accrual Components Workers";
                // RunPageLink = "Worker ID" = FIELD("No.");
                //commented By Avinash
            }
            action("Employee Position Assignment")
            {
                Image = Position;
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                //commented By Avinash
                // RunObject = Page "Employee Position Assignment";
                // RunPageLink = Worker = FIELD("No.");
                //commented By Avinash
            }
            action("Employee Work Date")
            {
                Image = Workdays;
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                //commented By Avinash
                // RunObject = Page "Employee Work Date";
                // RunPageLink = "Employee Code" = FIELD("No.");
                //commented By Avinash
                RunPageMode = View;
                Scope = Repeater;
            }
            action("Employee Dependents")
            {
                Image = Delegate;
                ApplicationArea = All;
                Promoted = true;
                PromotedIsBig = true;
                //commented By Avinash
                // RunObject = Page "Employee Dependent List";
                // RunPageLink = Field2 = FIELD("No.");
                //commented By Avinash

                trigger OnAction()
                begin
                    /*
                    CLEAR(EmployeeDependentPage);
                    EmpDepMasterRec.RESET;
                    EmpDepMasterRec.SETRANGE("Employee ID","No.");
                    EmployeeDependentPage.SETTABLEVIEW(EmpDepMasterRec);
                    EmployeeDependentPage.RUNMODAL;
                    */

                end;
            }
            action("Employee Identification")
            {
                Image = Document;
                ApplicationArea = All;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                //PromotedIsBig = true;
                //commented By Avinash
                //commented By Avinash
                // RunObject = Page "Employee Identification - Old";
                // RunPageLink = "Employee No." = FIELD("No."),
                //               "No." = FILTER(<> '');
                //commented By Avinash
            }
            action("Asset Assignment Register")
            {
                Image = FixedAssets;
                ApplicationArea = All;
                //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                //PromotedIsBig = true;
                //commented By Avinash  RunObject = Page "Asset Assignment RegisterList";
            }
            action(Contract)
            {
                Caption = 'Employee Contracts';
                ApplicationArea = All;
                Image = Certificate;
                //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                //PromotedIsBig = true;
                //commented By Avinash
                // RunObject = Page Page50027;
                // RunPageLink = Field3 = FIELD("No.");
                //commented By Avinash
            }
            action("Contract List")
            {
                Caption = 'Employee Contracts List';
                Image = ListPage;
                ApplicationArea = All;
                //commented By Avinash
                //commented By Avinash RunObject = Page Page50029;
                //commented By Avinash RunPageLink = Field7 = FIELD("No.");
                //commented By Avinash
                Visible = false;

            }
            action("Employee Bank Details")
            {
                Caption = 'Employee Bank Details';
                Image = BankAccount;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = All;
                //commented By Avinash
                //commented By Avinash  RunObject = Page "Employee Bank Account List";
                //commented By Avinash  RunPageLink = Field4 = FIELD("No.");
                //commented By Avinash
            }
            action("Employee Payout Scheme")
            {
                Caption = 'Employee Payout Scheme';
                Image = Salutation;
                Promoted = true;
                ApplicationArea = All;
                PromotedCategory = Process;
                PromotedIsBig = true;
                //commented By Avinash
                //commented By Avinash  RunObject = Page Page50064;
                //commented By Avinash RunPageLink = Field2 = FIELD("No.");
                //commented By Avinash
            }
            action("Employee Termination")
            {
                Image = TerminationDescription;
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    //commented By Avinash
                    CLEAR(EmployeeTermination);
                    EmployeeTermination.SetValues("No.");
                    EmployeeTermination.RUNMODAL;
                    CurrPage.UPDATE;
                    //commented By Avinash

                end;
            }
        }
    }

    trigger OnAfterGetCurrRecord()
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

    trigger OnAfterGetRecord()
    begin
        CLEAR("Age As Of Date");
        CLEAR(Age);
        if "Birth Date" <> 0D then begin
            Age := -("Birth Date" - TODAY);
            if Age <> 0 then
                "Age As Of Date" := FORMAT(ROUND((Age / 365.27), 0.1));
        end;
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        //<LT_AssetAssignment> //On hold
        /*AssetAssigntReg.RESET;
        AssetAssigntReg.SETRANGE("Issue to/Return by","No.");
        AssetAssigntReg.SETRANGE(Posted,TRUE);
        IF AssetAssigntReg.FINDSET THEN BEGIN
          REPEAT
            IF AssetAssigntReg.Status <> AssetAssigntReg.Status::Returned THEN
              ERROR('%1 Employee has not returned the asset %2',"No.",AssetAssigntReg."FA No");
          UNTIL AssetAssigntReg.NEXT = 0;
        END;*/
        //</LT_AssetAssignment> //On hold

    end;

    var
        EmplErngCodegrp: Record "Employee Earning Code Groups";
        PayrollEarningCodeWrkr: Record "Payroll Earning Code Wrkr";
        HCMLeaveTypesWrkr: Record "HCM Leave Types Wrkr";
        HCMBenefitWrkr: Record "HCM Benefit Wrkr";
        HCMLoanTableGCCWrkr: Record "HCM Loan Table GCC Wrkr";
        EmpDepMasterRec: Record "Employee Dependents Master";
        EmployeeRec2: Record Employee;
        //commented By Avinash
        EmployeeDependentPage: Page "Employee Dependent List1";
        EmployeeEarningCodeGroup: Record "Employee Earning Code Groups";
        // AssetAssigntReg: Record Zetalents_GL_View;
        Age: Decimal;
        EmployeeTermination: Report "Employee Termination";
    //commented By Avinash
}

