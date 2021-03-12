inherited frmMBus: TfrmMBus
  Caption = 'frmMBus'
  PixelsPerInch = 96
  TextHeight = 13
  object lbl1: TLabel
    Left = 227
    Top = 8
    Width = 213
    Height = 13
    Caption = #1050#1074#1072#1088#1090#1080#1088#1085#1099#1081' '#1089#1095#1077#1090#1095#1080#1082' '#1089' '#1080#1085#1090#1077#1088#1092#1077#1081#1089#1086#1084' MBus'
  end
  object lbl2: TLabel
    Left = 27
    Top = 52
    Width = 157
    Height = 13
    Caption = #1057#1077#1088#1080#1081#1085#1099#1081' '#1085#1086#1084#1077#1088' (SecondaryID)'
  end
  object lbl3: TLabel
    Left = 86
    Top = 79
    Width = 264
    Height = 13
    Caption = '('#1076#1072#1085#1085#1099#1081' '#1085#1086#1084#1077#1088' '#1091#1082#1072#1079#1099#1074#1072#1077#1090#1089#1103' '#1074' '#1082#1072#1095#1077#1089#1090#1074#1077' RS-'#1085#1086#1084#1077#1088#1072')'
  end
  object lbl4: TLabel
    Left = 384
    Top = 52
    Width = 172
    Height = 13
    Caption = #1053#1072#1073#1086#1088' '#1087#1077#1088#1077#1076#1072#1074#1072#1077#1084#1099#1093' '#1087#1072#1088#1072#1084#1077#1090#1088#1086#1074
  end
  object edtName: TEdit
    Left = 203
    Top = 52
    Width = 147
    Height = 21
    Enabled = False
    ReadOnly = True
    TabOrder = 0
    Text = '19113102'
  end
  object lst1: TValueListEditor
    Left = 384
    Top = 79
    Width = 323
    Height = 139
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goColSizing, goRowSelect, goThumbTracking]
    Strings.Strings = (
      #1069#1085#1077#1088#1075#1080#1103' ('#1082#1042#1090'*'#1095')=0,2'
      'T'#1087#1086#1076#1072#1095#1080'=20,71'
      #1058#1086#1073#1088#1072#1090#1082#1080'=20,99'
      #1056#1072#1079#1085#1080#1094#1072' '#1090#1077#1084#1087#1077#1088#1072#1090#1091#1088'=0,28'
      #1050#1086#1076' '#1086#1096#1080#1073#1082#1080'=0')
    TabOrder = 1
    TitleCaptions.Strings = (
      #1055#1072#1088#1072#1084#1077#1090#1088
      #1047#1085#1072#1095#1077#1085#1080#1077)
    ColWidths = (
      150
      167)
  end
end
