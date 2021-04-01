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
  object lblAKB: TLabel
    Left = 18
    Top = 118
    Width = 20
    Height = 13
    Caption = #1040#1050#1041
  end
  object lblK1: TLabel
    Left = 18
    Top = 70
    Width = 12
    Height = 13
    Caption = 'K1'
  end
  object btnK1: TSpeedButton
    Left = 59
    Top = 64
    Width = 55
    Height = 25
    AllowAllUp = True
    GroupIndex = 1
    Down = True
    Caption = #1044'1'
    OnClick = btnK1Click
  end
  object lblVer: TLabel
    Left = 18
    Top = 168
    Width = 96
    Height = 13
    Caption = #1042#1077#1088#1089#1080#1103' '#1091#1089#1090#1088#1086#1081#1089#1090#1074#1072
  end
  object lblRate1: TLabel
    Left = 29
    Top = 234
    Width = 139
    Height = 13
    Caption = #1063#1072#1089' '#1087#1077#1088#1077#1093#1086#1076#1072' '#1085#1072' '#1090#1072#1088#1080#1092' 1 - '
  end
  object lblRate2: TLabel
    Left = 29
    Top = 253
    Width = 139
    Height = 13
    Caption = #1063#1072#1089' '#1087#1077#1088#1077#1093#1086#1076#1072' '#1085#1072' '#1090#1072#1088#1080#1092' 2 - '
  end
  object lblRateOne: TLabel
    Left = 174
    Top = 234
    Width = 6
    Height = 13
    Caption = '7'
    Enabled = False
  end
  object lblRateTwo: TLabel
    Left = 174
    Top = 252
    Width = 12
    Height = 13
    Caption = '23'
    Enabled = False
  end
  object lbl1: TLabel
    Left = 18
    Top = 211
    Width = 220
    Height = 13
    Caption = #1050#1086#1085#1092#1080#1075#1091#1088#1072#1094#1080#1086#1085#1085#1099#1077' '#1087#1072#1088#1072#1084#1077#1090#1088#1099' '#1091#1089#1090#1088#1086#1081#1089#1090#1074#1072
  end
  object lbl2: TLabel
    Left = 202
    Top = 168
    Width = 166
    Height = 13
    Caption = #1091#1089#1090#1088#1086#1081#1089#1090#1074#1086' '#1085#1077' '#1087#1077#1088#1077#1076#1072#1077#1090' '#1074#1077#1088#1089#1080#1102
    Enabled = False
  end
  object lblK2: TLabel
    Left = 168
    Top = 70
    Width = 12
    Height = 13
    Caption = 'K2'
  end
  object btnK2: TSpeedButton
    Left = 202
    Top = 64
    Width = 55
    Height = 25
    AllowAllUp = True
    GroupIndex = 2
    Down = True
    Caption = #1044'2'
    OnClick = btnK1Click
  end
  object cbbPow: TComboBox
    Left = 202
    Top = 115
    Width = 120
    Height = 21
    TabOrder = 3
    Text = #1053#1086#1088#1084#1072
    OnChange = btnK1Click
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
    TabOrder = 0
    OnSelectCell = SGSelectCell
  end
  object seNumber: TSpinEdit
    Left = 202
    Top = 13
    Width = 55
    Height = 22
    MaxValue = 31
    MinValue = 0
    TabOrder = 1
    Value = 0
  end
  object CBSG1: TComboBox
    Left = 570
    Top = 39
    Width = 128
    Height = 21
    Style = csDropDownList
    ItemIndex = 0
    TabOrder = 2
    Text = #1096#1083#1077#1081#1092' '#1085#1086#1088#1084#1072
    OnChange = CBSG1Change
    OnExit = CBSG1Exit
    Items.Strings = (
      #1096#1083#1077#1081#1092' '#1085#1086#1088#1084#1072
      #1096#1083#1077#1081#1092' '#1079#1072#1084#1082#1085#1091#1090
      #1096#1083#1077#1081#1092' '#1086#1073#1088#1099#1074)
  end
end
