page 60159 "Employee Request"
{
    Caption = 'Employee Request';
    PageType = CardPart;
    RefreshOnActivate = true;
    ShowFilter = false;
    SourceTable = "Summary Payroll Cue";
    SourceTableView = SORTING("Primary Key")
                      ORDER(Ascending);
    UsageCategory = Administration;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            cuegroup(" ")
            {
                field("Car Registration Request"; "Car Registration Request")
                {
                    ApplicationArea = All;
                    //commented By Avinash   DrillDownPageID = 51003;
                }
                field("Driving Licence Request"; "Driving Licence Request")
                {
                    ApplicationArea = Basic, Suite;
                    //commented By Avinash   DrillDownPageID = 51000;
                }
                field("Visa Request"; "Visa Request")
                {
                    ApplicationArea = Basic, Suite;
                    //commented By Avinash  DrillDownPageID = 51019;
                }
                field("IQAMA Request"; "IQAMA Request")
                {
                    ApplicationArea = Basic, Suite;
                    //commented By Avinash  DrillDownPageID = 51024;
                }

                actions
                {
                    action("Edit Payment Journal")
                    {
                        ApplicationArea = ALL;
                        Caption = 'Edit Payment Journal';
                        InFooterBar = true;
                        Promoted = true;
                        PromotedIsBig = true;
                        RunObject = Page "Payment Journal";
                        ToolTip = 'Pay your vendors by filling the payment journal automatically according to payments due, and potentially export all payment to your bank for automatic processing.';
                    }
                    action("New Purchase Credit Memo")
                    {
                        ApplicationArea = ALL;
                        Caption = 'New Purchase Credit Memo';
                        RunObject = Page "Purchase Credit Memo";
                        RunPageMode = Create;
                        ToolTip = 'Specifies a new purchase credit memo so you can manage returned items to a vendor.';
                    }
                    action("Edit Purchase Journal")
                    {
                        ApplicationArea = ALL;
                        Caption = 'Edit Purchase Journal';
                        RunObject = Page "Purchase Journal";
                        ToolTip = 'Post purchase invoices in a purchase journal that may already contain journal lines.';
                    }
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetCurrRecord()
    begin
        //O365GettingStartedMgt.UpdateGettingStartedVisible(TileGettingStartedVisible,ReplayGettingStartedVisible);
    end;

    trigger OnAfterGetRecord()
    var
        DocExchServiceSetup: Record "Doc. Exch. Service Setup";
    begin
        /*CalculateCueFieldValues;
        ShowDocumentsPendingDocExchService := FALSE;
        IF DocExchServiceSetup.GET THEN
          ShowDocumentsPendingDocExchService := DocExchServiceSetup.Enabled;
        SetActivityGroupVisibility;
        
        */

    end;

    trigger OnInit()
    begin
        O365GettingStartedMgt.UpdateGettingStartedVisible(TileGettingStartedVisible, ReplayGettingStartedVisible);
    end;

    trigger OnOpenPage()
    var
        OCRServiceMgt: Codeunit "OCR Service Mgt.";
        RoleCenterNotificationMgt: Codeunit "Role Center Notification Mgt.";
    begin
        RESET;
        if not GET then begin
            INIT;
            INSERT;
        end;
        /*SETFILTER("Due Date Filter",'>=%1',WORKDATE);
        SETFILTER("Overdue Date Filter",'<%1',WORKDATE);
        SETFILTER("Due Next Week Filter",'%1..%2',CALCDATE('<1D>',WORKDATE),CALCDATE('<1W>',WORKDATE));
        SETRANGE("User ID Filter",USERID);
        
        HasCamera := CameraProvider.IsAvailable;
        IF HasCamera THEN
          CameraProvider := CameraProvider.Create;
        
        IF UserTours.IsAvailable THEN BEGIN
          UserTours := UserTours.Create;
          UserTours.NotifyShowTourWizard;
          IF O365GettingStartedMgt.IsGettingStartedSupported THEN
            UserTours.ShowPlayer
          ELSE
            UserTours.HidePlayer;
        END ELSE
          IF PageNotifier.IsAvailable THEN BEGIN
            PageNotifier := PageNotifier.Create;
            PageNotifier.NotifyPageReady;
          END;
        
        ShowCamera := TRUE;
        ShowStartActivities := TRUE;
        ShowSalesActivities := TRUE;
        ShowPurchasesActivities := TRUE;
        ShowPaymentsActivities := TRUE;
        ShowIncomingDocuments := TRUE;
        ShowAwaitingIncomingDoc := OCRServiceMgt.OcrServiceIsEnable;
        
        RoleCenterNotificationMgt.ShowNotifications;
        */

    end;

    var
        ActivitiesMgt: Codeunit "Activities Mgt.";
        //commented By Avinash  CueSetup: Codeunit "Cue Setup";
        O365GettingStartedMgt: Codeunit "O365 Getting Started Mgt.";
        //commented By Avinash  [RunOnClient]
        //commented By Avinash   [WithEvents]
        //commented By Avinash  CameraProvider: DotNet CameraProvider;
        //commented By Avinash  [RunOnClient]
        //commented By Avinash   [WithEvents]
        //commented By Avinash  UserTours: DotNet UserTours;
        //commented By Avinash  [RunOnClient]
        //commented By Avinash   [WithEvents]
        //commented By Avinash   PageNotifier: DotNet PageNotifier;
        HasCamera: Boolean;
        ShowCamera: Boolean;
        ShowDocumentsPendingDocExchService: Boolean;
        ShowStartActivities: Boolean;
        ShowIncomingDocuments: Boolean;
        ShowPaymentsActivities: Boolean;
        ShowPurchasesActivities: Boolean;
        ShowSalesActivities: Boolean;
        ShowAwaitingIncomingDoc: Boolean;
        TileGettingStartedVisible: Boolean;
        ReplayGettingStartedVisible: Boolean;

    local procedure CalculateCueFieldValues()
    begin
        /*IF FIELDACTIVE("Overdue Sales Invoice Amount") THEN
          "Overdue Sales Invoice Amount" := ActivitiesMgt.CalcOverdueSalesInvoiceAmount;
        IF FIELDACTIVE("Overdue Purch. Invoice Amount") THEN
          "Overdue Purch. Invoice Amount" := ActivitiesMgt.CalcOverduePurchaseInvoiceAmount;
        IF FIELDACTIVE("Sales This Month") THEN
          "Sales This Month" := ActivitiesMgt.CalcSalesThisMonthAmount;
        IF FIELDACTIVE("Top 10 Customer Sales YTD") THEN
          "Top 10 Customer Sales YTD" := ActivitiesMgt.CalcTop10CustomerSalesRatioYTD;
        IF FIELDACTIVE("Average Collection Days") THEN
          "Average Collection Days" := ActivitiesMgt.CalcAverageCollectionDays;
          */

    end;

    local procedure SetActivityGroupVisibility()
    var
    //commented By Avinash  StartActivitiesMgt: Codeunit "Start Activities Mgt.";
    //commented By Avinash   SalesActivitiesMgt: Codeunit "Sales Activities Mgt.";
    //commented By Avinash   PurchasesActivitiesMgt: Codeunit "Purchases Activities Mgt.";
    //commented By Avinash  PaymentsActivitiesMgt: Codeunit "Payments Activities Mgt.";
    //commented By Avinash  IncDocActivitiesMgt: Codeunit "Inc. Doc. Activities Mgt.";
    begin
        /*ShowStartActivities := StartActivitiesMgt.IsActivitiesVisible;
        ShowSalesActivities := SalesActivitiesMgt.IsActivitiesVisible;
        ShowPurchasesActivities := PurchasesActivitiesMgt.IsActivitiesVisible;
        ShowPaymentsActivities := PaymentsActivitiesMgt.IsActivitiesVisible;
        ShowIncomingDocuments := IncDocActivitiesMgt.IsActivitiesVisible;
        ShowCamera := HasCamera AND ShowIncomingDocuments;
        */

    end;

    //commented By Avinash 
    /*

        trigger CameraProvider::PictureAvailable(PictureName: Text; PictureFilePath: Text)
        var
            IncomingDocument: Record "Incoming Document";
        begin
            /*IncomingDocument.CreateIncomingDocumentFromServerFile(PictureName,PictureFilePath);
            CurrPage.UPDATE;
            */

    //commented By Avinash  end;
    /*
        trigger UserTours::ShowTourWizard(hasTourCompleted: Boolean)
        begin
            //O365GettingStartedMgt.LaunchWizard(FALSE,hasTourCompleted);
        end;

        trigger UserTours::IsTourInProgressResultReady(isInProgress: Boolean)
        begin
        end;

        trigger PageNotifier::PageReady()
        var
            O365GettingStarted: Record "O365 Getting Started";
            PermissionManager: Codeunit "Permission Manager";
            WizardHasBeenShownToUser: Boolean;
        begin
    */

    //commented By Avinash 

    /*IF NOT (CURRENTCLIENTTYPE IN [CLIENTTYPE::Tablet,CLIENTTYPE::Phone]) THEN
      EXIT;

    IF NOT PermissionManager.SoftwareAsAService THEN
      EXIT;

    WizardHasBeenShownToUser := O365GettingStarted.GET(USERID,CURRENTCLIENTTYPE);
    IF NOT WizardHasBeenShownToUser THEN
      PAGE.RUNMODAL(PAGE::"O365 Getting Started Device");
      */

    //commented By Avinash   end;
}

