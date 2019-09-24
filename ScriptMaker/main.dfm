object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 780
  ClientWidth = 904
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object pnl1: TPanel
    Left = 8
    Top = 8
    Width = 449
    Height = 409
    BevelOuter = bvNone
    Caption = 'pnl1'
    TabOrder = 0
    object sg1: TStringGrid
      Left = 0
      Top = 0
      Width = 449
      Height = 409
      Align = alClient
      ColCount = 2
      FixedCols = 0
      PopupMenu = pm1
      TabOrder = 0
      OnClick = sg1Click
      ColWidths = (
        216
        186)
    end
  end
  object pnl2: TPanel
    Left = 463
    Top = 8
    Width = 433
    Height = 409
    TabOrder = 1
  end
  object btn1: TButton
    Left = 725
    Top = 432
    Width = 75
    Height = 25
    Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
    TabOrder = 3
    OnClick = btn1Click
  end
  object btn2: TButton
    Left = 821
    Top = 431
    Width = 75
    Height = 25
    Caption = #1054#1090#1084#1077#1085#1080#1090#1100
    TabOrder = 2
    OnClick = btn2Click
  end
  object pm1: TPopupMenu
    Left = 32
    Top = 160
    object mniLj1: TMenuItem
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1057#1090#1088#1086#1082#1072
    end
    object mniN1: TMenuItem
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1057#1090#1088#1086#1082#1072' '#1089' '#1075#1088#1072#1085#1080#1094#1072#1084#1080
    end
    object mniN2: TMenuItem
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1057#1087#1080#1089#1086#1082
    end
    object mniN3: TMenuItem
      Caption = '-'
    end
    object mniN4: TMenuItem
      Caption = #1059#1076#1072#1083#1080#1090#1100' '#1086#1073#1098#1077#1082#1090
    end
  end
end
