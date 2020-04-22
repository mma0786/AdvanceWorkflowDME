table 60122 "Loan Adjustment Header"
{

    fields
    {
        field(1; "Loan Adjustment ID"; Code[50])
        {
        }
        field(2; "Employee ID"; Code[50])
        {
            TableRelation = Employee;

            trigger OnValidate()
            begin
                Employee.RESET;
                if Employee.GET("Employee ID") then begin
                    IF PAGE.RUNMODAL(0, Employee) = ACTION::LookupOK THEN BEGIN
                        "Employee ID" := Employee."No.";
                        "Employee Name" := Employee."First Name" + Employee."Middle Name" + Employee."Last Name";
                    end

                    /*

                    IF PAGE.RUNMODAL(0,Employee) = ACTION::LookupOK THEN BEGIN
                       "Employee ID" := Employee."No.";
                       "Employee Name" := Employee."First Name" + Employee."Middle Name" + Employee."Last Name";
                      END

                    */

                end;
            end;
        }
        field(3; "Employee Name"; Text[100])
        {
        }
        field(4; "Adjustment Type"; Option)
        {
            OptionCaption = ',Unrecovered,Recovered,Adjusted';
            OptionMembers = ,Unrecovered,Recovered,Adjusted;
        }
        field(5; "Loan ID"; Code[20])
        {
            Editable = false;
            TableRelation = "Loan Request"."Loan Type" WHERE("Loan Request ID" = FIELD("Loan Request ID"));

            trigger OnLookup()
            begin
                LoanTypeSetup.SETRANGE(Active, TRUE);
                IF PAGE.RUNMODAL(0, LoanTypeSetup) = ACTION::LookupOK THEN BEGIN
                    "Loan ID" := LoanTypeSetup."Loan Code";
                    "Loan Description" := LoanTypeSetup."Loan Description";
                END;
            end;
        }
        field(6; "Loan Description"; Text[250])
        {
            CalcFormula = Lookup ("Loan Type Setup"."Loan Description" WHERE("Loan Code" = FIELD("Loan ID")));
            FieldClass = FlowField;
        }
        field(7; "Adjustment Date"; Date)
        {
        }
        field(8; "Workflow Status"; Option)
        {
            Description = 'Not Submitted,Submitted,Approved,Cancelled,Rejected,Open,Pending For Approval';
            OptionCaption = 'Not Submitted,Submitted,Approved,Cancelled,Rejected,Open,Pending For Approval';
            OptionMembers = "Not Submitted",Submitted,Approved,Cancelled,Rejected,Open,"Pending For Approval";
        }
        field(9; "Loan Request ID"; Code[50])
        {
            TableRelation = "Loan Request"."Loan Request ID" WHERE("Employee ID" = FIELD("Employee ID"));

            trigger OnValidate()
            begin
                LoanRequest.SETRANGE("Employee ID", "Employee ID");
                if LoanRequest.FINDFIRST then begin
                    IF PAGE.RUNMODAL(0, LoanRequest) = ACTION::LookupOK THEN BEGIN
                        "Loan Request ID" := LoanRequest."Loan Request ID";
                        "Loan ID" := LoanRequest."Loan Type";
                        "Loan Description" := LoanRequest."Loan Description";
                        "Loan Request Amount" := LoanRequest."Request Amount";
                    end;


                    if (("Loan Request ID" <> '') and ("Loan ID" <> '')) then
                        GetLoanLines;
                end;
            end;
        }
        field(10; "Loan Request Amount"; Decimal)
        {
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "Loan Adjustment ID", "Loan ID", "Loan Request ID")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        if "Workflow Status" <> "Workflow Status"::Open then
            ERROR('Loan Adjustment Workflow Status should be Open.');
    end;

    trigger OnInsert()
    begin
        "Workflow Status" := "Workflow Status"::Open;
        Initialise;
    end;

    var
        NoSeriesManagement: Codeunit NoSeriesManagement;
        Employee: Record Employee;
        LoanTypeSetup: Record "Loan Type Setup";
        LoanRequest: Record "Loan Request";
        LoanAdjustmentLines: Record "Loan Adjustment Lines";
        Text50004: Label 'Loan Adjustment Lines already Exist !';
        LoanInstallmentGeneration: Record "Loan Installment Generation";
        AdvancePayrollSetup: Record "Advance Payroll Setup";

    local procedure Initialise()
    begin
        AdvancePayrollSetup.GET;
        "Loan Adjustment ID" := NoSeriesManagement.GetNextNo(AdvancePayrollSetup."Loan Adj. No Series", WORKDATE, true);
    end;

    //[Scope('Internal')]
    procedure Reopen(var Rec: Record "Loan Adjustment Header")
    begin
        with Rec do begin
            if "Workflow Status" = "Workflow Status"::Open then
                exit;

            "Workflow Status" := "Workflow Status"::Open;
            MODIFY;
        end;
    end;

    local procedure GetLoanLines()
    var
        LoanAdjustmentLinesRecL: Record "Work Time Template - Ramadn";
    begin
        LoanAdjustmentLines.SETRANGE("Loan Adjustment ID", "Loan Adjustment ID");
        LoanAdjustmentLines.SETRANGE(Loan, "Loan ID");
        LoanAdjustmentLines.SETRANGE("Employee ID", "Employee ID");
        LoanAdjustmentLines.SETRANGE("Loan Request ID", "Loan Request ID");
        if LoanAdjustmentLines.FINDFIRST then
            ERROR(Text50004);

        LoanInstallmentGeneration.RESET;
        LoanInstallmentGeneration.SETRANGE(Loan, "Loan ID");
        LoanInstallmentGeneration.SETRANGE("Employee ID", "Employee ID");
        LoanInstallmentGeneration.SETRANGE("Loan Request ID", "Loan Request ID");
        if LoanInstallmentGeneration.FINDSET then
            repeat
                LoanAdjustmentLinesRecL.RESET;
                IF LoanAdjustmentLinesRecL.FINDLAST THEN;
                LoanAdjustmentLines."Entry No." := LoanAdjustmentLines."Entry No." + 1;
                LoanAdjustmentLines.INIT;
                LoanAdjustmentLines."Entry No." := 0;
                LoanAdjustmentLines."Loan Adjustment ID" := "Loan Adjustment ID";
                LoanAdjustmentLines.INSERT;
                LoanAdjustmentLines."Loan Request ID" := LoanInstallmentGeneration."Loan Request ID";
                LoanAdjustmentLines.Loan := LoanInstallmentGeneration.Loan;
                LoanAdjustmentLines."Loan Description" := LoanInstallmentGeneration."Loan Description";
                LoanAdjustmentLines."Employee ID" := LoanInstallmentGeneration."Employee ID";
                LoanAdjustmentLines."Employee Name" := LoanInstallmentGeneration."Employee Name";
                LoanAdjustmentLines."Installament Date" := LoanInstallmentGeneration."Installament Date";
                LoanAdjustmentLines."Principal Installment Amount" := LoanInstallmentGeneration."Principal Installment Amount";
                LoanAdjustmentLines."Interest Installment Amount" := LoanInstallmentGeneration."Interest Installment Amount";
                LoanAdjustmentLines.Currency := LoanInstallmentGeneration.Currency;
                LoanAdjustmentLines.Status := LoanInstallmentGeneration.Status;
                LoanAdjustmentLines.MODIFY;//(TRUE);
            until LoanInstallmentGeneration.NEXT = 0;
    end;
}

