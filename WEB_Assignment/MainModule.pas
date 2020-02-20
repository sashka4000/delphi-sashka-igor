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
  FireDAC.Phys.FB, FireDAC.Phys.FBDef, FireDAC.Phys.IBBase, FireDAC.Comp.UI, FireDAC.Stan.StorageBin;

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
  // ������������ � ��
  confd.Connected := true;
  // �������� Read ����������. ��� ��� � ����� ��� ����� ��������
  self.fdtrnsctnRead.StartTransaction;
// ��� ���������� �������  fdmtblTripType

fdmtblTripType.Active := True;
fdmtblTripType.Insert;
fdmtblTripType.Fields[0].AsInteger := 0;
fdmtblTripType.Fields[1].AsString := '������������';
fdmtblTripType.Post;
fdmtblTripType.Insert;
fdmtblTripType.Fields[0].AsInteger := 1;
fdmtblTripType.Fields[1].AsString := '����������';
fdmtblTripType.Post;
end;

procedure TUniMainModule.UniGUIMainModuleDestroy(Sender: TObject);
begin
  self.fdtrnsctnRead.Commit;
  self.confd.Connected := false;
end;

initialization
  RegisterMainModuleClass(TUniMainModule);

end.

