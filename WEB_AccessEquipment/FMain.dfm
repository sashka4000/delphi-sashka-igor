object frmMain: TfrmMain
  Left = 0
  Top = 0
  ClientHeight = 766
  ClientWidth = 984
  Caption = 'frmMain'
  OldCreateOrder = False
  OnClose = UniFormClose
  Menu = unmnmnMain
  MonitoredKeys.Keys = <>
  OnCreate = UniFormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object undbgrdClient: TUniDBGrid
    Left = 0
    Top = 45
    Width = 976
    Height = 361
    Hint = ''
    DataSource = dsClient
    LoadMask.Message = 'Loading data...'
    TabOrder = 0
    OnDblClick = undbgrdClientDblClick
    Columns = <
      item
        FieldName = 'ID'
        Title.Alignment = taCenter
        Title.Caption = #8470
        Width = 30
      end
      item
        FieldName = 'NameEquipment'
        Title.Alignment = taCenter
        Title.Caption = ' '#1053#1072#1079#1074#1072#1085#1080#1077' '#1091#1089#1090#1088#1086#1081#1089#1090#1074#1072
        Width = 174
      end
      item
        FieldName = 'IpAddress'
        Title.Alignment = taCenter
        Title.Caption = 'IP-'#1072#1076#1088#1077#1089
        Width = 140
      end
      item
        FieldName = 'TimeQuery'
        Title.Alignment = taCenter
        Title.Caption = #1048#1085#1090#1077#1088#1074#1072#1083' '#1087#1088#1086#1074#1077#1088#1082#1080' ('#1089#1077#1082')'
        Width = 177
      end
      item
        FieldName = 'Comment'
        Title.Alignment = taCenter
        Title.Caption = #1050#1086#1084#1084#1077#1085#1090#1072#1088#1080#1080
        Width = 434
      end>
  end
  object unmList: TUniMemo
    Left = 0
    Top = 424
    Width = 489
    Height = 169
    Hint = ''
    TabOrder = 1
  end
  object unmLog: TUniMemo
    Left = 0
    Top = 616
    Width = 337
    Height = 142
    Hint = ''
    TabOrder = 2
  end
  object btnLogClear: TUniButton
    Left = 368
    Top = 733
    Width = 121
    Height = 25
    Hint = ''
    Caption = #1054#1095#1080#1089#1090#1080#1090#1100' '#1051#1086#1075
    TabOrder = 3
  end
  object unchrtTest: TUniChart
    Left = 552
    Top = 424
    Width = 424
    Height = 334
    Hint = ''
    LayoutConfig.BodyPadding = '10'
    object unlnsrsTest: TUniLineSeries
      Title = #1043#1088#1072#1092#1080#1082' '#1086#1090#1074#1077#1090#1072' '#1074' '#1084#1089
      SeriesLabel.Enabled = True
      DataSource = dsList
      YValues.ValueSource = 'TimeCount'
      XLabelsSource = 'TimeQuestion'
    end
  end
  object undbnvgtrClient: TUniDBNavigator
    Left = 0
    Top = 14
    Width = 976
    Height = 25
    Hint = ''
    DataSource = dsClient
    TabOrder = 5
  end
  object unmnmnMain: TUniMainMenu
    Left = 8
    Top = 336
    object unmntmOption: TUniMenuItem
      Caption = #1054#1087#1094#1080#1080
      object unmntmMode: TUniMenuItem
        Caption = #1055#1077#1088#1077#1081#1090#1080' '#1074' '#1088#1072#1073#1086#1095#1080#1081' '#1088#1077#1078#1080#1084
        OnClick = unmntmModeClick
      end
    end
    object unmntmHelp: TUniMenuItem
      Caption = #1055#1086#1084#1086#1097#1100
    end
  end
  object fdstnstrgjsnlnkClient: TFDStanStorageJSONLink
    Left = 8
    Top = 280
  end
  object fdmtblList: TFDMemTable
    Active = True
    FieldDefs = <
      item
        Name = 'IpAddr'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'TimeQuestion'
        DataType = ftDateTime
      end
      item
        Name = 'TimeCount'
        DataType = ftInteger
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
    Left = 760
    Top = 344
  end
  object fdmtblClient: TFDMemTable
    Active = True
    FieldDefs = <
      item
        Name = 'ID'
        DataType = ftAutoInc
      end
      item
        Name = 'NameEquipment'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'IpAddress'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'TimeQuery'
        DataType = ftInteger
      end
      item
        Name = 'Comment'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'LastTime'
        DataType = ftDateTime
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
    Left = 760
    Top = 248
  end
  object dsClient: TDataSource
    DataSet = fdmtblClient
    Left = 816
    Top = 248
  end
  object dsList: TDataSource
    DataSet = fdmtblList
    Left = 816
    Top = 344
  end
  object unthrdtmrClient: TUniThreadTimer
    OnTimer = unthrdtmrClientTimer
    Left = 99
    Top = 340
  end
  object fdmtblReadOnly: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 752
    Top = 296
  end
end
