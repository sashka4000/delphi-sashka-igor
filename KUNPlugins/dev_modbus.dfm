inherited frmModbus: TfrmModbus
  Caption = 'frmModbus'
  PixelsPerInch = 96
  TextHeight = 13
  object lbl17: TLabel
    Left = 19
    Top = 27
    Width = 92
    Height = 13
    Caption = #1040#1076#1088#1077#1089' '#1091#1089#1090#1088#1086#1081#1089#1090#1074#1072
  end
  object lbl1: TLabel
    Left = 18
    Top = 74
    Width = 97
    Height = 13
    Caption = #1058#1072#1073#1083#1080#1094#1072' '#1088#1077#1075#1080#1089#1090#1088#1086#1074
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
  object lst1: TValueListEditor
    Left = 272
    Top = 74
    Width = 377
    Height = 177
    Strings.Strings = (
      'Coils 0 Bit =1'
      'Coils 1 Bit =1'
      'HoldReg 0 Word=15'
      'HoldReg 1 Short=-14'
      'HoldReg 2 Float=24.78'
      'HoldReg 4 Integer=2487'
      'InpReg 0 Word=15'
      'InpReg 1 Word=1')
    TabOrder = 1
    TitleCaptions.Strings = (
      #1040#1076#1088#1077#1089
      #1047#1085#1072#1095#1077#1085#1080#1077)
    ColWidths = (
      150
      221)
  end
end
