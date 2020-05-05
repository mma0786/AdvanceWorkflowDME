codeunit 60039 InitCodeunit_Payroll
{
    trigger OnRun()
    begin
    end;
    //Events creation Start   
    [IntegrationEvent(false, false)]
    procedure OnSendPayrollStat_Approval(var PayrollRec: Record "Payroll Statement")
    begin
    end;

    [IntegrationEvent(false, false)]
    procedure OnCancelPayrollStat_Approval(var PayrollRec: Record "Payroll Statement")
    begin
    end;
    //Event Creation End

    procedure IsPayrollStat_Enabled(var PayrollRec: Record "Payroll Statement"): Boolean
    var
        WFMngt: Codeunit "Workflow Management";
        WFCode: Codeunit WFCode_Payroll;
    begin
        exit(WFMngt.CanExecuteWorkflow(PayrollRec, WFCode.RunWorkflowOnSend_PayrollStatApprovalCode))
    end;

    local procedure CheckWorkflowEnabled(): Boolean
    var
        PayrollRec: Record "Payroll Statement";
        NoWorkflowEnb: TextConst ENU = 'No workflow Enabled for this Record type', ENG = 'No workflow Enabled for this Record type';
    begin
        if not IsPayrollStat_Enabled(PayrollRec) then
            Error(NoWorkflowEnb);
    end;

    procedure IsPayrollStatApprovalWorkflowEnabled(RequisitionRequests: Record "Payroll Statement"): Boolean
    begin
        exit(WFMngt.CanExecuteWorkflow(RequisitionRequests, RFQEventMgt.RunWorkflowOnSend_PayrollStatApprovalCode()));
    end;


    var
        WFMngt: Codeunit "Workflow Management";
        Text001: TextConst ENU = 'No Workflows Enabled';
        PayrollRec: Record "Payroll Statement";
        RFQEventMgt: Codeunit WFCode_Payroll;
        g_PRHeader: Record "Payroll Statement";












}