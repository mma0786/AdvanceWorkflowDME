page 60301 "Work Time Template Card-Ramadn"
{
    // version LT_Payroll

    PageType = Document;
    SourceTable = "Work Time Template - Ramadn";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Work Time ID"; "Work Time ID")
                {
                }
                field("Template Name"; "Template Name")
                {
                }
                field("From Date"; "From Date")
                {
                }
                field("To Date"; "To Date")
                {
                }
            }

            group("Control28")
            {
                Caption = 'Sunday';
                part(Sunday; "Work Time SunSubform-Ramadn")
                {
                    Caption = 'Sunday';
                    SubPageLink = "Work Time ID" = FIELD("Work Time ID");
                    SubPageView = WHERE(Weekday = FILTER(Sunday));
                    UpdatePropagation = Both;
                }
                field("Sunday Calculation Type"; "Sunday Calculation Type")
                {
                    Visible = false;
                }
                field("Sunday No. Of Hours"; "Sunday No. Of Hours")
                {
                    Editable = false;
                }
            }
            group(Control29)
            {
                Caption = 'Monday';
                part(Monday; "Work Time MonSubform -Ramadn")
                {
                    Caption = 'Monday';
                    SubPageLink = "Work Time ID" = FIELD("Work Time ID");
                    SubPageView = WHERE(Weekday = FILTER(Monday));
                    UpdatePropagation = Both;
                }
                field("Monday Calculation Type"; "Monday Calculation Type")
                {
                    Visible = false;
                }
                field("Monday No. Of Hours"; "Monday No. Of Hours")
                {
                    Editable = false;
                }
            }
            group(Control30)
            {
                Caption = 'Tuesday';
                part(Tuesday; "Work TimeTuesSubform-Ramadn")
                {
                    Caption = 'Tuesday';
                    SubPageLink = "Work Time ID" = FIELD("Work Time ID");
                    SubPageView = WHERE(Weekday = FILTER(Tuesday));
                    UpdatePropagation = Both;
                }
                field("Tuesday Calculation Type"; "Tuesday Calculation Type")
                {
                    Visible = false;
                }
                field("Tuesday No. Of Hours"; "Tuesday No. Of Hours")
                {
                    Editable = false;
                }
            }
            group(Control31)
            {
                Caption = 'Wednesday';
                part(Wednesday; "Work Time WedSubform-Ramadan")
                {
                    Caption = 'Wednesday';
                    SubPageLink = "Work Time ID" = FIELD("Work Time ID");
                    SubPageView = WHERE(Weekday = FILTER(Wednesday));
                    UpdatePropagation = Both;
                }
                field("Wednesday Calculation Type"; "Wednesday Calculation Type")
                {
                    Visible = false;
                }
                field("Wednesday No. Of Hours"; "Wednesday No. Of Hours")
                {
                    Editable = false;
                }
            }
            group(Control32)
            {
                Caption = 'Thursday';
                part(Thursday; "Work TimeThuSubform-Ramadan")
                {
                    Caption = 'Thursday';
                    SubPageLink = "Work Time ID" = FIELD("Work Time ID");
                    SubPageView = WHERE(Weekday = FILTER(Thursday));
                    UpdatePropagation = Both;
                }
                field("Thursday Calculation Type"; "Thursday Calculation Type")
                {
                    Visible = false;
                }
                field("Thursday No. Of Hours"; "Thursday No. Of Hours")
                {
                    Editable = false;
                }
            }
            group(Control33)
            {
                Caption = 'Friday';
                part(Friday; "Work TimeFriSubform-Ramadan")
                {
                    Caption = 'Friday';
                    SubPageLink = "Work Time ID" = FIELD("Work Time ID");
                    SubPageView = WHERE(Weekday = FILTER(Friday));
                    UpdatePropagation = Both;
                }
                field("Friday Calculation Type"; "Friday Calculation Type")
                {
                    Visible = false;
                }
                field("Friday No. Of Hours"; "Friday No. Of Hours")
                {
                    Editable = false;
                }
            }



            group(Control34)
            {
                Caption = 'Saturday';
                field("Saturday Calculation Type"; "Saturday Calculation Type")
                {
                    Visible = false;
                }
                field("Saturday No. Of Hours"; "Saturday No. Of Hours")
                {
                    Editable = false;
                }
                part(Saturday; "Work Time SatSubform-Ramadn")
                {
                    Caption = 'Saturday';
                    SubPageLink = "Work Time ID" = FIELD("Work Time ID");
                    SubPageView = WHERE(Weekday = FILTER(Saturday));
                    UpdatePropagation = Both;
                }


            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Update Work Calendar")
            {
                Caption = 'Update Work Calendar';
                Image = Copy;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;

                trigger OnAction();
                var
                    WorkTimeTemplate: Record "Work Time Template";
                    CopyWorkTimeTemplate: Report "Copy Work Time Template";
                begin
                    /*
                    CLEAR(CopyWorkTimeTemplate);
                    WorkTimeTemplate.RESET;
                    WorkTimeTemplate.SETFILTER("Work Time ID",'<>%1',"Work Time ID");
                    IF WorkTimeTemplate.FINDLAST THEN ;
                    CopyWorkTimeTemplate.SetValues(Rec."Work Time ID",WorkTimeTemplate."Work Time ID");
                    CopyWorkTimeTemplate.RUNMODAL;
                    CurrPage.UPDATE;
                    */
                    UpdateCalTime;

                end;
            }
        }
    }

    var
        WorkTimeTemplate: Record "Work Time Template";
}

