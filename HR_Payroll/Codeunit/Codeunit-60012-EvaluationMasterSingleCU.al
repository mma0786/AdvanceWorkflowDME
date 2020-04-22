codeunit 60012 "Evaluation Master Single CU"
{
    // version PHASE-2 LT_Performance Appraisal

    SingleInstance = true;

    trigger OnRun();
    begin
    end;

    var
        EarningCodeGrpCodeG : Code[150];

    procedure SetEarningCodeGroup(EarningCodeGrp_P : Code[150]);
    begin
        CLEAR(EarningCodeGrpCodeG);
        EarningCodeGrpCodeG := EarningCodeGrp_P;
    end;

    procedure GetEarningCodeGroup() : Code[150];
    begin
        exit(EarningCodeGrpCodeG);
    end;
}

