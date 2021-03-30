inherited frmKIR8RS: TfrmKIR8RS
  Caption = 'frmKIR8RS'
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object lblName: TLabel
    Left = 18
    Top = 8
    Width = 59
    Height = 13
    Caption = #1050#1048#1056'-8RS '#8470
  end
  object lblParam: TLabel
    Left = 18
    Top = 211
    Width = 220
    Height = 13
    Caption = #1050#1086#1085#1092#1080#1075#1091#1088#1072#1094#1080#1086#1085#1085#1099#1077' '#1087#1072#1088#1072#1084#1077#1090#1088#1099' '#1091#1089#1090#1088#1086#1081#1089#1090#1074#1072
  end
  object lblTypeProtocol: TLabel
    Left = 18
    Top = 239
    Width = 115
    Height = 13
    Caption = #1058#1080#1087' '#1087#1088#1086#1090#1086#1082#1086#1083#1072': 40 '#1073#1080#1090
    Enabled = False
  end
  object lblAKB: TLabel
    Left = 18
    Top = 118
    Width = 20
    Height = 13
    Caption = #1040#1050#1041
  end
  object lblSensor: TLabel
    Left = 18
    Top = 64
    Width = 134
    Height = 13
    Caption = #1044#1072#1090#1095#1080#1082' '#1074#1089#1082#1088#1099#1090#1080#1103' '#1082#1086#1088#1087#1091#1089#1072
  end
  object btnSensor: TSpeedButton
    Left = 202
    Top = 64
    Width = 55
    Height = 25
    AllowAllUp = True
    GroupIndex = 1
    Down = True
    Caption = #1044#1042
    OnClick = btnSensorClick
  end
  object lblVer: TLabel
    Left = 18
    Top = 169
    Width = 96
    Height = 13
    Caption = #1042#1077#1088#1089#1080#1103' '#1091#1089#1090#1088#1086#1081#1089#1090#1074#1072
  end
  object cbbVersion: TComboBox
    Left = 202
    Top = 169
    Width = 76
    Height = 21
    Style = csDropDownList
    ItemIndex = 0
    TabOrder = 0
    Text = '2.20'
    Items.Strings = (
      '2.20')
  end
  object cbbPow: TComboBox
    Left = 202
    Top = 115
    Width = 120
    Height = 21
    TabOrder = 1
    Text = #1053#1086#1088#1084#1072
    OnChange = cbbPowChange
    Items.Strings = (
      #1053#1086#1088#1084#1072
      #1054#1090#1089#1091#1090#1089#1090#1074#1091#1077#1090' '#1040#1050#1041
      #1047#1072#1084#1082#1085#1091#1090' '#1040#1050#1041
      #1047#1072#1088#1103#1078#1072#1077#1090#1089#1103' '#1040#1050#1041
      #1054#1090#1089#1091#1090#1089#1090#1074#1091#1077#1090' '#1042#1055)
  end
  object SG: TStringGrid
    Left = 379
    Top = 8
    Width = 302
    Height = 206
    ColCount = 4
    DefaultColWidth = 105
    DefaultRowHeight = 22
    RowCount = 9
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing]
    ScrollBars = ssNone
    TabOrder = 3
    OnSelectCell = SGSelectCell
  end
  object seNumber: TSpinEdit
    Left = 202
    Top = 13
    Width = 55
    Height = 22
    MaxValue = 31
    MinValue = 0
    TabOrder = 4
    Value = 0
  end
  object CBSG1: TComboBox
    Left = 570
    Top = 39
    Width = 128
    Height = 21
    TabOrder = 2
    Text = #1096#1083#1077#1081#1092' '#1085#1086#1088#1084#1072
    OnCloseUp = CBSG1CloseUp
    OnExit = CBSG1Exit
    Items.Strings = (
      #1096#1083#1077#1081#1092' '#1085#1086#1088#1084#1072
      #1096#1083#1077#1081#1092' '#1079#1072#1084#1082#1085#1091#1090
      #1096#1083#1077#1081#1092' '#1086#1073#1088#1099#1074)
  end
end
