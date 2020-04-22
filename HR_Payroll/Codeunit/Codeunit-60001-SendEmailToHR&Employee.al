codeunit 60001 "Send Email To HR & Employee"
{

    // // // trigger OnRun();
    // // // begin
    // // //     EmployeeRec2_G.RESET;
    // // //     EmployeeRec2_G.SETFILTER("No.", '<>%1', '');
    // // //     if EmployeeRec2_G.FINDSET then
    // // //         repeat
    // // //             //CreateAlertForEmployeeIdentificationExpiryDoc90_LT('EMP-00003');
    // // //             CreateAlertForEmployeeIdentificationExpiryDoc90_LT(EmployeeRec2_G."No.");
    // // //             CreateAlertForEmployeeDepentedIdentificationExpiryDoc_LT(EmployeeRec2_G."No.");
    // // //         until EmployeeRec2_G.NEXT = 0;
    // // //     //CreateEmail_Body_LT_TEST('EMP-00003');
    // // // end;

    // // // var
    // // //     SMTPMail: Codeunit "SMTP Mail";
    // // //     UserSetupRec_G: Record "User Setup";
    // // //     EmployeeRec_G: Record Employee;
    // // //     ////IdentificationMasterRec_G: Record Table50003;
    // // //     ResourcesSetupRec_G: Record "Resources Setup";
    // // //     EmployeeRec2_G: Record Employee;

    // // // procedure CreateEmail_Body_LT(EmployeeNo_P: Code[30]; Subject_P: Text; EmployeeFullName_P: Text; ExpDate_P: Date; DocType_P: Text);
    // // // begin
    // // //     UserSetupRec_G.RESET;
    // // //     UserSetupRec_G.SETRANGE("Employee Id", EmployeeNo_P);
    // // //     if UserSetupRec_G.FINDFIRST then begin
    // // //         //MESSAGE('%1',UserSetupRec_G."E-Mail");
    // // //         SMTPMail.CreateMessage(UserSetupRec_G."User ID", UserSetupRec_G."E-Mail", UserSetupRec_G."E-Mail", Subject_P, '', true);
    // // //         SMTPMail.AppendBody('Dear ' + EmployeeFullName_P + ', <BR><BR>');
    // // //         SMTPMail.AppendBody('The expiry date for ' + DocType_P + ' is nearing expiry Dated: ' + FORMAT(ExpDate_P) + '. ');
    // // //         SMTPMail.AppendBody('Please initiate the required actions.');
    // // //         SMTPMail.AppendBody('<BR><BR>');
    // // //         SMTPMail.AppendBody('Regards,<BR> ERP Admin.<BR><BR>');
    // // //         ResourcesSetupRec_G.RESET;
    // // //         ResourcesSetupRec_G.GET;
    // // //         ResourcesSetupRec_G.TESTFIELD("HR Email ID");
    // // //         SMTPMail.AddCC(ResourcesSetupRec_G."HR Email ID");
    // // //         SMTPMail.Send;
    // // //     end;
    // // // end;

    // // // local procedure CreateAlertForEmployeeIdentificationExpiryDoc90_LT(EmployeeCode_P: Code[30]);
    // // // begin
    // // //     EmployeeRec_G.RESET;
    // // //     if EmployeeRec_G.GET(EmployeeCode_P) then;
    // // //     IdentificationMasterRec_G.RESET;
    // // //     IdentificationMasterRec_G.SETRANGE("Employee No.", EmployeeCode_P);
    // // //     if IdentificationMasterRec_G.FINDSET then begin
    // // //         repeat
    // // //             //MESSAGE('%1',(IdentificationMasterRec_G."Expiry Date" - TODAY));
    // // //             if IdentificationMasterRec_G."Expiry Date" <> 0D then begin
    // // //                 if ((IdentificationMasterRec_G."Expiry Date" - TODAY) = 90) or ((IdentificationMasterRec_G."Expiry Date" - TODAY) = 30) then
    // // //                     CreateEmail_Body_LT(EmployeeCode_P, 'Expiry notification for Identification Document', EmployeeRec_G.FullName, IdentificationMasterRec_G."Expiry Date", IdentificationMasterRec_G."Identification Type");
    // // //             end
    // // //         until IdentificationMasterRec_G.NEXT = 0;
    // // //     end;
    // // // end;

    // // // procedure CreateEmail_Body_Dependent_LT(EmployeeNo_P: Code[30]; Subject_P: Text; EmployeeFullName_P: Text; ExpDate_P: Date; DocType_P: Text; Depented_Name_P: Text);
    // // // begin
    // // //     UserSetupRec_G.RESET;
    // // //     UserSetupRec_G.SETRANGE("Employee Id", EmployeeNo_P);
    // // //     if UserSetupRec_G.FINDFIRST then begin
    // // //         //MESSAGE('%1',UserSetupRec_G."E-Mail");
    // // //         SMTPMail.CreateMessage(UserSetupRec_G."User ID", UserSetupRec_G."E-Mail", UserSetupRec_G."E-Mail", Subject_P, '', true);

    // // //         SMTPMail.AppendBody('Dear ' + EmployeeFullName_P + ', <BR><BR>');
    // // //         SMTPMail.AppendBody('The expiry date for ' + DocType_P + ' of ' + Depented_Name_P + ' is nearing expiry Dated: ' + FORMAT(ExpDate_P) + '. ');
    // // //         SMTPMail.AppendBody('Please initiate the required actions.');
    // // //         SMTPMail.AppendBody('<BR><BR>');
    // // //         SMTPMail.AppendBody('Regards,<BR> ERP Admin.<BR><BR>');
    // // //         ResourcesSetupRec_G.RESET;
    // // //         ResourcesSetupRec_G.GET;
    // // //         ResourcesSetupRec_G.TESTFIELD("HR Email ID");
    // // //         SMTPMail.AddCC(ResourcesSetupRec_G."HR Email ID");
    // // //         SMTPMail.Send;

    // // //     end;
    // // // end;

    // // // local procedure CreateAlertForEmployeeDepentedIdentificationExpiryDoc_LT(EmployeeNo_P: Code[30]);
    // // // var
    // // //     EmployeeDependentsMasterRec_L: Record Table50004;
    // // //     EmployeeRec_L: Record Employee;
    // // //     IdentificationMasterRec_L: Record Table50003;
    // // // begin
    // // //     /// MESSAGE('1');
    // // //     EmployeeRec_L.RESET;
    // // //     if EmployeeRec_L.GET(EmployeeNo_P) then begin
    // // //         EmployeeDependentsMasterRec_L.RESET;
    // // //         EmployeeDependentsMasterRec_L.SETRANGE("Employee ID", EmployeeRec_L."No.");
    // // //         if EmployeeDependentsMasterRec_L.FINDSET then begin

    // // //             repeat
    // // //                 IdentificationMasterRec_L.RESET;
    // // //                 IdentificationMasterRec_L.SETRANGE("Document Type", IdentificationMasterRec_L."Document Type"::"2");
    // // //                 //IdentificationMasterRec_L.SETRANGE("No.",EmployeeRec_L."No.");
    // // //                 IdentificationMasterRec_L.SETRANGE("Dependent No", EmployeeDependentsMasterRec_L."No.");
    // // //                 // MESSAGE('Emp on .%1   Dep No.  %2    %3',EmployeeRec_L."No.",EmployeeDependentsMasterRec_L."No.");
    // // //                 if IdentificationMasterRec_L.FINDFIRST then begin
    // // //                     // MESSAGE('LAst waka inside but if outside');
    // // //                     if ((IdentificationMasterRec_L."Expiry Date" - TODAY) = 90) or ((IdentificationMasterRec_L."Expiry Date" - TODAY) = 30) then begin
    // // //                         CreateEmail_Body_Dependent_LT(EmployeeNo_P,
    // // //                                                        'Expiry notification for Identification Document',
    // // //                                                        EmployeeRec_L.FullName,
    // // //                                                        IdentificationMasterRec_L."Expiry Date",
    // // //                                                        IdentificationMasterRec_L."Identification Type",
    // // //                                                        EmployeeDependentsMasterRec_L."Dependent First Name" + ' ' + EmployeeDependentsMasterRec_L."Dependent Middle Name" + ' ' + EmployeeDependentsMasterRec_L."Dependent Last Name");
    // // //                         // MESSAGE('LAst waka inside');
    // // //                     end;
    // // //                 end;
    // // //             until EmployeeDependentsMasterRec_L.NEXT = 0;
    // // //         end
    // // //     end;


    // // //     //MESSAGE('LAst waka');
    // // // end;
}

