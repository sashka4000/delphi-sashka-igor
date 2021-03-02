unit dev_ksl_otis;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Samples.Spin,
  dev_base_form, ext_global;

type
  TfrmKSL = class(TfrmBase)
    chkMass15: TCheckBox;
    chkData: TCheckBox;
    cbbError: TComboBox;
    edt1: TEdit;
    seKCSInterface: TSpinEdit;
    chkNoLift: TCheckBox;
    seKSLNumber: TSpinEdit;
    cbbLift: TComboBox;
    seFloor: TSpinEdit;
    lbl11: TLabel;
    lbl10: TLabel;
    lbl8: TLabel;
    lbl7: TLabel;
    procedure chkNoLiftClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

 TKSLOTis = class (TBaseDevice)
   function OnDataReceive (pd : PByte; PacketSize : Integer; MaxSize : Integer;  var AnswerSize : Integer) : HRESULT; override; stdcall;
  end;

const
  gKSLOtis : TGUID =  '{61542E8A-1835-4D17-8509-980C5A7E56E4}';  // Глобальный идентификатор, генерируются по Ctrl+Shift+G

implementation

{$R *.dfm}

{ TKSLOTis }

function TKSLOTis.OnDataReceive(pd: PByte; PacketSize, MaxSize: Integer;
  var AnswerSize: Integer): HRESULT;
var
FMyForm : TfrmKSL;
begin
  inherited;
  {
  // Внимание! Проверка на то, что устройства нет, делается внизу
   // перед send

   if TA[0] = ($D0 + seKSLNumber.Value)  then
   begin
     if (IO.InterfaceNumber <> seKCSInterface.Value+1) or
      (IO.Baud <> 9600) or (IO.Char <> 8) then
     begin
       Log ('!!! ОШИБКА Некорректный интерфейс');
       Sleep(TimeOut);
       Exit;
      end;
     rsType := rsKSL;
     LastKCSUpdateTime := Now;
   end;

   if RSType = rsNone then
     Exit;

   tmp := '';

   if TA[1] = $01  then
   begin
      tmp := ' (тип RS-устройства)';
      if RSTYpe = rsKSL then
      begin
       if chkData.Checked
       then
         TA := TArray<Byte>.Create ($D0,$81,$03,$07,$03,$02,$A0)
       else
         TA := TArray<Byte>.Create ($D0,$81,$03,$07,$01,$02,$A0);
      end;
      bSendAnswer := True;
   end;

   if TA[1] = $0D  then
   begin
      tmp := ' (версия прошивки)';
      if RSType = rsKSL then
        TA := TArray<Byte>.Create ($D0,$8D,$02,$01,$10,$00);
      bSendAnswer := True;
   end;

   if (RSType = rsKSL) and (P_Selected >= 0) then
   begin
       if chkNoLift.Checked
        then Q.SulConnected := 0
        else Q.SulConnected := 1;
       if chkMass15.Checked
        then Q.Mass15 := 1
        else Q.Mass15 := 0;
       Q.Floor := seFloor.Value;
       Q.Door1 := 0;
       Q.Door2 := 0;
       Q.Door3 := 0;
       Q.ErrNum := cbbError.ItemIndex;
   end;


   if TA[1] = $05  then
   begin
      tmp := ' (текущее состояние)';
     // Текущее состояние - без ответа
     if (RSType = rsKSL) and (P_Selected >= 0) then
     begin
       Q.DataType := $05;
       if P[P_Selected].Driver.GetAnswerPacket(Q,@Buff[0],255,Cnt) = 0 then
       begin
         TA := TArray<Byte>.Create(Cnt+3);
         TA[0] := $D0;
         TA[1] := $85;
         for I := 0 to Cnt do
          TA[i + 2] := Buff [i];
         bSendAnswer := True;
       end;
     end;
   end;

   if TA[1] = $09  then
   begin
       tmp := ' (оперативные данные)';
       if RSType = rsKSL then
       begin
         if P_Selected >= 0 then
         begin
           Q.DataType := $09;
           if P[P_Selected].Driver.GetAnswerPacket(Q,@Buff[0],255,Cnt) = 0 then
           begin
             TA := TArray<Byte>.Create(Cnt+3);
             TA[0] := $D0;
             TA[1] := $89;
             for I := 0 to Cnt do
               TA[i + 2] := Buff [i];
             bSendAnswer := True;
           end;
         end else
         begin
           bSendAnswer := True;
           if chkNoLift.Checked
           then
              TA := TArray<Byte>.Create ($D0,$89,$01,$08,$00)
           else
           begin
             case cbbError.ItemIndex of
              0: TA := TArray<Byte>.Create ($D0,$89,$05,$08,seFloor.Value,$6F,$2B,$05,$00);   // OTIS
              1: TA := TArray<Byte>.Create ($D0,$89,$07,$08,seFloor.Value,$6F,$2B,$05,$6D,$B6,$00);
              2: TA := TArray<Byte>.Create ($D0,$89,$07,$08,seFloor.Value,$6F,$2B,$05,$DC,$2C,$00);
             end;
           end;
         end;
       end;

   end;

   // Нет КСЛ
   if (rsType = rsKSL) and (cbbLift.ItemIndex = 0) then
   begin
     sleep (TimeOut);
     Exit;
   end;

   if bSendAnswer then
   begin
      if RSType = rsKSL then
       TA[0] := $D0 + seKSLNumber.Value;
      CRC (TA);
      if seRSDelay.Value > 0 then
       sleep (seRSDelay.Value);
      TA_HEADER := TArray <Byte>.Create (TA[0],TA[1],TA[2]);
      AContext.Connection.IOHandler.Write(TA_HEADER);
      Log ('5000 (1)>> ' + ByteArrayToStr(TA_HEADER) + tmp);
      if seRSDelay2.Value > 0 then
       sleep (seRSDelay2.Value);
      TA_HEADER := Copy(TA,3,Length(TA)-3);
      Log ('5000 (2)>> ' + ByteArrayToStr(TA_HEADER) + tmp);
      AContext.Connection.IOHandler.Write(TA_HEADER);
   end
  }
end;

procedure TfrmKSL.chkNoLiftClick(Sender: TObject);
begin
  cbbError.Enabled := not chkNoLift.Checked;
  seFloor.Enabled    := not chkNoLift.Checked;
  lbl8.Enabled       := not chkNoLift.Checked;
end;

end.
