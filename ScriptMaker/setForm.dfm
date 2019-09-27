object frmSetSimple: TfrmSetSimple
  Left = 0
  Top = 0
  Align = alClient
  BorderStyle = bsNone
  Caption = 'frmSetSimple'
  ClientHeight = 336
  ClientWidth = 547
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  DesignSize = (
    547
    336)
  PixelsPerInch = 96
  TextHeight = 13
  object lbl1: TLabel
    Left = 112
    Top = 8
    Width = 168
    Height = 13
    Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1072' '#1074#1099#1073#1088#1072#1085#1085#1086#1075#1086' '#1086#1073#1098#1077#1082#1090#1072':'
  end
  object lbl2: TLabel
    Left = 8
    Top = 35
    Width = 152
    Height = 13
    Caption = #1048#1084#1103' '#1088#1077#1076#1072#1082#1090#1080#1088#1091#1077#1084#1086#1075#1086' '#1086#1073#1098#1077#1082#1090#1072
  end
  object img1: TImage
    Left = 235
    Top = 56
    Width = 304
    Height = 161
    Anchors = [akTop, akRight]
  end
  object lbl6: TLabel
    Left = 235
    Top = 35
    Width = 192
    Height = 13
    Anchors = [akTop, akRight]
    Caption = #1055#1088#1080#1084#1077#1088' '#1086#1090#1086#1073#1088#1072#1078#1072#1077#1084#1086#1075#1086' '#1086#1082#1085#1072' '#1074' SCADA'
  end
  object lbl3: TLabel
    Left = 8
    Top = 91
    Width = 67
    Height = 13
    Caption = #1050#1086#1084#1084#1077#1085#1090#1072#1088#1080#1081
  end
  object lbl7: TLabel
    Left = 8
    Top = 275
    Width = 464
    Height = 13
    Anchors = [akLeft, akBottom]
    Caption = 
      #1042#1085#1080#1084#1072#1085#1080#1077'! '#1057#1086#1079#1076#1072#1085#1085#1099#1081' '#1086#1073#1098#1077#1082#1090' '#1084#1086#1078#1077#1090' '#1080#1089#1087#1086#1083#1100#1079#1086#1074#1072#1090#1100#1089#1103' '#1076#1083#1103' '#1085#1077#1089#1082#1086#1083#1100#1082#1080#1093' '#1087 +
      #1088#1080#1084#1080#1090#1080#1074#1086#1074' '#1074' SCADA'
  end
  object edtName: TEdit
    Left = 8
    Top = 56
    Width = 121
    Height = 21
    TabOrder = 0
    Text = 'edtName'
  end
  object btnCancel: TButton
    Left = 449
    Top = 295
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = #1054#1090#1084#1077#1085#1080#1090#1100
    TabOrder = 3
    OnClick = btnCancelClick
  end
  object btnSave: TButton
    Left = 352
    Top = 295
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
    TabOrder = 2
    OnClick = btnSaveClick
  end
  object edtComment: TEdit
    Left = 8
    Top = 110
    Width = 121
    Height = 21
    TabOrder = 1
    Text = 'edt1'
  end
end
