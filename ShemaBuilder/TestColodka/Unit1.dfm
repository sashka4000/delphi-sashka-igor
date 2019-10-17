object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 453
  ClientWidth = 900
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
  object lbl1: TLabel
    Left = 56
    Top = 32
    Width = 106
    Height = 13
    Caption = #1050#1086#1083#1086#1076#1086#1082' '#1074' 1 '#1101#1083#1077#1084#1077#1085#1090
  end
  object lbl2: TLabel
    Left = 224
    Top = 32
    Width = 112
    Height = 13
    Caption = #1050#1086#1083#1086#1076#1086#1082' '#1074' 2 '#1101#1083#1077#1084#1077#1085#1090#1072
  end
  object lbl3: TLabel
    Left = 376
    Top = 32
    Width = 112
    Height = 13
    Caption = #1050#1086#1083#1086#1076#1086#1082' '#1074' 3 '#1101#1083#1077#1084#1077#1085#1090#1072
  end
  object lbl4: TLabel
    Left = 520
    Top = 32
    Width = 112
    Height = 13
    Caption = #1050#1086#1083#1086#1076#1086#1082' '#1074' 4 '#1101#1083#1077#1084#1077#1085#1090#1072
  end
  object lbl5: TLabel
    Left = 688
    Top = 32
    Width = 114
    Height = 13
    Caption = #1069#1083#1077#1084#1077#1085#1090#1086#1074' '#1085#1072' '#1089#1090#1086#1088#1086#1085#1077
  end
  object sg1: TStringGrid
    Left = 48
    Top = 160
    Width = 809
    Height = 33
    ColCount = 14
    DefaultColWidth = 25
    FixedCols = 0
    RowCount = 1
    FixedRows = 0
    TabOrder = 5
    OnDrawCell = sg1DrawCell
  end
  object btn1: TButton
    Left = 40
    Top = 248
    Width = 75
    Height = 25
    Caption = 'btn1'
    TabOrder = 6
    OnClick = btn1Click
  end
  object edt1: TEdit
    Left = 56
    Top = 56
    Width = 121
    Height = 21
    TabOrder = 0
    Text = '0'
  end
  object edt2: TEdit
    Left = 224
    Top = 56
    Width = 121
    Height = 21
    TabOrder = 1
    Text = '0'
  end
  object edt3: TEdit
    Left = 376
    Top = 56
    Width = 121
    Height = 21
    TabOrder = 2
    Text = '0'
  end
  object edt4: TEdit
    Left = 520
    Top = 56
    Width = 121
    Height = 21
    TabOrder = 3
    Text = '0'
  end
  object edt5: TEdit
    Left = 688
    Top = 56
    Width = 121
    Height = 21
    TabOrder = 4
    Text = '0'
  end
end
