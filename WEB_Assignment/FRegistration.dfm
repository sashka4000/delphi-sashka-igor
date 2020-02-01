object frmRegistration: TfrmRegistration
  Left = 0
  Top = 0
  ClientHeight = 425
  ClientWidth = 831
  Caption = #1056#1077#1075#1080#1089#1090#1088#1072#1094#1080#1103
  BorderStyle = bsNone
  OldCreateOrder = False
  BorderIcons = []
  MonitoredKeys.Keys = <>
  PixelsPerInch = 96
  TextHeight = 13
  object undbgrd1: TUniDBGrid
    Left = 8
    Top = 96
    Width = 809
    Height = 250
    Hint = ''
    DataSource = UniMainModule.ds1
    LoadMask.Message = 'Loading data...'
    TabOrder = 2
  end
  object lbNameTab: TUniLabel
    Left = 280
    Top = 16
    Width = 234
    Height = 25
    Hint = ''
    Caption = #1058#1072#1073#1083#1080#1094#1072' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1077#1081
    ParentFont = False
    Font.Height = -21
    TabOrder = 0
  end
  object btnSave: TUniButton
    Left = 683
    Top = 352
    Width = 140
    Height = 25
    Hint = ''
    Enabled = False
    Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1080#1079#1084#1077#1085#1077#1085#1080#1103
    TabOrder = 4
    OnClick = btnSaveClick
  end
  object btnExit: TUniButton
    Left = 8
    Top = 352
    Width = 75
    Height = 25
    Hint = ''
    Caption = #1042#1077#1088#1085#1091#1090#1100#1089#1103
    TabOrder = 3
    OnClick = btnExitClick
  end
  object undbnvgtrTb1: TUniDBNavigator
    Left = 8
    Top = 65
    Width = 815
    Height = 25
    Hint = ''
    DataSource = UniMainModule.ds1
    TabOrder = 1
    BeforeAction = undbnvgtrTb1BeforeAction
  end
end
