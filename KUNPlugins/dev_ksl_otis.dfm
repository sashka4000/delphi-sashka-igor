object frmKSL: TfrmKSL
  Left = 653
  Top = 288
  BorderStyle = bsNone
  Caption = 'frmKSL'
  ClientHeight = 562
  ClientWidth = 561
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object lbl11: TLabel
    Tag = 100
    Left = 37
    Top = 297
    Width = 129
    Height = 13
    Caption = #1042#1088#1077#1084#1103' '#1089' '#1087#1086#1089#1083'. '#1086#1087#1088#1086#1089#1072'  ('#1089'.)'
  end
  object lbl10: TLabel
    Left = 37
    Top = 225
    Width = 35
    Height = 13
    Caption = 'RS-485'
  end
  object lbl8: TLabel
    Left = 293
    Top = 177
    Width = 27
    Height = 13
    Caption = #1069#1090#1072#1078
  end
  object lbl7: TLabel
    Left = 37
    Top = 193
    Width = 54
    Height = 13
    Caption = #1050#1057#1051'-RS '#8470
  end
  object chkMass15: TCheckBox
    Left = 302
    Top = 253
    Width = 90
    Height = 17
    Caption = #1052#1072#1089#1089#1072' 15 '#1082#1075'.'
    TabOrder = 4
  end
  object chkData: TCheckBox
    Left = 160
    Top = 394
    Width = 52
    Height = 17
    Caption = 'DATA'
    TabOrder = 8
  end
  object cbbError: TComboBox
    Left = 215
    Top = 96
    Width = 88
    Height = 22
    Style = csOwnerDrawFixed
    ItemIndex = 0
    TabOrder = 0
    Text = #1053#1077#1090' '#1086#1096#1080#1073#1082#1080
    Items.Strings = (
      #1053#1077#1090' '#1086#1096#1080#1073#1082#1080
      #1054#1096#1080#1073#1082#1072' 1'
      #1054#1096#1080#1073#1082#1072' 2')
  end
  object edt1: TEdit
    Tag = 100
    Left = 53
    Top = 392
    Width = 38
    Height = 21
    Alignment = taRightJustify
    Enabled = False
    TabOrder = 7
  end
  object seKCSInterface: TSpinEdit
    Left = 206
    Top = 222
    Width = 60
    Height = 22
    MaxValue = 1
    MinValue = 0
    TabOrder = 3
    Value = 0
  end
  object chkNoLift: TCheckBox
    Left = 221
    Top = 363
    Width = 108
    Height = 17
    Caption = #1053#1077#1090' '#1089#1074#1103#1079#1080' '#1089' '#1057#1059#1051
    TabOrder = 6
    OnClick = chkNoLiftClick
  end
  object seKSLNumber: TSpinEdit
    Left = 104
    Top = 125
    Width = 60
    Height = 22
    MaxValue = 7
    MinValue = 0
    TabOrder = 1
    Value = 0
  end
  object cbbLift: TComboBox
    Left = 206
    Top = 312
    Width = 97
    Height = 22
    Style = csOwnerDrawFixed
    ItemIndex = 0
    TabOrder = 5
    Text = #1053#1077#1090
    Items.Strings = (
      #1053#1077#1090
      'OTIS')
  end
  object seFloor: TSpinEdit
    Left = 359
    Top = 174
    Width = 49
    Height = 22
    MaxValue = 0
    MinValue = 0
    TabOrder = 2
    Value = 0
  end
end
