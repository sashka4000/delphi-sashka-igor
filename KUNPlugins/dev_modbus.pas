unit dev_modbus;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, dev_base_form, Vcl.StdCtrls,
  Vcl.ComCtrls, CRCUnit, Vcl.Samples.Spin, Vcl.Grids, Vcl.ValEdit;

type
  TfrmModbus = class(TfrmBase)
    lbl17: TLabel;
    seNumber: TSpinEdit;
    lbl1: TLabel;
    lst1: TValueListEditor;
  private
    { Private declarations }
  public
    { Public declarations }
    Cash : Variant;
    procedure UpdateListValue (var T :TMessage); message WM_USER + 1;
  end;

  TModbus = class(TBaseDevice)
    FCRC : TCRCCreator;
    procedure SwapBuffer (T : TArray<Byte>; Pos, Count : Integer);
    constructor Create (F : TFrmBaseClass);
    destructor  Destroy; override;
    function OnDataReceive(pd: PByte; PacketSize: Integer; MaxSize: Integer; var AnswerSize: Integer): HRESULT; override; stdcall;
  end;

const
  gModbus: TGUID = '{1ADE3ADA-EA57-4663-9E1D-4DEB1A4CE17D}';  // √лобальный идентификатор, генерируютс€ по Ctrl+Shift+G


implementation

{$R *.dfm}

{ TModbus }

constructor TModbus.Create(F: TFrmBaseClass);
begin
   inherited;
   FCRC := TCRCCreator.Create(crc16ModbusLSB);
end;

destructor TModbus.Destroy;
begin
  FCRC.Free;
  inherited;
end;

function TModbus.OnDataReceive(pd: PByte; PacketSize, MaxSize: Integer;
  var AnswerSize: Integer): HRESULT;
var
  TR, TA: TArray<Byte>;
  FMyForm: TfrmModbus;
  RegAddRess : Word;
  mbFunc  : Byte;
  mbAddress : Word;
  CRC : Word;
  vW : Word;
  vI : Integer;
  VF : Single;
  vS : SHORT;
  FS: TFormatSettings;
  procedure SetError;
  begin
     TA[1] := TA[1] + $80;
     TA[2] := $02;
     SetLength(TA,5);
  end;
begin
 Result := inherited;

 FMyForm := TfrmModbus(MyForm);
  // преобразование указател€ к типу массив байт

  TR := TArray<Byte>(pd);

  if FCRC.GetCRC(TR,PacketSize) <> 0 then
   Exit;

  // провер€ю адрес устройства в первом байте
  if TR[0] <> FMyForm.seNumber.Value then
    Exit;

  mbFunc := TR[1];
  move (TR[2],mbAddress,2);
  mbAddress := Swap(mbAddress);

  TA := TArray <Byte>.Create ($00, mbFunc, $04, $00, $00, $00, $00, $00, $00);

  case mbFunc of
   $01 :
   begin
     case mbAddress of
       0,1 :
      begin
         vW := StrToIntDef (FMyForm.lst1.Cells [1,1+ mbAddress],0);
         if vw > 1 then
           vW := 1;
         Move(vW,TA[3],2);
         TA[2] := $02;
         SetLength(TA,Length(TA)-2);
      end
      else
       SetError;
     end;
   end;
   $03 :
   begin
      case mbAddress of
      0 :
      begin
         vW := StrToIntDef (FMyForm.lst1.Cells [1,3],0);
         vW := Swap(vW);
         Move(vW,TA[3],2);
         TA[2] := $02;
         SetLength(TA,Length(TA)-2);
      end;
      1 :
        begin
         vS := StrToIntDef (FMyForm.lst1.Cells [1,4],0);
         vS := Swap(vS);
         Move(vS,TA[3],2);
         TA[2] := $02;
         SetLength(TA,Length(TA)-2);
        end;
      2 :
       begin
         FS := TFormatSettings.Create;
         vF := StrToFloatDef (StringReplace(FMyForm.lst1.Cells [1,5],'.',FS.DecimalSeparator,[rfReplaceAll]),0);
         Move(vF,TA[3],4);
         SwapBuffer(TA,3,4);
        end;
      4 :
        begin
         vI:= StrToIntDef (FMyForm.lst1.Cells [1,6],0);
         Move(vI,TA[3],4);
         SwapBuffer(TA,3,4);
        end;
      else
       SetError;
      end;
   end;
   $04 :
   begin
     case mbAddress of
      0,1 :
      begin
         vW := StrToIntDef (FMyForm.lst1.Cells [1,7+ mbAddress],0);
         vW := Swap(vW);
         Move(vW,TA[3],2);
         TA[2] := $02;
         SetLength(TA,Length(TA)-2);
      end
      else
       SetError;
      end;
   end;
   $05 :
   begin
     case mbAddress of
      0,1 :
      begin
         if TR[4] = $FF
         then
           vW := 1
         else
           vW := 0;
         FMyForm.Cash := vW;
         PostMessage (FMyForm.Handle,WM_USER+1, 1,1+ mbAddress);
         SetLength(TA,PacketSize);
         Move(TR[0],TA[0],PacketSize);
      end
      else
       SetError;
     end;
    end;
    $10 :
    begin
     case mbAddress of
      0 :
      begin
         vW := 0;
         Move(TR[7],vW,2);
         vW := Swap(vW);
         FMyForm.Cash := vW;
         PostMessage (FMyForm.Handle,WM_USER+1, 1,3);
         SetLength(TA,8);
         Move(TR[0],TA[0],8);
      end;
      1 :
        begin
         vS := 0;
         Move(TR[7],vS,2);
         vS := Swap(vS);
         FMyForm.Cash := vS;
         PostMessage (FMyForm.Handle,WM_USER+1, 1,4);
         SetLength(TA,8);
         Move(TR[0],TA[0],8);
        end;
      2 :
       begin
         vF := 0;
         SwapBuffer(TR,7,4);
         Move(TR[7],vF,4);
         FMyForm.Cash := vF;
         PostMessage (FMyForm.Handle,WM_USER+1, 1,5);
         SetLength(TA,8);
         Move(TR[0],TA[0],8);
        end;
      4 :
        begin
         vI := 0;
         SwapBuffer(TR,7,4);
         Move(TR[7],vI,4);
         FMyForm.Cash := vI;
         PostMessage (FMyForm.Handle,WM_USER+1, 1,6);
         SetLength(TA,8);
         Move(TR[0],TA[0],8);
        end;
      else
       SetError;
      end;
   end
   else
       SetError;
  end;

  TA[0] := FMyForm.seNumber.Value;

  AnswerSize := Length(TA);

  CRC := FCRC.GetCRC(TA,Length(TA)-2);
  TA[High(TA)-1] := Lo (CRC);
  TA[High(TA)]   := Hi (CRC);


   // провер€ю что ответ не превысил размер буфера
  if AnswerSize > MaxSize then
  begin
    Result := 1;
    Exit;
  end;

  // записываю буфер ответа во вход€щий буфер
  move(TA[0], TR[0], AnswerSize);

end;

procedure TModbus.SwapBuffer(T: TArray<Byte>; Pos, Count: Integer);
var
 b : Byte;
 i : Integer;
begin
 for i := 0 to Count div 2 - 1 do
   begin
      b := T[Pos + i];
      T[Pos + i] := T[Pos + Count - 1 - i];
      T[Pos + Count - 1 - i] := b;
   end;

end;

{ TfrmModbus }

procedure TfrmModbus.UpdateListValue(var T: TMessage);
begin
  lst1.Cells [T.WParam,T.LParam] :=  Cash;
end;

end.
