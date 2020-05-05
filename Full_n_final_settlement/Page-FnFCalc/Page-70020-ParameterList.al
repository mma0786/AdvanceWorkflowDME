page 70020 "Parameter List FnFCalc"
{
    PageType = List;
    SourceTable = "ParamList Data Table FnFCalc";
    UsageCategory = Lists;
    ApplicationArea = All;
    DeleteAllowed = false;
    ModifyAllowed = false;
    InsertAllowed = false;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Entry No."; "Entry No.")
                {
                }
                field(ParamList__KeyId; ParamList__KeyId)
                {
                }

                field(ParamList__KeyValueTxt; ParamList__KeyValueTxt)
                {
                }
                field(ParamList__DataType; ParamList__DataType)
                {
                }
            }
        }
    }
    var
        ParamList__KeyValueTxt: Text;

    trigger OnAfterGetRecord()
    begin
        ParamList__KeyValueTxt := GET_ParamList__KeyValueP();
    end;


}

