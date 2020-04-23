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
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, FireDAC.Stan.Async, FireDAC.DApt;

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
    fdmtblReadOnly: TFDMemTable;
    procedure unmntmModeClick(Sender: TObject);
    procedure UniFormCreate(Sender: TObject);
    procedure UniFormClose(Sender: TObject; var Action: TCloseAction);
    procedure undbgrdClientDblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

{class TThread}

{ TMyThread }
type
  TMyThread = class(TThread)
  private
    { Private declarations }
  protected
    procedure Execute; override;
  public
    idcmpclntOne: TIdIcmpClient;
    procedure StatisticsLog;
    procedure ErrorIPLog;
  end;
const
  MaxElement = 200;

var
FCS: TCriticalSection;
MyThread: TMyThread;
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
//    mmoList.Visible := False;
    if MyThread <> nil then
      Exit;
    if fdmtblReadOnly.Exists then
      fdmtblReadOnly.Delete;
    undbnvgtrClient.Enabled := False;
//   ���������� �������������� �������
    with undbgrdClient do
      Options := Options - [dgEditing];
//*********************************************
    fdmtblReadOnly.CopyDataSet(fdmtblClient, [coStructure, coRestart, coAppend]);
    MyThread := TMyThread.Create(True);
    MYthread.Start;

  end
  else
  begin
//   CodeSite.Send(csmYellow,'������� � ����� ���������');
    unmntmMode.Caption := '������� � ������� �����';
    if MyThread = nil then
      Exit;
    MyThread.Terminate;
    MyThread.WaitFor;
    FreeAndNil(MyThread);

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
  FCS := TCriticalSection.Create;   // �������� ����������� ������
  if FileExists('client.FDS') then
    fdmtblClient.LoadFromFile('client', sfJSON) // client.FDS
  else
  begin

    raise exception.Create('���� - client.FDS, �� ������');
  end;
//  MyList := TMyList.Create;
  unmntmModeClick(Self);

end;

//**************************************************************************************************

//**************************** �������� ����� ******************************************************
procedure TfrmMain.UniFormClose(Sender: TObject; var Action: TCloseAction);
begin
  fdmtblClient.SaveToFile('client.FDS', sfJSON);
  if MyThread <> nil then
  begin
    MyThread.Terminate;
    MyThread.WaitFor;
    FreeAndNil(MyThread);
  end;

//  CodeSite.Send(csmIndigo,'�������� ����������');
  FCS.Free;     // ����������� ����������� ������
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
  // ����� ����������� ������
  FCS.Enter;
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
  // �������� ����������� ������
    FCS.Leave;

  end;
//   CodeSite.Send('����� ������������ ����� �� ������� ', J);
end;
//**************************************************************************************************
{ TMyThread }

procedure TMyThread.Execute;
var
  i, j: Integer;
  IP: string;
  Interval: Integer;
  LastTime: TDateTime;
  echoTime: Integer;
begin
  idcmpclntOne := TIdIcmpClient.Create(nil);
  while (not Terminated) do
  begin
    frmMain.fdmtblReadOnly.First;
    for i := 0 to frmMain.fdmtblReadOnly.RecordCount - 1 do
    begin
      if Terminated then
        break;
      IP := frmMain.fdmtblReadOnly.FieldByName('IPAddress').AsString;
      Interval := frmMain.fdmtblReadOnly.FieldByName('TimeQuery').AsInteger;
      LastTime := frmMain.fdmtblReadOnly.FieldByName('LastTime').AsDateTime; // ����� ��������� ��������
      if SecondsBetween(Now, LastTime) < Interval then
      begin
        frmMain.fdmtblReadOnly.Next;
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
            Synchronize(ErrorIPLog);    // ��������� ������ IP
          end;
        end;
        echoTime := idcmpclntOne.ReplyStatus.MsRoundTripTime;
        frmMain.fdmtblReadOnly.Edit;
        frmMain.fdmtblReadOnly.FieldByName('LastTime').AsDateTime := Now;
        frmMain.fdmtblReadOnly.Post;
        if (idcmpclntOne.ReplyStatus.ReplyStatusType = rsEcho) and (idcmpclntOne.ReplyStatus.FromIpAddress = idcmpclntOne.Host) then
        begin
          frmMain.fdmtblList.FieldByName('TimeCount').AsInteger := echoTime;
        end
        else
        begin
          frmMain.fdmtblList.FieldByName('TimeCount').AsInteger := -1;
          Synchronize(StatisticsLog);
        end;
        frmMain.fdmtblList.FieldByName('IpAddr').AsString := IP;
        frmMain.fdmtblList.FieldByName('TimeQuestion').AsDateTime := Now;
        //
        FCS.Enter;
        try
// *********** ����������� fdmtblList
          if frmMain.fdmtblList.RecordCount > MaxElement then
            for j := 0 to (MaxElement div 10) - 1 do
            begin
              frmMain.fdmtblList.FindFirst;
              frmMain.fdmtblList.Delete;
            end;

// ************************
//          MyList.add(MyRecord);
          with frmMain.fdmtblList do
          begin
            Append;
            Fields[0].AsString := IP;
            Fields[1].AsDateTime := LastTime;
            Fields[2].AsInteger := echoTime;
            Post;
          end;
        finally
          FCS.Leave;
        end;
//        CodeSite.Send(csmGreen,'IP �����: ' + IP + ' result: ' + IntToStr(echoTime));
      end;
      frmMain.fdmtblReadOnly.Next;
    end;
  end;
  idcmpclntOne.Free;
end;

procedure TMyThread.StatisticsLog;
begin
  frmMain.unmLog.Lines.Add('���� ' + frmMain.fdmtblReadOnly.FieldByName('IPAddress').AsString + ' ����������');
end;

procedure TMyThread.ErrorIPLog;
begin
  frmMain.unmLog.Lines.Add('IP ' + frmMain.fdmtblReadOnly.FieldByName('IPAddress').AsString + ' ������������');
end;

initialization
  RegisterAppFormClass(TfrmMain);
end.
