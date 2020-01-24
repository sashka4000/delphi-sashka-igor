object frmRegistration: TfrmRegistration
  Left = 0
  Top = 0
  ClientHeight = 506
  ClientWidth = 456
  Caption = #1056#1077#1075#1080#1089#1090#1088#1072#1094#1080#1103
  BorderStyle = bsNone
  OldCreateOrder = False
  BorderIcons = []
  MonitoredKeys.Keys = <>
  PixelsPerInch = 96
  TextHeight = 13
  object lbReg: TUniLabel
    Left = 136
    Top = 16
    Width = 153
    Height = 33
    Hint = ''
    Caption = #1056#1077#1075#1080#1089#1090#1088#1072#1094#1080#1103
    ParentFont = False
    Font.Charset = RUSSIAN_CHARSET
    Font.Height = -29
    Font.Name = 'Times New Roman'
    TabOrder = 0
  end
  object lbuser: TUniLabel
    Left = 35
    Top = 166
    Width = 43
    Height = 27
    Hint = ''
    Caption = #1048#1084#1103
    ParentFont = False
    Font.Charset = RUSSIAN_CHARSET
    Font.Height = -24
    Font.Name = 'Times New Roman'
    TabOrder = 1
  end
  object lblog: TUniLabel
    Left = 35
    Top = 229
    Width = 63
    Height = 27
    Hint = ''
    Caption = #1051#1086#1075#1080#1085
    ParentFont = False
    Font.Charset = RUSSIAN_CHARSET
    Font.Height = -24
    Font.Name = 'Times New Roman'
    TabOrder = 2
  end
  object lbPassword: TUniLabel
    Left = 35
    Top = 292
    Width = 75
    Height = 27
    Hint = ''
    Caption = #1055#1072#1088#1086#1083#1100
    ParentFont = False
    Font.Charset = RUSSIAN_CHARSET
    Font.Height = -24
    Font.Name = 'Times New Roman'
    TabOrder = 3
  end
  object lbRepPass: TUniLabel
    Left = 35
    Top = 355
    Width = 150
    Height = 27
    Hint = ''
    Caption = #1055#1086#1090#1074#1077#1088#1078#1076#1077#1085#1080#1077
    ParentFont = False
    Font.Charset = RUSSIAN_CHARSET
    Font.Height = -24
    Font.Name = 'Times New Roman'
    TabOrder = 4
  end
  object undtuser: TUniEdit
    Left = 232
    Top = 172
    Width = 170
    Height = 25
    Hint = ''
    Text = ''
    TabOrder = 5
  end
  object undtlog: TUniEdit
    Left = 232
    Top = 229
    Width = 170
    Height = 25
    Hint = ''
    Text = ''
    TabOrder = 6
  end
  object undtpass: TUniEdit
    Left = 232
    Top = 298
    Width = 170
    Height = 25
    Hint = ''
    Text = ''
    TabOrder = 7
  end
  object undtreppass: TUniEdit
    Left = 232
    Top = 355
    Width = 170
    Height = 25
    Hint = ''
    Text = ''
    TabOrder = 8
  end
  object btnOk: TUniButton
    Left = 313
    Top = 432
    Width = 89
    Height = 25
    Hint = ''
    Caption = #1042#1074#1086#1076
    ParentFont = False
    Font.Height = -13
    TabOrder = 9
    OnClick = btnOkClick
  end
end
