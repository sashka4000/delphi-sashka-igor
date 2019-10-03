object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 554
  ClientWidth = 829
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object lbl1: TLabel
    Left = 8
    Top = 16
    Width = 47
    Height = 13
    Caption = #1054#1073#1098#1077#1082#1090#1099
  end
  object lblFunction: TLabel
    Left = 408
    Top = 16
    Width = 44
    Height = 13
    Caption = #1060#1091#1085#1082#1094#1080#1080
  end
  object lbl2: TLabel
    Left = 8
    Top = 293
    Width = 66
    Height = 13
    Caption = #1050#1086#1076' '#1086#1073#1098#1077#1082#1090#1072
  end
  object lbl3: TLabel
    Left = 408
    Top = 293
    Width = 67
    Height = 13
    Caption = #1050#1086#1076' '#1092#1091#1085#1082#1094#1080#1080
  end
  object mmoObjectCode: TMemo
    Left = 8
    Top = 312
    Width = 321
    Height = 217
    Lines.Strings = (
      'mmo1')
    TabOrder = 2
  end
  object lstObject: TListBox
    Left = 8
    Top = 35
    Width = 321
    Height = 230
    ItemHeight = 13
    TabOrder = 0
  end
  object lstFunctions: TListBox
    Left = 408
    Top = 35
    Width = 321
    Height = 230
    ItemHeight = 13
    TabOrder = 1
  end
  object mmoFunctionCode: TMemo
    Left = 408
    Top = 312
    Width = 321
    Height = 217
    Lines.Strings = (
      'mmo1')
    TabOrder = 3
  end
end
