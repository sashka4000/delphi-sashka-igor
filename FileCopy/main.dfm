object frmMain: TfrmMain
  Left = 0
  Top = 0
  Caption = 'frmMain'
  ClientHeight = 346
  ClientWidth = 579
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PopupMode = pmAuto
  Position = poScreenCenter
  DesignSize = (
    579
    346)
  PixelsPerInch = 96
  TextHeight = 13
  object lbl1: TLabel
    Left = 16
    Top = 16
    Width = 75
    Height = 13
    Caption = #1060#1072#1081#1083' '#1079#1072#1076#1072#1085#1080#1103':'
  end
  object lbl2: TLabel
    Left = 16
    Top = 72
    Width = 81
    Height = 13
    Caption = #1055#1072#1087#1082#1072' '#1080#1089#1090#1086#1095#1085#1080#1082
  end
  object lbl3: TLabel
    Left = 16
    Top = 128
    Width = 93
    Height = 13
    Caption = #1055#1072#1087#1082#1072' '#1085#1072#1079#1085#1072#1095#1077#1085#1080#1103
  end
  object lbl4: TLabel
    Left = 16
    Top = 184
    Width = 90
    Height = 13
    Caption = #1055#1088#1086#1090#1086#1082#1086#1083' '#1088#1072#1073#1086#1090#1099
  end
  object edtFlieName: TEdit
    Left = 16
    Top = 35
    Width = 506
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 1
    Text = 'edtFlieName'
  end
  object btnSelectFile: TButton
    Left = 528
    Top = 33
    Width = 33
    Height = 25
    Anchors = [akTop, akRight]
    Caption = '...'
    TabOrder = 0
    OnClick = btnSelectFileClick
  end
  object edtSourceFolder: TEdit
    Left = 16
    Top = 91
    Width = 506
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 3
    Text = 'edt1'
  end
  object btnSelectSourceFolder: TButton
    Left = 528
    Top = 89
    Width = 33
    Height = 25
    Anchors = [akTop, akRight]
    Caption = '...'
    TabOrder = 2
    OnClick = btnSelectSourceFolderClick
  end
  object edtDestFolder: TEdit
    Left = 16
    Top = 147
    Width = 506
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 5
    Text = 'edt1'
  end
  object btnSelectDestFolder: TButton
    Left = 528
    Top = 145
    Width = 33
    Height = 25
    Anchors = [akTop, akRight]
    Caption = '...'
    TabOrder = 4
    OnClick = btnSelectDestFolderClick
  end
  object btnDoWork: TButton
    Left = 486
    Top = 313
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = #1042#1099#1087#1086#1083#1085#1080#1090#1100
    TabOrder = 7
    OnClick = btnDoWorkClick
  end
  object mmo1: TMemo
    Left = 16
    Top = 203
    Width = 545
    Height = 104
    Anchors = [akLeft, akTop, akRight, akBottom]
    Lines.Strings = (
      'mmo1')
    TabOrder = 6
  end
  object dlgOpen1: TOpenDialog
    Filter = #1060#1072#1081#1083' '#1079#1072#1076#1072#1085#1080#1103' (iss)|*.iss'
    Left = 96
  end
end
