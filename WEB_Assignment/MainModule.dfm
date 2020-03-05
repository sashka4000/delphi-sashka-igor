object UniMainModule: TUniMainModule
  OldCreateOrder = False
  OnCreate = UniGUIMainModuleCreate
  OnDestroy = UniGUIMainModuleDestroy
  MonitoredKeys.Keys = <>
  Height = 418
  Width = 688
  object confd: TFDConnection
    Params.Strings = (
      'Database=C:\DB\TEKONDB.FDB'
      'User_Name=sysdba'
      'Password=masterkey'
      'CharacterSet=WIN1251'
      'Protocol=TCPIP'
      'Server=127.0.0.1'
      'DriverID=FB')
    ConnectedStoredUsage = [auDesignTime]
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
    Options.AutoStop = False
    Options.EnableNested = False
    Connection = confd
    Left = 120
    Top = 24
  end
  object fdtrnsctnWrite: TFDTransaction
    Options.DisconnectAction = xdRollback
    Options.EnableNested = False
    Connection = confd
    Left = 120
    Top = 96
  end
  object fdgxwtcrsrUser: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 24
    Top = 136
  end
  object fdmtblTripType: TFDMemTable
    Active = True
    FieldDefs = <
      item
        Name = 'ID'
        DataType = ftInteger
      end
      item
        Name = 'TripType'
        DataType = ftString
        Size = 20
      end>
    IndexDefs = <>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvPersistent, rvSilentMode]
    ResourceOptions.Persistent = True
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    StoreDefs = True
    Left = 252
    Top = 26
    Content = {
      414442530F00301C1B010000FF00010001FF02FF0304001C000000660064006D
      00740062006C005400720069007000540079007000650005000A000000540061
      0062006C006500060000000000070000080032000000090000FF0AFF0B040004
      00000049004400050004000000490044000C00010000000E000D000F00011000
      0111000112000113000114000115000400000049004400FEFF0B040010000000
      5400720069007000540079007000650005001000000054007200690070005400
      7900700065000C00020000000E0016001700140000000F000110000111000112
      0001130001140001150010000000540072006900700054007900700065001800
      14000000FEFEFF19FEFF1AFEFF1BFEFEFEFF1CFEFF1DFF1EFEFEFE0E004D0061
      006E0061006700650072001E0055007000640061007400650073005200650067
      006900730074007200790012005400610062006C0065004C006900730074000A
      005400610062006C00650008004E0061006D006500140053006F007500720063
      0065004E0061006D0065000A0054006100620049004400240045006E0066006F
      0072006300650043006F006E00730074007200610069006E00740073001E004D
      0069006E0069006D0075006D0043006100700061006300690074007900180043
      006800650063006B004E006F0074004E0075006C006C00140043006F006C0075
      006D006E004C006900730074000C0043006F006C0075006D006E00100053006F
      007500720063006500490044000E006400740049006E00740033003200100044
      0061007400610054007900700065001400530065006100720063006800610062
      006C006500120041006C006C006F0077004E0075006C006C0008004200610073
      00650014004F0041006C006C006F0077004E0075006C006C0012004F0049006E
      0055007000640061007400650010004F0049006E00570068006500720065001A
      004F0072006900670069006E0043006F006C004E0061006D0065001800640074
      0041006E007300690053007400720069006E0067000800530069007A00650014
      0053006F007500720063006500530069007A0065001C0043006F006E00730074
      007200610069006E0074004C00690073007400100056006900650077004C0069
      00730074000E0052006F0077004C006900730074001800520065006C00610074
      0069006F006E004C006900730074001C0055007000640061007400650073004A
      006F00750072006E0061006C000E004300680061006E00670065007300}
    object intgrfldTripTypeID: TIntegerField
      FieldName = 'ID'
    end
    object strngfldTripTypeTripType: TStringField
      FieldName = 'TripType'
    end
  end
  object dsTripType: TDataSource
    DataSet = fdmtblTripType
    Left = 324
    Top = 26
  end
  object fdqryUsers: TFDQuery
    Active = True
    Connection = confd
    Transaction = fdtrnsctnRead
    FetchOptions.AssignedValues = [evItems]
    FetchOptions.Items = [fiBlobs, fiDetails]
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate, uvGeneratorName]
    UpdateOptions.EnableDelete = False
    UpdateOptions.EnableInsert = False
    UpdateOptions.EnableUpdate = False
    UpdateOptions.GeneratorName = 'GEN_USERS_ID'
    SQL.Strings = (
      'SELECT ID, NAME FROM USERS')
    Left = 272
    Top = 136
    object lrgntfldUsersID: TLargeintField
      FieldName = 'ID'
      Origin = 'ID'
      Required = True
    end
    object strngfldUsersNAME: TStringField
      FieldName = 'NAME'
      Origin = 'NAME'
      Required = True
      Size = 255
    end
  end
  object dsUsersAll: TDataSource
    DataSet = fdqryUsers
    Left = 344
    Top = 136
  end
end
