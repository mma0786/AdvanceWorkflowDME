table 60005 "HCM Leave Types"
{
    Caption = 'HCM Leave Types';
    DrillDownPageID = "Leave Types";
    LookupPageID = "Leave Types";

    fields
    {
        field(10; "Leave Type Id"; Code[20])
        {
            NotBlank = true;

            trigger OnValidate()
            begin
                /*
                LeaveAccrualComponentLines.RESET;
                LeaveAccrualComponentLines.SETRANGE("Accrual ID",Rec."Accrual ID");
                LeaveAccrualComponentLines.SETRANGE("Leave Type ID","Leave Type Id");
                LeaveAccrualComponentLines.DELETEALL;
                
                AccrualComponentLines.RESET;
                AccrualComponentLines.SETRANGE("Accrual ID",Rec."Accrual ID");
                IF AccrualComponentLines.FINDSET THEN
                  REPEAT
                        LeaveAccrualComponentLines.INIT;
                        LeaveAccrualComponentLines.TRANSFERFIELDS(AccrualComponentLines);
                        LeaveAccrualComponentLines."Leave Type ID" := Rec."Leave Type Id";
                        LeaveAccrualComponentLines.INSERT;
                  UNTIL AccrualComponentLines.NEXT =0;
                  */

            end;
        }
        field(15; "Earning Code"; Code[20])
        {
            TableRelation = "Payroll Earning Code" WHERE(Active = CONST(true));
        }
        field(20; Description; Text[100])
        {
        }
        field(21; "Short Name"; Code[20])
        {

            trigger OnValidate()
            begin
                if (xRec."Short Name" <> '') and (xRec."Short Name" <> "Short Name") then begin
                    DeleteLeaveTypeFormulas(xRec."Short Name", 3);
                end;
                if "Short Name" <> '' then
                    InsertLeaveTypeFormulas("Short Name");
            end;
        }
        field(25; "Max Days"; Integer)
        {
        }
        field(30; "Max Times"; Integer)
        {
        }
        field(40; "Min Service Days"; Integer)
        {
        }
        field(50; "Min Days Before Req"; Integer)
        {
        }
        field(60; "Max Occurance"; Integer)
        {
        }
        field(65; "Min Days Avail"; Integer)
        {
        }
        field(70; "Max Days Avail"; Integer)
        {
        }
        field(80; "Exc Public Holidays"; Boolean)
        {
        }
        field(85; "Exc Week Offs"; Boolean)
        {
        }
        field(90; "Allow Half Day"; Boolean)
        {
        }
        field(105; "Entitlement Days"; Integer)
        {
        }
        field(110; "Request Advance"; Boolean)
        {
        }
        field(115; "Religion ID"; Code[20])
        {
            TableRelation = "Payroll Religion";
        }
        field(120; Nationality; Text[50])
        {

            trigger OnLookup()
            var
                CountryRegion: Record "Country/Region";
            begin
                CountryRegion.RESET;
                if PAGE.RUNMODAL(0, CountryRegion) = ACTION::LookupOK then begin
                    Nationality := CountryRegion.Name;
                end;
            end;
        }
        field(125; "Balance Round Off Type"; Code[20])
        {
        }
        field(130; "Leave Avail Basis"; Option)
        {
            OptionCaption = 'None,Joining Date,Probation End Date,Confirmation Date';
            OptionMembers = "None","Joining Date","Probation End Date","Confirmation Date";
        }
        field(135; Gender; Option)
        {
            OptionCaption = ' ,Female,Male';
            OptionMembers = " ",Female,Male;
        }
        field(140; "Pay Type"; Option)
        {
            OptionCaption = 'None,Paid,UnPaid';
            OptionMembers = "None",Paid,UnPaid;
        }
        field(145; "Leave Type"; Option)
        {
            OptionCaption = 'None,Days,Hours';
            OptionMembers = "None",Days,Hours;
        }
        field(150; Accrued; Boolean)
        {
        }
        field(155; "Max Days Accrual"; Integer)
        {
        }
        field(165; Active; Boolean)
        {
        }
        field(170; "Is System Defined"; Boolean)
        {

            trigger OnValidate()
            begin
                if "Is System Defined" then begin
                    "Max Days" := 0;
                    "Min Days Avail" := 0;
                    "Max Carry Forward" := 0;
                    "Max Days Accrual" := 0;
                    "Max Days Avail" := 0;
                    "Max Occurance" := 0;
                    "Max Times" := 0;
                    "Min Days Before Req" := 0;
                    "Min Days Between 2 leave Req." := 0;
                    "Min Service Days" := 0;
                    "Exc Public Holidays" := false;
                    "Exc Week Offs" := false;
                    "Allow Early Late Resumption" := false;
                    "Allow Encashment" := false;
                    "Allow Half Day" := false;
                    "Allow Negative" := false;
                    "Request Advance" := false;

                end;
            end;
        }
        field(175; "WorkFlow Required"; Boolean)
        {
        }
        field(180; "Attachment Mandate"; Boolean)
        {
        }
        field(190; RefTableId; Integer)
        {
        }
        field(195; "Benefit Id"; Code[20])
        {
            TableRelation = "HCM Benefit";
        }
        field(205; "Leave Classification"; Option)
        {
            OptionCaption = 'Other,Annual Leave,Sick Leave';
            OptionMembers = Other,"Annual Leave","Sick Leave";
        }
        field(210; "Allow Negative"; Boolean)
        {
        }
        field(225; "Allow Early Late Resumption"; Boolean)
        {
        }
        field(230; "Roll Over Years"; Integer)
        {
            MinValue = 1;
        }
        field(240; "Probation Entitlement Days"; Integer)
        {
        }
        field(245; "Attachment Mandatory Days"; Integer)
        {
        }
        field(246; "Leave Carry Over Benefit"; Code[20])
        {
        }
        field(247; "Allow Encashment"; Boolean)
        {
        }
        field(248; "Accrual ID"; Code[20])
        {
            TableRelation = "Accrual Components";

            trigger OnValidate()
            var
                IntervalMonthStart: Integer;
                IntervalMonthEnd: Integer;
                i: Integer;
            begin

                IF AccrualComponent.GET("Accrual ID") THEN BEGIN
                    "Accrual Description" := AccrualComponent.Description;
                    "Accrual Interval Basis Date" := AccrualComponent."Accrual Interval Basis Date";
                    "Months Ahead Calculate" := AccrualComponent."Months Ahead Calculate";
                    "Consumption Split by Month" := AccrualComponent."Consumption Split by Month";
                    "Accrual Basis Date" := AccrualComponent."Accrual Basis Date";
                    "Interval Month Start" := AccrualComponent."Interval Month Start";
                    "Accrual Units Per Month" := AccrualComponent."Accrual Units Per Month";
                    "Opening Additional Accural" := AccrualComponent."Opening Additional Accural";
                    "Max Carry Forward" := AccrualComponent."Max Carry Forward";
                    "CarryForward Lapse After Month" := AccrualComponent."CarryForward Lapse After Month";
                    "Repeat After Months" := AccrualComponent."Repeat After Months";
                    "Avail Allow Till" := AccrualComponent."Avail Allow Till";
                END
                ELSE BEGIN
                    "Accrual Description" := '';
                    "Accrual Interval Basis Date" := 0D;
                    "Months Ahead Calculate" := 0;
                    "Consumption Split by Month" := FALSE;
                    "Accrual Basis Date" := 0D;
                    "Interval Month Start" := 0;
                    "Accrual Units Per Month" := 0;
                    "Opening Additional Accural" := 0;
                    "Max Carry Forward" := 0;
                    "CarryForward Lapse After Month" := 0;
                    "Repeat After Months" := 0;
                    "Avail Allow Till" := "Avail Allow Till"::"Accrual Till Date";
                END;


            end;
        }
        field(249; "Accrual Description"; Text[100])
        {
        }
        field(250; "Accrual Interval Basis"; Option)
        {
            OptionCaption = ' ,Fixed,Employee Joining Date,Probation End/Confirm,Original Hire Date,Define Per Employee';
            OptionMembers = " ","Fixed","Employee Joining Date","Probation End/Confirm","Original Hire Date","Define Per Employee";
        }
        field(251; "Accrual Frequency"; Option)
        {
            OptionCaption = ' ,Daily,Weekly,Monthly,Annually';
            OptionMembers = " ",Daily,Weekly,Monthly,Annually;
        }
        field(252; "Accrual Policy Enrollment"; Option)
        {
            OptionCaption = ' ,Prorated,Full Accural,No Accural';
            OptionMembers = " ",Prorated,"Full Accural","No Accural";
        }
        field(253; "Accrual Award Date"; Option)
        {
            OptionCaption = ' ,Accural Period Start,Accural Period End';
            OptionMembers = " ","Accural Period Start","Accural Period End";
        }
        field(254; "Months Ahead Calculate"; Integer)
        {
        }
        field(255; "Consumption Split by Month"; Boolean)
        {
        }
        field(256; "Accrual Interval Basis Date"; Date)
        {
        }
        field(257; "Accrual Basis Date"; Date)
        {
        }
        field(258; "Min Days Between 2 leave Req."; Decimal)
        {
        }
        field(300; "Interval Month Start"; Integer)
        {
        }
        field(301; "Accrual Units Per Month"; Decimal)
        {
        }
        field(302; "Opening Additional Accural"; Decimal)
        {
        }
        field(304; "Max Carry Forward"; Decimal)
        {
        }
        field(305; "CarryForward Lapse After Month"; Decimal)
        {
        }
        field(306; "Repeat After Months"; Decimal)
        {
        }
        field(307; "Avail Allow Till"; Option)
        {
            OptionCaption = 'Accrual Till Date,End of Period';
            OptionMembers = "Accrual Till Date","End of Period";
        }
        field(350; "Roll Over Period"; Integer)
        {
        }
        field(351; "Cover Resource Mandatory"; Boolean)
        {
        }
        field(352; "Marital Status"; Text[30])
        {
            TableRelation = "Marital Status";
            // Commented By Avinash  TableRelation = Table50050;
        }
        field(500; "Termination Leave"; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; "Leave Type Id")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
    //Krishna
    trigger OnDelete()
    var
        RecLeaveTypeErnGrp: Record "HCM Leave Types ErnGrp";
    begin
        Clear(RecLeaveTypeErnGrp);
        RecLeaveTypeErnGrp.SetRange("Leave Type Id", Rec."Leave Type Id");
        if RecLeaveTypeErnGrp.FindFirst() then
            Error('You cannot delete this Leave Type as it is assigned to Earning Group Code %1', RecLeaveTypeErnGrp."Earning Code Group");
    end;

    var
        PayrollFormula: Record "Payroll Formula";
        AccrualComponent: Record "Accrual Components";
        AccrualComponentLines: Record "Accrual Component Lines";


    procedure InsertLeaveTypeFormulas(ShortName: Code[20])
    begin
        FixedFormula('AC_' + ShortName, 'Total number of days in a specific period.', 3, ShortName);
        FixedFormula('AC_' + ShortName + '_ESD', 'Entitlement service days for the period.', 3, ShortName);
        FixedFormula('AC_' + ShortName + '_TD', 'Total number of days between employee joining date and payroll period end date.', 3, ShortName);
        FixedFormula('AC_' + ShortName + '_TDFY', 'Total number of days between financial year start date and payroll period end date.', 3, ShortName);
        FixedFormula('AC_' + ShortName + '_TDY', 'Total number of  days between calendar year end date and payroll period end date.', 3, ShortName);
        FixedFormula('AC_' + ShortName + '_EJYC', 'Employee from last joining month anniversary to current pay period end date', 3, ShortName);
    end;


    procedure FixedFormula(FormulaKey: Code[100]; FormulaDescription: Text[250]; FormulaKeyType: Option Parameter,"Pay Component",Benefit,"Leave Type",Custom; ShortName: Code[20])
    begin
        if FormulaKey <> '' then begin
            if not PayrollFormula.GET(FormulaKey) then begin
                PayrollFormula.INIT;
                PayrollFormula."Formula Key" := FormulaKey;
                PayrollFormula."Formula description" := FormulaDescription;
                PayrollFormula."Formula Key Type" := FormulaKeyType;
                PayrollFormula."Short Name" := ShortName;
                PayrollFormula.INSERT;
            end;
        end;
    end;


    procedure DeleteLeaveTypeFormulas(ShortName: Code[20]; FormulaKeyType: Option Parameter,"Pay Component",Benefit,"Leave Type",Custom)
    begin
        PayrollFormula.RESET;
        PayrollFormula.SETCURRENTKEY("Short Name");
        PayrollFormula.SETRANGE("Short Name", ShortName);
        PayrollFormula.SETRANGE("Formula Key Type", FormulaKeyType);
        PayrollFormula.DELETEALL;
    end;
}

