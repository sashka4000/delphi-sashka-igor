inherited frmUPSL: TfrmUPSL
  Left = 576
  Top = 394
  Caption = 'frmUPSL'
  ClientHeight = 407
  ClientWidth = 504
  ExplicitWidth = 504
  ExplicitHeight = 407
  PixelsPerInch = 96
  TextHeight = 13
  object lbl17: TLabel
    Left = 18
    Top = 27
    Width = 44
    Height = 13
    Caption = #1059#1055#1057#1051' '#8470
  end
  object lbl21: TLabel
    Left = 18
    Top = 107
    Width = 70
    Height = 13
    Caption = #1042#1099#1079#1086#1074' '#1089' '#1059#1055#1057#1051
  end
  object lbl12: TLabel
    Left = 18
    Top = 69
    Width = 237
    Height = 13
    Caption = #1050#1072#1085#1072#1083' '#1055#1043#1057'  '#1050#1059#1053', '#1082' '#1082#1086#1090#1086#1088#1086#1084#1091' '#1087#1086#1076#1082#1083#1102#1095#1077#1085' '#1059#1055#1057#1051
  end
  object lbl1: TLabel
    Left = 371
    Top = 69
    Width = 89
    Height = 13
    Caption = '0 - '#1085#1077' '#1087#1086#1076#1082#1083#1102#1095#1077#1085
  end
  object seUPSL_KUN: TSpinEdit
    Left = 272
    Top = 69
    Width = 83
    Height = 22
    MaxValue = 8
    MinValue = 0
    TabOrder = 1
    Value = 0
  end
  object cbbUPSLVyzov: TComboBox
    Left = 272
    Top = 107
    Width = 83
    Height = 22
    Style = csOwnerDrawFixed
    ItemIndex = 0
    TabOrder = 2
    Text = #1053#1077#1090
    OnChange = cbbUPSLVyzovChange
    Items.Strings = (
      #1053#1077#1090
      #1054#1055#1069
      #1055#1088#1080#1103#1084#1086#1081
      #1050#1088#1099#1096#1072
      #1050#1072#1073#1080#1085#1072)
  end
  object seNumber: TSpinEdit
    Left = 272
    Top = 27
    Width = 83
    Height = 22
    MaxValue = 7
    MinValue = 0
    TabOrder = 0
    Value = 0
  end
  object chklstType: TCheckListBox
    Left = 18
    Top = 136
    Width = 70
    Height = 105
    AutoComplete = False
    ItemHeight = 13
    Items.Strings = (
      'DMA'
      'STORY'
      'DATA'
      'TIME'
      'ALERT'
      'VALID')
    TabOrder = 3
  end
end
