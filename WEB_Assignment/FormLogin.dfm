object LoginForm: TLoginForm
  Left = 0
  Top = 0
  ClientHeight = 168
  ClientWidth = 227
  Caption = ''
  OnShow = UniLoginFormShow
  BorderStyle = bsNone
  Position = poDesktopCenter
  OldCreateOrder = False
  BorderIcons = [biSystemMenu]
  MonitoredKeys.Keys = <>
  ActiveControl = undtLogin
  PixelsPerInch = 96
  TextHeight = 13
  object lb_Welcome: TUniLabel
    Left = 4
    Top = 7
    Width = 228
    Height = 18
    Hint = ''
    Alignment = taCenter
    AutoSize = False
    Caption = #1055#1086#1078#1072#1083#1091#1081#1089#1090#1072' '#1072#1074#1090#1086#1088#1080#1079#1091#1081#1090#1077#1089#1100
    ParentFont = False
    Font.Height = -16
    TabOrder = 0
  end
  object undtLogin: TUniEdit
    Left = 32
    Top = 37
    Width = 161
    Hint = ''
    Text = ''
    ParentFont = False
    Font.Height = -13
    TabOrder = 1
    EmptyText = #1051#1086#1075#1080#1085
    ClearButton = True
    FieldLabelFont.Height = -13
  end
  object undtPassword: TUniEdit
    Left = 32
    Top = 71
    Width = 161
    Hint = ''
    PasswordChar = '*'
    Text = ''
    ParentFont = False
    Font.Height = -13
    TabOrder = 2
    EmptyText = #1055#1072#1088#1086#1083#1100
    ClearButton = True
    FieldLabelFont.Height = -13
    OnKeyPress = undtPasswordKeyPress
  end
  object btnCancel: TUniButton
    Left = 32
    Top = 109
    Width = 75
    Height = 25
    Hint = ''
    Caption = #1054#1090#1084#1077#1085#1072
    ModalResult = 2
    ParentFont = False
    Font.Height = -13
    TabOrder = 3
  end
  object btnOk: TUniButton
    Left = 129
    Top = 109
    Width = 64
    Height = 25
    Hint = ''
    Caption = #1042#1074#1086#1076
    ParentFont = False
    Font.Height = -13
    TabOrder = 4
    OnClick = btnOkClick
  end
  object fdqryCheckLogin: TFDQuery
    Connection = UniMainModule.confd
    Transaction = UniMainModule.fdtrnsctnRead
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate, uvGeneratorName, uvCheckRequired]
    UpdateOptions.GeneratorName = 'GEN_USERS_ID'
    UpdateOptions.KeyFields = 'ID'
    UpdateOptions.AutoIncFields = 'ID'
    SQL.Strings = (
      'select id, blocked,superuser'
      ' from users'
      ' where Login = :l and  "PASSWORD" = :p'
      '')
    Left = 183
    Top = 28
    ParamData = <
      item
        Name = 'L'
        DataType = ftString
        ParamType = ptInput
        Size = 255
        Value = Null
      end
      item
        Name = 'P'
        DataType = ftString
        ParamType = ptInput
        Value = Null
      end>
  end
end
