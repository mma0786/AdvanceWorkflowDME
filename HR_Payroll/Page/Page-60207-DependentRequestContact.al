page 60207 "Dependent Request Contact"
{
    AutoSplitKey = true;
    Caption = 'Dependent Contact';
    PageType = ListPart;
    SourceTable = "Dependent New Contacts Line";
    UsageCategory = Administration;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Request No"; No2)
                {
                    ApplicationArea = All;
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                }
                field(Type; Type)
                {
                    ApplicationArea = All;
                }
                field("Contact Number & Address"; "Contact Number & Address")
                {
                    ApplicationArea = All;
                }
                field(Extension; Extension)
                {
                    ApplicationArea = All;
                }
                field(Primary; Primary)
                {
                    ApplicationArea = All;
                }
                field("Line No"; "Line No")
                {
                    ApplicationArea = All;
                }
            }
        }
    }


}

