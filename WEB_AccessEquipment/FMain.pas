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
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, FireDAC.Stan.Async, FireDAC.DApt,
  uniThreadTimer, System.Generics.Collections, CodeSiteLogging, uniTimer;

type
  TfrmMain = class(TUniForm)
    undbgrdClient: TUniDBGrid;
    unmnmnMain: TUniMainMenu;
    unmntmOption: TUniMenuItem;
    unmntmMode: TUniMenuItem;
    unmntmHelp: TUniMenuItem;
    unmLog: TUniMemo;
    btnLogClear: TUniButton;
    unchrtTest: TUniChart;
    fdstnstrgjsnlnkClient: TFDStanStorageJSONLink;
    fdmtblList: TFDMemTable;
    fdmtblClient: TFDMemTable;
    dsClient: TDataSource;
    dsList: TDataSource;
    undbnvgtrClient: TUniDBNavigator;
    unthrdtmrClient: TUniThreadTimer;
    fdmtblReadOnly: TFDMemTable;
    untmrLog: TUniTimer;
    unlnsrs1: TUniLineSeries;
    procedure unmntmModeClick(Sender: TObject);
    procedure UniFormCreate(Sender: TObject);
    procedure UniFormClose(Sender: TObject; var Action: TCloseAction);
    procedure undbgrdClientDblClick(Sender: TObject);
    procedure unthrdtmrClientTimer(Sender: TObject);
    procedure btnLogClearClick(Sender: TObject);
    procedure untmrLogTimer(Sender: TObject);
    procedure UniFormDestroy(Sender: TObject);
  private
    { Private declarations }
     FLogList : TThreadList<String>;
  public
    { Public declarations }
    FBusy, FAbort : Boolean; // Флаги работы/завершения потока таймера, как в примере Thread-3
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

    if fdmtblReadOnly.Exists then
      fdmtblReadOnly.Delete;
    undbnvgtrClient.DataSource := nil;
//   Отключение редактирования таблицы
    with undbgrdClient do
      Options := Options - [dgEditing];
//*********************************************
      fdmtblReadOnly.CopyDataSet(fdmtblClient, [coStructure, coRestart, coAppend]);
      FBusy := True; // Поток начал работать
      FAbort := False;
      unthrdtmrClient.Enabled := True;
  end
  else
  begin
   CodeSite.Send(csmYellow,'Переход в режим настройки');
    // останавливаем поток
    FAbort := True;
    unthrdtmrClient.Enabled := False;
    //  Должны дожжаться пока реально закончится поток
    while (FBusy) do
    begin
      sleep (50);
    end;
    //
    unmntmMode.Caption := 'Перейти в рабочий режим';
    undbgrdClient.Enabled := True;
    //   Включение редактирования таблицы
    with undbgrdClient do
      Options := Options + [dgEditing];
   //**************************************
   undbnvgtrClient.DataSource := dsClient;
   unmLog.Clear;
  end;
end;

//**************************************************************************************************

//********************* Создание формы *************************************************************

procedure TfrmMain.UniFormCreate(Sender: TObject);
begin
  FLogList := TThreadList<string>.Create;  // Для отправки Лог-сообщений из потока в GUI
  unmLog.Clear;
  if FileExists('client.FDS') then
    fdmtblClient.LoadFromFile('client', sfJSON) // client.FDS
  else
  begin
    raise exception.Create('Файл - client.FDS, не найден');
  end;
  FBusy := False;
  FAbort := False;
  unmntmModeClick(Self);
end;

procedure TfrmMain.UniFormDestroy(Sender: TObject);
begin
  FLogList.Free;
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
  IP : String;
begin
  IP :=  fdmtblClient.FieldByName('IPAddress').AsString;

  CodeSite.Send('Выбор строки в рабочем режиме');   // сообщение о выборе строки
  CodeSite.Send('IP адрес ', IP);   // IP адрес

//  unlnsrs1.DataSource := nil;

  fdmtblList.filtered := False;
  fdmtblList.Filter := 'IPAddr LIKE ' + QuotedStr(IP);
  fdmtblList.filtered := True;

  unchrtTest.RefreshData;



  CodeSite.Send('Число элементов в fdmtbList после Фильтра ', fdmtblList.RecordCount);
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
  ErrorIP : Boolean;
  List : TList <string>;
begin
  // В данном таймере ЛЮБАЯ работа с GUI запрещена !!!!!
  // см. пример Demos \ Thread-3
  idcmpclntOne := TIdIcmpClient.Create(nil);
  fdmtblReadOnly.First;      // ставим курсор в начало таблицы
  for i := 0 to fdmtblReadOnly.RecordCount - 1 do
  begin
    if FAbort then
      Break;

    IP := fdmtblReadOnly.FieldByName('IPAddress').AsString;
    Interval := fdmtblReadOnly.FieldByName('TimeQuery').AsInteger;
    LastTime := fdmtblReadOnly.FieldByName('LastTime').AsDateTime; // время последней проверки

    if SecondsBetween(Now, LastTime) < Interval then
    begin
      fdmtblReadOnly.Next;
      Continue;
    end;

    // здесь не нужен был Else

    ErrorIP := False;
    try
      idcmpclntOne.Host := IP;
      idcmpclntOne.ReceiveTimeout := 1000;
      idcmpclntOne.Ping();
    except
        ErrorIP := True;
    end;

    if ErrorIP then
    begin
      List := FLogList.LockList;
      try
          List.Add('IP: ' + IP + ' некорректный')
      finally
          FLogList.UnlockList;
      end;
     fdmtblReadOnly.Next;
     Continue ;
    end;

    echoTime := idcmpclntOne.ReplyStatus.MsRoundTripTime;
    if (idcmpclntOne.ReplyStatus.ReplyStatusType = rsEcho) and
       (idcmpclntOne.ReplyStatus.FromIpAddress = idcmpclntOne.Host) then
    begin
      ;
    end
    else
    begin
      echoTime := -1;
      List := FLogList.LockList;
      try
        List.Add('Узел ' + IP + ' недоступен')
      finally
        FLogList.UnlockList;
      end;
    end;

    fdmtblReadOnly.Edit;
    fdmtblReadOnly.FieldByName('LastTime').AsDateTime := Now;
    fdmtblReadOnly.Post;

    FS := (Self.UniApplication as TUniGUIApplication).UniSession;
    FS.LockSession;   // убедитесь, что сессия не занята
    try
     fdmtblList.Insert;
     fdmtblList.FieldByName('TimeCount').AsInteger := echoTime;
     fdmtblList.FieldByName('IpAddr').AsString := IP;
     fdmtblList.FieldByName('TimeQuestion').AsDateTime := Now;
     fdmtblList.Post;
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
    finally
     FS.ReleaseSession;
    end;
  fdmtblReadOnly.Next;
end;
  idcmpclntOne.Free;
  FBusy := False;
end;

procedure TfrmMain.untmrLogTimer(Sender: TObject);
var
 List : TList <string>;
 asMsg : string;
begin
  // Данный таймер работает в главном потоке  и
  // может работать с GUI
  List := FLogList.LockList;  // блокируем лист
  try
   for asMsg in List  do   // перебираем элементы List
    unmLog.Lines.Add (FormatDateTime ('hh:mm:ss.zzz ',Now) +  asMsg);
   List.Clear;  // очищаем
  finally
    FLogList.UnlockList;
  end;
end;


procedure TfrmMain.btnLogClearClick(Sender: TObject);
begin
unmLog.Clear;
end;

//**************************************************************************************************
initialization
  RegisterAppFormClass(TfrmMain);
end.
