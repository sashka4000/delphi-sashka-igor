unit dev_upsl_m;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, dev_base_form;

type
  TfrmUPSL_M = class(TfrmBase)
  private
    { Private declarations }
  public
    { Public declarations }
  end;
  TUPSL_M = class(TBaseDevice)
    function OnDataReceive(pd: PByte; PacketSize: Integer; MaxSize: Integer; var AnswerSize: Integer): HRESULT; override; stdcall;
  end;

   gUPSLM_2: TGUID = '{DD24BED3-1DE3-42FF-A30C-5176FC964CD3}' ;  // Глобальный идентификатор, генерируются по Ctrl+Shift+G


var
  frmUPSL_M: TfrmUPSL_M;

implementation

{$R *.dfm}

end.
