inherited frmKIR16RS: TfrmKIR16RS
  Caption = 'frmKIR16RS'
  ClientHeight = 387
  ExplicitHeight = 387
  PixelsPerInch = 96
  TextHeight = 13
  object lblVer: TLabel
    Left = 300
    Top = 208
    Width = 96
    Height = 13
    Caption = #1042#1077#1088#1089#1080#1103' '#1091#1089#1090#1088#1086#1081#1089#1090#1074#1072
  end
  object lbl17: TLabel
    Left = 18
    Top = 8
    Width = 65
    Height = 13
    Caption = #1050#1048#1056'-16RS '#8470
  end
  object btnSensor: TSpeedButton
    Left = 394
    Top = 67
    Width = 40
    Height = 25
    Caption = #1044#1042
  end
  object lblSensor: TLabel
    Left = 300
    Top = 40
    Width = 134
    Height = 13
    Caption = #1044#1072#1090#1095#1080#1082' '#1074#1089#1082#1088#1099#1090#1080#1103' '#1082#1086#1088#1087#1091#1089#1072
  end
  object lblAKB: TLabel
    Left = 414
    Top = 119
    Width = 20
    Height = 13
    Caption = #1040#1050#1041
  end
  object medtVer: TMaskEdit
    Left = 402
    Top = 205
    Width = 36
    Height = 21
    Alignment = taCenter
    EditMask = '!99\.99;1; '
    MaxLength = 5
    TabOrder = 0
    Text = '01.12'
  end
  object seNumber: TSpinEdit
    Left = 351
    Top = 8
    Width = 83
    Height = 22
    MaxValue = 31
    MinValue = 0
    TabOrder = 1
    Value = 0
  end
  object strngrdLoop: TStringGrid
    Left = 18
    Top = 40
    Width = 251
    Height = 292
    ColCount = 4
    DefaultColWidth = 60
    DefaultRowHeight = 16
    RowCount = 17
    TabOrder = 2
  end
  object cbbPow: TComboBox
    Left = 318
    Top = 146
    Width = 120
    Height = 21
    TabOrder = 3
    Text = #1053#1086#1088#1084#1072
    Items.Strings = (
      #1053#1086#1088#1084#1072
      #1054#1090#1089#1091#1090#1089#1090#1074#1091#1077#1090
      #1047#1072#1084#1082#1085#1091#1090
      #1047#1072#1088#1103#1078#1072#1077#1090#1089#1103
      #1063#1077#1075#1086'-'#1090#1086)
  end
end
