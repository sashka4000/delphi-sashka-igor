object frmAdmin: TfrmAdmin
  Left = 0
  Top = 0
  ClientHeight = 100
  ClientWidth = 310
  Caption = 'frmAdmin'
  BorderStyle = bsNone
  Position = poDesktopCenter
  OldCreateOrder = False
  MonitoredKeys.Keys = <>
  PixelsPerInch = 96
  TextHeight = 13
  object btn1: TUniButton
    Left = 35
    Top = 35
    Width = 95
    Height = 25
    Hint = ''
    Caption = #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1080
    TabOrder = 0
    OnClick = btn1Click
  end
  object btn2: TUniButton
    Left = 180
    Top = 35
    Width = 95
    Height = 25
    Hint = ''
    Caption = #1050#1086#1084#1072#1085#1076#1080#1088#1086#1074#1082#1080
    ModalResult = 1
    TabOrder = 1
    OnClick = btn2Click
  end
end
