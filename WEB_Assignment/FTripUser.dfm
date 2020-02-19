object frmTripUser: TfrmTripUser
  Left = 0
  Top = 0
  ClientHeight = 722
  ClientWidth = 1041
  Caption = ''
  OnShow = UniFormShow
  BorderStyle = bsNone
  OldCreateOrder = False
  BorderIcons = []
  MonitoredKeys.Keys = <>
  PixelsPerInch = 96
  TextHeight = 13
  object undbgrdTrip: TUniDBGrid
    Left = 0
    Top = 96
    Width = 1033
    Height = 425
    Hint = ''
    DataSource = dsTrip
    LoadMask.Message = 'Loading data...'
    TabOrder = 2
    OnColumnFilter = undbgrdTripColumnFilter
    Columns = <
      item
        FieldName = 'NAME'
        Title.Alignment = taCenter
        Title.Caption = #1054#1090#1074#1077#1090#1089#1090#1074#1077#1085#1085#1086#1077' '#1083#1080#1094#1086
        Width = 300
        ReadOnly = True
      end
      item
        FieldName = 'TRIPDATE'
        Title.Alignment = taCenter
        Title.Caption = #1044#1072#1090#1072' '#1082#1086#1084#1072#1085#1076#1080#1088#1086#1074#1082#1080
        Width = 180
        ReadOnly = True
      end
      item
        FieldName = 'TT'
        Filtering.Enabled = True
        Filtering.Editor = undblkpcmbx1
        Title.Alignment = taCenter
        Title.Caption = #1058#1080#1087
        Width = 120
      end
      item
        FieldName = 'COMMENT'
        Title.Alignment = taCenter
        Title.Caption = #1050#1086#1084#1084#1077#1085#1090#1072#1088#1080#1080
        Width = 400
        ReadOnly = True
      end>
  end
  object undbnvgtrTrip: TUniDBNavigator
    Left = 0
    Top = 65
    Width = 1033
    Height = 25
    Hint = ''
    VisibleButtons = [nbFirst, nbPrior, nbNext, nbLast, nbRefresh]
    TabOrder = 1
  end
  object lbTripTab: TUniLabel
    Left = 408
    Top = 16
    Width = 225
    Height = 25
    Hint = ''
    Caption = #1058#1072#1073#1083#1080#1094#1072' '#1082#1086#1084#1072#1085#1076#1080#1088#1086#1074#1086#1082
    ParentFont = False
    Font.Height = -21
    TabOrder = 0
  end
  object undtmpckrBegin: TUniDateTimePicker
    Left = 8
    Top = 544
    Width = 209
    Height = 25
    Hint = ''
    DateTime = 43879.000000000000000000
    DateFormat = 'dd/MM/yyyy'
    TimeFormat = 'HH:mm:ss'
    TabOrder = 3
    FieldLabel = #1053#1072#1095#1072#1083#1100#1085#1072#1103' '#1076#1072#1090#1072
    EmptyText = #1053#1072#1095#1072#1083#1100#1085#1072#1103' '#1076#1072#1090#1072
  end
  object undtmpckrEnd: TUniDateTimePicker
    Left = 8
    Top = 584
    Width = 209
    Height = 25
    Hint = ''
    DateTime = 43879.000000000000000000
    DateFormat = 'dd/MM/yyyy'
    TimeFormat = 'HH:mm:ss'
    TabOrder = 6
    FieldLabel = #1050#1086#1085#1077#1095#1085#1072#1103' '#1076#1072#1090#1072
    EmptyText = #1050#1086#1085#1077#1095#1085#1072#1103' '#1076#1072#1090#1072
  end
  object btnRefresh: TUniButton
    Left = 942
    Top = 544
    Width = 75
    Height = 25
    Hint = ''
    Caption = #1054#1073#1085#1086#1074#1080#1090#1100
    TabOrder = 4
    OnClick = btnRefreshClick
  end
  object unhdnpnl1: TUniHiddenPanel
    Left = 312
    Top = 304
    Width = 305
    Height = 113
    Hint = ''
    Visible = True
    object undblkpcmbx1: TUniDBLookupComboBox
      Left = 24
      Top = 16
      Width = 145
      Hint = ''
      ListField = 'TripType'
      ListSource = dsTripType
      KeyField = 'ID'
      ListFieldIndex = 0
      TabOrder = 1
      Color = clWindow
    end
  end
  object fdqryTrip: TFDQuery
    Connection = UniMainModule.confd
    Transaction = UniMainModule.fdtrnsctnRead
    FetchOptions.AssignedValues = [evItems]
    FetchOptions.Items = [fiBlobs, fiDetails]
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate, uvGeneratorName]
    UpdateOptions.EnableDelete = False
    UpdateOptions.EnableInsert = False
    UpdateOptions.EnableUpdate = False
    UpdateOptions.GeneratorName = 'GEN_USERS_ID'
    SQL.Strings = (
      'SELECT  users.name, trip.tripdate,  trip.triptype, trip.comment'
      'FROM users'
      'INNER JOIN trip on (users.id = trip.admin_id)'
      
        'WHERE ((trip.user_id = :id)  and  (trip.tripdate between :d1 and' +
        ' :d2))')
    Left = 888
    Top = 16
    ParamData = <
      item
        Name = 'ID'
        DataType = ftLargeint
        ParamType = ptInput
      end
      item
        Name = 'D1'
        DataType = ftDate
        ParamType = ptInput
      end
      item
        Name = 'D2'
        DataType = ftDate
        ParamType = ptInput
      end>
    object strngfldTripNAME: TStringField
      FieldName = 'NAME'
      Origin = 'NAME'
      Required = True
      Size = 255
    end
    object dtfldTripTRIPDATE: TDateField
      AutoGenerateValue = arDefault
      FieldName = 'TRIPDATE'
      Origin = 'TRIPDATE'
      ProviderFlags = []
      ReadOnly = True
    end
    object smlntfldTripTRIPTYPE: TSmallintField
      AutoGenerateValue = arDefault
      FieldName = 'TRIPTYPE'
      Origin = 'TRIPTYPE'
      ProviderFlags = []
      ReadOnly = True
    end
    object strngfldTripCOMMENT: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'COMMENT'
      Origin = '"COMMENT"'
      ProviderFlags = []
      ReadOnly = True
      Size = 255
    end
    object strngfldTripTT: TStringField
      FieldKind = fkLookup
      FieldName = 'TT'
      LookupDataSet = fdmtblTripType
      LookupKeyFields = 'ID'
      LookupResultField = 'TripType'
      KeyFields = 'TRIPTYPE'
      Lookup = True
    end
  end
  object dsTrip: TDataSource
    DataSet = fdqryTrip
    Left = 840
    Top = 16
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
    Left = 528
    Top = 560
    Content = {
      414442530F005D1967010000FF00010001FF02FF0304001C000000660064006D
      00740062006C005400720069007000540079007000650005000A000000540061
      0062006C006500060000000000070000080032000000090000FF0AFF0B040004
      00000049004400050004000000490044000C00010000000E000D000F00011000
      0111000112000113000114000115000400000049004400FEFF0B040010000000
      5400720069007000540079007000650005001000000054007200690070005400
      7900700065000C00020000000E0016001700140000000F000110000111000112
      0001130001140001150010000000540072006900700054007900700065001800
      14000000FEFEFF19FEFF1AFEFF1BFF1C1D0000000000FF1E0000000000000100
      0C000000CAEEECE0EDE4E8F0EEE2EAE0FEFEFF1C1D0001000000FF1E00000100
      000001000A000000C1EEEBFCEDE8F7EDFBE9FEFEFEFEFEFF1FFEFF2021000200
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
    Left = 456
    Top = 560
  end
end
