object MainForm: TMainForm
  Left = 0
  Top = 0
  ClientHeight = 374
  ClientWidth = 659
  Caption = ''
  BorderStyle = bsNone
  WindowState = wsMaximized
  OldCreateOrder = False
  BorderIcons = []
  MonitoredKeys.Keys = <>
  PixelsPerInch = 96
  TextHeight = 13
  object UniLabel1: TUniLabel
    Left = 24
    Top = 8
    Width = 70
    Height = 25
    Hint = ''
    Caption = #1055#1088#1080#1074#1077#1090
    ParentFont = False
    Font.Height = -21
    TabOrder = 0
  end
  object undbgrd1: TUniDBGrid
    Left = 24
    Top = 80
    Width = 537
    Height = 169
    Hint = ''
    DataSource = UniMainModule.ds1
    LoadMask.Message = 'Loading data...'
    TabOrder = 1
  end
end
