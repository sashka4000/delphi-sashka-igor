inherited frmKIR16RS: TfrmKIR16RS
  Caption = 'frmKIR16RS'
  ClientHeight = 441
  OnCreate = FormCreate
  ExplicitHeight = 441
  PixelsPerInch = 96
  TextHeight = 13
  object lblVer: TLabel
    Left = 300
    Top = 232
    Width = 96
    Height = 13
    Caption = #1042#1077#1088#1089#1080#1103' '#1091#1089#1090#1088#1086#1081#1089#1090#1074#1072
  end
  object lbl17: TLabel
    Left = 300
    Top = 16
    Width = 65
    Height = 13
    Caption = #1050#1048#1056'-16RS '#8470
  end
  object btnSensor: TSpeedButton
    Left = 394
    Top = 91
    Width = 40
    Height = 25
    AllowAllUp = True
    GroupIndex = 1
    Down = True
    Caption = #1044#1042
  end
  object lblSensor: TLabel
    Left = 300
    Top = 64
    Width = 134
    Height = 13
    Caption = #1044#1072#1090#1095#1080#1082' '#1074#1089#1082#1088#1099#1090#1080#1103' '#1082#1086#1088#1087#1091#1089#1072
  end
  object lblAKB: TLabel
    Left = 414
    Top = 143
    Width = 20
    Height = 13
    Caption = #1040#1050#1041
  end
  object medtVer: TMaskEdit
    Left = 402
    Top = 229
    Width = 36
    Height = 21
    Alignment = taCenter
    EditMask = '!99\.99;1; '
    MaxLength = 5
    TabOrder = 0
    Text = '01.12'
  end
  object seNumber: TSpinEdit
    Left = 383
    Top = 13
    Width = 55
    Height = 22
    MaxValue = 31
    MinValue = 0
    TabOrder = 1
    Value = 0
  end
  object SG: TStringGrid
    Left = 18
    Top = 8
    Width = 263
    Height = 377
    ColCount = 3
    DefaultColWidth = 105
    DefaultRowHeight = 22
    RowCount = 17
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing]
    ScrollBars = ssNone
    TabOrder = 2
    OnSelectCell = SGSelectCell
  end
  object cbbPow: TComboBox
    Left = 318
    Top = 170
    Width = 120
    Height = 21
    TabOrder = 3
    Text = #1053#1086#1088#1084#1072
    Items.Strings = (
      #1053#1086#1088#1084#1072
      #1054#1090#1089#1091#1090#1089#1090#1074#1091#1077#1090
      #1047#1072#1084#1082#1085#1091#1090
      #1047#1072#1088#1103#1078#1072#1077#1090#1089#1103
      #1040#1050#1041)
  end
  object CBSG1: TComboBox
    Left = 160
    Top = 24
    Width = 113
    Height = 21
    TabOrder = 4
    Text = #1096#1083#1077#1081#1092' '#1085#1086#1088#1084#1072
    OnCloseUp = CBSG1CloseUp
    OnExit = CBSG1Exit
    Items.Strings = (
      #1096#1083#1077#1081#1092' '#1085#1086#1088#1084#1072
      #1096#1083#1077#1081#1092' '#1079#1072#1084#1082#1085#1091#1090
      #1096#1083#1077#1081#1092' '#1086#1073#1088#1099#1074)
  end
end
