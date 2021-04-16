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
    Left = 18
    Top = 69
    Width = 87
    Height = 13
    Caption = #1042#1099#1079#1086#1074' '#1089' '#1050#1041#1055'-RSM'
  end
  object btnON1: TSpeedButton
    Left = 18
    Top = 227
    Width = 55
    Height = 25
    AllowAllUp = True
    GroupIndex = 1
    Caption = #1059#1055#1056'1'
  end
  object btnON2: TSpeedButton
    Left = 79
    Top = 227
    Width = 55
    Height = 25
    AllowAllUp = True
    GroupIndex = 2
    Caption = #1059#1055#1056'2'
  end
  object btnON3: TSpeedButton
    Left = 140
    Top = 227
    Width = 55
    Height = 25
    AllowAllUp = True
    GroupIndex = 3
    Caption = #1059#1055#1056'3'
  end
  object btnON4: TSpeedButton
    Left = 200
    Top = 227
    Width = 55
    Height = 25
    AllowAllUp = True
    GroupIndex = 4
    Caption = #1059#1055#1056'4'
  end
  object lblControl: TLabel
    Left = 18
    Top = 195
    Width = 94
    Height = 13
    Caption = #1050#1072#1085#1072#1083' '#1091#1087#1088#1072#1074#1083#1077#1085#1080#1103
  end
  object lblInDiscrete: TLabel
    Left = 18
    Top = 109
    Width = 91
    Height = 13
    Caption = #1044#1080#1089#1082#1088#1077#1090#1085#1099#1081' '#1074#1093#1086#1076
  end
  object btnDS2: TSpeedButton
    Left = 79
    Top = 143
    Width = 55
    Height = 25
    AllowAllUp = True
    GroupIndex = 6
    Caption = #1044#1042'2'
  end
  object btnDS4: TSpeedButton
    Left = 201
    Top = 143
    Width = 55
    Height = 25
    AllowAllUp = True
    GroupIndex = 8
    Caption = #1044#1042'4'
  end
  object btnDS3: TSpeedButton
    Left = 140
    Top = 143
    Width = 55
    Height = 25
    AllowAllUp = True
    GroupIndex = 7
    Caption = #1044#1042'3'
  end
  object btnDS1: TSpeedButton
    Left = 18
    Top = 143
    Width = 55
    Height = 25
    AllowAllUp = True
    GroupIndex = 5
    Caption = #1044#1042'1'
  end
  object btnDS5: TSpeedButton
    Left = 262
    Top = 143
    Width = 55
    Height = 25
    AllowAllUp = True
    GroupIndex = 9
    Caption = #1044#1042'5'
  end
  object btnDS6: TSpeedButton
    Left = 323
    Top = 143
    Width = 55
    Height = 25
    AllowAllUp = True
    GroupIndex = 10
    Caption = #1044#1042'6'
  end
  object btnCTRL_220: TSpeedButton
    Left = 384
    Top = 143
    Width = 55
    Height = 25
    AllowAllUp = True
    GroupIndex = 11
    Caption = '220 '#1042
  end
  object cbbKBPRSMVyzov: TComboBox
    Left = 200
    Top = 69
    Width = 100
    Height = 22
    Style = csOwnerDrawFixed
    ItemIndex = 0
    TabOrder = 0
    Text = #1053#1077#1090
    Items.Strings = (
      #1053#1077#1090
      '1-'#1081' '#1082#1072#1085#1072#1083' '#1055#1043#1057
      '2-'#1081' '#1082#1072#1085#1072#1083' '#1055#1043#1057
      '3-'#1081' '#1082#1072#1085#1072#1083' '#1055#1043#1057)
  end
  object seNumber: TSpinEdit
    Left = 200
    Top = 30
    Width = 99
    Height = 22
    MaxValue = 7
    MinValue = 0
    TabOrder = 1
    Value = 0
  end
end
