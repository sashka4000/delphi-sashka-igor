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
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, FireDAC.Stan.Async, FireDAC.DApt, uniThreadTimer, CodeSiteLogging;

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
    unlnsrsTest: TUniLineSeries;
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

//********************** Выбор режима работы *******************************************************
procedure TfrmMain.unmntmModeClick(Sender: TObject);
begin

  if unmntmMode.Caption = 'Перейти в рабочий режим' then
  begin
  CodeSite.Send(csmOrange,'Переход в рабочий режим');
    unmntmMode.Caption := 'Перейти в режим настройки';

    unmList.Visible := False;
    if fdmtblReadOnly.Exists then
      fdmtblReadOnly.Delete;
    undbnvgtrClient.DataSource := nil;
//   Отключение редактирования таблицы
    with undbgrdClient do
      Options := Options - [dgEditing];
//*********************************************
      fdmtblReadOnly.CopyDataSet(fdmtblClient, [coStructure, coRestart, coAppend]);
      unthrdtmrClient.Enabled := True;
  end
  else
  begin
   CodeSite.Send(csmYellow,'Переход в режим настройки');
    unmntmMode.Caption := 'Перейти в рабочий режим';
    unthrdtmrClient.Enabled := False;
    undbgrdClient.Enabled := True;
//   Включение редактирования таблицы
    with undbgrdClient do
      Options := Options + [dgEditing];
//**************************************
  undbnvgtrClient.DataSource := dsClient;
  end;
end;



//**************************************************************************************************

//********************* Создание формы *************************************************************

procedure TfrmMain.UniFormCreate(Sender: TObject);
begin
  unmLog.Clear;
//  unthrdtmrClient.Enabled := True;
  if FileExists('client.FDS') then
    fdmtblClient.LoadFromFile('client', sfJSON) // client.FDS
  else
  begin
    raise exception.Create('Файл - client.FDS, не найден');
  end;
  unmntmModeClick(Self);
end;

//**************************************************************************************************

//**************************** Закрытие формы ******************************************************
procedure TfrmMain.UniFormClose(Sender: TObject; var Action: TCloseAction);
begin
  fdmtblClient.SaveToFile('client.FDS', sfJSON);
  CodeSite.Send(csmIndigo,'Закрытие приложения');
end;
//**************************************************************************************************

//***************************** Двойной клик по таблице ********************************************

procedure TfrmMain.undbgrdClientDblClick(Sender: TObject);
var
  I, j: Integer;
begin
  unmList.Visible := True;
  unmList.Clear;
  unlnsrsTest.Clear;
  CodeSite.Send('Выбор строки в рабочем режиме');   // сообщение о выборе строки
  CodeSite.Send('IP адрес ', fdmtblClient.FieldByName('IPAddress').AsString);   // IP адрес
  CodeSite.Send('Число элементов в fdmtbList ', fdmtblList.RecordCount );

  // установить CodeSite
  try

    J := 0;
    for I := 0 to fdmtblList.RecordCount - 1 do

      if fdmtblClient.FieldByName('IPAddress').AsString = fdmtblList.FieldByName('IPAddr').AsString then
      begin
// Как запустить построение графика
        unmList.Lines.add('IP= ' + fdmtblList.FieldByName('IPAddr').AsString + '  ' + 'Число мс в  ответе= ' +
         fdmtblList.FieldByName('TimeCount').AsInteger.ToString + '  ' + 'Время запроса= ' +
         fdmtblClient.FieldByName('TimeQuery').AsInteger.ToString);
        Inc(J);
      end;

  finally


  end;
   CodeSite.Send('Число отрисованных точек на графике ', J);
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
  idcmpclntOne := TIdIcmpClient.Create(nil);
  fdmtblReadOnly.First;      // ставим курсор в начало таблицы
  for i := 0 to fdmtblReadOnly.RecordCount - 1 do
  begin
    IP := fdmtblReadOnly.FieldByName('IPAddress').AsString;
    Interval := fdmtblReadOnly.FieldByName('TimeQuery').AsInteger;
    LastTime := fdmtblReadOnly.FieldByName('LastTime').AsDateTime; // время последней проверки
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
          ErrorIPLog;    // обработка ошибки IP
        end;
      end;
      echoTime := idcmpclntOne.ReplyStatus.MsRoundTripTime;
      fdmtblReadOnly.Edit;
      fdmtblReadOnly.FieldByName('LastTime').AsDateTime := Now;
      fdmtblReadOnly.Post;
      try
        if (idcmpclntOne.ReplyStatus.ReplyStatusType = rsEcho) and (idcmpclntOne.ReplyStatus.FromIpAddress = idcmpclntOne.Host) then
        begin
          FS.LockSession;   // убедитесь, что сессия не занята
          fdmtblList.Insert;
          fdmtblList.FieldByName('TimeCount').AsInteger := echoTime;
        end
        else
        begin
          fdmtblList.Insert;
          fdmtblList.FieldByName('TimeCount').AsInteger := -1;
          StatisticsLog;
        end;
        fdmtblList.FieldByName('IpAddr').AsString := IP;
        fdmtblList.FieldByName('TimeQuestion').AsDateTime := Now;
        fdmtblList.Post;
      finally
        FS.ReleaseSession;
      end;
// *********** Ограничение fdmtblList
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
  unmLog.Lines.Add('Узел ' +fdmtblReadOnly.FieldByName('IPAddress').AsString + ' недоступен');
end;

procedure TfrmMain.ErrorIPLog;
begin
  unmLog.Lines.Add('IP ' + fdmtblReadOnly.FieldByName('IPAddress').AsString + ' некорректный');
end;


//**************************************************************************************************
initialization
  RegisterAppFormClass(TfrmMain);
end.
