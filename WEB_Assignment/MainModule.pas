unit MainModule;

interface

uses
  uniGUIMainModule, SysUtils, Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, frxClass, frxDBSet, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Data.Win.ADODB, FireDAC.UI.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs, FireDAC.VCLUI.Wait,
  FireDAC.Phys.SQLiteVDataSet, FireDAC.DApt, FireDAC.Stan.StorageJSON, FireDAC.Phys.FB,
  FireDAC.Phys.FBDef, FireDAC.Phys.IBBase, FireDAC.Comp.UI;

type
  TUniMainModule = class(TUniGUIMainModule)
    fdmtblOne: TFDMemTable;
    fdqryfdq: TFDQuery;
    fdstnstrgjsnlnk1: TFDStanStorageJSONLink;
    confd: TFDConnection;
    fdphysfbdrvrlnkOne: TFDPhysFBDriverLink;
    fdtrnsctnRead: TFDTransaction;
    fdtrnsctnWrite: TFDTransaction;
    fdqryTrip: TFDQuery;
    dsTrip: TDataSource;
    fdpdtsqlTrip: TFDUpdateSQL;
    fdgxwtcrsrUser: TFDGUIxWaitCursor;
    fdqryUsers: TFDQuery;
    fdpdtsqlUsers: TFDUpdateSQL;
    dsUsers: TDataSource;
    procedure UniGUIMainModuleCreate(Sender: TObject);
    procedure fdqryUsersBeforePost(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
    BlockPost: Boolean;
    UserPassword: string;
    SuperUser: Integer;
    Blocked : Integer;
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



procedure TUniMainModule.fdqryUsersBeforePost(DataSet: TDataSet);
begin
  if BlockPost then
    Exit;
  if (DataSet.FieldByName('UserName').AsString = '') or (DataSet.FieldByName('login').AsString = '') or (DataSet.FieldByName('password').AsString = '') then
  begin
    raise UniErrorException.Create('Заполните все поля!');
  end;
  fdqryUsers.Close;
  fdqryUsers.SQL.Clear;
  fdqryUsers.SQL.Add('select Login  from users where Login=:login');
  fdqryUsers.ParamByName('login').Value := fdqryUsers.FieldByName('login').Value;
  fdqryUsers.Open;
  if fdqryUsers.RecordCount > 0 then
  begin
    fdqryUsers.Close;
    raise UniErrorException.Create('Такой логин уже существует!');
  end;

end;

procedure TUniMainModule.UniGUIMainModuleCreate(Sender: TObject);
begin
  UserID := 0;
  SuperUser := 0;
  Blocked := 0;
  BlockPost := False;
end;

initialization
  RegisterMainModuleClass(TUniMainModule);

end.

