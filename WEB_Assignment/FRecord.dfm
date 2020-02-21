object frmRecord: TfrmRecord
  Left = 0
  Top = 0
  ClientHeight = 400
  ClientWidth = 546
  Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1079#1072#1087#1080#1089#1100
  OnShow = UniFormShow
  BorderStyle = bsSingle
  Position = poMainFormCenter
  OldCreateOrder = False
  BorderIcons = [biSystemMenu]
  MonitoredKeys.Keys = <>
  PixelsPerInch = 96
  TextHeight = 13
  object lstTrip: TUniDBLookupListBox
    Left = 296
    Top = 40
    Width = 121
    Height = 95
    Hint = ''
    ListFieldIndex = 0
    TabOrder = 0
  end
  object lstUser: TUniDBLookupListBox
    Left = 48
    Top = 40
    Width = 121
    Height = 95
    Hint = ''
    ListFieldIndex = 0
    TabOrder = 1
  end
  object btnOk: TUniButton
    Left = 359
    Top = 321
    Width = 75
    Height = 25
    Hint = ''
    Caption = #1055#1086#1090#1074#1077#1088#1076#1080#1090#1100
    ModalResult = 1
    TabOrder = 2
  end
  object btnCancel: TUniButton
    Left = 24
    Top = 321
    Width = 75
    Height = 25
    Hint = ''
    Caption = #1054#1090#1084#1077#1085#1072
    ModalResult = 2
    TabOrder = 3
  end
  object unclndrdlgTrip: TUniCalendarDialog
    Date = 43882.000000000000000000
    Left = 48
    Top = 216
  end
end
