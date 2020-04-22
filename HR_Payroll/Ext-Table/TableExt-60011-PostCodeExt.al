tableextension 60011 PostCodeExt extends "Post Code"
{
    fields
    {
        // Add changes to table fields here
    }
    trigger OnDelete()
    var
        myInt: Integer;
    begin
        //    ValidateDelete;
    end;

    /*
        local procedure ValidateDelete()
        var
            EmpAddressLineRec: Record 60071;
            EmplCreaAddRec: Record 60071;
            DepAddRec: Record 60071;
            Text000: Label '%1 %2 already exists.';
            Error001: Label 'Record cannot be Deleted.';
        begin
            // <Lt Check Employee Address>
            EmpAddressLineRec.RESET;
            EmpAddressLineRec.SETRANGE("Country/Region Code", "Country/Region Code");
            IF EmpAddressLineRec.FINDFIRST THEN
                ERROR(Error001);

            EmpAddressLineRec.RESET;
            EmpAddressLineRec.SETRANGE("Post Code", Code);
            IF EmpAddressLineRec.FINDFIRST THEN
                ERROR(Error001);

            EmpAddressLineRec.RESET;
            EmpAddressLineRec.SETRANGE(City, City);
            IF EmpAddressLineRec.FINDFIRST THEN
                ERROR(Error001);
            // </Lt Check Employee Address>

            // <Lt Check Employee Creation Address>
            EmplCreaAddRec.RESET;
            EmplCreaAddRec.SETRANGE("Country/Region Code", "Country/Region Code");
            IF EmplCreaAddRec.FINDFIRST THEN
                ERROR(Error001);

            EmplCreaAddRec.RESET;
            EmplCreaAddRec.SETRANGE("Post Code", Code);
            IF EmplCreaAddRec.FINDFIRST THEN
                ERROR(Error001);

            EmplCreaAddRec.RESET;
            EmplCreaAddRec.SETRANGE(City, City);
            IF EmplCreaAddRec.FINDFIRST THEN
                ERROR(Error001);
            // </Lt Check Employee Creation Address>

            // <Lt Check Employee Dependant Address>
            DepAddRec.RESET;
            DepAddRec.SETRANGE("Country/Region Code", "Country/Region Code");
            IF DepAddRec.FINDFIRST THEN
                ERROR(Error001);

            DepAddRec.RESET;
            DepAddRec.SETRANGE("Post Code", Code);
            IF DepAddRec.FINDFIRST THEN
                ERROR(Error001);

            DepAddRec.RESET;
            DepAddRec.SETRANGE(City, City);
            IF DepAddRec.FINDFIRST THEN
                ERROR(Error001);
            // </Lt Check Employee Dependant Address>
        end;
        */

    var
        myInt: Integer;
}