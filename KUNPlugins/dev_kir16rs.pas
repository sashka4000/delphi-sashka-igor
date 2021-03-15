unit dev_kir16rs;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, dev_base_form, Vcl.Grids, Vcl.ValEdit;

type
  TfrmKIR16RS = class(TfrmBase)
    lst1: TValueListEditor;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  TKIR16RS = class(TBaseDevice)
    function OnDataReceive(pd: PByte; PacketSize: Integer; MaxSize: Integer; var AnswerSize: Integer): HRESULT; override; stdcall;
  end;

const
  gKIR16RS: TGUID = '{C8B1EF56-D63C-4711-B44A-AE6E7024286A}';  // Глобальный идентификатор, генерируются по Ctrl+Shift+G

implementation

{$R *.dfm}

{ TKIR16RS }

function TKIR16RS.OnDataReceive(pd: PByte; PacketSize, MaxSize: Integer;
  var AnswerSize: Integer): HRESULT;
begin
  Result := inherited;
end;

end.
