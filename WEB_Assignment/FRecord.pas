unit FRecord;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIForm, uniButton, uniCalendar, uniGUIBaseClasses, uniMultiItem, uniListBox,
  uniDBListBox, uniDBLookupListBox, uniCalendarPanel, uniEdit, uniDateTimePicker;

type
  TfrmRecord = class(TUniForm)
    lstTrip: TUniDBLookupListBox;
    lstUser: TUniDBLookupListBox;
    btnOk: TUniButton;
    btnCancel: TUniButton;
    undtDay: TUniEdit;
    undtComment: TUniEdit;
    undtmpckrBegin: TUniDateTimePicker;
    undtmpckrEnd: TUniDateTimePicker;
    procedure lstTripClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function frmRecord: TfrmRecord;

implementation

{$R *.dfm}

uses
  MainModule, uniGUIApplication, FTripAdmin;

function frmRecord: TfrmRecord;
begin
  Result := TfrmRecord(UniMainModule.GetFormInstance(TfrmRecord));
end;



procedure TfrmRecord.lstTripClick(Sender: TObject);
begin
  ShowMessage (lstTrip.KeyValue);
end;

end.
