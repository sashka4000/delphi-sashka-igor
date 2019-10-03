unit setForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, parser,
  Vcl.Imaging.pngimage, Vcl.ExtCtrls;

type
  TOnCheckName = function (const Name : String) : Boolean of Object;

  TfrmSetSimple = class(TForm)
    lbl1: TLabel;
    edtName: TEdit;
    lbl2: TLabel;
    btnCancel: TButton;
    btnSave: TButton;
    img1: TImage;
    lbl6: TLabel;
    edtComment: TEdit;
    lbl3: TLabel;
    lbl7: TLabel;
    procedure btnSaveClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    FS : TSimpleObject;
    FOnCheckName : TOnCheckName;
    FOnCancel : TNotifyEvent;
    FOnOk     : TNotifyEvent;
    procedure Init (S : TSimpleObject; OnCheckName  : TOnCheckName; OnOk, OnCancel : TNotifyEvent); virtual;
  end;

var
  frmSetSimple: TfrmSetSimple;

implementation

{$R *.dfm}

{ TForm2 }

procedure TfrmSetSimple.btnCancelClick(Sender: TObject);
begin
  if Assigned (FOnCancel) then
   FOnCancel (Sender);
end;

procedure TfrmSetSimple.btnSaveClick(Sender: TObject);
begin
 if Assigned (FOnCheckName) then
    if not FOnCheckName (edtName.Text) then
    begin
     Application.MessageBox('Данное Имя уже используется',
       PChar(Application.Title), MB_OK + MB_ICONSTOP);
     Exit;
    end;

 FS.Name := edtName.Text;
 FS.Arguments[0] := edtComment.Text;
 if Assigned (FOnOk) then
  FOnOk (Sender);
end;


procedure TfrmSetSimple.Init  (S : TSimpleObject; OnCheckName  : TOnCheckName; OnOk, OnCancel : TNotifyEvent);
begin
  FS := S;
  FOnCheckName := OnCheckName;
  FOnOk := OnOk;
  FOnCancel := OnCancel;
  edtName.Text := FS.Name;
  edtComment.Text := FS.Arguments[0];
end;

end.
