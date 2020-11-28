unit dataModulFireDAC;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error,
  FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.Phys.FB, FireDAC.Phys.FBDef, FireDAC.VCLUI.Wait, FireDAC.Phys.IBBase,
  Data.DB, FireDAC.Comp.Client, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet, Data.FMTBcd, Data.SqlExpr;

type
  TDM_fireDAC = class(TDataModule)
    con_db: TFDConnection;
    fdphysfbdrvrlnk_db: TFDPhysFBDriverLink;
    fdtrnsctnOne_db: TFDTransaction;
    fdqryLog_db: TFDQuery;
    fdqryLog_mod: TFDQuery;
    fdqry_countClient: TFDQuery;
    fdqryParam: TFDQuery;
    fdqry_Chart_Par: TFDQuery;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DM_fireDAC: TDM_fireDAC;

implementation

uses
  dbMonitoring, Fmodal, FParam;



{$R *.dfm}



end.
