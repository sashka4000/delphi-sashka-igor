object LoginForm: TLoginForm
  Left = 0
  Top = 0
  ClientHeight = 214
  ClientWidth = 270
  Caption = ''
  BorderStyle = bsNone
  Position = poDesktopCenter
  OldCreateOrder = False
  BorderIcons = [biSystemMenu]
  MonitoredKeys.Keys = <>
  PixelsPerInch = 96
  TextHeight = 13
  object lb_Welcome: TUniLabel
    Left = 20
    Top = 8
    Width = 228
    Height = 41
    Hint = ''
    Alignment = taCenter
    AutoSize = False
    Caption = #1055#1086#1078#1072#1083#1091#1081#1089#1090#1072' '#1072#1074#1090#1086#1088#1080#1079#1091#1081#1090#1077#1089#1100' '#1080#1083#1080' '#1079#1072#1088#1077#1075#1080#1089#1090#1088#1080#1088#1091#1081#1090#1077#1089#1100
    ParentFont = False
    Font.Height = -16
    TabOrder = 0
  end
  object lb_Login: TUniLabel
    Left = 8
    Top = 72
    Width = 40
    Height = 18
    Hint = ''
    Caption = #1051#1086#1075#1080#1085
    ParentFont = False
    Font.Height = -15
    TabOrder = 1
  end
  object lb_Password: TUniLabel
    Left = 8
    Top = 120
    Width = 50
    Height = 18
    Hint = ''
    Caption = #1055#1072#1088#1086#1083#1100
    ParentFont = False
    Font.Height = -15
    TabOrder = 2
  end
  object undtLogin: TUniEdit
    Left = 68
    Top = 72
    Width = 180
    Hint = ''
    Text = ''
    TabOrder = 3
  end
  object undtPassword: TUniEdit
    Left = 68
    Top = 117
    Width = 180
    Hint = ''
    PasswordChar = '*'
    Text = ''
    TabOrder = 4
  end
  object btnCancel: TUniButton
    Left = 8
    Top = 160
    Width = 75
    Height = 25
    Hint = ''
    Caption = #1054#1090#1084#1077#1085#1072
    ModalResult = 2
    ParentFont = False
    Font.Height = -13
    TabOrder = 5
    OnClick = btnCancelClick
  end
  object btnOk: TUniButton
    Left = 89
    Top = 160
    Width = 64
    Height = 25
    Hint = ''
    Caption = #1042#1074#1086#1076
    ParentFont = False
    Font.Height = -13
    TabOrder = 6
    OnClick = btnOkClick
  end
  object btnReg: TUniButton
    Left = 159
    Top = 160
    Width = 89
    Height = 25
    Hint = ''
    Caption = #1056#1077#1075#1080#1089#1090#1088#1072#1094#1080#1103
    ParentFont = False
    Font.Height = -13
    TabOrder = 7
  end
end
