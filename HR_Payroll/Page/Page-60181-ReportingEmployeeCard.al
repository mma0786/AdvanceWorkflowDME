page 60181 "Reporting Employee Card"
{
    Caption = 'Employee Card';
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    ShowFilter = false;
    SourceTable = Employee;

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

                    trigger OnAssistEdit()
                    begin

                        /*IF AssistEdit(xRec) THEN
                          CurrPage.UPDATE;
                          */

                    end;
                }
                field("Job Title"; "Job Title")
                {
                    Caption = 'Professional Title';
                    Editable = false;
                    Importance = Promoted;
                    ToolTip = 'Specifies the employee''s job title.';
                }
                field("Professional Title in Arabic"; "Professional Title in Arabic")
                {
                }
                field("First Name"; "First Name")
                {
                    Importance = Promoted;
                    ToolTip = 'Specifies the employee''s first name.';
                }
                field("Middle Name"; "Middle Name")
                {
                    Caption = 'Middle Name';
                    ToolTip = 'Specifies the employee''s middle name.';
                }
                field("Last Name"; "Last Name")
                {
                    ToolTip = 'Specifies the employee''s last name.';
                }
                field(Initials; Initials)
                {
                    Caption = 'Personal Title';
                    ToolTip = 'Specifies the employee''s initials.';
                }
                field("Personal   Title in Arabic"; "Personal   Title in Arabic")
                {
                    Caption = 'Personal  Title in Arabic';
                }
                field("Employee Name in Arabic"; "Employee Name in Arabic")
                {
                }
                field("Marital Status"; "Marital Status")
                {
                }
                field("Last Date Modified"; "Last Date Modified")
                {
                    Importance = Promoted;
                    ToolTip = 'Specifies the last day this entry was modified.';
                }
                field("Joining Date"; "Joining Date")
                {
                    Enabled = false;
                }
                field("Joining Date - Hijiri"; "D.O.J Hijiri")
                {
                }
                field("Probation Period"; "Probation Period")
                {
                }
                field(Department; Department)
                {
                    Editable = false;
                }
                field("Sub Department"; "Sub Department")
                {
                    Caption = 'Sub Department';
                    Editable = false;
                }
                field("Line manager"; "Line manager")
                {
                    Editable = false;
                }
                field(HOD; HOD)
                {
                    Editable = false;
                }
            }
            //commented By Avinash  part(Contacts; "Employee Contacts SubPage")
            //commented By Avinash  {
            //commented By Avinash     Caption = 'Contacts';
            //commented By Avinash     SubPageLink = Field1 = FIELD ("No.");
            //commented By Avinash   }
            group("Employee Grade Details")
            {
                Caption = 'Employee Grade Details';
                field("Earning Code Group"; "Earning Code Group")
                {
                    Editable = false;
                }
                field("Grade Category"; "Grade Category")
                {
                    Editable = false;
                }
                field("Unsatisfactory Grade"; "Unsatisfactory Grade")
                {
                }
            }
        }
        area(factboxes)
        {
            //commented By Avinash  part(Control3; "Employee Picture")
            //commented By Avinash  {
            //commented By Avinash     ApplicationArea = Basic, Suite;
            //commented By Avinash     SubPageLink = "No." = FIELD("No.");
            //commented By Avinash  }
            part("Employee Details"; "Reporting to FactBox")
            {
                SubPageLink = "No." = FIELD("No.");
            }
            systempart(Control1900383207; Links)
            {
                Visible = false;
            }
            systempart(Control1905767507; Notes)
            {
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
                Visible = false;
                action(Leaves)
                {
                    Image = Holiday;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;
                    RunObject = Page "Leave Requests_RC";
                    RunPageLink = "Personnel Number" = FIELD("No.");
                }
                action("Overtime Request")
                {
                    Image = CalculateCrossDock;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;
                    RunObject = Page "Loan Adjustments";
                    RunPageLink = "Employee Name" = FIELD("No.");
                }
                action("Overtime  Benefit Claim")
                {
                    Image = CalculateCrossDock;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;
                    RunObject = Page "Loan Types";
                    RunPageLink = "Arabic Name" = FIELD("No.");
                }
            }
            group("Employee Competencies")
            {
                Caption = 'Employee Competencies';
                action(Education)
                {
                    Image = Certificate;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Process;
                    RunObject = Page "Employee Education List";
                    RunPageLink = "Emp ID" = FIELD("No.");
                }
                action(Experience)
                {
                    Image = Accounts;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Process;
                    RunObject = Page "Employee Education List";
                    RunPageLink = "Emp ID" = FIELD("No.");
                }
                action(Skills)
                {
                    Image = Skills;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Process;
                    RunObject = Page "Employee Skills List";
                    RunPageLink = "Emp ID" = FIELD("No.");
                }
                action(Certificates)
                {
                    Image = Certificate;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Process;
                    RunObject = Page "Employee Certificates List";
                    RunPageLink = "Emp ID" = FIELD("No.");
                }
                action(Attendance)
                {
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    var
                    //commented By Avinash  EmployeeAttendance: Report "Employee Attendance";
                    //commented By Avinash  TimeAttendanceDetails: Record Table55016;
                    begin
                        //
                        //commented By Avinash  TimeAttendanceDetails.RESET;
                        //commented By Avinash  TimeAttendanceDetails.SETRANGE("Employee ID", "No.");
                        //commented By Avinash  if TimeAttendanceDetails.FINDFIRST then begin
                        //commented By Avinash    CLEAR(EmployeeAttendance);
                        //commented By Avinash    EmployeeAttendance.SETTABLEVIEW(TimeAttendanceDetails);
                        //commented By Avinash    EmployeeAttendance.RUNMODAL;
                        //commented By Avinash  end
                        //commented By Avinash  else
                        //commented By Avinash    MESSAGE('Attendance details not available');
                    end;
                }
                action("Mission Orders")
                {
                    Image = MakeOrder;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    var
                        MissionOrderLine: Record "Summary Payroll Cue";
                        MissionOrderHeader: Record "Asset Assignment Register";
                        MissionOrderLists: Page "Payoll Role Center";
                    begin
                        MissionOrderLine.RESET;
                        //commented By Avinash   MissionOrderLine.SETRANGE("Driving Licence Request", "No.");
                        if MissionOrderLine.FINDFIRST then
                            repeat
                                MissionOrderHeader.GET(MissionOrderLine."Primary Key");
                                MissionOrderHeader.MARK(true);
                            until MissionOrderLine.NEXT = 0;
                        MissionOrderHeader.MARKEDONLY(true);
                        MissionOrderLists.SETTABLEVIEW(MissionOrderHeader);
                        MissionOrderLists.RUNMODAL;
                    end;
                }
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

    trigger OnInit()
    begin
        UserSetupRec.RESET;
        UserSetupRec.SETRANGE("User ID", USERID);
        if UserSetupRec.FINDFIRST then begin
            EmpRec.RESET;
            EmpRec.SETRANGE("No.", UserSetupRec."Employee Id");
            if EmpRec.FINDSET then;
        end;

        //SETRANGE("Line manager Code",EmpRec."No.");
        if FINDSET then begin
            repeat
                MARK(true);
            until NEXT = 0;
        end;
    end;

    trigger OnNextRecord(Steps: Integer): Integer
    begin
        MARK(true)
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        if CloseAction in [ACTION::OK, ACTION::LookupOK] then begin
            if "First Name" <> '' then
                CheckMand;
        end;
    end;

    var
        EmplErngCodegrp: Record "Employee Earning Code Groups";
        PayrollEarningCodeWrkr: Record "Payroll Earning Code Wrkr";
        HCMLeaveTypesWrkr: Record "HCM Leave Types Wrkr";
        HCMBenefitWrkr: Record "HCM Benefit Wrkr";
        HCMLoanTableGCCWrkr: Record "HCM Loan Table GCC Wrkr";
        //commented By Avinash  EmpDepMasterRec: Record Table50004;
        EmployeeRec2: Record Employee;
        //commented By Avinash EmployeeDependentPage: Page "Employee Dependent List";
        EmployeeEarningCodeGroup: Record "Employee Earning Code Groups";
        //commented By Avinash  AssetAssigntReg: Record Table50075;
        Age: Decimal;
        //commented By Avinash  EmployeeTermination: Report "Employee Termination";
        DelegateWFLTRec_G: Record "Delegate - WFLT";
        UserSetupRec_G: Record "User Setup";
        UserEmployee: Text;
        UserSetupRec: Record "User Setup";
        EmpRec: Record Employee;
        EmpRec2: Record Employee;

    local procedure CheckMand()
    begin
        TESTFIELD("Marital Status");
        if Gender = Gender::" " then
            ERROR('Please select Gender');
        TESTFIELD("Birth Date");
        TESTFIELD(Region);
    end;
}

