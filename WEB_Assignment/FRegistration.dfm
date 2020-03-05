object frmRegistration: TfrmRegistration
  Left = 0
  Top = 0
  ClientHeight = 700
  ClientWidth = 1040
  Caption = #1056#1077#1075#1080#1089#1090#1088#1072#1094#1080#1103
  OnShow = UniFormShow
  BorderStyle = bsNone
  OldCreateOrder = False
  BorderIcons = []
  MonitoredKeys.Keys = <>
  PixelsPerInch = 96
  TextHeight = 13
  object undbgrd1: TUniDBGrid
    Left = 5
    Top = 100
    Width = 1030
    Height = 450
    Hint = ''
    DataSource = dsUsers
    LoadMask.Message = 'Loading data...'
    TabOrder = 2
    OnColumnFilter = undbgrd1ColumnFilter
    Columns = <
      item
        FieldName = 'ID'
        Title.Alignment = taCenter
        Title.Caption = 'ID'
        Width = 78
        ReadOnly = True
      end
      item
        FieldName = 'NAME'
        Title.Alignment = taCenter
        Title.Caption = #1060#1048#1054
        Width = 341
      end
      item
        FieldName = 'LOGIN'
        Title.Alignment = taCenter
        Title.Caption = #1051#1086#1075#1080#1085
        Width = 242
      end
      item
        FieldName = 'PASSWORD'
        Title.Alignment = taCenter
        Title.Caption = #1055#1072#1088#1086#1083#1100#13#10
        Width = 139
      end
      item
        FieldName = 'StrStatus'
        Filtering.Enabled = True
        Filtering.Editor = cbbFSt
        Title.Alignment = taCenter
        Title.Caption = #1057#1090#1072#1090#1091#1089
        Width = 124
      end
      item
        FieldName = 'StrBlock'
        Filtering.Enabled = True
        Filtering.Editor = cbbBlock
        Title.Alignment = taCenter
        Title.Caption = #1041#1083#1086#1082#1080#1088#1086#1074#1082#1072
        Width = 112
      end>
  end
  object lbNameTab: TUniLabel
    Left = 10
    Top = 20
    Width = 234
    Height = 25
    Hint = ''
    Caption = #1058#1072#1073#1083#1080#1094#1072' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1077#1081
    ParentFont = False
    Font.Height = -21
    TabOrder = 0
  end
  object btnExit: TUniButton
    Left = 900
    Top = 580
    Width = 120
    Height = 25
    Hint = ''
    Caption = #1042#1077#1088#1085#1091#1090#1100#1089#1103
    TabOrder = 4
    OnClick = btnExitClick
  end
  object undbnvgtrTb1: TUniDBNavigator
    Left = 5
    Top = 73
    Width = 1030
    Height = 25
    Hint = ''
    DataSource = dsUsers
    TabOrder = 1
  end
  object unhdnpnlSuperUser: TUniHiddenPanel
    Left = 576
    Top = 160
    Width = 409
    Height = 177
    Hint = ''
    Visible = True
    object cbbStatus: TUniDBLookupComboBox
      Left = 16
      Top = 3
      Width = 145
      Hint = ''
      ListField = 'VString'
      ListSource = UniMainModule.dsStatus
      KeyField = 'Value'
      ListFieldIndex = 0
      TabOrder = 1
      Color = clWindow
    end
    object cbbBlock: TUniDBLookupComboBox
      Left = 16
      Top = 48
      Width = 145
      Hint = ''
      ListField = 'VString'
      ListSource = UniMainModule.dsBlock
      KeyField = 'Value'
      ListFieldIndex = 0
      TabOrder = 2
      Color = clWindow
    end
    object cbbFSt: TUniDBLookupComboBox
      Left = 176
      Top = 3
      Width = 145
      Hint = ''
      ListField = 'VString'
      ListSource = UniMainModule.dsStatus
      KeyField = 'Value'
      ListFieldIndex = 0
      TabOrder = 3
      Color = clWindow
    end
    object cbbFBl: TUniDBLookupComboBox
      Left = 176
      Top = 48
      Width = 145
      Hint = ''
      ListField = 'VString'
      ListSource = UniMainModule.dsBlock
      KeyField = 'Value'
      ListFieldIndex = 0
      TabOrder = 4
      Color = clWindow
    end
  end
  object dsUsers: TDataSource
    DataSet = fdqryUsers
    Left = 608
    Top = 16
  end
  object fdpdtsqlUsers: TFDUpdateSQL
    Connection = UniMainModule.confd
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
    Left = 752
    Top = 16
  end
  object fdqryUsers: TFDQuery
    BeforePost = fdqryUsersBeforePost
    Connection = UniMainModule.confd
    Transaction = UniMainModule.fdtrnsctnRead
    UpdateTransaction = UniMainModule.fdtrnsctnWrite
    FetchOptions.AssignedValues = [evItems]
    FetchOptions.Items = [fiBlobs, fiDetails]
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate, uvGeneratorName, uvCheckRequired, uvCheckReadOnly]
    UpdateOptions.GeneratorName = 'GEN_USERS_ID'
    UpdateOptions.KeyFields = 'ID'
    UpdateOptions.AutoIncFields = 'ID'
    UpdateObject = fdpdtsqlUsers
    SQL.Strings = (
      'select * from users')
    Left = 680
    Top = 16
    object lrgntfldUsersID: TLargeintField
      AutoGenerateValue = arAutoInc
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object strngfldUsersNAME: TStringField
      FieldName = 'NAME'
      Origin = 'NAME'
      Required = True
      Size = 255
    end
    object strngfldUsersLOGIN: TStringField
      FieldName = 'LOGIN'
      Origin = 'LOGIN'
      Required = True
      Size = 255
    end
    object strngfldUsersPASSWORD: TStringField
      FieldName = 'PASSWORD'
      Origin = '"PASSWORD"'
      Required = True
      Size = 255
    end
    object smlntfldUsersSUPERUSER: TSmallintField
      FieldName = 'SUPERUSER'
      KeyFields = 'StrStatus'
      Origin = 'SUPERUSER'
      Required = True
    end
    object smlntfldUsersBLOCKED: TSmallintField
      FieldName = 'BLOCKED'
      KeyFields = 'StrBlock'
      Origin = 'BLOCKED'
      Required = True
    end
    object strngfldUsersStrStatus: TStringField
      FieldKind = fkLookup
      FieldName = 'StrStatus'
      LookupDataSet = UniMainModule.fdmtblStatus
      LookupKeyFields = 'Value'
      LookupResultField = 'VString'
      KeyFields = 'SUPERUSER'
      Lookup = True
    end
    object strngfldUsersStrBlock: TStringField
      FieldKind = fkLookup
      FieldName = 'StrBlock'
      LookupDataSet = UniMainModule.fdmtblBlock
      LookupKeyFields = 'Value'
      LookupResultField = 'VString'
      KeyFields = 'BLOCKED'
      Lookup = True
    end
  end
  object fdqryCheckLogin: TFDQuery
    BeforePost = fdqryUsersBeforePost
    Connection = UniMainModule.confd
    Transaction = UniMainModule.fdtrnsctnRead
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate, uvGeneratorName, uvCheckRequired]
    UpdateOptions.GeneratorName = 'GEN_USERS_ID'
    UpdateOptions.KeyFields = 'ID'
    UpdateOptions.AutoIncFields = 'ID'
    SQL.Strings = (
      'select Login from users where Login=:login')
    Left = 520
    Top = 24
    ParamData = <
      item
        Name = 'LOGIN'
        DataType = ftString
        ParamType = ptInput
        Size = 255
        Value = Null
      end>
  end
end
