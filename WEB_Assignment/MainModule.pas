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
    procedure fdmtblOneBeforePost(DataSet: TDataSet);
//    procedure fdmtblOneBeforeInsert(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
    UserPassword : string;
    UserStaus : Boolean;
    UserID: Integer;
  end;

function UniMainModule: TUniMainModule;

implementation

{$R *.dfm}

uses
  UniGUIVars, ServerModule, uniGUIApplication, FRegistration;

function UniMainModule: TUniMainModule;
begin
  Result := TUniMainModule(UniApplication.UniMainModule);
end;
{
procedure TUniMainModule.fdmtblOneBeforeInsert(DataSet: TDataSet);
begin
fdmtblOne.FieldByName('UserName').AsString := 'Error';
fdmtblOne.FieldByName('Status').AsBoolean := False;
fdmtblOne.FieldByName('Assignment').AsString := 'empty';
end;
 }
procedure TUniMainModule.fdmtblOneBeforePost(DataSet: TDataSet);
begin
  fdqryfdq.Close;
  fdqryfdq.SQL.Clear;
  fdqryfdq.SQL.Add('select Login  from Tb1 where Login=:login');
  fdqryfdq.ParamByName('login').Value := fdmtblOne.FieldByName('login').Value;
  fdqryfdq.Open;
  if fdqryfdq.RecordCount > 0 then
  begin
     fdqryfdq.Close;
<<<<<<< HEAD
     raise Exception.Create('Такой логин уже существует!');
  end;

=======
     raise UniErrorException.Create('Такой логин уже существует!');
  end;
  fdqryfdq.close;
>>>>>>> 7e8543559f2c2395545f3716a946663359d34275
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
    fdmtblOne.Fields[2].AsString := 'admin';
    fdmtblOne.Fields[3].AsString := '0000';
    fdmtblOne.Fields[4].AsBoolean := True;
    fdmtblOne.Fields[5].AsString := 'Вёл аморальный образ жизни';
    fdmtblOne.Post;
    fdmtblOne.SaveToFile('text', sfJSON);
  end;
  UserID := 0;
  UserStaus := False;
end;


initialization
  RegisterMainModuleClass(TUniMainModule);

end.

