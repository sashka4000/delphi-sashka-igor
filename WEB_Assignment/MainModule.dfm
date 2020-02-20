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
      414442530F000F2B67010000FF00010001FF02FF0304001C000000660064006D
      00740062006C005400720069007000540079007000650005000A000000540061
      0062006C006500060000000000070000080032000000090000FF0AFF0B040004
      00000049004400050004000000490044000C00010000000E000D000F00011000
      0111000112000113000114000115000400000049004400FEFF0B040010000000
      5400720069007000540079007000650005001000000054007200690070005400
      7900700065000C00020000000E0016001700140000000F000110000111000112
      0001130001140001150010000000540072006900700054007900700065001800
      14000000FEFEFF19FEFF1AFEFF1BFF1C1D0000000000FF1E0000010000000100
      0A000000C1EEEBFCEDE8F7EDFBE5FEFEFF1C1D0001000000FF1E000000000000
      01000C000000CAEEECE0EDE4E8F0EEE2EAE0FEFEFEFEFEFF1FFEFF2021000400
      0000FF22FEFEFE0E004D0061006E0061006700650072001E0055007000640061
      007400650073005200650067006900730074007200790012005400610062006C
      0065004C006900730074000A005400610062006C00650008004E0061006D0065
      00140053006F0075007200630065004E0061006D0065000A0054006100620049
      004400240045006E0066006F0072006300650043006F006E0073007400720061
      0069006E00740073001E004D0069006E0069006D0075006D0043006100700061
      006300690074007900180043006800650063006B004E006F0074004E0075006C
      006C00140043006F006C0075006D006E004C006900730074000C0043006F006C
      0075006D006E00100053006F007500720063006500490044000E006400740049
      006E007400330032001000440061007400610054007900700065001400530065
      006100720063006800610062006C006500120041006C006C006F0077004E0075
      006C006C000800420061007300650014004F0041006C006C006F0077004E0075
      006C006C0012004F0049006E0055007000640061007400650010004F0049006E
      00570068006500720065001A004F0072006900670069006E0043006F006C004E
      0061006D00650018006400740041006E007300690053007400720069006E0067
      000800530069007A006500140053006F007500720063006500530069007A0065
      001C0043006F006E00730074007200610069006E0074004C0069007300740010
      0056006900650077004C006900730074000E0052006F0077004C006900730074
      00060052006F0077000A0052006F0077004900440010004F0072006900670069
      006E0061006C001800520065006C006100740069006F006E004C006900730074
      001C0055007000640061007400650073004A006F00750072006E0061006C0012
      00530061007600650050006F0069006E0074000E004300680061006E00670065
      007300}
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
end
