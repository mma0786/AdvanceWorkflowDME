codeunit 70000 "BC Json Handling"
{
    trigger OnRun()
    var
        ParameterTable: Record "ParamList Data Table";
        EmpEarningCodePayComponentTable: Record "Emp. Earning Code  List Table";
        BenefitTable: Record "Emp. Benefits List Table";
        JsonText: Text;
    begin
        //  JsonText := CreateJSonFomatOfTable_LT(ParameterTable, EmpEarningCodePayComponentTable, BenefitTable);
        //  Message('My JSON : %1', JsonText);
        // CopyJsonStringIntoResultTable;
    end;

    procedure CreateJSonFomatOfTable_LT(ParameterTable: Record "ParamList Data Table";
                                         EmpEarningCodePayComponentTable: Record "Emp. Earning Code  List Table";
                                         BenefitTable: Record "Emp. Benefits List Table"): Text;
    var
        VJsonObjectLines: JsonObject;
        VJsonObjectLines1: JsonObject;
        VJsonArray: JsonArray;
        VJsonArrayLines: JsonArray;
        VJsonArrayHeader: JsonArray;
        JToken: JsonToken;

    begin
        //================================================ParamList Data Table"===============================================
        // Start here ParamList Data Table
        // @ ParameterTable       
        ParameterTable.Reset();
        if ParameterTable.FindSet() then
            repeat
                clear(VJsonObjectLines);

                VJsonObjectLines.Add('KeyId', ParameterTable.ParamList__KeyId);
                //VJsonObjectLines.Add('KeyValue',  ParameterTable.ParamList__KeyValue);
                VJsonObjectLines.Add('KeyValue', ParameterTable.GET_ParamList__KeyValueP_Code(ParameterTable."Entry No."));
                VJsonObjectLines.Add('DataType', ParameterTable.ParamList__DataType);

                VJsonArrayLines.Add(VJsonObjectLines);

            until ParameterTable.Next() = 0;
        JToken := VJsonArrayLines.AsToken();
        VJsonObjectLines1.Add('ParamList', JToken);
        // Stop here ParamList Data Table

        //======================================================Emp. Earning Code  List Table=================================
        // Start here Emp. Earning Code  List Table
        clear(VJsonObjectLines);
        Clear(JToken);
        Clear(VJsonArrayLines);
        EmpEarningCodePayComponentTable.Reset();
        if EmpEarningCodePayComponentTable.FindSet() then
            repeat
                clear(VJsonObjectLines);

                VJsonObjectLines.Add('Paycomponentcode', EmpEarningCodePayComponentTable.EECList__Paycomponentcode);

                // Start Below need to uncommented once got solution
                VJsonObjectLines.Add('UnitFormula', EmpEarningCodePayComponentTable.EECList__Pay_Comp_UnitFormula);
                //VJsonObjectLines.Add('UnitFormula', EmpEarningCodePayComponentTable.GET_FormulaEECList__UnitFormula_Code(EmpEarningCodePayComponentTable."Entry No."));
                // Stop

                //VJsonObjectLines.Add('Formulaforattendance', EmpEarningCodePayComponentTable.EECList__Formulaforattendance);
                VJsonObjectLines.Add('Formulaforattendance', EmpEarningCodePayComponentTable.GET_EECList__Formulaforattendance_Code(EmpEarningCodePayComponentTable."Entry No."));
                //VJsonObjectLines.Add('Formulafordays', EmpEarningCodePayComponentTable.EECList__Formulafordays);
                VJsonObjectLines.Add('Formulafordays', EmpEarningCodePayComponentTable.GET_EECList__Formulafordays_Code(EmpEarningCodePayComponentTable."Entry No."));
                VJsonObjectLines.Add('Paycomponenttype', EmpEarningCodePayComponentTable.EECList__Paycomponenttype);

                VJsonArrayLines.Add(VJsonObjectLines);

            until EmpEarningCodePayComponentTable.Next() = 0;

        JToken := VJsonArrayLines.AsToken();
        VJsonObjectLines1.Add('EECList', JToken);
        // Stop here Emp. Earning Code  List Table

        //=================================================Emp. Benefits List Table===============================================
        // Start here Emp. Benefits List Table
        clear(VJsonObjectLines);
        Clear(JToken);
        Clear(VJsonArrayLines);
        BenefitTable.Reset();
        if BenefitTable.FindSet() then
            repeat
                clear(VJsonObjectLines);

                VJsonObjectLines.Add('Benefitcode', BenefitTable.EBList__Benefitcode);
                //VJsonObjectLines.Add('UnitFormula', BenefitTable.EBList__UnitFormula);
                VJsonObjectLines.Add('UnitFormula', BenefitTable.GET_EBList__UnitFormula_Code(BenefitTable."Entry No."));
                //VJsonObjectLines.Add('ValueFormula', BenefitTable.EBList__ValueFormula);
                VJsonObjectLines.Add('ValueFormula', BenefitTable.GET_EBList__ValueFormula_Code(BenefitTable."Entry No."));
                //VJsonObjectLines.Add('EncashmentFormula', BenefitTable.EBList__EncashmentFormula);
                VJsonObjectLines.Add('EncashmentFormula', BenefitTable.GET_EBList__EncashmentFormula_Code(BenefitTable."Entry No."));

                VJsonArrayLines.Add(VJsonObjectLines);

            until BenefitTable.Next() = 0;

        JToken := VJsonArrayLines.AsToken();
        VJsonObjectLines1.Add('EBList', JToken);
        // Stop here Emp. Benefits List Table



        // Message('My JSON : %1', VJsonObjectLines1);

        exit(Format(VJsonObjectLines1));

    end;

    //####=================================================Copy Json String into Result Table===============================
    procedure CopyJsonStringIntoResultTable(var ResultRec_P: Record "Emp. Result Table"; APIJsonString: Text)
    var

        JsonObjectL: JsonObject;
        JsonArrayL: JsonArray;
        JsonTokenL: JsonToken;
        JsonToken2L: JsonToken;
    // Below Variable need to remove
    // // APIJsonString: Text;
    // // ResultRec_P: Record "Emp. Result Table";
    begin

        //APIJsonString := '{ "Results":[{"FormulaType":"P","BaseCode":"BS","FormulaID1":"[BS]","Result1":"50", "FormulaID2":"[C_BS]", "Result2":"81",  "FormulaID3":"[C_BS_DAYS]",  "Result3":"0",  "Error Log":"0" },   {   "FormulaType":"P",   "BaseCode":"HRA",  "FormulaID1":"[HRA]",    "Result1":"123", "FormulaID2":"[C_HRA]",    "Result2":"2.5",  "FormulaID3":"[C_HRA_DAYS]",  "Result3":"0",  "Error Log":"0"   },  {   "FormulaType":"B",  "BaseCode":"ALA",  "FormulaID1":"[BU_ALA]", "Result1":"63",   "FormulaID2":"[BA_ALA]", "Result2":"0",  "FormulaID3":"[BEA_ALA]",  "Result3":"0",  "Error Log":"0"  },  { "FormulaType":"B", "BaseCode":"VLCFB",  "FormulaID1":"[BU_VLCFB]",  "Result1":"0",   "FormulaID2":"[BA_VLCFB]",   "Result2":"31.5",  "FormulaID3":"[BEA_VLCFB]",  "Result3":"0",  "Error Log":"0"   }  ]}';

        JsonObjectL.ReadFrom(APIJsonString);
        JsonObjectL.Get('Results', JsonTokenL);
        JsonArrayL := JsonTokenL.AsArray();

        foreach JsonToken2L in JsonArrayL do begin

            JsonObjectL := JsonToken2L.AsObject();
            // Start  GEtting Val from Object / Array
            ResultRec_P.Init();
            ResultRec_P."Entry No." := 0;
            ResultRec_P.Insert(true);

            ResultRec_P.FormulaType := GetJsonTokenAsText(JsonObjectL, 'FormulaType');
            ResultRec_P.BaseCode := GetJsonTokenAsText(JsonObjectL, 'BaseCode');

            ResultRec_P.FormulaID1 := GetJsonTokenAsText(JsonObjectL, 'FormulaID1');
            ResultRec_P.Result1 := GetJsonTokenAsText(JsonObjectL, 'Result1');

            ResultRec_P.FormulaID2 := GetJsonTokenAsText(JsonObjectL, 'FormulaID2');
            ResultRec_P.Result2 := GetJsonTokenAsText(JsonObjectL, 'Result2');

            ResultRec_P.FormulaID3 := GetJsonTokenAsText(JsonObjectL, 'FormulaID3');
            ResultRec_P.Result3 := GetJsonTokenAsText(JsonObjectL, 'Result3');

            ResultRec_P.SET_ErrorLog_Code(GetJsonTokenAsText(JsonObjectL, 'Error Log'), ResultRec_P."Entry No.");
            ResultRec_P.Modify();
            // Start  GEtting Val from Object / Array
        end;

    end;



    // ASD
    local procedure GetJsonTokenAsText(JsonObjectP: JsonObject; TokenKeyP: Text): Text
    var
        JsonTokenL: JsonToken;
        JsonValueL: JsonValue;
        ValueL: Text;
    begin
        if JsonObjectP.Get(TokenKeyP, JsonTokenL) then begin
            JsonValueL := JsonTokenL.AsValue();
            if not JsonValueL.IsNull then
                ValueL := JsonValueL.AsText();
        end;
        exit(ValueL);
    end;
    // ASD

    procedure CalledAzureAPI(JsonStringTxtL: Text): Text
    var
        Client: HttpClient;
        Response: HttpResponseMessage;
        Responsejson: Text;
        jsonObj: JsonObject;

    begin
        Clear(Response);
        Clear(Responsejson);
        //client.Post('https://azfntrialdme01.azurewebsites.net/api/AzFn-Pyrl?' + JsonStringTxtL, Response);
        //Reads the response content from the Azure Function
        Response.Content().ReadAs(Responsejson);
        //Here you need to parse jsonObj (the JSON of your response)
        //Message('%2 - App published: Hello world %1', json);
        exit(Responsejson)
    end;

    // POST Method API Sending
    procedure MakeRequest(uri: Text; payload: Text) responseText: Text;
    var
        client: HttpClient;
        request: HttpRequestMessage;
        response: HttpResponseMessage;
        contentHeaders: HttpHeaders;
        content: HttpContent;
    begin
        // Add the payload to the content
        content.WriteFrom(payload);

        // Retrieve the contentHeaders associated with the content
        content.GetHeaders(contentHeaders);
        contentHeaders.Clear();
        contentHeaders.Add('Content-Type', 'application/json');

        // Assigning content to request.Content will actually create a copy of the content and assign it.
        // After this line, modifying the content variable or its associated headers will not reflect in 
        // the content associated with the request message
        request.Content := content;

        request.SetRequestUri(uri);
        request.Method := 'POST';

        client.Send(request, response);

        // Read the response content as json.
        response.Content().ReadAs(responseText);
    end;
    // POST
}

