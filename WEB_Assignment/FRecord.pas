unit FRecord;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIForm, uniButton, uniCalendar, uniGUIBaseClasses, uniMultiItem, uniListBox,
  uniDBListBox, uniDBLookupListBox;

type
  TfrmRecord = class(TUniForm)
    lstTrip: TUniDBLookupListBox;
    unclndrdlgTrip: TUniCalendarDialog;
    lstUser: TUniDBLookupListBox;
    btnOk: TUniButton;
    btnCancel: TUniButton;
    procedure UniFormShow(Sender: TObject);
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

procedure TfrmRecord.UniFormShow(Sender: TObject);
begin
frmRecord.Caption := 'Добавить запись';
frmRecord.Position := poMainFormCenter;
end;

end.
