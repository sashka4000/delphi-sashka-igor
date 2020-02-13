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
    procedure UniGUIMainModuleCreate(Sender: TObject);
    procedure UniGUIMainModuleDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    BlockPost: Boolean;
    UserPassword: string;
    SuperUser: Integer;
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



procedure TUniMainModule.UniGUIMainModuleCreate(Sender: TObject);
begin
  UserID := 0;
  SuperUser := 0;
  UserPassword :='';
  // Подключаемся к БД
  confd.Connected := true;
  // Убираем параметры READ транзакции, которые были нам удобны во время проектирования
  self.fdtrnsctnRead.Options.AutoStart := False;
  // стартуем Read транзакцию. Она так и будет все время запущена
  self.fdtrnsctnRead.StartTransaction;
end;

procedure TUniMainModule.UniGUIMainModuleDestroy(Sender: TObject);
begin
  self.fdtrnsctnRead.Commit;
  self.confd.Connected := false;
end;

initialization
  RegisterMainModuleClass(TUniMainModule);

end.

