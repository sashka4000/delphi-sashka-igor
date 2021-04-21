object frmKBPRSM: TfrmKBPRSM
  Left = 0
  Top = 0
  Caption = 'frmKBPRSM'
  ClientHeight = 372
  ClientWidth = 581
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object lblName: TLabel
    Left = 18
    Top = 30
    Width = 61
    Height = 13
    Caption = #1050#1041#1055'-RSM '#8470
  end
  object lblkbprsm: TLabel
    Left = 19
    Top = 119
    Width = 87
    Height = 13
    Caption = #1042#1099#1079#1086#1074' '#1089' '#1050#1041#1055'-RSM'
  end
  object btnON1: TSpeedButton
    Left = 18
    Top = 273
    Width = 55
    Height = 25
    AllowAllUp = True
    GroupIndex = 1
    Caption = #1059#1055#1056'1'
  end
  object btnON2: TSpeedButton
    Left = 79
    Top = 273
    Width = 55
    Height = 25
    AllowAllUp = True
    GroupIndex = 2
    Caption = #1059#1055#1056'2'
  end
  object btnON3: TSpeedButton
    Left = 140
    Top = 273
    Width = 55
    Height = 25
    AllowAllUp = True
    GroupIndex = 3
    Caption = #1059#1055#1056'3'
  end
  object btnON4: TSpeedButton
    Left = 200
    Top = 273
    Width = 55
    Height = 25
    AllowAllUp = True
    GroupIndex = 4
    Caption = #1059#1055#1056'4'
  end
  object lblControl: TLabel
    Left = 18
    Top = 241
    Width = 94
    Height = 13
    Caption = #1050#1072#1085#1072#1083' '#1091#1087#1088#1072#1074#1083#1077#1085#1080#1103
  end
  object lblInDiscrete: TLabel
    Left = 18
    Top = 155
    Width = 91
    Height = 13
    Caption = #1044#1080#1089#1082#1088#1077#1090#1085#1099#1081' '#1074#1093#1086#1076
  end
  object btnDS2: TSpeedButton
    Left = 79
    Top = 189
    Width = 55
    Height = 25
    AllowAllUp = True
    GroupIndex = 6
    Caption = #1044#1042'2'
  end
  object btnDS4: TSpeedButton
    Left = 201
    Top = 189
    Width = 55
    Height = 25
    AllowAllUp = True
    GroupIndex = 8
    Caption = #1044#1042'4'
  end
  object btnDS3: TSpeedButton
    Left = 140
    Top = 189
    Width = 55
    Height = 25
    AllowAllUp = True
    GroupIndex = 7
    Caption = #1044#1042'3'
  end
  object btnDS1: TSpeedButton
    Left = 18
    Top = 189
    Width = 55
    Height = 25
    AllowAllUp = True
    GroupIndex = 5
    Caption = #1044#1042'1'
  end
  object btnDS5: TSpeedButton
    Left = 262
    Top = 189
    Width = 55
    Height = 25
    AllowAllUp = True
    GroupIndex = 9
    Caption = #1044#1042'5'
  end
  object btnDS6: TSpeedButton
    Left = 323
    Top = 189
    Width = 55
    Height = 25
    AllowAllUp = True
    GroupIndex = 10
    Caption = #1044#1042'6'
  end
  object lbl12: TLabel
    Left = 20
    Top = 72
    Width = 229
    Height = 13
    Caption = #1050#1072#1085#1072#1083' '#1055#1043#1057'  '#1050#1059#1053', '#1082' '#1082#1086#1090#1086#1088#1086#1084#1091' '#1087#1086#1076#1082#1083#1102#1095#1077#1085' '#1050#1041#1055
  end
  object lbl1: TLabel
    Left = 360
    Top = 74
    Width = 89
    Height = 13
    Caption = '0 - '#1085#1077' '#1087#1086#1076#1082#1083#1102#1095#1077#1085
  end
  object cbbKBPRSMVyzov: TComboBox
    Left = 272
    Top = 116
    Width = 100
    Height = 22
    Style = csOwnerDrawFixed
    ItemIndex = 0
    TabOrder = 2
    Text = #1053#1077#1090
    OnChange = cbbKBPRSMVyzovChange
    Items.Strings = (
      #1053#1077#1090
      '1-'#1081' '#1082#1072#1085#1072#1083' '#1055#1043#1057
      '2-'#1081' '#1082#1072#1085#1072#1083' '#1055#1043#1057
      '3-'#1081' '#1082#1072#1085#1072#1083' '#1055#1043#1057)
  end
  object seNumber: TSpinEdit
    Left = 273
    Top = 27
    Width = 99
    Height = 22
    MaxValue = 7
    MinValue = 0
    TabOrder = 0
    Value = 0
  end
  object seKBP_KUN: TSpinEdit
    Left = 273
    Top = 69
    Width = 80
    Height = 22
    MaxValue = 8
    MinValue = 0
    TabOrder = 1
    Value = 0
  end
  object chkPower220: TCheckBox
    Left = 18
    Top = 324
    Width = 195
    Height = 17
    Caption = #1053#1072#1083#1080#1095#1080#1077' '#1089#1077#1090#1077#1074#1086#1075#1086' '#1087#1080#1090#1072#1085#1080#1103' 220'#1042
    Checked = True
    State = cbChecked
    TabOrder = 3
  end
end
