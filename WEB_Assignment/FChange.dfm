object frmChange: TfrmChange
  Left = 0
  Top = 0
  ClientHeight = 151
  ClientWidth = 177
  Caption = 'frmChange'
  BorderStyle = bsNone
  OldCreateOrder = False
  MonitoredKeys.Keys = <>
  ActiveControl = undtOldPass
  PixelsPerInch = 96
  TextHeight = 13
  object undtOldPass: TUniEdit
    Left = 32
    Top = 8
    Width = 120
    Hint = ''
    Text = ''
    TabOrder = 0
    EmptyText = #1057#1090#1072#1088#1099#1081' '#1087#1072#1088#1086#1083#1100
    ClearButton = True
  end
  object undtNewPass: TUniEdit
    Left = 32
    Top = 42
    Width = 120
    Hint = ''
    Text = ''
    TabOrder = 1
    EmptyText = #1053#1086#1074#1099#1081' '#1087#1072#1088#1086#1083#1100
    ClearButton = True
  end
  object undtRepPas: TUniEdit
    Left = 32
    Top = 76
    Width = 120
    Hint = ''
    Text = ''
    TabOrder = 2
    EmptyText = #1055#1086#1076#1090#1074#1077#1088#1078#1076#1077#1085#1080#1077' '
    ClearButton = True
  end
  object btnCancel: TUniButton
    Left = 32
    Top = 110
    Width = 55
    Height = 25
    Hint = ''
    Caption = #1054#1090#1084#1077#1085#1072
    TabOrder = 3
    OnClick = btnCancelClick
  end
  object btnOk: TUniButton
    Left = 97
    Top = 110
    Width = 55
    Height = 25
    Hint = ''
    Caption = #1042#1074#1086#1076
    TabOrder = 4
    OnClick = btnOkClick
  end
  object fdqryChange: TFDQuery
    Connection = UniMainModule.confd
    Transaction = UniMainModule.fdtrnsctnWrite
    UpdateTransaction = UniMainModule.fdtrnsctnRead
    SQL.Strings = (
      'update users set password = :p where id = :id')
    Left = 144
    Top = 32
    ParamData = <
      item
        Name = 'P'
        DataType = ftString
        ParamType = ptInput
        Size = 255
        Value = Null
      end
      item
        Name = 'ID'
        DataType = ftLargeint
        ParamType = ptInput
      end>
  end
end
