object UniMainModule: TUniMainModule
  OldCreateOrder = False
  OnCreate = UniGUIMainModuleCreate
  OnDestroy = UniGUIMainModuleDestroy
  MonitoredKeys.Keys = <>
  Height = 453
  Width = 847
  object fdmtblOne: TFDMemTable
    Active = True
    FieldDefs = <
      item
        Name = 'ID'
        DataType = ftAutoInc
      end
      item
        Name = 'UserName'
        DataType = ftString
        Size = 30
      end
      item
        Name = 'Login'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'Password'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'Status'
        DataType = ftBoolean
      end
      item
        Name = 'Assignment'
        DataType = ftString
        Size = 50
      end>
    IndexDefs = <>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    StoreDefs = True
    Left = 16
    Top = 8
  end
  object fdqryfdq: TFDQuery
    Left = 72
    Top = 8
  end
  object fdstnstrgjsnlnk1: TFDStanStorageJSONLink
    Left = 144
    Top = 16
  end
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
    Left = 512
    Top = 16
  end
  object fdphysfbdrvrlnkOne: TFDPhysFBDriverLink
    VendorLib = 'C:\Program Files (x86)\Firebird\Firebird_2_5\bin\fbclient.dll'
    Left = 512
    Top = 80
  end
  object fdtrnsctnRead: TFDTransaction
    Options.ReadOnly = True
    Options.AutoStop = False
    Options.EnableNested = False
    Connection = confd
    Left = 392
    Top = 24
  end
  object fdtrnsctnWrite: TFDTransaction
    Options.DisconnectAction = xdRollback
    Options.EnableNested = False
    Connection = confd
    Left = 392
    Top = 88
  end
  object fdqryTrip: TFDQuery
    Connection = confd
    Transaction = fdtrnsctnRead
    UpdateTransaction = fdtrnsctnRead
    UpdateOptions.AssignedValues = [uvGeneratorName]
    UpdateOptions.GeneratorName = 'GEN_USERS_ID'
    SQL.Strings = (
      'select * from trip')
    Left = 96
    Top = 256
  end
  object dsTrip: TDataSource
    DataSet = fdqryTrip
    Left = 96
    Top = 200
  end
  object fdpdtsqlTrip: TFDUpdateSQL
    Connection = confd
    Left = 96
    Top = 320
  end
  object fdgxwtcrsrUser: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 512
    Top = 144
  end
end
