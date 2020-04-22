page 60175 UserPictureDetails
{
    Caption = 'Profile';
    DeleteAllowed = false;
    InsertAllowed = false;
    LinksAllowed = false;
    PageType = CardPart;
    SourceTable = Employee;

    layout
    {
        area(content)
        {
            field(EmpName; EmpName)
            {
                Editable = false;
                Importance = Promoted;
                Style = Strong;
                StyleExpr = TRUE;
                ApplicationArea = All;
            }
            field(Image; Image)
            {
                ApplicationArea = Basic, Suite;
                ShowCaption = false;
                ToolTip = 'Specifies the picture of the employee.';
            }
            group(Control5)
            {
                field(DepartmentName; DepartmentName)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                group(Control11)
                {
                    field(PositionName; PositionName)
                    {
                        Editable = false;
                        ApplicationArea = All;
                    }
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(TakePicture)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Take';
                Image = Camera;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Activate the camera on the device.';
                Visible = CameraAvailable;

                trigger OnAction()
                var
                //commented By Avinash CameraOptions: DotNet CameraOptions;
                begin
                    if not CameraAvailable then
                        exit;
                    //commented By Avinash
                    // CameraOptions := CameraOptions.CameraOptions;
                    // CameraOptions.Quality := 100;
                    // CameraProvider.RequestPictureAsync(CameraOptions);
                    //commented By Avinash
                end;
            }
            action(ImportPicture)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Import';
                Image = Import;
                ToolTip = 'Import a picture file.';

                trigger OnAction()
                var
                    FileManagement: Codeunit "File Management";
                    FileName: Text;
                    ClientFileName: Text;
                begin
                    if Image.HASVALUE then
                        if not CONFIRM(OverrideImageQst) then
                            exit;

                    //commented By Avinash  FileName := FileManagement.UploadFile(SelectPictureTxt, ClientFileName);
                    if FileName = '' then
                        exit;

                    CLEAR(Image);
                    //commented By Avinash  Image.IMPORTFILE(FileName, ClientFileName);
                    MODIFY(true);
                    //commented By Avinashif FileManagement.DeleteServerFile(FileName) then;
                end;
            }
            action(ExportFile)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Export';
                Enabled = DeleteExportEnabled;
                Image = Export;
                ToolTip = 'Export the picture to a file.';

                trigger OnAction()
                var
                    NameValueBuffer: Record "Name/Value Buffer";
                    TempNameValueBuffer: Record "Name/Value Buffer" temporary;
                    FileManagement: Codeunit "File Management";
                    ToFile: Text;
                    ExportPath: Text;
                begin
                    //commented By Avinash
                    // NameValueBuffer.DELETEALL;
                    // ExportPath := TEMPORARYPATH + "No." + FORMAT(Image.MEDIAID);
                    // Image.EXPORTFILE(ExportPath);
                    // FileManagement.GetServerDirectoryFilesList(TempNameValueBuffer, TEMPORARYPATH);
                    // TempNameValueBuffer.SETFILTER(Name, STRSUBSTNO('%1*', ExportPath));
                    // TempNameValueBuffer.FINDFIRST;
                    // ToFile := STRSUBSTNO('%1 %2 %3.jpg', "No.", "First Name", "Last Name");
                    // DOWNLOAD(TempNameValueBuffer.Name, DownloadImageTxt, '', '', ToFile);
                    // if FileManagement.DeleteServerFile(TempNameValueBuffer.Name) then;
                    //commented By Avinash
                end;
            }
            action(DeletePicture)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Delete';
                Enabled = DeleteExportEnabled;
                Image = Delete;
                ToolTip = 'Delete the record.';

                trigger OnAction()
                begin
                    if not CONFIRM(DeleteImageQst) then
                        exit;

                    CLEAR(Image);
                    MODIFY(true);
                end;
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        SetEditableOnPictureActions;
    end;

    trigger OnAfterGetRecord()
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        if UserSetup.FINDFIRST then begin
            //commented By Avinash SETRANGE("No.", UserSetup."Employee Id");
            //commented By Avinash CALCFIELDS(Picture);
            EmpName := WelComtex + FullName;
            // if PayrollJobTitle.GET("Job Title") then
            //     PositionName := PayrollJobTitle.Description;

            if PayrollDepartment.GET(Department) then
                DepartmentName := PayrollDepartment.Description
        end;
    end;

    trigger OnOpenPage()
    begin
        //commented By Avinash
        // CameraAvailable := CameraProvider.IsAvailable;
        // if CameraAvailable then
        //     CameraProvider := CameraProvider.Create;
        //commented By Avinash
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        if UserSetup.FINDFIRST then begin
            //commented By Avinash  SETRANGE("No.", UserSetup."Employee Id");
            //CALCFIELDS(Picture);
            //MESSAGE("No.");
        end;
    end;

    var
        //commented By Avinash
        // [RunOnClient]
        // [WithEvents]
        //commented By Avinash CameraProvider: DotNet CameraProvider;
        //commented By Avinash
        CameraAvailable: Boolean;
        OverrideImageQst: Label 'The existing picture will be replaced. Do you want to continue?';
        DeleteImageQst: Label 'Are you sure you want to delete the picture?';
        SelectPictureTxt: Label 'Select a picture to upload';
        DeleteExportEnabled: Boolean;
        DownloadImageTxt: Label 'Download image';
        UserSetup: Record "User Setup";
        EmpName: Text;
        DepartmentName: Text[150];
        PositionName: Text[150];
        WelComtex: Label 'Welcome ';
        PayrollDepartment: Record "Payroll Department";
    // PayrollJobTitle: Record "Payroll Job Title";

    local procedure SetEditableOnPictureActions()
    begin
        DeleteExportEnabled := Image.HASVALUE;
    end;
    //commented By Avinash
    //commented By Avinash

    // // trigger CameraProvider::PictureAvailable(PictureName: Text; PictureFilePath: Text)
    // // var
    // //     File: File;
    // //     Instream: InStream;
    // // begin
    // //     if (PictureName = '') or (PictureFilePath = '') then
    // //         exit;

    // //     if Image.HASVALUE then
    // //         if not CONFIRM(OverrideImageQst) then begin
    // //             if ERASE(PictureFilePath) then;
    // //             exit;
    // //         end;

    // //     File.OPEN(PictureFilePath);
    // //     File.CREATEINSTREAM(Instream);

    // //     CLEAR(Image);
    // //     Image.IMPORTSTREAM(Instream, PictureName);
    // //     MODIFY(true);

    // //     File.CLOSE;
    // //     if ERASE(PictureFilePath) then;
    // // end;
    //commented By Avinash
    //commented By Avinash
}

