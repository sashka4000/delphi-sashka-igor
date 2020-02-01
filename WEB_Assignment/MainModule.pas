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

procedure TUniMainModule.fdmtblOneBeforePost(DataSet: TDataSet);
begin
  fdqryfdq.Close;
  fdqryfdq.SQL.Clear;
  fdqryfdq.SQL.Add('select Login  from Tb1 where Login=:login');
  fdqryfdq.ParamByName('login').Value := fdmtblOne.FieldByName('login').Value;

  if fdqryfdq.RecordCount > 0 then
  begin
     raise Exception.Create('����� ����� ��� ����������!');
  end;
  fdqryfdq.Open;
end;

procedure TUniMainModule.UniGUIMainModuleCreate(Sender: TObject);
begin
 // ��������� ������������� �����
  if FileExists('text.FDS') then
    fdmtblOne.LoadFromFile('text', sfJSON)   // text.fds
  else
  begin
    fdmtblOne.Insert;
    fdmtblOne.Fields[1].AsString := '�����';
    fdmtblOne.Fields[2].AsString := 'admin';
    fdmtblOne.Fields[3].AsString := '0000';
    fdmtblOne.Fields[4].AsBoolean := True;
    fdmtblOne.Fields[5].AsString := '¸� ���������� ����� �����';
    fdmtblOne.Post;
    fdmtblOne.SaveToFile('text', sfJSON);
  end;
  UserID := 0;
  UserStaus := False;
end;


initialization
  RegisterMainModuleClass(TUniMainModule);

end.

