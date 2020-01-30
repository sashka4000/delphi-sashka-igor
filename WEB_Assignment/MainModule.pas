unit MainModule;

interface

uses
  uniGUIMainModule, SysUtils, Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, frxClass, frxDBSet, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Data.Win.ADODB, FireDAC.UI.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs, FireDAC.VCLUI.Wait,
  FireDAC.Phys.SQLiteVDataSet, FireDAC.DApt, FireDAC.Stan.StorageJSON;

type
  TUniMainModule = class(TUniGUIMainModule)
    fdmtblOne: TFDMemTable;
    con1: TFDConnection;
    fdlclsql: TFDLocalSQL;
    fdqryfdq: TFDQuery;
    fdstnstrgjsnlnk1: TFDStanStorageJSONLink;
    ds1: TDataSource;
    procedure UniGUIMainModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    UserPassword : string;
    UserStaus : Boolean;
    UserName: string;
    UserID: Integer;
  end;

function UniMainModule: TUniMainModule;

implementation

{$R *.dfm}

uses
  UniGUIVars, ServerModule, uniGUIApplication;

function UniMainModule: TUniMainModule;
begin
  Result := TUniMainModule(UniApplication.UniMainModule);
end;

procedure TUniMainModule.UniGUIMainModuleCreate(Sender: TObject);
begin
 // Проверить существование файла
  if FileExists('text.FDS') then
    fdmtblOne.LoadFromFile('text', sfJSON)   // text.fds
  else
  begin
    fdmtblOne.Insert;
    fdmtblOne.Fields[1].AsString := 'Некто';
    fdmtblOne.Fields[2].AsString := 'ADMIN';
    fdmtblOne.Fields[3].AsString := '0000';
    fdmtblOne.Fields[4].AsBoolean := True;
    fdmtblOne.Fields[5].AsString := 'Вёл аморальный образ жизни';
    fdmtblOne.Post;
    fdmtblOne.SaveToFile('text', sfJSON);
  end;
  UserName := '';
  UserID := 0;
  UserStaus := False;
end;


initialization
  RegisterMainModuleClass(TUniMainModule);

end.

