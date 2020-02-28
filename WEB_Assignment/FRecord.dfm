object frmRecord: TfrmRecord
  Left = 0
  Top = 0
  ClientHeight = 627
  ClientWidth = 492
  Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1079#1072#1087#1080#1089#1100
  BorderStyle = bsSingle
  OldCreateOrder = False
  BorderIcons = [biSystemMenu]
  MonitoredKeys.Keys = <>
  PixelsPerInch = 96
  TextHeight = 13
  object lstTrip: TUniDBLookupListBox
    Left = 199
    Top = 16
    Width = 121
    Height = 49
    Hint = ''
    ListField = 'TripType'
    ListSource = UniMainModule.dsTripType
    KeyField = 'ID'
    ListFieldIndex = 0
    TabOrder = 0
    OnClick = lstTripClick
  end
  object lstUser: TUniDBLookupListBox
    Left = 8
    Top = 16
    Width = 185
    Height = 497
    Hint = ''
    ListField = 'NAME'
    ListSource = frmTripAdmin.dsUsersAll
    KeyField = 'ID'
    ListFieldIndex = 0
    TabOrder = 1
  end
  object btnOk: TUniButton
    Left = 406
    Top = 561
    Width = 75
    Height = 25
    Hint = ''
    Caption = #1055#1086#1090#1074#1077#1088#1076#1080#1090#1100
    ModalResult = 1
    TabOrder = 2
  end
  object btnCancel: TUniButton
    Left = 8
    Top = 561
    Width = 75
    Height = 25
    Hint = ''
    Caption = #1054#1090#1084#1077#1085#1072
    ModalResult = 2
    TabOrder = 3
  end
  object undtDay: TUniEdit
    Left = 344
    Top = 16
    Width = 121
    Hint = ''
    Text = ''
    TabOrder = 4
    EmptyText = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1076#1085#1077#1081
    ClearButton = True
  end
  object undtComment: TUniEdit
    Left = 16
    Top = 519
    Width = 465
    Hint = ''
    Text = ''
    TabOrder = 5
    EmptyText = #1050#1086#1084#1084#1077#1085#1090#1072#1088#1080#1080
    ClearButton = True
  end
  object undtmpckrBegin: TUniDateTimePicker
    Left = 215
    Top = 88
    Width = 226
    Hint = ''
    DateTime = 43889.000000000000000000
    DateFormat = 'dd/MM/yyyy'
    TimeFormat = 'HH:mm:ss'
    TabOrder = 6
    FieldLabel = #1053#1072#1095#1072#1083#1100#1085#1072#1103' '#1076#1072#1090#1072
  end
  object undtmpckrEnd: TUniDateTimePicker
    Left = 215
    Top = 136
    Width = 226
    Hint = ''
    DateTime = 43889.000000000000000000
    DateFormat = 'dd/MM/yyyy'
    TimeFormat = 'HH:mm:ss'
    TabOrder = 7
    FieldLabel = #1050#1086#1085#1077#1095#1085#1072#1103' '#1076#1072#1090#1072
  end
end
