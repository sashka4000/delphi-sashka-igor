object frmKBPRSM: TfrmKBPRSM
  Left = 0
  Top = 0
  Caption = 'frmKBPRSM'
  ClientHeight = 372
  ClientWidth = 724
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
    Top = 27
    Width = 61
    Height = 13
    Caption = #1050#1041#1055'-RSM '#8470
  end
  object lblkbprsm: TLabel
    Left = 18
    Top = 91
    Width = 87
    Height = 13
    Caption = #1042#1099#1079#1086#1074' '#1089' '#1050#1041#1055'-RSM'
  end
  object lbl12: TLabel
    Left = 18
    Top = 64
    Width = 237
    Height = 13
    Caption = #1050#1072#1085#1072#1083' '#1055#1043#1057'  '#1050#1059#1053', '#1082' '#1082#1086#1090#1086#1088#1086#1084#1091' '#1087#1086#1076#1082#1083#1102#1095#1077#1085' '#1059#1055#1057#1051
  end
  object lbl1: TLabel
    Left = 358
    Top = 66
    Width = 89
    Height = 13
    Caption = '0 - '#1085#1077' '#1087#1086#1076#1082#1083#1102#1095#1077#1085
  end
  object seUPSL_KUN: TSpinEdit
    Left = 271
    Top = 61
    Width = 80
    Height = 22
    MaxValue = 8
    MinValue = 0
    TabOrder = 0
    Value = 0
  end
  object cbbKBPRSMVyzov: TComboBox
    Left = 271
    Top = 92
    Width = 80
    Height = 22
    Style = csOwnerDrawFixed
    ItemIndex = 0
    TabOrder = 1
    Text = #1053#1077#1090
    Items.Strings = (
      #1053#1077#1090
      #1054#1055#1069
      #1055#1088#1080#1103#1084#1086#1081
      #1050#1088#1099#1096#1072
      #1050#1072#1073#1080#1085#1072
      #1052#1072#1096'. '#1087#1086#1084#1077#1097#1077#1085#1080#1077)
  end
  object seNumber: TSpinEdit
    Left = 272
    Top = 27
    Width = 80
    Height = 22
    MaxValue = 7
    MinValue = 0
    TabOrder = 2
    Value = 0
  end
  object chkNet: TCheckBox
    Left = 18
    Top = 126
    Width = 165
    Height = 17
    Caption = #1053#1072#1083#1080#1095#1080#1077' '#1089#1077#1090#1077#1074#1086#1075#1086' '#1087#1080#1090#1072#1085#1080#1103
    Checked = True
    State = cbChecked
    TabOrder = 3
  end
  object chkAmp1: TCheckBox
    Left = 271
    Top = 126
    Width = 165
    Height = 17
    Caption = #1045#1089#1090#1100' '#1086#1090#1074#1077#1090' '#1086#1090' '#1091#1089#1080#1083#1080#1090#1077#1083#1103' 1'
    Checked = True
    State = cbChecked
    TabOrder = 4
  end
end
