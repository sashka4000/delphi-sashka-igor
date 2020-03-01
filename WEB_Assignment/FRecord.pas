unit FRecord;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIForm, uniButton, uniCalendar, uniGUIBaseClasses, uniMultiItem, uniListBox,
  uniDBListBox, uniDBLookupListBox, uniCalendarPanel, uniEdit, uniDateTimePicker,
  uniLabel, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TfrmRecord = class(TUniForm)
    lstTrip: TUniDBLookupListBox;
    lstUser: TUniDBLookupListBox;
    btnOk: TUniButton;
    btnCancel: TUniButton;
    undtDay: TUniEdit;
    undtComment: TUniEdit;
    undtmpckrBegin: TUniDateTimePicker;
    unlbl1: TUniLabel;
    unlbl2: TUniLabel;
    unlbl3: TUniLabel;
    unlbl4: TUniLabel;
    unlbl5: TUniLabel;
    fdqryInsert: TFDQuery;
    fdqryUsers: TFDQuery;
    fdqryUsersID: TLargeintField;
    fdqryUsersNAME: TStringField;
    dsUsersAll: TDataSource;
    procedure lstTripClick(Sender: TObject);
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
  DayCount : Integer;
  i : Integer;
begin
 // Здесь наобходимо добавить проверки что заполнены все поля
 // Пользователь, Причина отсутствия, Число дней
 // Далее выполнить SQL запрос

  DayCount := StrToInt(undtDay.Text);

  //   DayCount не должен пересекаться с выходными
  // Т.е. если сегодня Четверг  - то  DayCount может быть только 1 или 2, но не 3 (т.е. задевается Суббота)

  for I := 0 to DayCount - 1 do
  begin


  end;

end;

procedure TfrmRecord.lstTripClick(Sender: TObject);
begin
  undtDay.Enabled :=  (lstTrip.KeyValue = '1');
end;

procedure TfrmRecord.UniFormShow(Sender: TObject);
begin
  fdqryUsers.Active := True;
  undtmpckrBegin.DateTime := Date;
  undtDay.Text := '3';
end;

end.
