object UniMainModule: TUniMainModule
  OldCreateOrder = False
  OnCreate = UniGUIMainModuleCreate
  MonitoredKeys.Keys = <>
  Height = 426
  Width = 635
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
    Left = 56
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
    Left = 576
    Top = 8
  end
  object fdtrnsctnRead: TFDTransaction
    Options.ReadOnly = True
    Options.AutoStop = False
    Options.EnableNested = False
    Connection = confd
    Left = 176
    Top = 216
  end
  object fdtrnsctnWrite: TFDTransaction
    Options.DisconnectAction = xdRollback
    Options.EnableNested = False
    Connection = confd
    Left = 176
    Top = 304
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
    Left = 576
    Top = 112
  end
  object fdqryUsers: TFDQuery
    Active = True
    BeforePost = fdqryUsersBeforePost
    Connection = confd
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate, uvGeneratorName, uvCheckRequired]
    UpdateOptions.GeneratorName = 'GEN_USERS_ID'
    UpdateOptions.KeyFields = 'ID'
    UpdateOptions.AutoIncFields = 'ID'
    UpdateObject = fdpdtsqlUsers
    SQL.Strings = (
      'select * from users')
    Left = 16
    Top = 256
  end
  object fdpdtsqlUsers: TFDUpdateSQL
    Connection = confd
    InsertSQL.Strings = (
      'INSERT INTO USERS'
      '(NAME, LOGIN, "PASSWORD", SUPERUSER, BLOCKED)'
      
        'VALUES (:NEW_NAME, :NEW_LOGIN, :NEW_PASSWORD, :NEW_SUPERUSER, :N' +
        'EW_BLOCKED)'
      'RETURNING NAME, LOGIN, "PASSWORD", SUPERUSER, BLOCKED')
    ModifySQL.Strings = (
      'UPDATE USERS'
      
        'SET NAME = :NEW_NAME, LOGIN = :NEW_LOGIN, "PASSWORD" = :NEW_PASS' +
        'WORD, '
      '  SUPERUSER = :NEW_SUPERUSER, BLOCKED = :NEW_BLOCKED'
      'WHERE ID = :OLD_ID'
      'RETURNING NAME, LOGIN, "PASSWORD", SUPERUSER, BLOCKED')
    DeleteSQL.Strings = (
      'DELETE FROM USERS'
      'WHERE ID = :OLD_ID')
    FetchRowSQL.Strings = (
      
        'SELECT ID, NAME, LOGIN, "PASSWORD" AS "PASSWORD", SUPERUSER, BLO' +
        'CKED'
      'FROM USERS'
      'WHERE ID = :OLD_ID')
    Left = 16
    Top = 320
  end
  object dsUsers: TDataSource
    DataSet = fdqryUsers
    Left = 16
    Top = 200
  end
end
