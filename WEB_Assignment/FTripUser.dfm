object frmTripUser: TfrmTripUser
  Left = 0
  Top = 0
  ClientHeight = 700
  ClientWidth = 1040
  Caption = ''
  OnShow = UniFormShow
  BorderStyle = bsNone
  OldCreateOrder = False
  BorderIcons = []
  MonitoredKeys.Keys = <>
  PixelsPerInch = 96
  TextHeight = 13
  object undbgrdTrip: TUniDBGrid
    Left = 5
    Top = 100
    Width = 1030
    Height = 450
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
        Width = 135
      end
      item
        FieldName = 'COMMENT'
        Title.Alignment = taCenter
        Title.Caption = #1050#1086#1084#1084#1077#1085#1090#1072#1088#1080#1080
        Width = 393
        ReadOnly = True
      end>
  end
  object undbnvgtrTrip: TUniDBNavigator
    Left = 5
    Top = 73
    Width = 1030
    Height = 25
    Hint = ''
    VisibleButtons = [nbFirst, nbPrior, nbNext, nbLast, nbRefresh]
    TabOrder = 1
  end
  object lbTripTab: TUniLabel
    Left = 20
    Top = 20
    Width = 225
    Height = 25
    Hint = ''
    Caption = #1058#1072#1073#1083#1080#1094#1072' '#1082#1086#1084#1072#1085#1076#1080#1088#1086#1074#1086#1082
    ParentFont = False
    Font.Height = -21
    TabOrder = 0
  end
  object undtmpckrBegin: TUniDateTimePicker
    Left = 10
    Top = 580
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
    Left = 10
    Top = 620
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
    Left = 912
    Top = 580
    Width = 120
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
      ListSource = UniMainModule.dsTripType
      KeyField = 'ID'
      ListFieldIndex = 0
      TabOrder = 1
      Color = clWindow
    end
  end
  object btnBack: TUniButton
    Left = 912
    Top = 620
    Width = 120
    Height = 25
    Hint = ''
    Caption = #1042#1077#1088#1085#1091#1090#1100#1089#1103
    TabOrder = 7
    OnClick = btnBackClick
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
      LookupDataSet = UniMainModule.fdmtblTripType
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
end
