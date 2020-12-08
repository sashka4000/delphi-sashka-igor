unit main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Data.DB,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.StdCtrls, Vcl.DBCtrls,
  Vcl.Grids, Vcl.DBGrids, FireDAC.Stan.StorageBin;

type
  TfrmMain = class(TForm)
    pnl1: TPanel;
    spl1: TSplitter;
    pnl2: TPanel;
    mmo1: TMemo;
    dbgrd1: TDBGrid;
    dbnvgr1: TDBNavigator;
    btnDoText: TButton;
    btnDoValues: TButton;
    fdmtbl1: TFDMemTable;
    ds1: TDataSource;
    strngfldfdmtbl1Value1: TStringField;
    strngfldfdmtbl1Value2: TStringField;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    function GetImageFolder: String;
    function GetWavFolder: String;
    procedure DBGrid1EditButtonClick(Sender: TObject);
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}

{ TfrmMain }

procedure TfrmMain.DBGrid1EditButtonClick(Sender: TObject);
begin
 ShowMessage(DBGrd1.SelectedField.FieldName);
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  dbgrd1.Columns[0].ButtonStyle:=cbsEllipsis;
  dbgrd1.Columns[1].ButtonStyle:=cbsEllipsis;
  dbgrd1.OnEditButtonClick:= DBGrid1EditButtonClick;
end;

function TfrmMain.GetImageFolder: String;
begin
  Result := ExtractFilePath (Application.ExeName) +  'Images\';
  if not DirectoryExists(Result) then
   CreateDir(Result);
end;

function TfrmMain.GetWavFolder: String;
begin
  Result :=  ExtractFilePath (Application.ExeName) +  'Sounds\';
  if not DirectoryExists(Result) then
   CreateDir(Result);
end;

end.
