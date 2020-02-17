object UniMainModule: TUniMainModule
  OldCreateOrder = False
  OnCreate = UniGUIMainModuleCreate
  OnDestroy = UniGUIMainModuleDestroy
  MonitoredKeys.Keys = <>
  Height = 231
  Width = 316
  object confd: TFDConnection
    Params.Strings = (
      'Database=C:\DB\TEKONDB.FDB'
      'User_Name=sysdba'
      'Password=masterkey'
      'CharacterSet=WIN1251'
      'Protocol=TCPIP'
      'Server=127.0.0.1'
      'DriverID=FB')
    Connected = True
    LoginPrompt = False
    Left = 16
    Top = 16
  end
  object fdphysfbdrvrlnkOne: TFDPhysFBDriverLink
    VendorLib = 'C:\Program Files (x86)\Firebird\Firebird_2_5\bin\fbclient.dll'
    Left = 24
    Top = 80
  end
  object fdtrnsctnRead: TFDTransaction
    Options.ReadOnly = True
    Options.AutoStart = False
    Options.AutoStop = False
    Options.EnableNested = False
    Connection = confd
    Left = 88
    Top = 24
  end
  object fdtrnsctnWrite: TFDTransaction
    Options.DisconnectAction = xdRollback
    Options.EnableNested = False
    Connection = confd
    Left = 136
    Top = 24
  end
  object fdqryTrip: TFDQuery
    Connection = confd
    Transaction = fdtrnsctnRead
    UpdateTransaction = fdtrnsctnRead
    UpdateOptions.AssignedValues = [uvGeneratorName]
    UpdateOptions.GeneratorName = 'GEN_USERS_ID'
    SQL.Strings = (
      'select * from trip')
    Left = 216
    Top = 88
  end
  object dsTrip: TDataSource
    DataSet = fdqryTrip
    Left = 216
    Top = 24
  end
  object fdpdtsqlTrip: TFDUpdateSQL
    Connection = confd
    Left = 216
    Top = 144
  end
  object fdgxwtcrsrUser: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 24
    Top = 136
  end
end
