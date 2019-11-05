object frmMain: TfrmMain
  Left = 0
  Top = 0
  Caption = 'frmMain'
  ClientHeight = 689
  ClientWidth = 750
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  DesignSize = (
    750
    689)
  PixelsPerInch = 96
  TextHeight = 13
  object pb1: TPaintBox
    Left = 8
    Top = 35
    Width = 550
    Height = 600
    Anchors = [akLeft, akTop, akRight, akBottom]
    OnPaint = pb1Paint
  end
  object lbl1: TLabel
    Left = 136
    Top = 6
    Width = 296
    Height = 23
    Caption = #1069#1058#1054' '#1044#1054#1057#1050#1040' '#1044#1051#1071' '#1056#1048#1057#1054#1042#1040#1053#1048#1071
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object btnTest1: TButton
    Left = 584
    Top = 32
    Width = 137
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'Test Draw 1'
    TabOrder = 0
    OnClick = btnTest1Click
  end
  object btnSave: TButton
    Left = 584
    Top = 80
    Width = 137
    Height = 25
    Caption = 'Save File  to  *.bmp'
    TabOrder = 1
    OnClick = btnSaveClick
  end
  object btnSaveToWord: TButton
    Left = 584
    Top = 128
    Width = 137
    Height = 25
    Caption = 'Save File to Word'
    TabOrder = 2
    OnClick = btnSaveToWordClick
  end
end
