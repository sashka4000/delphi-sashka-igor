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
  object lblVer: TLabel
    Left = 272
    Top = 217
    Width = 96
    Height = 13
    Caption = #1042#1077#1088#1089#1080#1103' '#1091#1089#1090#1088#1086#1081#1089#1090#1074#1072
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
  object chkNet: TCheckBox
    Left = 18
    Top = 148
    Width = 165
    Height = 17
    Caption = #1053#1072#1083#1080#1095#1080#1077' '#1089#1077#1090#1077#1074#1086#1075#1086' '#1087#1080#1090#1072#1085#1080#1103
    TabOrder = 3
  end
  object chkBat: TCheckBox
    Left = 18
    Top = 170
    Width = 165
    Height = 17
    Caption = #1048#1089#1087#1088#1072#1074#1085#1086#1089#1090#1100' '#1072#1082#1082#1091#1084#1091#1083#1103#1090#1086#1088#1072
    TabOrder = 5
  end
  object lbledtBat: TLabeledEdit
    Left = 177
    Top = 214
    Width = 50
    Height = 21
    EditLabel.Width = 153
    EditLabel.Height = 13
    EditLabel.BiDiMode = bdLeftToRight
    EditLabel.Caption = #1053#1072#1087#1088#1103#1078#1077#1085#1080#1077' '#1085#1072' '#1072#1082#1082#1091#1084#1091#1083#1103#1090#1086#1088#1077
    EditLabel.ParentBiDiMode = False
    LabelPosition = lpLeft
    LabelSpacing = 5
    TabOrder = 8
    Text = '14'
  end
  object chkAmp1: TCheckBox
    Left = 272
    Top = 148
    Width = 165
    Height = 17
    Caption = #1045#1089#1090#1100' '#1086#1090#1074#1077#1090' '#1086#1090' '#1091#1089#1080#1083#1080#1090#1077#1083#1103' 1'
    TabOrder = 4
  end
  object chkAmp2: TCheckBox
    Left = 272
    Top = 170
    Width = 165
    Height = 17
    Caption = #1045#1089#1090#1100' '#1086#1090#1074#1077#1090' '#1086#1090' '#1091#1089#1080#1083#1080#1090#1077#1083#1103' 2'
    TabOrder = 6
  end
  object chkFire: TCheckBox
    Left = 18
    Top = 192
    Width = 360
    Height = 17
    Caption = #1054#1073#1098#1077#1076#1080#1085#1077#1085#1085#1099#1081' '#1087#1088#1080#1079#1085#1072#1082' "'#1087#1086#1078#1072#1088'" '#1086#1090' '#1091#1089#1090#1088#1086#1081#1089#1090#1074#1072' '#1080' '#1091#1089#1080#1083#1080#1090#1077#1083#1077#1081' 1 '#1080' 2'
    TabOrder = 7
  end
  object medtVer: TMaskEdit
    Left = 374
    Top = 215
    Width = 36
    Height = 21
    Alignment = taCenter
    EditMask = '!99\.99;1; '
    MaxLength = 5
    TabOrder = 9
    Text = '01.12'
  end
end
