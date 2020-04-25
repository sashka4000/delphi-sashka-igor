unit FMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIRegClasses, uniGUIForm, uniGUIBaseClasses, uniBasicGrid, uniDBGrid,
  uniDBNavigator, unimDBNavigator, Vcl.Menus, uniMainMenu, uniChart, uniPanel, uniButton, uniMemo,
  FireDAC.Stan.StorageJSON, syncobjs , IdBaseComponent, IdComponent, IdRawBase,
  IdRawClient, IdIcmpClient, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, FireDAC.Stan.Async, FireDAC.DApt, uniThreadTimer;

type
  TfrmMain = class(TUniForm)
    undbgrdClient: TUniDBGrid;
    unmnmnMain: TUniMainMenu;
    unmntmOption: TUniMenuItem;
    unmntmMode: TUniMenuItem;
    unmntmHelp: TUniMenuItem;
    unmList: TUniMemo;
    unmLog: TUniMemo;
    btnLogClear: TUniButton;
    unchrtTest: TUniChart;
    fdstnstrgjsnlnkClient: TFDStanStorageJSONLink;
    fdmtblList: TFDMemTable;
    fdmtblClient: TFDMemTable;
    dsClient: TDataSource;
    dsList: TDataSource;
    fdqryLogClient: TFDQuery;
    fdpdtsqlClient: TFDUpdateSQL;
    unlnsrsTest: TUniLineSeries;
    fdqryList: TFDQuery;
    undbnvgtrClient: TUniDBNavigator;
    unthrdtmrClient: TUniThreadTimer;
    fdmtblReadOnly: TFDMemTable;
    procedure unmntmModeClick(Sender: TObject);
    procedure UniFormCreate(Sender: TObject);
    procedure UniFormClose(Sender: TObject; var Action: TCloseAction);
    procedure undbgrdClientDblClick(Sender: TObject);
    procedure unthrdtmrClientTimer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure StatisticsLog;
    procedure ErrorIPLog;
  end;


const
  MaxElement = 200;

function frmMain: TfrmMain;

implementation

{$R *.dfm}

uses
  uniGUIVars, MainModule, uniGUIApplication, DateUtils;

function frmMain: TfrmMain;
begin
  Result := TfrmMain(UniMainModule.GetFormInstance(TfrmMain));
end;

//********************** ����� ������ ������ *******************************************************
procedure TfrmMain.unmntmModeClick(Sender: TObject);
begin

  if unmntmMode.Caption = '������� � ������� �����' then
  begin
//  CodeSite.Send(csmOrange,'������� � ������� �����');
    unmntmMode.Caption := '������� � ����� ���������';
//    lblTwo.Visible := False;
    unmList.Visible := False;
    if fdmtblReadOnly.Exists then
      fdmtblReadOnly.Delete;
    undbnvgtrClient.Enabled := False;
//   ���������� �������������� �������
    with undbgrdClient do
      Options := Options - [dgEditing];
//*********************************************
      fdmtblReadOnly.CopyDataSet(fdmtblClient, [coStructure, coRestart, coAppend]);



  end
  else
  begin
//   CodeSite.Send(csmYellow,'������� � ����� ���������');
    unmntmMode.Caption := '������� � ������� �����';
    undbgrdClient.Enabled := True;
//   ��������� �������������� �������
    with undbgrdClient do
      Options := Options + [dgEditing];
//**************************************
    undbnvgtrClient.Enabled := True;
  end;
end;



//**************************************************************************************************

//********************* �������� ����� *************************************************************

procedure TfrmMain.UniFormCreate(Sender: TObject);
begin
  unmLog.Clear;
  unthrdtmrClient.Enabled := True;
  if FileExists('client.FDS') then
    fdmtblClient.LoadFromFile('client', sfJSON) // client.FDS
  else
  begin
    raise exception.Create('���� - client.FDS, �� ������');
  end;
  unmntmModeClick(Self);
end;

//**************************************************************************************************

//**************************** �������� ����� ******************************************************
procedure TfrmMain.UniFormClose(Sender: TObject; var Action: TCloseAction);
begin
  fdmtblClient.SaveToFile('client.FDS', sfJSON);
//  CodeSite.Send(csmIndigo,'�������� ����������');
end;
//**************************************************************************************************

//***************************** ������� ���� �� ������� ********************************************

procedure TfrmMain.undbgrdClientDblClick(Sender: TObject);
var
  I, j: Integer;
begin

//  lblTwo.Visible := True;
  unmList.Visible := True;
  unmList.Clear;
  unlnsrsTest.Clear;
//  CodeSite.Send('����� ������ � ������� ������');   // ��������� � ������ ������
//  CodeSite.Send('IP ����� ', fdmtblClient.FieldByName('IPAddress').AsString);   // IP �����
//  CodeSite.Send('����� ��������� � MyList ',MyList.count );

  // ���������� CodeSite
  try

{    J := 0;
    for I := 0 to MyList.Count - 1 do

      if fdmtblClient.FieldByName('IPAddress').AsString = MyList.Items[I].IpAddr then
      begin
        fstlnsrsSeriesTest.AddXY(MyList.Items[I].TimeQuestion, MyList.Items[I].TimeCount);
        mmoList.Lines.add('IP= ' + MyList.Items[I].IpAddr + '  ' + '����� �� �  ������= ' + MyList.Items[I].TimeCount.ToString + '  ' + '����� �������= ' + fdmtblClient.FieldByName('TimeQuery').AsInteger.ToString);
        Inc(J);
      end;
}
  finally


  end;
//   CodeSite.Send('����� ������������ ����� �� ������� ', J);
end;
//**************************************************************************************************

procedure TfrmMain.unthrdtmrClientTimer(Sender: TObject);
var
  i, j: Integer;
  FS: TUniGUISession;
  idcmpclntOne: TIdIcmpClient;
  IP: string;
  Interval: Integer;
  LastTime: TDateTime;
  echoTime: Integer;
begin
  FS := (Self.UniApplication as TUniGUIApplication).UniSession;
               // ��� ��������� uniSession, ������� �������� ���������� ����� ������ UniMainModule.
//**************************************************************************************************
  idcmpclntOne := TIdIcmpClient.Create(nil);
  fdmtblReadOnly.First;      // ������ ������ � ������ �������
  for i := 0 to fdmtblReadOnly.RecordCount - 1 do
  begin
    IP := fdmtblReadOnly.FieldByName('IPAddress').AsString;
    Interval := fdmtblReadOnly.FieldByName('TimeQuery').AsInteger;
    LastTime := fdmtblReadOnly.FieldByName('LastTime').AsDateTime; // ����� ��������� ��������
    if SecondsBetween(Now, LastTime) < Interval then
    begin
      fdmtblReadOnly.Next;
      Continue;
    end
    else
    begin
      try
        idcmpclntOne.Host := IP;
        idcmpclntOne.ReceiveTimeout := 1000;
        idcmpclntOne.Ping();
      except
        on E: Exception do
        begin
          ErrorIPLog;    // ��������� ������ IP
        end;
      end;
      echoTime := idcmpclntOne.ReplyStatus.MsRoundTripTime;
      fdmtblReadOnly.Edit;
      fdmtblReadOnly.FieldByName('LastTime').AsDateTime := Now;
      fdmtblReadOnly.Post;
      try
        if (idcmpclntOne.ReplyStatus.ReplyStatusType = rsEcho) and (idcmpclntOne.ReplyStatus.FromIpAddress = idcmpclntOne.Host) then
        begin
          FS.LockSession;   // ���������, ��� ������ �� ������
          fdmtblList.Edit;
          fdmtblList.FieldByName('TimeCount').AsInteger := echoTime;
          fdmtblList.Post;
        end
        else
        begin
          fdmtblList.Edit;
          fdmtblList.FieldByName('TimeCount').AsInteger := -1;
          fdmtblList.Post;
          StatisticsLog;
        end;
        fdmtblList.Edit;
        fdmtblList.FieldByName('IpAddr').AsString := IP;
        fdmtblList.FieldByName('TimeQuestion').AsDateTime := Now;
        fdmtblList.Post;
      finally
        FS.ReleaseSession;
      end;
// *********** ����������� MyList
      if fdmtblList.RecordCount > MaxElement then
      begin
        fdmtblList.First;
        for j := 0 to (MaxElement div 10) - 1 do
        begin
          fdmtblList.Edit;
          fdmtblList.Delete;
        end;
      end;
// ************************
//**************************************************************************************************


    end;
    fdmtblReadOnly.Next;
  end;
  idcmpclntOne.Free;
end;

procedure TfrmMain.StatisticsLog;
begin
  unmLog.Lines.Add('���� ' + frmMain.fdmtblReadOnly.FieldByName('IPAddress').AsString + ' ����������');
end;

procedure TfrmMain.ErrorIPLog;
begin
  unmLog.Lines.Add('IP ' + frmMain.fdmtblReadOnly.FieldByName('IPAddress').AsString + ' ������������');
end;


//**************************************************************************************************
initialization
  RegisterAppFormClass(TfrmMain);
end.
