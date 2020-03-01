object frmRecord: TfrmRecord
  Left = 0
  Top = 0
  ClientHeight = 361
  ClientWidth = 573
  Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1079#1072#1087#1080#1089#1100
  OnShow = UniFormShow
  BorderStyle = bsSingle
  OldCreateOrder = False
  BorderIcons = [biSystemMenu]
  MonitoredKeys.Keys = <>
  PixelsPerInch = 96
  TextHeight = 13
  object lstTrip: TUniDBLookupListBox
    Left = 384
    Top = 32
    Width = 172
    Height = 73
    Hint = ''
    ListField = 'TripType'
    ListSource = UniMainModule.dsTripType
    KeyField = 'ID'
    ListFieldIndex = 0
    TabOrder = 3
    OnClick = lstTripClick
  end
  object lstUser: TUniDBLookupListBox
    Left = 8
    Top = 32
    Width = 353
    Height = 185
    Hint = ''
    ListField = 'NAME'
    ListSource = dsUsersAll
    KeyField = 'ID'
    ListFieldIndex = 0
    TabOrder = 2
  end
  object btnOk: TUniButton
    Left = 384
    Top = 313
    Width = 75
    Height = 25
    Hint = ''
    Caption = #1055#1086#1090#1074#1077#1088#1076#1080#1090#1100
    ModalResult = 1
    TabOrder = 10
    OnClick = btnOkClick
  end
  object btnCancel: TUniButton
    Left = 481
    Top = 313
    Width = 75
    Height = 25
    Hint = ''
    Caption = #1054#1090#1084#1077#1085#1072
    ModalResult = 2
    TabOrder = 11
    OnClick = btnCancelClick
  end
  object undtDay: TUniEdit
    Left = 384
    Top = 184
    Width = 172
    Hint = ''
    Enabled = False
    Text = ''
    TabOrder = 7
    EmptyText = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1076#1085#1077#1081
    ClearButton = True
  end
  object undtComment: TUniEdit
    Left = 8
    Top = 253
    Width = 548
    Hint = ''
    Text = ''
    TabOrder = 9
    EmptyText = #1050#1086#1084#1084#1077#1085#1090#1072#1088#1080#1080
    ClearButton = True
  end
  object undtmpckrBegin: TUniDateTimePicker
    Left = 384
    Top = 130
    Width = 172
    Hint = ''
    DateTime = 43889.000000000000000000
    DateFormat = 'dd/MM/yyyy'
    TimeFormat = 'HH:mm:ss'
    TabOrder = 5
  end
  object unlbl1: TUniLabel
    Left = 8
    Top = 234
    Width = 70
    Height = 13
    Hint = ''
    Caption = #1050#1086#1084#1084#1077#1085#1090#1072#1088#1080#1081' '
    TabOrder = 8
  end
  object unlbl2: TUniLabel
    Left = 8
    Top = 13
    Width = 95
    Height = 13
    Hint = ''
    Caption = #1042#1099#1073#1086#1088' '#1089#1086#1090#1088#1091#1076#1085#1080#1082#1072
    TabOrder = 0
  end
  object unlbl3: TUniLabel
    Left = 384
    Top = 13
    Width = 104
    Height = 13
    Hint = ''
    Caption = #1055#1088#1080#1095#1080#1085#1072' '#1086#1090#1089#1091#1090#1089#1090#1074#1080#1103
    TabOrder = 1
  end
  object unlbl4: TUniLabel
    Left = 384
    Top = 111
    Width = 26
    Height = 13
    Hint = ''
    Caption = #1044#1072#1090#1072
    TabOrder = 4
  end
  object unlbl5: TUniLabel
    Left = 384
    Top = 165
    Width = 58
    Height = 13
    Hint = ''
    Enabled = False
    Caption = #1063#1080#1089#1083#1086' '#1076#1085#1077#1081
    TabOrder = 6
  end
  object fdqryInsert: TFDQuery
    Connection = UniMainModule.confd
    Transaction = UniMainModule.fdtrnsctnWrite
    SQL.Strings = (
      'INSERT INTO TRIP  '
      '(ADMIN_ID, USER_ID,  TRIPDATE, TRIPTYPE, COMMENT) '
      ' VALUES   (:AID, :UID, :TD, :TP, :CMT)')
    Left = 16
    Top = 296
    ParamData = <
      item
        Name = 'AID'
        DataType = ftLargeint
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'UID'
        DataType = ftLargeint
        ParamType = ptInput
      end
      item
        Name = 'TD'
        DataType = ftDate
        ParamType = ptInput
      end
      item
        Name = 'TP'
        DataType = ftSmallint
        ParamType = ptInput
      end
      item
        Name = 'CMT'
        DataType = ftString
        ParamType = ptInput
        Size = 255
      end>
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
    Left = 80
    Top = 296
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
  object dsUsersAll: TDataSource
    DataSet = fdqryUsers
    Left = 136
    Top = 296
  end
end
