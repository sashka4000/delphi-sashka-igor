object frmTripAdmin: TfrmTripAdmin
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
    Left = 2
    Top = 104
    Width = 1030
    Height = 450
    Hint = ''
    DataSource = dsTripAd
    LoadMask.Message = 'Loading data...'
    TabOrder = 2
    OnColumnFilter = undbgrdTripColumnFilter
    Columns = <
      item
        FieldName = 'ID'
        Title.Alignment = taCenter
        Title.Caption = 'ID'
        Width = 50
        ReadOnly = True
      end
      item
        FieldName = 'USERNAME'
        Filtering.Enabled = True
        Filtering.Editor = cbbUSER
        Title.Alignment = taCenter
        Title.Caption = #1048#1084#1103' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1103#13#10
        Width = 220
        ReadOnly = True
      end
      item
        FieldName = 'ADMINNAME'
        Filtering.Enabled = True
        Filtering.Editor = cbbAdmin
        Title.Alignment = taCenter
        Title.Caption = #1054#1090#1074#1077#1090#1089#1090#1074#1077#1085#1085#1086#1077' '#1083#1080#1094#1086
        Width = 250
        ReadOnly = True
      end
      item
        FieldName = 'TRIPDATE'
        Title.Alignment = taCenter
        Title.Caption = #1044#1072#1090#1072#13#10
        Width = 106
        Editor = undtmpckrSelectDate
      end
      item
        FieldName = 'TT'
        Filtering.Enabled = True
        Filtering.Editor = cbbAd
        Title.Alignment = taCenter
        Title.Caption = ' '#1058#1080#1087
        Width = 137
      end
      item
        FieldName = 'COMMENT'
        Title.Alignment = taCenter
        Title.Caption = #1050#1086#1084#1084#1077#1085#1090#1072#1088#1080#1080
        Width = 255
      end>
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
  object btnRefresh: TUniButton
    Left = 900
    Top = 580
    Width = 120
    Height = 25
    Hint = ''
    Caption = #1054#1073#1085#1086#1074#1080#1090#1100
    TabOrder = 4
    OnClick = btnRefreshClick
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
  object undbnvgtrAd: TUniDBNavigator
    Left = 5
    Top = 73
    Width = 1030
    Height = 25
    Hint = ''
    DataSource = dsTripAd
    VisibleButtons = [nbFirst, nbPrior, nbNext, nbLast, nbDelete, nbEdit, nbPost, nbCancel, nbRefresh]
    TabOrder = 1
  end
  object unhdnpnlAd: TUniHiddenPanel
    Left = 680
    Top = 160
    Width = 273
    Height = 177
    Hint = ''
    Visible = True
    object cbbAd: TUniDBLookupComboBox
      Left = 56
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
    object cbbUSER: TUniDBLookupComboBox
      Left = 56
      Top = 44
      Width = 145
      Hint = ''
      ListField = 'NAME'
      ListSource = UniMainModule.dsUsersAll
      KeyField = 'ID'
      ListFieldIndex = 0
      TabOrder = 2
      Color = clWindow
    end
    object cbbAdmin: TUniDBLookupComboBox
      Left = 56
      Top = 72
      Width = 145
      Hint = ''
      ListField = 'NAME'
      ListSource = dsAdmin
      KeyField = 'ID'
      ListFieldIndex = 0
      TabOrder = 3
      Color = clWindow
    end
    object undtmpckrSelectDate: TUniDateTimePicker
      Left = 64
      Top = 100
      Width = 120
      Hint = ''
      DateTime = 43895.000000000000000000
      DateFormat = 'dd/MM/yyyy'
      TimeFormat = 'HH:mm:ss'
      TabOrder = 4
    end
  end
  object btnRecord: TUniButton
    Left = 900
    Top = 620
    Width = 120
    Height = 25
    Hint = ''
    Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1079#1072#1087#1080#1089#1100
    TabOrder = 7
    OnClick = btnRecordClick
  end
  object btnBack: TUniButton
    Left = 900
    Top = 660
    Width = 120
    Height = 25
    Hint = ''
    Caption = #1042#1077#1088#1085#1091#1090#1100#1089#1103
    TabOrder = 8
    OnClick = btnBackClick
  end
  object dsTripAd: TDataSource
    DataSet = fdqryTripAd
    Left = 744
    Top = 16
  end
  object fdqryTripAd: TFDQuery
    Connection = UniMainModule.confd
    Transaction = UniMainModule.fdtrnsctnRead
    UpdateTransaction = UniMainModule.fdtrnsctnWrite
    FetchOptions.AssignedValues = [evItems]
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate, uvGeneratorName]
    UpdateOptions.EnableInsert = False
    UpdateOptions.GeneratorName = 'GEN_USERS_ID'
    UpdateObject = fdpdtsqlAd
    SQL.Strings = (
      'SELECT * FROM trip where TRIPDATE BETWEEN :d1 and :d2')
    Left = 808
    Top = 16
    ParamData = <
      item
        Name = 'D1'
        DataType = ftDate
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'D2'
        DataType = ftDate
        ParamType = ptInput
      end>
    object lrgntfldTripAdID: TLargeintField
      FieldName = 'ID'
      Origin = 'ID'
      ReadOnly = True
      Required = True
    end
    object lrgntfldTripAdUSER_ID: TLargeintField
      FieldName = 'USER_ID'
      Origin = 'USER_ID'
      ReadOnly = True
      Required = True
    end
    object lrgntfldTripAdADMIN_ID: TLargeintField
      FieldName = 'ADMIN_ID'
      Origin = 'ADMIN_ID'
      ReadOnly = True
      Required = True
    end
    object dtfldTripAdTRIPDATE: TDateField
      FieldName = 'TRIPDATE'
      Origin = 'TRIPDATE'
      Required = True
    end
    object smlntfldTripAdTRIPTYPE: TSmallintField
      FieldName = 'TRIPTYPE'
      Origin = 'TRIPTYPE'
      Required = True
    end
    object strngfldTripAdCOMMENT: TStringField
      FieldName = 'COMMENT'
      Origin = '"COMMENT"'
      Size = 255
    end
    object strngfldTripAdUSERNAME: TStringField
      DisplayWidth = 50
      FieldKind = fkLookup
      FieldName = 'USERNAME'
      LookupDataSet = UniMainModule.fdqryUsers
      LookupKeyFields = 'ID'
      LookupResultField = 'NAME'
      KeyFields = 'USER_ID'
      ReadOnly = True
      Size = 50
      Lookup = True
    end
    object strngfldTripAdADMINNAME: TStringField
      DisplayWidth = 50
      FieldKind = fkLookup
      FieldName = 'ADMINNAME'
      LookupDataSet = UniMainModule.fdqryUsers
      LookupKeyFields = 'ID'
      LookupResultField = 'NAME'
      KeyFields = 'ADMIN_ID'
      ReadOnly = True
      Size = 50
      Lookup = True
    end
    object strngfldTripAdTT: TStringField
      FieldKind = fkLookup
      FieldName = 'TT'
      LookupDataSet = UniMainModule.fdmtblTripType
      LookupKeyFields = 'ID'
      LookupResultField = 'TripType'
      KeyFields = 'TRIPTYPE'
      Lookup = True
    end
  end
  object fdpdtsqlAd: TFDUpdateSQL
    Connection = UniMainModule.confd
    ModifySQL.Strings = (
      'UPDATE TRIP'
      
        'SET USER_ID = :NEW_USER_ID, ADMIN_ID = :NEW_ADMIN_ID, TRIPDATE =' +
        ' :NEW_TRIPDATE, '
      '  TRIPTYPE = :NEW_TRIPTYPE, "COMMENT" = :NEW_COMMENT'
      'WHERE ID = :OLD_ID'
      'RETURNING USER_ID, ADMIN_ID, TRIPDATE, TRIPTYPE, "COMMENT"')
    DeleteSQL.Strings = (
      'DELETE FROM TRIP'
      'WHERE ID = :OLD_ID')
    FetchRowSQL.Strings = (
      
        'SELECT ID, USER_ID, ADMIN_ID, TRIPDATE, TRIPTYPE, "COMMENT" AS "' +
        'COMMENT"'
      'FROM TRIP'
      'WHERE ID = :OLD_ID')
    Left = 888
    Top = 16
  end
  object dsAdmin: TDataSource
    DataSet = fdqryAdmin
    Left = 272
    Top = 32
  end
  object fdqryAdmin: TFDQuery
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
      'SELECT ID, NAME FROM USERS WHERE SUPERUSER = 1')
    Left = 208
    Top = 32
    object lrgntfld1: TLargeintField
      FieldName = 'ID'
      Origin = 'ID'
      Required = True
    end
    object strngfld1: TStringField
      FieldName = 'NAME'
      Origin = 'NAME'
      Required = True
      Size = 255
    end
  end
end
