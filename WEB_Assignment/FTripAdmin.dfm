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
    Top = 113
    Width = 1030
    Height = 425
    Hint = ''
    DataSource = dsTripAd
    LoadMask.Message = 'Loading data...'
    TabOrder = 0
    OnColumnFilter = undbgrdTripColumnFilter
    Columns = <
      item
        FieldName = 'ID'
        Title.Alignment = taCenter
        Title.Caption = 'ID'
        Width = 50
      end
      item
        FieldName = 'USERNAME'
        Filtering.Enabled = True
        Filtering.Editor = cbbUSER
        Title.Alignment = taCenter
        Title.Caption = #1048#1084#1103' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1103#13#10
        Width = 220
      end
      item
        FieldName = 'ADMINNAME'
        Filtering.Enabled = True
        Filtering.Editor = cbbAdmin
        Title.Alignment = taCenter
        Title.Caption = #1054#1090#1074#1077#1090#1089#1090#1074#1077#1085#1085#1086#1077' '#1083#1080#1094#1086
        Width = 250
      end
      item
        FieldName = 'TRIPDATE'
        Title.Alignment = taCenter
        Title.Caption = #1044#1072#1090#1072#13#10
        Width = 100
      end
      item
        FieldName = 'TT'
        Filtering.Enabled = True
        Filtering.Editor = cbbAd
        Title.Alignment = taCenter
        Title.Caption = ' '#1058#1080#1087
        Width = 120
      end
      item
        FieldName = 'COMMENT'
        Title.Alignment = taCenter
        Title.Caption = #1050#1086#1084#1084#1077#1085#1090#1072#1088#1080#1080
        Width = 250
      end>
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
    TabOrder = 1
  end
  object btnRefresh: TUniButton
    Left = 950
    Top = 568
    Width = 75
    Height = 25
    Hint = ''
    Caption = #1054#1073#1085#1086#1074#1080#1090#1100
    TabOrder = 2
    OnClick = btnRefreshClick
  end
  object undtmpckrEnd: TUniDateTimePicker
    Left = 8
    Top = 608
    Width = 209
    Height = 25
    Hint = ''
    DateTime = 43879.000000000000000000
    DateFormat = 'dd/MM/yyyy'
    TimeFormat = 'HH:mm:ss'
    TabOrder = 3
    FieldLabel = #1050#1086#1085#1077#1095#1085#1072#1103' '#1076#1072#1090#1072
    EmptyText = #1050#1086#1085#1077#1095#1085#1072#1103' '#1076#1072#1090#1072
  end
  object undtmpckrBegin: TUniDateTimePicker
    Left = 8
    Top = 560
    Width = 209
    Height = 25
    Hint = ''
    DateTime = 43879.000000000000000000
    DateFormat = 'dd/MM/yyyy'
    TimeFormat = 'HH:mm:ss'
    TabOrder = 4
    FieldLabel = #1053#1072#1095#1072#1083#1100#1085#1072#1103' '#1076#1072#1090#1072
    EmptyText = #1053#1072#1095#1072#1083#1100#1085#1072#1103' '#1076#1072#1090#1072
  end
  object undbnvgtrAd: TUniDBNavigator
    Left = 0
    Top = 88
    Width = 1032
    Height = 25
    Hint = ''
    TabOrder = 5
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
      ListSource = dsUser
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
  end
  object btnRecord: TUniButton
    Left = 904
    Top = 608
    Width = 121
    Height = 25
    Hint = ''
    Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1079#1072#1087#1080#1089#1100
    TabOrder = 7
    OnClick = btnRecordClick
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
    FetchOptions.Items = [fiBlobs, fiDetails]
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate, uvGeneratorName]
    UpdateOptions.GeneratorName = 'GEN_USERS_ID'
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
      Required = True
    end
    object lrgntfldTripAdUSER_ID: TLargeintField
      FieldName = 'USER_ID'
      Origin = 'USER_ID'
      Required = True
    end
    object lrgntfldTripAdADMIN_ID: TLargeintField
      FieldName = 'ADMIN_ID'
      Origin = 'ADMIN_ID'
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
      LookupDataSet = fdqryUsers
      LookupKeyFields = 'ID'
      LookupResultField = 'NAME'
      KeyFields = 'USER_ID'
      Size = 50
      Lookup = True
    end
    object strngfldTripAdADMINNAME: TStringField
      DisplayWidth = 50
      FieldKind = fkLookup
      FieldName = 'ADMINNAME'
      LookupDataSet = fdqryUsers
      LookupKeyFields = 'ID'
      LookupResultField = 'NAME'
      KeyFields = 'ADMIN_ID'
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
    InsertSQL.Strings = (
      'INSERT INTO TRIP'
      '(TRIPDATE, TRIPTYPE, "COMMENT")'
      'VALUES (:NEW_TRIPDATE, :NEW_TRIPTYPE, :NEW_COMMENT)'
      'RETURNING TRIPDATE, TRIPTYPE, "COMMENT"')
    ModifySQL.Strings = (
      'UPDATE TRIP'
      
        'SET TRIPDATE = :NEW_TRIPDATE, TRIPTYPE = :NEW_TRIPTYPE, "COMMENT' +
        '" = :NEW_COMMENT'
      
        'WHERE ID = :OLD_ID AND USER_ID = :OLD_USER_ID AND ADMIN_ID = :OL' +
        'D_ADMIN_ID'
      'RETURNING TRIPDATE, TRIPTYPE, "COMMENT"')
    DeleteSQL.Strings = (
      'DELETE FROM TRIP'
      
        'WHERE ID = :OLD_ID AND USER_ID = :OLD_USER_ID AND ADMIN_ID = :OL' +
        'D_ADMIN_ID')
    FetchRowSQL.Strings = (
      
        'SELECT ID, USER_ID, ADMIN_ID, TRIPDATE, TRIPTYPE, "COMMENT" AS "' +
        'COMMENT"'
      'FROM TRIP'
      
        'WHERE ID = :OLD_ID AND USER_ID = :OLD_USER_ID AND ADMIN_ID = :OL' +
        'D_ADMIN_ID')
    Left = 888
    Top = 16
  end
  object fdqryUsers: TFDQuery
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
      'SELECT ID, NAME FROM USERS')
    Left = 88
    Top = 24
    object fdqryUsersID: TLargeintField
      FieldName = 'ID'
      Origin = 'ID'
      Required = True
    end
    object fdqryUsersNAME: TStringField
      FieldName = 'NAME'
      Origin = 'NAME'
      Required = True
      Size = 255
    end
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
  object dsUser: TDataSource
    DataSet = fdqryUser
    Left = 392
    Top = 32
  end
  object fdqryUser: TFDQuery
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
      'SELECT ID, NAME FROM USERS WHERE SUPERUSER = 0')
    Left = 336
    Top = 32
    object lrgntfld2: TLargeintField
      FieldName = 'ID'
      Origin = 'ID'
      Required = True
    end
    object strngfld2: TStringField
      FieldName = 'NAME'
      Origin = 'NAME'
      Required = True
      Size = 255
    end
  end
end
