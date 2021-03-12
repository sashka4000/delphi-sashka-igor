object frmKSL: TfrmKSL
  Left = 653
  Top = 288
  BorderStyle = bsNone
  Caption = 'frmKSL'
  ClientHeight = 354
  ClientWidth = 726
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object lbl8: TLabel
    Left = 18
    Top = 112
    Width = 27
    Height = 13
    Caption = #1069#1090#1072#1078
  end
  object lbl17: TLabel
    Left = 18
    Top = 27
    Width = 54
    Height = 13
    Caption = #1050#1057#1051'-RS '#8470
  end
  object lbl1: TLabel
    Left = 18
    Top = 69
    Width = 64
    Height = 13
    Caption = #1054#1096#1080#1073#1082#1072' '#1057#1059#1051
  end
  object cbbError: TComboBox
    Left = 272
    Top = 69
    Width = 88
    Height = 22
    Style = csOwnerDrawFixed
    ItemIndex = 0
    TabOrder = 2
    Text = #1053#1077#1090' '#1086#1096#1080#1073#1082#1080
    Items.Strings = (
      #1053#1077#1090' '#1086#1096#1080#1073#1082#1080
      #1054#1096#1080#1073#1082#1072' 1'
      #1054#1096#1080#1073#1082#1072' 2')
  end
  object chkNoLift: TCheckBox
    Left = 414
    Top = 68
    Width = 108
    Height = 17
    Caption = #1053#1077#1090' '#1089#1074#1103#1079#1080' '#1089' '#1057#1059#1051
    TabOrder = 1
    OnClick = chkNoLiftClick
  end
  object seNumber: TSpinEdit
    Left = 272
    Top = 24
    Width = 83
    Height = 22
    MaxValue = 7
    MinValue = 0
    TabOrder = 0
    Value = 0
  end
  object seFloor: TSpinEdit
    Left = 272
    Top = 112
    Width = 88
    Height = 22
    MaxValue = 0
    MinValue = 0
    TabOrder = 3
    Value = 0
  end
end
