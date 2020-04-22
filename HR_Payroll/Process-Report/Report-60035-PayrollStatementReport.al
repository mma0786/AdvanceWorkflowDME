report 60035 "Payroll Statement Report"
{
    // version LT_Payroll

    DefaultLayout = RDLC;
    ///// RDLCLayout = './Payroll Statement Report.rdlc';

    dataset
    {
        dataitem(Employee; Employee)
        {
            RequestFilterFields = "No.";
            column(EmpNo; Employee."No.")
            {
            }
            column(EmpFullName; Employee."First Name" + Employee."Middle Name" + Employee."Last Name")
            {
            }
            column(CompName; CompInfo.Name)
            {
            }
            column(CompanyImage; CompInfo.Picture)
            {
            }
            column(BasicSalaryCaption; BasicSalaryCaption)
            {
            }
            column(CostOfAllowCaption; CostOfAllowCaption)
            {
            }
            column(ErsNoCaption; ErsNoCaption)
            {
            }
            column(EmpNameCaption; EmpNameCaption)
            {
            }
            column(GrdStep; GrdStep)
            {
            }
            column(GradeStepCaption; GradeStepCaption)
            {
            }
            dataitem(PayrollStatementLines; "Payroll Statement Lines")
            {
                DataItemLink = "Payroll Statment Employee" = FIELD("No.");
                DataItemTableView = SORTING("Payroll Statement ID", "Payroll Statment Employee", "Line No.");
                column(CostOfAllowance; CostOfAllowance)
                {
                }
                column(Paayroll_Year; PayrollStatementLines."Payroll Year")
                {

                }
                column(Payroll_Months; PayrollStatementLines."Payroll Month")
                {

                }
                column(EarningCodeDesc; PayrollStatementLines."Payroll Earning Code Desc")
                {
                }
                column(EmpNoLines; PayrollStatementLines."Payroll Statment Employee")
                {
                }
                column(SerialNo; SerialNo)
                {
                }
                column(BasicSalary; BasicSalary)
                {
                }
                column(EarnCode; PayrollStatementLines."Earniing Code Short Name")
                {
                }
                column(EarningCodeAmount; PayrollStatementLines."Earning Code Amount")
                {
                }
                column(TotalDeductions; TotalDeductions)
                {
                }
                column(TotalCostOfAllowance; TotalCostOfAllowance)
                {
                }
                column(TotalBasicSalary; TotalBasicSalary)
                {
                }
                column(GrandTotalEmoulments; GrandTotalEmoulments)
                {
                }
                column(GrandTotalDeductions; GrandTotalDeductions)
                {
                }
                column(PaymentInSAR; PaymentInSAR)
                {
                }
                column(TotalPaymentInSAR; TotalPaymentInSAR)
                {
                }
                column(TotalEmoulmants; TotalEmoulments)
                {
                }

                trigger OnAfterGetRecord();
                begin
                    CLEAR(BasicSalary);
                    if PayrollStatementLines."Earniing Code Short Name" = 'BS' then
                        BasicSalary := PayrollStatementLines."Earning Code Amount";

                    CLEAR(CostOfAllowance);
                    if PayrollStatementLines."Earniing Code Short Name" = 'COL' then
                        CostOfAllowance := PayrollStatementLines."Earning Code Amount";

                    TotalBasicSalary += BasicSalary;
                end;

                trigger OnPreDataItem();
                begin
                    BasicSalary := 0;
                    CostOfAllowance := 0;
                    PayrollStatementLines.SETRANGE("Payroll Pay Cycle", PayCycle);
                    PayrollStatementLines.SETRANGE("Payroll Month", FORMAT(PayMonth));
                    PayrollStatementLines.SETRANGE("Payroll Year", PayYear);
                    PayrollStatementLines.SETRANGE("Payroll Statement ID", PayrollStatementID);
                end;
            }
            // // // // dataitem(Table50021;Table50021)
            // // // // {
            // // // //     DataItemLink = Field4=FIELD("No.");
            // // // //     DataItemTableView = WHERE(Field23=FILTER(true));
            // // // //     column(BankAccountNumber;Table50021."Bank Acccount Number")
            // // // //     {
            // // // //     }
            // // // //     column(BankName;Table50021."Bank Name")
            // // // //     {
            // // // //     }
            // // // // }

            trigger OnAfterGetRecord();
            begin
                GrdStep := '';
                TotalDeductions := 0;
                TotalEmoulments := 0;

                SerialNo += 1;
                EmployeeEarningCodeGroups.RESET;
                EmployeeEarningCodeGroups.SETRANGE("Employee Code", Employee."No.");
                EmployeeEarningCodeGroups.SETFILTER("Valid To", '=%1', 0D);
                if EmployeeEarningCodeGroups.FINDFIRST then;
                //  GrdStep := EmployeeEarningCodeGroups."Increment Step";

                PayrollStatementRec.RESET;
                PayrollStatementRec.SETRANGE("Payroll Statment Employee", Employee."No.");
                PayrollStatementRec.SETRANGE("Payroll Pay Cycle", PayCycle);
                PayrollStatementRec.SETRANGE("Payroll Month", FORMAT(PayMonth));
                PayrollStatementRec.SETRANGE("Payroll Year", PayYear);
                PayrollStatementRec.SETRANGE("Payroll Statement ID", PayrollStatementID);
                if not PayrollStatementRec.FINDFIRST then
                    CurrReport.SKIP
                else
                    PayrollStatementRec.SETRANGE("Earniing Code Short Name", 'COL');
                if PayrollStatementRec.FINDFIRST then
                    CostOfAllowance := PayrollStatementRec."Earning Code Amount";
                PayrollStatementRec.SETRANGE("Earniing Code Short Name");
                PayrollStatementRec.SETFILTER("Earning Code Amount", '>%1', 0);
                if PayrollStatementRec.FINDSET then
                    repeat
                        TotalEmoulments := TotalEmoulments + PayrollStatementRec."Earning Code Amount";
                    until PayrollStatementRec.NEXT = 0;

                PayrollStatementRec.SETRANGE("Earning Code Amount");
                PayrollStatementRec.SETFILTER("Earning Code Amount", '<%1', 0);
                if PayrollStatementRec.FINDSET then
                    repeat
                        TotalDeductions += PayrollStatementRec."Earning Code Amount";
                    until PayrollStatementRec.NEXT = 0;

                PaymentInSAR := CurrencyExchangeRate.ExchangeAmount(TotalEmoulments + TotalDeductions, 'USD', '', 0D);

                //////Page totals //
                GrandTotalDeductions += TotalDeductions;
                GrandTotalEmoulments += TotalEmoulments;
                TotalCostOfAllowance += CostOfAllowance;
                TotalPaymentInSAR += PaymentInSAR;
            end;

            trigger OnPreDataItem();
            begin
                GrandTotalEmoulments := 0;
                GrandTotalDeductions := 0;
                TotalBasicSalary := 0;
                TotalCostOfAllowance := 0;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field("Pay Cycle"; PayCycle)
                {
                    ApplicationArea = all;
                    TableRelation = "Pay Cycles"."Pay Cycle";
                }
                field("Pay Period"; PayPeriodCode)
                {
                    ApplicationArea = all;
                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        PayPeriodRec.RESET;
                        PayPeriodRec.SETRANGE("Pay Cycle", PayCycle);
                        if PAGE.RUNMODAL(PAGE::"Pay Periods List", PayPeriodRec) = ACTION::LookupOK then begin
                            PayPeriodCode := PayPeriodRec.Month + ' ' + FORMAT(PayPeriodRec.Year);
                            PayMonth := PayPeriodRec.Month;
                            PayYear := PayPeriodRec.Year;
                            PayPeriodStartDate := PayPeriodRec."Period Start Date";
                            PayPeriodEndDate := PayPeriodRec."Period End Date";
                        end;
                    end;
                }
                field("Payroll Statement ID"; PayrollStatementID)
                {
                    ApplicationArea = all;
                    TableRelation = "Payroll Statement"."Payroll Statement ID";

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        if PayCycle = '' then
                            ERROR('Please select Pay Cycle');

                        if PayPeriodCode = '' then
                            ERROR('Please select Pay Period');

                        PayrollStatement.RESET;
                        PayrollStatement.FILTERGROUP(2);
                        PayrollStatement.SETRANGE("Pay Cycle", PayCycle);
                        PayrollStatement.SETRANGE("Pay Period Start Date", PayPeriodStartDate);
                        PayrollStatement.SETRANGE("Pay Period End Date", PayPeriodEndDate);
                        PayrollStatement.FILTERGROUP(0);
                        if PAGE.RUNMODAL(PAGE::"Payroll Statements", PayrollStatement) = ACTION::LookupOK then begin
                            PayrollStatementID := PayrollStatement."Payroll Statement ID";
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

    trigger OnPreReport();
    begin
        if CompInfo.GET then
            CompInfo.CALCFIELDS(Picture);
    end;

    var
        PayMonth: Code[20];
        PayYear: Integer;
        PayCycle: Code[50];
        PayPeriodRec: Record "Pay Periods";
        PayrollStatementID: Code[20];
        BasicSalaryCaption: Label 'BASIC SALARY';
        CostOfAllowCaption: Label 'COST OF L. ALLOWANCE';
        ErsNoCaption: Label 'ERS NO';
        EmpNameCaption: Label 'NAME';
        GradeStepCaption: Label 'GRADE / STEP';
        BasicSalary: Decimal;
        CostOfAllowance: Decimal;
        CompInfo: Record "Company Information";
        EmployeeEarningCodeGroups: Record "Employee Earning Code Groups";
        GrdStep: Code[20];
        SerialNo: Integer;
        TotalEmoulments: Decimal;
        FinalCostOfAllowance: Decimal;
        PayrollStatementRec: Record "Payroll Statement Lines";
        TotalDeductions: Decimal;
        PayPeriodCode: Code[50];
        TotalBasicSalary: Decimal;
        TotalCostOfAllowance: Decimal;
        GrandTotalEmoulments: Decimal;
        GrandTotalDeductions: Decimal;
        CurrencyExchangeRate: Record "Currency Exchange Rate";
        PaymentInSAR: Decimal;
        TotalPaymentInSAR: Decimal;
        PayrollStatement: Record "Payroll Statement";
        PayPeriodStartDate: Date;
        PayPeriodEndDate: Date;

    procedure SetData(PayCycle_P: Code[150]; PayPeriodCode_P: Code[150]; PayrollStatementID_P: Code[150]; PaySDate_P: Date; PayEDae_P: Date);
    begin
        PayCycle := PayCycle_P;

        // Start Finding Period Code
        PayPeriodRec.RESET;
        PayPeriodRec.SETRANGE("Pay Cycle", PayCycle_P);
        PayPeriodRec.SETRANGE("Period Start Date", PaySDate_P);
        PayPeriodRec.SETRANGE("Period End Date", PayEDae_P);
        if PayPeriodRec.FINDFIRST then begin
            PayPeriodCode := PayPeriodRec.Month + ' ' + FORMAT(PayPeriodRec.Year);
            PayMonth := PayPeriodRec.Month;
            PayYear := PayPeriodRec.Year;
            PayPeriodStartDate := PayPeriodRec."Period Start Date";
            PayPeriodEndDate := PayPeriodRec."Period End Date";
        end;
        // Stop Finding Period Code

        PayrollStatementID := PayrollStatementID_P;
    end;
}

