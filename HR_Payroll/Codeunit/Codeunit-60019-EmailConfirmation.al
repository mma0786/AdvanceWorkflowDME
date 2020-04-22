codeunit 60000 Email_Confirmation
{
    // version LT_HRMS-P1-009,PHASE-2 LT_Payroll Mission

    // Email
    // 


    trigger OnRun();
    begin
    end;

    var
        EmployeeRec: Record Employee;
        MailId: Text;
        SMTPSetup: Record "SMTP Mail Setup";
        SMTP: Codeunit "SMTP Mail";
        EmpName: Text;
        /// AssetAssigRec : Record Zetalents_GL_View;
        UserSetupRec: Record "User Setup";

    procedure Document_Request(DocumentRequest: Record "Document Request");
    begin
        IF EmployeeRec.GET(DocumentRequest."Employee ID") THEN BEGIN
            MailId := EmployeeRec."E-Mail";
            EmpName := EmployeeRec."First Name"
        END;

        SMTPSetup.RESET;
        SMTPSetup.GET;
        ////////////  SMTP.CreateMessage(USERID, SMTPSetup."User ID", MailId, DocumentRequest."Document Title", '', TRUE);
        SMTP.AppendBody('Dear Sir / Madam,');
        SMTP.AppendBody('<br><br>');
        SMTP.AppendBody('The ' + DocumentRequest."Document Title" + ' document ready');
        SMTP.AppendBody('<br><br>');
        SMTP.AppendBody('Regards');
        SMTP.AppendBody('<br>');
        SMTP.AppendBody(USERID);
        SMTP.Send;
    end;

    local procedure AssetRequest();
    begin
    end;

    // // // procedure ShortLeaveNote(ShortLeaveHeader : Record Table50043);
    // // // var
    // // //     l_ShortLeaveLine : Record Table50044;
    // // //     DateText : Text;
    // // //     l_EmpRec : Record Employee;
    // // //     UserRec : Record User;
    // // //     ApprUserSetup : Record "User Setup";
    // // //     UserAppId : Code[20];
    // // //     ApprUserSetup2 : Record "User Setup";
    // // //     ToEmailID : Text;
    // // //     EmailMsg : Label '"This is to inform you that short leave has been applied by "';
    // // // begin
    // // //     l_ShortLeaveLine.RESET;
    // // //     l_ShortLeaveLine.SETRANGE("Employee Id",ShortLeaveHeader."Employee Id");
    // // //     l_ShortLeaveLine.SETRANGE("Short Leave Request Id",ShortLeaveHeader."Short Leave Request Id");
    // // //     IF l_ShortLeaveLine.FINDFIRST THEN;

    // // //     IF EmployeeRec.GET(ShortLeaveHeader."Employee Id") THEN;
    // // //     IF l_EmpRec.GET(EmployeeRec."First Reporting ID") THEN;

    // // //     ApprUserSetup.RESET;
    // // //     ApprUserSetup.SETRANGE("Employee Id",l_EmpRec."No.");
    // // //     IF ApprUserSetup.FINDFIRST THEN

    // // //     IF ApprUserSetup."E-Mail" <> '' THEN BEGIN
    // // //       SMTPSetup.RESET;
    // // //       SMTPSetup.GET;
    // // //       DateText := FORMAT(ShortLeaveHeader."Request Date");
    // // //       SMTP.CreateMessage(USERID,SMTPSetup."User ID",ApprUserSetup."E-Mail",'Shor leave applied by '+ShortLeaveHeader."Employee Name",'',TRUE) ;
    // // //       SMTP.AppendBody('Dear ' + l_EmpRec.FullName +',');
    // // //       SMTP.AppendBody('<br><br>');
    // // //       SMTP.AppendBody(EmailMsg+'<B>'+ShortLeaveHeader."Employee Name"+'</B>'+' from '+'<B>'+FORMAT(l_ShortLeaveLine."Req. Start Time")+'</B>'+' - '+'<B>'+FORMAT(l_ShortLeaveLine."Req. End Time")  + ' on '+DateText +'</B>'+'.');
    // // //       SMTP.AppendBody('<br><br>');
    // // //       SMTP.AppendBody('Regards');
    // // //       SMTP.AppendBody('<br>');
    // // //       SMTP.AppendBody('ERP Admin.');
    // // //       SMTP.Send;
    // // //       MESSAGE('Notification Mail Sent');
    // // //     END;

    // // // end;

    // // procedure NewDLUpdate(DL_ReqRec: Record Table51000);
    // // var
    // //     EmailId: Text;
    // // begin
    // //     UserSetupRec.RESET;
    // //     UserSetupRec.SETRANGE("Employee Id", DL_ReqRec."Employee ID");
    // //     IF UserSetupRec.FINDFIRST THEN
    // //         EmailId := UserSetupRec."E-Mail";

    // //     IF EmailId <> '' THEN BEGIN
    // //         SMTPSetup.GET;
    // //         SMTP.CreateMessage(USERID, SMTPSetup."User ID", EmailId, 'Driving License Request approved', '', TRUE);
    // //         SMTP.AppendBody('Dear ' + DL_ReqRec."Employee Name" + '+');
    // //         SMTP.AppendBody('<br><br>');
    // //         SMTP.AppendBody('As per your request Driving License is approed');
    // //         SMTP.AppendBody('<br><br>');
    // //         SMTP.AppendBody('Regards');
    // //         SMTP.AppendBody('<br>');
    // //         SMTP.AppendBody('ERP Admin.');
    // //         SMTP.Send;
    // //     END;
    // // end;

    // // // procedure CarReg(CarRegistrationRequest: Record Table51002);
    // // // var
    // // //     EmailID: Text;
    // // // begin
    // // //     UserSetupRec.RESET;
    // // //     UserSetupRec.SETRANGE("Employee Id", CarRegistrationRequest."Employee Id");
    // // //     IF UserSetupRec.FINDFIRST THEN
    // // //         EmailID := UserSetupRec."E-Mail";

    // // //     IF EmailID <> '' THEN BEGIN
    // // //         SMTPSetup.GET;
    // // //         SMTP.CreateMessage(USERID, SMTPSetup."User ID", EmailID, 'Car Registration Request approved', '', TRUE);
    // // //         SMTP.AppendBody('Dear ' + CarRegistrationRequest."Employee Name" + '+');
    // // //         SMTP.AppendBody('<br><br>');
    // // //         SMTP.AppendBody('As per your request Driving License is approed');
    // // //         SMTP.AppendBody('<br><br>');
    // // //         SMTP.AppendBody('Regards');
    // // //         SMTP.AppendBody('<br>');
    // // //         SMTP.AppendBody('ERP Admin.');
    // // //         SMTP.Send;
    // // //     END;
    // // // end;

    local procedure "########################PHASE_____2################################"();
    begin
    end;

    // // // procedure MissionOrderEmployeeAlert(MissionOrderHeader: Record "Asset Assignment Register");
    // // // var
    // // //     EmailID: Text;
    // // //     MissionOrderLineRec_L: Record "Summary Payroll Cue";
    // // // begin
    // // //     MissionOrderLineRec_L.RESET;
    // // //     MissionOrderLineRec_L.SETRANGE("Primary Key", MissionOrderHeader."Transaction Type");
    // // //     IF MissionOrderLineRec_L.FINDSET THEN BEGIN
    // // //         CLEAR(EmailID);
    // // //         UserSetupRec.RESET;
    // // //         UserSetupRec.SETRANGE("Employee Id", MissionOrderLineRec_L."Driving Licence Request");
    // // //         IF UserSetupRec.FINDFIRST THEN
    // // //             EmailID := UserSetupRec."E-Mail";

    // // //         IF EmailID <> '' THEN BEGIN
    // // //             SMTPSetup.GET;
    // // //             SMTP.CreateMessage(USERID, SMTPSetup."User ID", EmailID, 'Mission Order Report Submission', '', TRUE);
    // // //             SMTP.AppendBody('Dear ' + MissionOrderLineRec_L."Car Registration Request" + '+');
    // // //             SMTP.AppendBody('<br><br>');
    // // //             SMTP.AppendBody('This is to inform you that the Mission Order' + MissionOrderLineRec_L."Primary Key" + ' is open for submitting the Mission Report and attaching the supporting documents.');
    // // //             SMTP.AppendBody('<br><br>');
    // // //             SMTP.AppendBody('Regards');
    // // //             SMTP.AppendBody('<br>');
    // // //             SMTP.AppendBody('ERP Admin.');
    // // //             SMTP.Send;
    // // //         END;

    // // //     END;
    // // // end;

    // // // procedure MissionOrderEmployeeVisaReqAlert(MissionOrderHeader: Record "Asset Assignment Register");
    // // // var
    // // //     EmailID: Text;
    // // //     MissionOrderLineRec_L: Record "Summary Payroll Cue";
    // // // begin
    // // //     MissionOrderLineRec_L.RESET;
    // // //     MissionOrderLineRec_L.SETRANGE("Primary Key", MissionOrderHeader."Transaction Type");
    // // //     IF MissionOrderLineRec_L.FINDSET THEN BEGIN
    // // //         CLEAR(EmailID);
    // // //         UserSetupRec.RESET;
    // // //         UserSetupRec.SETRANGE("Employee Id", MissionOrderLineRec_L."Driving Licence Request");
    // // //         IF UserSetupRec.FINDFIRST THEN
    // // //             EmailID := UserSetupRec."E-Mail";

    // // //         IF EmailID <> '' THEN BEGIN
    // // //             SMTPSetup.GET;
    // // //             SMTP.CreateMessage(USERID, SMTPSetup."User ID", EmailID, 'Mission Order VISA Request', '', TRUE);
    // // //             SMTP.AppendBody('Dear ' + MissionOrderLineRec_L."Car Registration Request" + '+');
    // // //             SMTP.AppendBody('<br><br>');
    // // //             SMTP.AppendBody('This is to inform you that, you have been sleected for the Mission ' + MissionOrderHeader."Issue Date" + ', Create a visa request against this Mission Order ' + MissionOrderHeader."Transaction Type");
    // // //             SMTP.AppendBody('<br><br>');
    // // //             SMTP.AppendBody('Regards');
    // // //             SMTP.AppendBody('<br>');
    // // //             SMTP.AppendBody('ERP Admin.');
    // // //             SMTP.Send;
    // // //         END;

    // // //     END;
    // // // end;
}

