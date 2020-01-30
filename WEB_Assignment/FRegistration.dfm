object frmRegistration: TfrmRegistration
  Left = 0
  Top = 0
  ClientHeight = 492
  ClientWidth = 712
  Caption = #1056#1077#1075#1080#1089#1090#1088#1072#1094#1080#1103
  BorderStyle = bsNone
  OldCreateOrder = False
  BorderIcons = []
  MonitoredKeys.Keys = <>
  ActiveControl = undtUserName
  PixelsPerInch = 96
  TextHeight = 13
  object lbReg: TUniLabel
    Left = 253
    Top = 8
    Width = 177
    Height = 73
    Hint = ''
    Alignment = taCenter
    AutoSize = False
    Caption = #1055#1088#1086#1081#1076#1080#1090#1077' '#1088#1077#1075#1080#1089#1090#1088#1072#1094#1080#1102
    ParentFont = False
    Font.Charset = RUSSIAN_CHARSET
    Font.Height = -29
    Font.Name = 'Times New Roman'
    TabOrder = 0
  end
  object undtUserName: TUniEdit
    Left = 24
    Top = 93
    Width = 170
    Height = 25
    Hint = ''
    Text = ''
    ParentFont = False
    Font.Height = -13
    TabOrder = 1
    EmptyText = #1042#1072#1096#1077' '#1080#1084#1103
    ClearButton = True
    FieldLabelFont.Height = -13
  end
  object undtLog: TUniEdit
    Left = 24
    Top = 130
    Width = 170
    Height = 25
    Hint = ''
    Text = ''
    ParentFont = False
    Font.Height = -13
    TabOrder = 2
    EmptyText = #1051#1086#1075#1080#1085
    ClearButton = True
    FieldLabelFont.Height = -13
  end
  object undtPassword: TUniEdit
    Left = 224
    Top = 93
    Width = 170
    Height = 25
    Hint = ''
    Text = ''
    ParentFont = False
    Font.Height = -13
    TabOrder = 3
    EmptyText = #1055#1072#1088#1086#1083#1100
    ClearButton = True
    FieldLabelFont.Height = -13
  end
  object undtRepPass: TUniEdit
    Left = 224
    Top = 130
    Width = 170
    Height = 25
    Hint = ''
    Text = ''
    ParentFont = False
    Font.Height = -13
    TabOrder = 4
    EmptyText = #1055#1086#1090#1074#1077#1088#1076#1080#1090#1077' '#1087#1072#1088#1086#1083#1100
    ClearButton = True
    FieldLabelFont.Height = -13
  end
  object btnReg: TUniButton
    Left = 299
    Top = 171
    Width = 95
    Height = 25
    Hint = ''
    Caption = #1056#1077#1075#1080#1089#1090#1088#1072#1094#1080#1103
    ParentFont = False
    Font.Height = -13
    TabOrder = 5
    OnClick = btnRegClick
  end
  object btnReset: TUniButton
    Left = 24
    Top = 171
    Width = 75
    Height = 25
    Hint = ''
    Caption = #1054#1090#1084#1077#1085#1072
    TabOrder = 6
    OnClick = btnResetClick
  end
  object undbgrd1: TUniDBGrid
    Left = 16
    Top = 216
    Width = 688
    Height = 241
    Hint = ''
    DataSource = UniMainModule.ds1
    LoadMask.Message = 'Loading data...'
    TabOrder = 7
  end
  object btnChange: TUniButton
    Left = 164
    Top = 171
    Width = 95
    Height = 25
    Hint = ''
    Caption = #1057#1084#1077#1085#1080#1090#1100' '#1087#1072#1088#1086#1083#1100
    TabOrder = 8
    OnClick = btnChangeClick
  end
end
