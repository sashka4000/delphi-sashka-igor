object frmRegistration: TfrmRegistration
  Left = 0
  Top = 0
  ClientHeight = 516
  ClientWidth = 831
  Caption = #1056#1077#1075#1080#1089#1090#1088#1072#1094#1080#1103
  BorderStyle = bsNone
  OldCreateOrder = False
  BorderIcons = []
  MonitoredKeys.Keys = <>
  PixelsPerInch = 96
  TextHeight = 13
  object undbgrd1: TUniDBGrid
    Left = 8
    Top = 64
    Width = 809
    Height = 241
    Hint = ''
    DataSource = UniMainModule.ds1
    LoadMask.Message = 'Loading data...'
    TabOrder = 0
  end
  object lbNameTab: TUniLabel
    Left = 280
    Top = 16
    Width = 234
    Height = 25
    Hint = ''
    Caption = #1058#1072#1073#1083#1080#1094#1072' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1077#1081
    ParentFont = False
    Font.Height = -21
    TabOrder = 1
  end
  object PanReg: TUniPanel
    Left = 8
    Top = 320
    Width = 401
    Height = 145
    Hint = ''
    Visible = False
    TabOrder = 2
    Caption = ''
    object btnReset: TUniButton
      Left = 16
      Top = 104
      Width = 75
      Height = 25
      Hint = ''
      Caption = #1054#1090#1084#1077#1085#1072
      TabOrder = 1
      OnClick = btnResetClick
    end
    object undtLog: TUniEdit
      Left = 16
      Top = 65
      Width = 170
      Height = 25
      Hint = ''
      Text = ''
      ParentFont = False
      Font.Height = -13
      TabOrder = 2
      EmptyText = #1051#1086#1075#1080#1085
      ClearButton = True
      FieldLabelFont.Height = -13
    end
    object undtPassword: TUniEdit
      Left = 212
      Top = 26
      Width = 170
      Height = 25
      Hint = ''
      Text = ''
      ParentFont = False
      Font.Height = -13
      TabOrder = 3
      EmptyText = #1055#1072#1088#1086#1083#1100
      ClearButton = True
      FieldLabelFont.Height = -13
    end
    object undtRepPass: TUniEdit
      Left = 212
      Top = 64
      Width = 170
      Height = 25
      Hint = ''
      Text = ''
      ParentFont = False
      Font.Height = -13
      TabOrder = 4
      EmptyText = #1055#1086#1090#1074#1077#1088#1076#1080#1090#1077' '#1087#1072#1088#1086#1083#1100
      ClearButton = True
      FieldLabelFont.Height = -13
    end
    object undtUserName: TUniEdit
      Left = 16
      Top = 26
      Width = 170
      Height = 25
      Hint = ''
      Text = ''
      ParentFont = False
      Font.Height = -13
      TabOrder = 5
      EmptyText = #1042#1072#1096#1077' '#1080#1084#1103
      ClearButton = True
      FieldLabelFont.Height = -13
    end
    object btnReg: TUniButton
      Left = 287
      Top = 104
      Width = 95
      Height = 25
      Hint = ''
      Caption = #1042#1099#1087#1086#1083#1085#1080#1090#1100
      ParentFont = False
      Font.Height = -13
      TabOrder = 6
      OnClick = btnRegClick
    end
    object lbReg: TUniLabel
      Left = 112
      Top = -3
      Width = 160
      Height = 23
      Hint = ''
      Caption = #1047#1072#1088#1077#1075#1080#1089#1090#1088#1080#1088#1086#1074#1072#1090#1100
      ParentFont = False
      Font.Height = -19
      TabOrder = 7
    end
    object unchckbxStatus: TUniCheckBox
      Left = 128
      Top = 95
      Width = 153
      Height = 46
      Hint = ''
      Caption = #1057#1090#1072#1090#1091#1089' '#1091#1095#1077#1090#1085#1086#1081' '#1079#1072#1087#1080#1089#1080
      TabOrder = 8
    end
  end
  object btnChange: TUniButton
    Left = 728
    Top = 392
    Width = 95
    Height = 25
    Hint = ''
    Caption = #1057#1084#1077#1085#1080#1090#1100' '#1087#1072#1088#1086#1083#1100
    TabOrder = 3
    OnClick = btnChangeClick
  end
  object btnPanReg: TUniButton
    Left = 8
    Top = 440
    Width = 85
    Height = 25
    Hint = ''
    Caption = #1056#1077#1075#1080#1089#1090#1088#1072#1094#1080#1103
    TabOrder = 4
    OnClick = btnPanRegClick
  end
  object btnRefresh: TUniButton
    Left = 717
    Top = 320
    Width = 105
    Height = 25
    Hint = ''
    Caption = #1054#1073#1085#1086#1074#1080#1090#1100' '#1090#1072#1073#1083#1080#1094#1091
    TabOrder = 5
    OnClick = btnRefreshClick
  end
  object btnExit: TUniButton
    Left = 748
    Top = 448
    Width = 75
    Height = 25
    Hint = ''
    Caption = #1042#1099#1093#1086#1076
    TabOrder = 6
    OnClick = btnExitClick
  end
end
