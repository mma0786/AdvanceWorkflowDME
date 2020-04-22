page 60014 "Formula Designer"
{
    UsageCategory = Lists;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(Control19)
            {
                field("Key Input"; KeyInput)
                {
                    ApplicationArea = All;
                }
            }
            group(Control7)
            {
                field(Parameters; Parameters)
                {
                    ApplicationArea = All;
                    TableRelation = "Payroll Formula" WHERE("Formula Key Type" = CONST(Parameter));
                }
                field("Pay Components"; PayComponents)
                {
                    ApplicationArea = All;
                    TableRelation = "Payroll Formula" WHERE("Formula Key Type" = CONST("Pay Component"));
                }
                field(Benefits; Benefits)
                {
                    ApplicationArea = All;
                    TableRelation = "Payroll Formula" WHERE("Formula Key Type" = CONST(Benefit));
                }
                field("Leave Types"; LeaveTypes)
                {
                    ApplicationArea = All;
                    TableRelation = "Payroll Formula" WHERE("Formula Key Type" = CONST("Leave Type"));
                }
                field("Custom Formula Key"; CustomFormulaKeys)
                {
                    ApplicationArea = All;
                    TableRelation = "Payroll Formula" WHERE("Formula Key Type" = CONST(Custom));
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action(Add)
            {
                ApplicationArea = All;
                Caption = 'Add';
                Image = Add;
                Promoted = true;
                PromotedCategory = Category4;

                trigger OnAction()
                begin
                    KeyInput := KeyInput + Parameters + PayComponents + Benefits + LeaveTypes + CustomFormulaKeys;
                    CLEAR(Parameters);
                    CLEAR(PayComponents);
                    CLEAR(Benefits);
                    CLEAR(LeaveTypes);
                    CLEAR(CustomFormulaKeys);
                end;
            }
            action("Test Formula")
            {
                ApplicationArea = All;
                Caption = 'Test Formula';
                Image = TestFile;
                Promoted = true;
                PromotedCategory = Category4;

                trigger OnAction()
                begin
                    //
                end;
            }
            action("Clear Input")
            {
                ApplicationArea = All;
                Caption = 'Clear Input';
                Image = ClearFilter;
                Promoted = true;
                PromotedCategory = Category4;

                trigger OnAction()
                begin
                    Calc('C');
                end;
            }
        }
    }

    var
        KeyInput: Text;
        Parameters: Text;
        PayComponents: Text;
        Benefits: Text;
        LeaveTypes: Text;
        CustomFormulaKeys: Text;

    //commented By Avinash  [Scope('Internal')]
    procedure Calc(input: Char)
    begin
        case input of
            'C':
                begin
                    CLEAR(KeyInput);
                end;
        end;
        /*
        CASE input OF
           '+':
              BEGIN
                 IF (flag > 1) AND (ClearScreen <> 1) THEN BEGIN
                    EVALUATE(two,str);
                    one :=  perform(one,two,operation);
                    str :=  FORMAT(one);
                 END;
                 IF (flag = 1) AND (str <> '') THEN BEGIN
                    EVALUATE(one,str);
                    str  :=  '';
                    flag :=  flag + 1;
                 END;
                 ClearScreen :=  1;
                 operation :=  '+';
              END;
           '-':
              BEGIN
                 IF (flag > 1) AND (ClearScreen <> 1) THEN BEGIN
                    EVALUATE(two,str);
                    one :=  perform(one,two,operation);
                    str :=  FORMAT(one);
                 END;
                 IF (flag = 1) AND (str <> '') THEN BEGIN
                    EVALUATE(one,str);
                    str  :=  '';
                    flag :=  flag + 1;
                 END;
                 ClearScreen :=  1;
                 operation :=  '-';
              END;
           '*':
              BEGIN
                 IF (flag > 1) AND (ClearScreen <> 1) THEN BEGIN
                    EVALUATE(two,str);
                    one :=  perform(one,two,operation);
                    str :=  FORMAT(one);
                 END;
                 IF (flag = 1) AND (str <> '') THEN BEGIN
                    EVALUATE(one,str);
                    str  :=  '';
                    flag :=  flag + 1;
                 END;
                 ClearScreen :=  1;
                 operation :=  '*';
              END;
           '/':
              BEGIN
                 IF (flag > 1) AND (ClearScreen <> 1) THEN BEGIN
                    EVALUATE(two,str);
                    one :=  perform(one,two,operation);
                    str :=  FORMAT(one);
                 END;
                 IF (flag = 1) AND (str <> '') THEN BEGIN
                    EVALUATE(one,str);
                    str  :=  '';
                    flag :=  flag + 1;
                 END;
                 ClearScreen :=  1;
                 operation :=  '/';
              END;
           '=':
              BEGIN
                 IF (str <> '') AND (one <> 0 )THEN BEGIN
                    EVALUATE(two,str);
                    one :=  perform(one,two,operation);
                    str := FORMAT(one);
                 END;
                 CLEAR(two);
                 ClearScreen  :=  1;
                 flag         :=  1;
              END;
           'X':
              BEGIN
                 IF str <> '' THEN BEGIN
                    EVALUATE(one,str);
                    str := FORMAT((1 / one));
                 END;
              END;
           '%':
              BEGIN
                 IF (flag > 1) AND (ClearScreen <> 1) THEN BEGIN
                    EVALUATE(two,str);
                    one :=  perform(one,two,operation);
                    str :=  FORMAT(one);
                 END;
                 IF (flag = 1) AND (str <> '') THEN BEGIN
                    EVALUATE(one,str);
                    str  :=  '';
                    flag :=  flag + 1;
                 END;
                 ClearScreen :=  1;
                 operation :=  '%';
              END;
           'S':
              BEGIN
                 IF str <> '' THEN BEGIN
                    EVALUATE(one,str);
                    str := FORMAT(POWER(one , 0.5));
                    ClearScreen  := 1;
                 END;
              END;
           'C':
              BEGIN
                 CLEARALL;
                 flag         := 1;
                 ClearScreen  := 1;
              END;
           'B':
              IF str <> '' THEN
                 str := COPYSTR(str,1,(STRLEN(str) - 1));
           'O':
              BEGIN
                 IF str <> '' THEN BEGIN
                    EVALUATE(one,str);
                    two := ROUND(one,1,'<');
                    CLEAR(str);
                    WHILE two >= 1 DO BEGIN
                       str :=  str + FORMAT(two MOD 8);
                       two :=  ROUND((two / 8),1,'<');
                    END;
        
                    CLEAR(temp);
                    temp  :=  str;
                    CLEAR(str);
        
                    WHILE temp <> '' DO BEGIN
                       str   :=  str + COPYSTR(temp,STRLEN(temp),1);
                       temp  :=  COPYSTR(temp,1,STRLEN(temp) - 1);
                    END;
                 END;
                 ClearScreen  := 1;
              END;
           'D':
              BEGIN
                 IF str <> '' THEN BEGIN
                    EVALUATE(one,str);
                    two := ROUND(one,1,'<');
                    CLEAR(str);
                    WHILE two >= 1 DO BEGIN
                       str :=  str + FORMAT(two MOD 2);
                       two :=  ROUND((two / 2),1,'<');
                    END;
        
                    CLEAR(temp);
                    temp  :=  str;
                    CLEAR(str);
        
                    WHILE temp <> '' DO BEGIN
                       str   :=  str + COPYSTR(temp,STRLEN(temp),1);
                       temp  :=  COPYSTR(temp,1,STRLEN(temp) - 1);
                    END;
                 END;
                 ClearScreen  := 1;
              END;
           'E':
              BEGIN
                 IF str <> '' THEN BEGIN
                    EVALUATE(one,str);
                    one := ROUND(one,1);
                    str := FORMAT(one);
        
                    IF (one MOD 2) = 0 THEN
                       MESSAGE(' Even Number')
                    ELSE
                       MESSAGE(' Odd Number ');
                 END;
              END;
           'P':
              BEGIN
                 IF str <> '' THEN BEGIN
                    CLEAR(j);
                    EVALUATE(one,str);
                    one := ROUND(one,1);
                    str := FORMAT(one);
                    j   := prime(one);
                    IF one = j THEN
                       MESSAGE(' Prime Number')
                    ELSE
                       MESSAGE(' Not Prime Number');
                 END;
              END;
           '_':
              BEGIN
                 IF str[1] = '-' THEN
                    str := COPYSTR(str,2)
                 ELSE
                    str := '-' + str;
              END;
           '.':
              IF STRPOS(str,'.') = 0 THEN BEGIN
                 str         :=  str + '.';
                 ClearScreen :=  0;
              END;
           ELSE
              MESSAGE(' Invalid Operation    %1',Key);
        END;
        IF STRLEN(str) > 35 THEN BEGIN
           CLEAR(operation);
           str          := 'E';
           flag         := 1;
           ClearScreen  := 1;
        END;
        */

    end;
}

