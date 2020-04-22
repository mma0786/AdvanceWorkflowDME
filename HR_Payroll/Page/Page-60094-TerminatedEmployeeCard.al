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
            //commented By Avinash
            //commented By Avinash
            /*
            part("Address Part "; "Employee Address ListPart")
            {
                Caption = 'Address';
                SubPageLink = Field1 = FIELD(No.);
            }
            part(Contacts; "Employee Contacts SubPage")
            {
                Caption = 'Contacts';
                SubPageLink = Field1 = FIELD(No.);
            }*/

            //commented By Avinash
            //commented By Avinash
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
                    ApplicationArea = All;
                    //commented By Avinash RunPageLink = Table Name=CONST(Employee),No.=FIELD(No.);
                }
                action(Dimensions)
                {
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    //commented By Avinash RunObject = Page "Default Dimensions";
                    //commented By Avinash        RunPageLink = Table ID=CONST(5200),No.=FIELD(No.);
                    ShortCutKey = 'Shift+Ctrl+D';
                    ApplicationArea = All;
                    ToolTip = 'View or edit dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.';
                }
                action("&Picture")
                {
                    Caption = '&Picture';
                    Image = Picture;
                    ApplicationArea = All;
                    //commented By AvinashRunObject = Page "Employee Picture";
                    //commented By Avinash            RunPageLink = No.=FIELD(No.);
                }
                action(AlternativeAddresses)
                {
                    Caption = '&Alternative Addresses';
                    Image = Addresses;
                    //commented By Avinash RunObject = Page "Alternative Address List";
                    //commented By Avinash     RunPageLink = Employee No.=FIELD(No.);
                }
                action("&Relatives")
                {
                    Caption = '&Relatives';
                    Image = Relatives;
                    ApplicationArea = All;
                    //commented By Avinash   RunObject = Page "Employee Relatives";
                    //commented By Avinash      RunPageLink = Employee No.=FIELD(No.);
                }
                action("Mi&sc. Article Information")
                {
                    Caption = 'Mi&sc. Article Information';
                    Image = Filed;
                    ApplicationArea = All;
                    //commented By Avinash  RunObject = Page "Misc. Article Information";
                    //commented By Avinash      RunPageLink = Employee No.=FIELD(No.);
                }
                action("&Confidential Information")
                {
                    Caption = '&Confidential Information';
                    Image = Lock;
                    ApplicationArea = All;
                    //commented By Avinash RunObject = Page "Confidential Information";
                    //commented By Avinash   RunPageLink = Employee No.=FIELD(No.);
                }
                action("Q&ualifications")
                {
                    Caption = 'Q&ualifications';
                    Image = Certificate;
                    ApplicationArea = All;
                    //commented By Avinash  RunObject = Page "Employee Qualifications";
                    //commented By Avinash           RunPageLink = Employee No.=FIELD(No.);
                }
                action("A&bsences")
                {
                    Caption = 'A&bsences';
                    Image = Absence;
                    ApplicationArea = All;
                    //commented By Avinash  RunObject = Page "Employee Absences";
                    //commented By Avinash       RunPageLink = Employee No.=FIELD(No.);
                }
                separator(Separator23)
                {
                }
                action("Absences by Ca&tegories")
                {
                    Caption = 'Absences by Ca&tegories';
                    Image = AbsenceCategory;
                    ApplicationArea = All;
                    //commented By Avinash  RunObject = Page "Empl. Absences by Categories";
                    //commented By Avinash            RunPageLink = No.=FIELD(No.),Employee No. Filter=FIELD(No.);
                }
                action("Misc. Articles &Overview")
                {
                    Caption = 'Misc. Articles &Overview';
                    Image = FiledOverview;
                    ApplicationArea = All;
                    //commented By Avinash  RunObject = Page "Misc. Articles Overview";
                }
                action("Co&nfidential Info. Overview")
                {
                    Caption = 'Co&nfidential Info. Overview';
                    Image = ConfidentialOverview;
                    ApplicationArea = All;
                    //commented By Avinash  RunObject = Page "Confidential Info. Overview";
                }
                separator(Separator61)
                {
                }
                action("Online Map")
                {
                    Caption = 'Online Map';
                    Image = Map;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        DisplayMap;
                    end;
                }
                action(Insurance)
                {
                    Caption = 'Insurance';
                    Image = BankAccount;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = All;
                    //commented By Avinash   RunObject = Page "Employee Insurance List";
                    //commented By Avinash               RunPageLink = Field1=FIELD(No.);
                    //commented By Avinash  RunPageView = SORTING(Field1);
                    Scope = Repeater;
                }
                action("New Insurance")
                {
                    Caption = 'New Insurance';
                    Image = BankAccount;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = All;
                    //commented By Avinash  RunObject = Page "Employee Insurance Card";
                    //commented By Avinash               RunPageLink = Field1=FIELD(No.);
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
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    //commented By Avinash  EmployeeEarningCodeGroup.RESET;
                    //commented By Avinash EmployeeEarningCodeGroup.SETRANGE("Employee Code", "No.");
                    //commented By Avinash  EmployeeEarningCodeGroup.SETFILTER("Valid From", '<=%1', WORKDATE);
                    //commented By Avinash  EmployeeEarningCodeGroup.SETFILTER("Valid To", '>%1|%2', WORKDATE, 0D);
                    // // // //commented By Avinash  IF EmployeeEarningCodeGroup.FINDFIRST THEN;
                    // // // PayrollEarningCodeWrkr.RESET;
                    // // // PayrollEarningCodeWrkr.FILTERGROUP(2);

                    // // // /// PayrollEarningCodeWrkr.SETRANGE(Worker, "No.");
                    // // // //commented By Avinash PayrollEarningCodeWrkr.SETRANGE("Earning Code Group", EmployeeEarningCodeGroup."Earning Code Group");
                    // // // PayrollEarningCodeWrkr.FILTERGROUP(0);
                    //commented By Avinash   PAGE.RUNMODAL(60041,PayrollEarningCodeWrkr);
                end;
            }
            action("Leave Type")
            {
                Image = Holiday;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = All;


                trigger OnAction()
                begin
                    //commented By Avinash
                    // EmployeeEarningCodeGroup.RESET;
                    // EmployeeEarningCodeGroup.SETRANGE("Employee Code", "No.");
                    // EmployeeEarningCodeGroup.SETFILTER("Valid From", '<=%1', WORKDATE);
                    // EmployeeEarningCodeGroup.SETFILTER("Valid To", '>%1|%2', WORKDATE, 0D);
                    // IF EmployeeEarningCodeGroup.FINDFIRST THEN;
                    //commented By Avinash
                    HCMLeaveTypesWrkr.RESET;
                    HCMLeaveTypesWrkr.FILTERGROUP(2);
                    HCMLeaveTypesWrkr.SETRANGE(Worker, "No.");
                    //commented By Avinash  HCMLeaveTypesWrkr.SETRANGE("Earning Code Group", EmployeeEarningCodeGroup."Earning Code Group");
                    HCMLeaveTypesWrkr.FILTERGROUP(0);
                    //commented By Avinash   PAGE.RUNMODAL(60039,HCMLeaveTypesWrkr);
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
                    //commented By Avinash
                    // EmployeeEarningCodeGroup.RESET;
                    // EmployeeEarningCodeGroup.SETRANGE("Employee Code", "No.");
                    // EmployeeEarningCodeGroup.SETFILTER("Valid From", '<=%1', WORKDATE);
                    // EmployeeEarningCodeGroup.SETFILTER("Valid To", '>%1|%2', WORKDATE, 0D);
                    // IF EmployeeEarningCodeGroup.FINDFIRST THEN;
                    //commented By Avinash
                    // // // //commented By Avinash
                    // // // HCMBenefitWrkr.RESET;
                    // // // HCMBenefitWrkr.FILTERGROUP(2);
                    // // // ////   HCMBenefitWrkr.SETRANGE(Worker, "No.");
                    // // // //commented By Avinash  HCMBenefitWrkr.SETRANGE("Earning Code Group", EmployeeEarningCodeGroup."Earning Code Group");
                    // // // HCMBenefitWrkr.FILTERGROUP(0);
                    //commented By Avinash  PAGE.RUNMODAL(60043,HCMBenefitWrkr);
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
                    //commented By Avinash
                    //commented By Avinash

                    // EmployeeEarningCodeGroup.RESET;
                    // EmployeeEarningCodeGroup.SETRANGE("Employee Code", "No.");
                    // EmployeeEarningCodeGroup.SETFILTER("Valid From", '<=%1', WORKDATE);
                    // EmployeeEarningCodeGroup.SETFILTER("Valid To", '>%1|%2', WORKDATE, 0D);
                    // IF EmployeeEarningCodeGroup.FINDFIRST THEN;
                    //commented By Avinash
                    //commented By Avinash
                    // // HCMLoanTableGCCWrkr.RESET;
                    //HCMLoanTableGCCWrkr.FILTERGROUP(2);
                    ////   HCMLoanTableGCCWrkr.SETRANGE(Worker, "No.");
                    //commented By Avinash HCMLoanTableGCCWrkr.SETRANGE("Earning Code Group", EmployeeEarningCodeGroup."Earning Code Group");
                    //HCMLoanTableGCCWrkr.FILTERGROUP(0);
                    //commented By Avinash PAGE.RUNMODAL(60045,HCMLoanTableGCCWrkr);
                end;
            }
            action("Earning Code Group")
            {
                Image = PaymentJournal;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;
                PromotedIsBig = true;
                //commented By Avinash   RunObject = Page "Employee Earning Code Group";
                //commented By Avinash             RunPageLink = Employee Code=FIELD(No.);
            }
            action("Accrual Components")
            {
                Caption = 'Accrual Components';
                Image = Agreement;
                Promoted = true;
                PromotedCategory = Process;
                //commented By Avinash   RunObject = Page "Accrual Components Workers";
                //commented By Avinash           RunPageLink = Worker ID=FIELD(No.);
            }
            action("Employee Position Assignment")
            {
                Image = Position;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;
                PromotedIsBig = true;
                //commented By Avinash  RunObject = Page "Employee Position Assignment";
                //commented By Avinash           RunPageLink = Worker=FIELD(No.);
            }
            action("Employee Work Date")
            {
                Image = Workdays;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;
                PromotedIsBig = true;
                //commented By Avinash   RunObject = Page "Employee Work Date";
                //commented By Avinash      RunPageLink = Employee Code=FIELD(No.);
                RunPageMode = View;
                Scope = Repeater;
            }
            action("Employee Dependents")
            {
                Image = Delegate;
                Promoted = true;
                PromotedIsBig = true;
                ApplicationArea = All;
                //commented By Avinash RunObject = Page "Employee Dependent List";
                //commented By Avinash           RunPageLink = Field2=FIELD(No.);

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
                //commented By Avinash   RunObject = Page "Employee Identification - Old";
                //commented By Avinash     RunPageLink = Employee No.=FIELD(No.),No.=FILTER(<>'');
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
                Image = Certificate;
                ApplicationArea = All;
                //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                //PromotedIsBig = true;
                //commented By Avinash  RunObject = Page Page50027;
                //commented By Avinash      RunPageLink = Field3=FIELD(No.);
            }
            action("Contract List")
            {
                Caption = 'Employee Contracts List';
                ApplicationArea = All;
                Image = ListPage;
                //commented By Avinash  RunObject = Page Page50029;
                //commented By Avinash    RunPageLink = Field7=FIELD(No.);
                Visible = false;
            }
            action("Employee Bank Details")
            {
                Caption = 'Employee Bank Details';
                ApplicationArea = All;
                Image = BankAccount;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                //commented By Avinash  RunObject = Page "Employee Bank Account List";
                //commented By Avinash   RunPageLink = Field4=FIELD(No.);
            }
            action("Employee Payout Scheme")
            {
                Caption = 'Employee Payout Scheme';
                ApplicationArea = All;
                Image = Salutation;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                //commented By Avinash  RunObject = Page Page50064;
                //commented By Avinash  RunPageLink = Field2=FIELD(No.);
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
        IF EmplErngCodegrp.FINDFIRST THEN
            "Earning Code Group" := EmplErngCodegrp."Earning Code Group";
        //LT_05052019 <<
        //commented By Avinash
        CLEAR("Age As Of Date");
        CLEAR(Age);
        IF "Birth Date" <> 0D THEN BEGIN
            Age := -("Birth Date" - TODAY);
            IF Age <> 0 THEN
                "Age As Of Date" := FORMAT(ROUND((Age / 365.27), 0.1));
        END;
        //commented By Avinash
    end;

    trigger OnAfterGetRecord()
    begin
        CLEAR("Age As Of Date");
        //commented By Avinash
        CLEAR(Age);
        IF "Birth Date" <> 0D THEN BEGIN
            Age := -("Birth Date" - TODAY);
            IF Age <> 0 THEN
                "Age As Of Date" := FORMAT(ROUND((Age / 365.27), 0.1));
        END;
        //commented By Avinash
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
        EmployeeDependentPage: Page "Employee Identification List";
        EmployeeEarningCodeGroup: Record "Employee Earning Code Groups";
        //commented By Avinash                         AssetAssigntReg: Record Zetalents_GL_View;
        Age: Decimal;
        EmployeeTermination: Report "Employee Termination";
}

