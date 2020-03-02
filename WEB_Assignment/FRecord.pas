unit FRecord;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  uniGUITypes, uniGUIAbstractClasses, uniGUIClasses, uniGUIForm, uniButton,
  uniCalendar, uniGUIBaseClasses, uniMultiItem, uniListBox, uniDBListBox,
  uniDBLookupListBox, uniCalendarPanel, uniEdit, uniDateTimePicker, uniLabel,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error,
  FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async,
  FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TfrmRecord = class(TUniForm)
    lstTrip: TUniDBLookupListBox;
    lstUser: TUniDBLookupListBox;
    btnOk: TUniButton;
    btnCancel: TUniButton;
    undtComment: TUniEdit;
    undtmpckrBegin: TUniDateTimePicker;
    unlbl1: TUniLabel;
    unlbl2: TUniLabel;
    unlbl3: TUniLabel;
    unlbl4: TUniLabel;
    fdqryInsert: TFDQuery;
    fdqryRepeat: TFDQuery;
    procedure UniFormShow(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function frmRecord: TfrmRecord;

implementation

{$R *.dfm}

uses
  MainModule, uniGUIApplication;

function frmRecord: TfrmRecord;
begin
  Result := TfrmRecord(UniMainModule.GetFormInstance(TfrmRecord));
end;

procedure TfrmRecord.btnCancelClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TfrmRecord.btnOkClick(Sender: TObject);
var
  DayCount: Integer;
  i: Integer;
begin
 // Здесь наобходимо добавить проверки что заполнены все поля
 // Пользователь, Причина отсутствия, Число дней
 // Далее выполнить SQL запрос

 // Проверка на заполнения всех полей
  if (lstUser.Text = '') or (lstTrip.Text = '')  then
  begin
    ShowMessage('Заполните все поля');
    Exit;
  end;


 // Проверка на существования записи ******************************************
    fdqryRepeat.ParamByName('user').AsInteger := lstUser.KeyValue;
    fdqryRepeat.ParamByName('date').AsDateTime := undtmpckrBegin.DateTime;
    fdqryRepeat.Open;
    if fdqryRepeat.RecordCount <> 0 then
    begin
      fdqryRepeat.Close;
      raise UniErrorException.Create('Такая запись уже существует!');
    end;
    fdqryRepeat.Close;

    if fdqryInsert.Active then
      fdqryInsert.Close;
    fdqryInsert.ParamByName('AID').AsString := 'Некто';
    fdqryInsert.ParamByName('UID').AsString := lstUser.KeyField;
    fdqryInsert.ParamByName('TD').AsDateTime := undtmpckrBegin.DateTime;
    fdqryInsert.ParamByName('TP').AsString   := lstTrip.Caption;
    fdqryInsert.ParamByName('CMT').AsString  := undtmpckrBegin.Text;
    fdqryInsert.ExecSQL;
    fdqryInsert.Close;

   ModalResult := mrOk;
end;

procedure TfrmRecord.UniFormShow(Sender: TObject);
begin
  undtmpckrBegin.DateTime := Date;


end;

end.

