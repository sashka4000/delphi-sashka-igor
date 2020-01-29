object frmGreeting: TfrmGreeting
  Left = 0
  Top = 0
  ClientHeight = 225
  ClientWidth = 423
  Caption = 'Greeting'
  OnShow = UniFormShow
  BorderStyle = bsNone
  Position = poDesktopCenter
  OldCreateOrder = False
  MonitoredKeys.Keys = <>
  PixelsPerInch = 96
  TextHeight = 13
  object UniLbGreeting: TUniLabel
    Left = 32
    Top = 8
    Width = 361
    Height = 89
    Hint = ''
    Alignment = taCenter
    AutoSize = False
    Caption = #1044#1086#1073#1088#1086' '#1087#1086#1078#1072#1083#1086#1074#1072#1090#1100' '#1074' '#1088#1072#1081
    ParentFont = False
    Font.Charset = RUSSIAN_CHARSET
    Font.Height = -37
    Font.Name = 'Times New Roman'
    Font.Style = [fsBold, fsItalic]
    TabOrder = 0
  end
  object btnGreetingOk: TUniButton
    Left = 160
    Top = 176
    Width = 75
    Height = 25
    Hint = ''
    Caption = #1042#1093#1086#1076
    ParentFont = False
    Font.Height = -16
    TabOrder = 1
    OnClick = btnGreetingOkClick
  end
  object unlbl1: TUniLabel
    Left = 160
    Top = 120
    Width = 62
    Height = 29
    Hint = ''
    Caption = 'unlbl1'
    ParentFont = False
    Font.Height = -24
    TabOrder = 2
  end
end
