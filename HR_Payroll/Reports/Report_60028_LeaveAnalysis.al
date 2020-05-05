report 60028 "Leave Analysis"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'HR_Payroll\Reports\LeaveAnalysis.rdlc';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    dataset
    {
        dataitem(Employee; Employee)
        {
            RequestFilterFields = "No.";
            column(CompLogo; CompanyInformation.Picture)
            {
            }
            column(CompName; CompanyInformation.Name)
            {
            }
            column(EmpNo; Employee."No.")
            {
            }
            column(EmpName; Employee."First Name")
            {
            }
            column(EmpDepartment; Employee.Department)
            {
            }
            column(EmployeeIDCaption; EmpIDCaption)
            {
            }
            column(EmpNameCaption; EmpNameCaption)
            {
            }
            column(EmpDepartCaption; EmpDepartmentCaption)
            {
            }
            column(RepNameCaption; ReportCaption)
            {
            }
            column(DateFilter; AsOfDate)
            {
            }
            dataitem(EmployeeWorkDate_GCC; EmployeeWorkDate_GCC)
            {
                DataItemLink = "Employee Code" = FIELD("No.");
                DataItemTableView = SORTING("Employee Code", "Trans Date");
                PrintOnlyIfDetail = false;
                column(EmpTransDate; EmployeeWorkDate_GCC."Trans Date")
                {
                }
                column(LeaveType; EmployeeWorkDate_GCC."First Half Leave Type")
                {
                }
                column(EmpCode; EmployeeWorkDate_GCC."Employee Code")
                {
                }
                column(OtherLeave; Other)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    IF HCMLeaveTypes.GET(EmployeeWorkDate_GCC."First Half Leave Type") THEN
                        IF HCMLeaveTypes."Is System Defined" THEN
                            CurrReport.SKIP
                        ELSE
                            Other := HCMLeaveTypes."Leave Classification" = HCMLeaveTypes."Leave Classification"::Other;
                end;

                trigger OnPreDataItem()
                begin
                    IF AsOfDate <> 0D THEN
                        EmployeeWorkDate_GCC.SETFILTER("Trans Date", '%1..%2', 0D, AsOfDate);
                end;
            }
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field("As Of Date"; AsOfDate)
                {
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

    trigger OnPreReport()
    begin
        IF CompanyInformation.GET THEN
            CompanyInformation.CALCFIELDS(Picture);
    end;

    var
        AsOfDate: Date;
        CompanyInformation: Record "Company Information";
        EmpIDCaption: Label 'Employee ID';
        EmpNameCaption: Label 'Employee Name';
        EmpDepartmentCaption: Label 'Department';
        ReportCaption: Label 'Leave Analysis';
        HCMLeaveTypes: Record "HCM Leave Types";
        Other: Boolean;
}

