page 60128 "Leave Accural Subpage"
{
    AutoSplitKey = true;
    DelayedInsert = true;
    MultipleNewLines = true;
    PageType = ListPart;
    SourceTable = "Accrual Component Lines";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Interval Month Start"; "Interval Month Start")
                {
                    ApplicationArea = All;
                }
                field("Interval Month End"; "Interval Month End")
                {
                    ApplicationArea = All;
                }
                field("Accrual Units Per Month"; "Accrual Units Per Month")
                {
                    ApplicationArea = All;
                }
                field("Opening Additional Accural"; "Opening Additional Accural")
                {
                    ApplicationArea = All;
                }
                field("Max Carry Forward"; "Max Carry Forward")
                {
                    ApplicationArea = All;
                }
                field("CarryForward Lapse After Month"; "CarryForward Lapse After Month")
                {
                    ApplicationArea = All;
                }
                field("Repeat After Months"; "Repeat After Months")
                {
                    ApplicationArea = All;
                }
                field("Avail Allow Till"; "Avail Allow Till")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Calculate Accruals")
            {
                Image = Allocate;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;
                trigger OnAction()
                var
                    i: Integer;
                    AccrualComponent: Record "Accrual Components";
                begin
                    /*
                    AccrualComponentLines.RESET;
                    AccrualComponentLines.SETRANGE("Accrual ID","Accrual ID");
                    IF AccrualComponentLines.FINDFIRST THEN
                      IF NOT CONFIRM('Accrual Lines Exist, Do you want to delete and recreate ?') THEN
                        EXIT;
                    
                    AccrualComponentLines.RESET;
                    AccrualComponentLines.SETRANGE("Accrual ID","Accrual ID");
                    AccrualComponentLines.DELETEALL;
                    
                    AccrualComponent.GET("Accrual ID");
                    AccrualComponent.TESTFIELD("Months Ahead Calculate");
                    FOR i:= 1 TO AccrualComponent."Months Ahead Calculate" DO BEGIN
                        AccrualComponentLines.INIT;
                        AccrualComponentLines."Accrual ID" := AccrualComponent."Accrual ID";
                        AccrualComponentLines."Line No." := i*10000;
                        AccrualComponentLines.INSERT;
                    END;
                    */

                end;
            }
        }
    }

    var
        AccrualComponentLines: Record "Accrual Component Lines";
}

