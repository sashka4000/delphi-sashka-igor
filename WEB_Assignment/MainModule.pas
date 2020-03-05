unit MainModule;

interface

uses
  uniGUIMainModule, SysUtils, Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, frxClass, frxDBSet, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Data.Win.ADODB, FireDAC.UI.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs, FireDAC.VCLUI.Wait,
  FireDAC.Phys.SQLiteVDataSet, FireDAC.DApt, FireDAC.Stan.StorageJSON,
  FireDAC.Phys.FB, FireDAC.Phys.FBDef, FireDAC.Phys.IBBase, FireDAC.Comp.UI,
  FireDAC.Stan.StorageBin;

type
  TUniMainModule = class(TUniGUIMainModule)
    confd: TFDConnection;
    fdphysfbdrvrlnkOne: TFDPhysFBDriverLink;
    fdtrnsctnRead: TFDTransaction;
    fdtrnsctnWrite: TFDTransaction;
    fdgxwtcrsrUser: TFDGUIxWaitCursor;
    fdmtblTripType: TFDMemTable;
    intgrfldTripTypeID: TIntegerField;
    strngfldTripTypeTripType: TStringField;
    dsTripType: TDataSource;
    fdqryUsers: TFDQuery;
    lrgntfldUsersID: TLargeintField;
    strngfldUsersNAME: TStringField;
    dsUsersAll: TDataSource;
    fdmtblStatus: TFDMemTable;
    fdmtblBlock: TFDMemTable;
    dsStatus: TDataSource;
    dsBlock: TDataSource;
    intgrfldStatusValue: TIntegerField;
    strngfldStatusVString: TStringField;
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
  UserPassword := '';
 // Заполняем таблицу Комондировка-Больничный
  fdmtblTripType.Active := True;
  fdmtblTripType.Insert;
  fdmtblTripType.Fields[0].AsInteger := 0;
  fdmtblTripType.Fields[1].AsString := 'Командировка';
  fdmtblTripType.Post;
  fdmtblTripType.Insert;
  fdmtblTripType.Fields[0].AsInteger := 1;
  fdmtblTripType.Fields[1].AsString := 'Больничный';
  fdmtblTripType.Post;
 //**************************************************

 //Заполняем таблицу Статус
 //Заполняем таблицу Статус
  fdmtblStatus.Active := True;
  fdmtblStatus.Insert;
  fdmtblStatus.Fields[0].AsInteger := 0;
  fdmtblStatus.Fields[1].AsString := 'User';
  fdmtblStatus.Post;
  fdmtblStatus.Insert;
  fdmtblStatus.Fields[0].AsInteger := 1;
  fdmtblStatus.Fields[1].AsString := 'Admin';
  fdmtblStatus.Post;
  //****************************************************

 //Заполняем таблицу Блокировка
  fdmtblBlock.Active := True;
  fdmtblBlock.Insert;
  fdmtblBlock.Fields[0].AsInteger := 0;
  fdmtblBlock.Fields[1].AsString := 'Нет';
  fdmtblBlock.Post;
  fdmtblBlock.Insert;
  fdmtblBlock.Fields[0].AsInteger := 1;
  fdmtblBlock.Fields[1].AsString := 'Да';
  fdmtblBlock.Post;
 //****************************************************
  // Подключаемся к БД
  fdtrnsctnRead.Options.AutoStart := False;
  confd.Connected := true;
  // стартуем Read транзакцию. Она так и будет все время запущена
  fdtrnsctnRead.StartTransaction;
// Код заполнения таблицы  fdmtblTripType
end;

procedure TUniMainModule.UniGUIMainModuleDestroy(Sender: TObject);
begin
  self.fdtrnsctnRead.Commit;
  self.confd.Connected := false;
end;
{
   fdmtblTripType.Active := True;
  fdmtblTripType.Insert;
  fdmtblTripType.Fields[0].AsInteger := 0;
  fdmtblTripType.Fields[1].AsString := 'Командировка';
  fdmtblTripType.Post;

 }
initialization
  RegisterMainModuleClass(TUniMainModule);

end.

