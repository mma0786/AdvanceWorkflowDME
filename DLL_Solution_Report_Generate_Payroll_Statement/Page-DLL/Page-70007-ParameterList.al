page 70007 "Parameter List"
{
    PageType = List;
    SourceTable = "ParamList Data Table";
    UsageCategory = Lists;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(ParamList__KeyId; ParamList__KeyId)
                {
                }
                field("Entry No."; "Entry No.")
                {
                }
                field(ParamList__KeyValue; ParamList__KeyValue)
                {
                }
                field(ParamList__DataType; ParamList__DataType)
                {
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Run Code unit")
            {
                Image = ShowList;
                ApplicationArea = All;
                Promoted = true;
                PromotedIsBig = true;
                // RunObject = codeunit "BC Json Handling";
            }
        }
    }
}

