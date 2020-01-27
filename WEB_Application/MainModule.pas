unit MainModule;

interface

uses
  uniGUIMainModule, SysUtils, Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, frxClass, frxDBSet, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Data.Win.ADODB, FireDAC.UI.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool,
  FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.SQLite, FireDAC.Phys.SQLiteDef,
  FireDAC.Stan.ExprFuncs, FireDAC.VCLUI.Wait, FireDAC.Phys.SQLiteVDataSet,
  FireDAC.DApt, FireDAC.Stan.StorageJSON;

type
  TUniMainModule = class(TUniGUIMainModule)
    fdmtblOne: TFDMemTable;
    con1: TFDConnection;
    fdlclsql: TFDLocalSQL;
    fdqryfdq: TFDQuery;
    fdstnstrgjsnlnk1: TFDStanStorageJSONLink;
    procedure UniGUIMainModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    UserName : String;
    UserID   : Integer;
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
fdmtblOne.Active := True;
fdmtblOne.Insert;
fdmtblOne.Fields[0].AsInteger := 1;
fdmtblOne.Fields[1].AsString := 'Шишкин';
fdmtblOne.Fields[2].AsString := 'admin';
fdmtblOne.Fields[3].AsString := '0000';
fdmtblOne.Post;
fdmtblOne.Insert;
fdmtblOne.Fields[0].AsInteger := 2;
fdmtblOne.Fields[1].AsString := 'Иванов';
fdmtblOne.Fields[2].AsString := '0000';
fdmtblOne.Fields[3].AsString := 'admin';
fdmtblOne.Post;
//
 fdmtblOne.SaveToFile('text',sfJSON);

 // Проверить существование файла

 fdmtblOne.LoadFromFile('text',sfJSON);   // text.fds

UserName := '';
UserID := 0;
end;

initialization
  RegisterMainModuleClass(TUniMainModule);
end.
