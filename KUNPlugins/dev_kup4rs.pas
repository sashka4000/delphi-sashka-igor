unit dev_kup4rs;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms,
  dev_base_form, Vcl.StdCtrls;

type
  TfrmKUP4RS = class(TfrmBase)
  private
    { Private declarations }
  public
    { Public declarations }
  end;

 TKUP4RS = class (TBaseDevice)
   function OnDataReceive (pd : PByte; PacketSize : Integer; MaxSize : Integer;  var AnswerSize : Integer) : HRESULT; override; stdcall;
  end;

const
  gKUP4RS  : TGUID =  '{FA28155C-2CF0-4A5A-A4F9-723656F33218}';  // Глобальный идентификатор, генерируются по Ctrl+Shift+G

implementation

{$R *.dfm}

{ TKUP4RS }

function TKUP4RS.OnDataReceive(pd: PByte; PacketSize, MaxSize: Integer;
  var AnswerSize: Integer): HRESULT;
begin
  inherited;
end;

end.
