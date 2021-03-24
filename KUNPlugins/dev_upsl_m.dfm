inherited frmUPSLM: TfrmUPSLM
  Caption = 'frmUPSLM'
  ClientHeight = 407
  ClientWidth = 737
  ExplicitWidth = 737
  ExplicitHeight = 407
  PixelsPerInch = 96
  TextHeight = 13
  object lblVer: TLabel
    Left = 11
    Top = 362
    Width = 96
    Height = 13
    Caption = #1042#1077#1088#1089#1080#1103' '#1091#1089#1090#1088#1086#1081#1089#1090#1074#1072
  end
  object lbl1: TLabel
    Left = 358
    Top = 66
    Width = 89
    Height = 13
    Caption = '0 - '#1085#1077' '#1087#1086#1076#1082#1083#1102#1095#1077#1085
  end
  object lbl12: TLabel
    Left = 8
    Top = 64
    Width = 237
    Height = 13
    Caption = #1050#1072#1085#1072#1083' '#1055#1043#1057'  '#1050#1059#1053', '#1082' '#1082#1086#1090#1086#1088#1086#1084#1091' '#1087#1086#1076#1082#1083#1102#1095#1077#1085' '#1059#1055#1057#1051
  end
  object lbl21: TLabel
    Left = 8
    Top = 91
    Width = 82
    Height = 13
    Caption = #1042#1099#1079#1086#1074' '#1089' '#1059#1055#1057#1051'-'#1052
  end
  object lbl17: TLabel
    Left = 18
    Top = 27
    Width = 56
    Height = 13
    Caption = #1059#1055#1057#1051'-'#1052' '#8470
  end
  object lblControl: TLabel
    Left = 8
    Top = 217
    Width = 202
    Height = 13
    Caption = #1056#1077#1079#1091#1083#1100#1090#1072#1090#1099' '#1072#1074#1090#1086#1084#1072#1090#1080#1095#1077#1089#1082#1086#1081' '#1087#1088#1086#1074#1077#1088#1082#1080':'
  end
  object lbl2: TLabel
    Left = 501
    Top = 122
    Width = 158
    Height = 13
    Caption = #1050#1086#1085#1092#1080#1075#1091#1088#1072#1094#1080#1103' '#1055#1047#1059' '#1091#1089#1090#1088#1086#1081#1089#1090#1074#1072
  end
  object lbl3: TLabel
    Left = 497
    Top = 164
    Width = 126
    Height = 13
    Caption = #1058#1072#1081#1084#1077#1088' '#1087#1077#1088#1074#1086#1081' '#1087#1088#1086#1074#1077#1088#1082#1080
    Enabled = False
  end
  object chkAmp1: TCheckBox
    Left = 271
    Top = 126
    Width = 165
    Height = 17
    Caption = #1045#1089#1090#1100' '#1086#1090#1074#1077#1090' '#1086#1090' '#1091#1089#1080#1083#1080#1090#1077#1083#1103' 1'
    TabOrder = 3
  end
  object medtVer: TMaskEdit
    Left = 169
    Top = 360
    Width = 45
    Height = 21
    Alignment = taCenter
    EditMask = '!99\.99;1; '
    MaxLength = 5
    TabOrder = 23
    Text = '03.04'
  end
  object chkFire: TCheckBox
    Left = 8
    Top = 193
    Width = 360
    Height = 17
    Caption = #1054#1073#1098#1077#1076#1080#1085#1077#1085#1085#1099#1081' '#1087#1088#1080#1079#1085#1072#1082' "'#1087#1086#1078#1072#1088'" '#1086#1090' '#1091#1089#1090#1088#1086#1081#1089#1090#1074#1072' '#1080' '#1091#1089#1080#1083#1080#1090#1077#1083#1077#1081' 1 '#1080' 2'
    TabOrder = 11
  end
  object chkAmp2: TCheckBox
    Left = 271
    Top = 148
    Width = 165
    Height = 17
    Caption = #1045#1089#1090#1100' '#1086#1090#1074#1077#1090' '#1086#1090' '#1091#1089#1080#1083#1080#1090#1077#1083#1103' 2'
    TabOrder = 7
  end
  object lbledtBat: TLabeledEdit
    Left = 168
    Top = 166
    Width = 46
    Height = 21
    EditLabel.Width = 153
    EditLabel.Height = 13
    EditLabel.BiDiMode = bdLeftToRight
    EditLabel.Caption = #1053#1072#1087#1088#1103#1078#1077#1085#1080#1077' '#1085#1072' '#1072#1082#1082#1091#1084#1091#1083#1103#1090#1086#1088#1077
    EditLabel.ParentBiDiMode = False
    LabelPosition = lpLeft
    LabelSpacing = 5
    TabOrder = 8
    Text = '4'
  end
  object chkBat: TCheckBox
    Left = 8
    Top = 148
    Width = 165
    Height = 17
    Caption = #1048#1089#1087#1088#1072#1074#1085#1086#1089#1090#1100' '#1072#1082#1082#1091#1084#1091#1083#1103#1090#1086#1088#1072
    TabOrder = 6
  end
  object chkNet: TCheckBox
    Left = 8
    Top = 129
    Width = 165
    Height = 17
    Caption = #1053#1072#1083#1080#1095#1080#1077' '#1089#1077#1090#1077#1074#1086#1075#1086' '#1087#1080#1090#1072#1085#1080#1103
    TabOrder = 4
  end
  object seNumber: TSpinEdit
    Left = 272
    Top = 27
    Width = 80
    Height = 22
    MaxValue = 7
    MinValue = 0
    TabOrder = 0
    Value = 0
  end
  object cbbUPSLVyzov: TComboBox
    Left = 271
    Top = 92
    Width = 80
    Height = 22
    Style = csOwnerDrawFixed
    ItemIndex = 0
    TabOrder = 2
    Text = #1053#1077#1090
    Items.Strings = (
      #1053#1077#1090
      #1054#1055#1069
      #1055#1088#1080#1103#1084#1086#1081
      #1050#1088#1099#1096#1072
      #1050#1072#1073#1080#1085#1072
      #1052#1072#1096'. '#1087#1086#1084#1077#1097#1077#1085#1080#1077)
  end
  object seUPSL_KUN: TSpinEdit
    Left = 271
    Top = 61
    Width = 80
    Height = 22
    MaxValue = 8
    MinValue = 0
    TabOrder = 1
    Value = 0
  end
  object chkInd: TCheckBox
    Left = 272
    Top = 171
    Width = 156
    Height = 17
    Caption = #1045#1089#1090#1100' '#1089#1074#1103#1079#1100' '#1089' '#1080#1085#1076#1080#1082#1072#1090#1086#1088#1086#1084
    TabOrder = 10
  end
  object chkA1_M1: TCheckBox
    Left = 64
    Top = 256
    Width = 157
    Height = 17
    Caption = #1052#1080#1082#1088#1086#1092#1086#1085' '#1052'1 '#1091#1089#1080#1083#1080#1090#1077#1083#1103' 1'
    TabOrder = 15
  end
  object chkA1_G1: TCheckBox
    Left = 64
    Top = 279
    Width = 172
    Height = 17
    Caption = #1052#1080#1082#1088#1086#1092#1086#1085' '#1043'1-'#1052'1 '#1091#1089#1080#1083#1080#1090#1077#1083#1103' 1'
    TabOrder = 17
  end
  object chkA1_G2: TCheckBox
    Left = 64
    Top = 324
    Width = 126
    Height = 17
    Caption = ' '#1043'2-'#1052'2 '#1091#1089#1080#1083#1080#1090#1077#1083#1103' 1'
    TabOrder = 21
  end
  object chkA1_M2: TCheckBox
    Left = 64
    Top = 301
    Width = 156
    Height = 17
    Caption = #1052#1080#1082#1088#1086#1092#1086#1085' '#1052'2 '#1091#1089#1080#1083#1080#1090#1077#1083#1103' 1'
    TabOrder = 19
  end
  object chkTST_OK: TCheckBox
    Left = 271
    Top = 216
    Width = 136
    Height = 17
    Caption = #1055#1088#1086#1074#1077#1088#1082#1072' '#1074#1099#1087#1086#1083#1085#1077#1085#1072
    TabOrder = 12
  end
  object chkA2_K2: TCheckBox
    Left = 302
    Top = 235
    Width = 126
    Height = 17
    Caption = #1042#1093#1086#1076' '#1050'2 '#1091#1089#1080#1083#1080#1090#1077#1083#1103' 2'
    TabOrder = 14
  end
  object chkA1_K2: TCheckBox
    Left = 64
    Top = 235
    Width = 136
    Height = 17
    Caption = #1042#1093#1086#1076' '#1050'2 '#1091#1089#1080#1083#1080#1090#1077#1083#1103' 1'
    TabOrder = 13
  end
  object chkA2_M1: TCheckBox
    Left = 302
    Top = 258
    Width = 157
    Height = 17
    Caption = #1052#1080#1082#1088#1086#1092#1086#1085' '#1052'1 '#1091#1089#1080#1083#1080#1090#1077#1083#1103' 2'
    TabOrder = 16
  end
  object chkA2_G1: TCheckBox
    Left = 302
    Top = 281
    Width = 126
    Height = 17
    Caption = #1043'1-'#1052'1 '#1091#1089#1080#1083#1080#1090#1077#1083#1103' 2'
    TabOrder = 18
  end
  object chkA2_G2: TCheckBox
    Left = 302
    Top = 324
    Width = 116
    Height = 17
    Caption = #1043'2-'#1052'2 '#1091#1089#1080#1083#1080#1090#1077#1083#1103' 2'
    TabOrder = 22
  end
  object chkA2_M2: TCheckBox
    Left = 302
    Top = 301
    Width = 157
    Height = 17
    Caption = #1052#1080#1082#1088#1086#1092#1086#1085' '#1052'2 '#1091#1089#1080#1083#1080#1090#1077#1083#1103' 2'
    TabOrder = 20
  end
  object chkROMAutoPGS: TCheckBox
    Left = 495
    Top = 141
    Width = 183
    Height = 17
    Caption = #1040#1074#1090#1086#1084#1072#1090#1080#1095#1077#1089#1082#1072#1103' '#1087#1088#1086#1074#1077#1088#1082#1072' '#1055#1043#1057
    Checked = True
    Enabled = False
    State = cbChecked
    TabOrder = 5
  end
  object edtROMTimer: TEdit
    Left = 633
    Top = 166
    Width = 68
    Height = 21
    Enabled = False
    TabOrder = 9
    Text = '12'
  end
end
