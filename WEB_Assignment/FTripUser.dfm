object frmTripUser: TfrmTripUser
  Left = 0
  Top = 0
  ClientHeight = 722
  ClientWidth = 1041
  Caption = ''
  OnShow = UniFormShow
  BorderStyle = bsNone
  WindowState = wsMaximized
  OldCreateOrder = False
  BorderIcons = []
  MonitoredKeys.Keys = <>
  PixelsPerInch = 96
  TextHeight = 13
  object undbgrdTrip: TUniDBGrid
    Left = 0
    Top = 96
    Width = 1033
    Height = 425
    Hint = ''
    DataSource = dsTrip
    LoadMask.Message = 'Loading data...'
    TabOrder = 0
    Columns = <
      item
        FieldName = 'NAME'
        Title.Alignment = taCenter
        Title.Caption = #1060#1048#1054
        Width = 300
        ReadOnly = True
      end
      item
        FieldName = 'TRIPDATE'
        Title.Alignment = taCenter
        Title.Caption = #1044#1072#1090#1072' '#1082#1086#1084#1072#1085#1076#1080#1088#1086#1074#1082#1080
        Width = 180
      end
      item
        FieldName = 'TRIPTYPE'
        Title.Alignment = taCenter
        Title.Caption = #1058#1080#1087
        Width = 120
      end
      item
        FieldName = 'COMMENT'
        Title.Alignment = taCenter
        Title.Caption = #1050#1086#1084#1084#1077#1085#1090#1072#1088#1080#1080
        Width = 400
      end>
  end
  object undbnvgtrTrip: TUniDBNavigator
    Left = 0
    Top = 65
    Width = 1033
    Height = 25
    Hint = ''
    VisibleButtons = [nbFirst, nbPrior, nbNext, nbLast, nbRefresh]
    TabOrder = 1
  end
  object lbTripTab: TUniLabel
    Left = 408
    Top = 16
    Width = 225
    Height = 25
    Hint = ''
    Caption = #1058#1072#1073#1083#1080#1094#1072' '#1082#1086#1084#1072#1085#1076#1080#1088#1086#1074#1086#1082
    ParentFont = False
    Font.Height = -21
    TabOrder = 2
  end
  object undtmpckrBegin: TUniDateTimePicker
    Left = 8
    Top = 544
    Width = 209
    Height = 25
    Hint = ''
    DateTime = 43879.000000000000000000
    DateFormat = 'dd/MM/yyyy'
    TimeFormat = 'HH:mm:ss'
    TabOrder = 3
    FieldLabel = #1053#1072#1095#1072#1083#1100#1085#1072#1103' '#1076#1072#1090#1072
    EmptyText = #1053#1072#1095#1072#1083#1100#1085#1072#1103' '#1076#1072#1090#1072
  end
  object undtmpckrEnd: TUniDateTimePicker
    Left = 8
    Top = 584
    Width = 209
    Height = 25
    Hint = ''
    DateTime = 43865.000000000000000000
    DateFormat = 'dd/MM/yyyy'
    TimeFormat = 'HH:mm:ss'
    TabOrder = 4
    FieldLabel = #1050#1086#1085#1077#1095#1085#1072#1103' '#1076#1072#1090#1072
    EmptyText = #1050#1086#1085#1077#1095#1085#1072#1103' '#1076#1072#1090#1072
  end
  object btnRefresh: TUniButton
    Left = 942
    Top = 544
    Width = 75
    Height = 25
    Hint = ''
    Caption = #1054#1073#1085#1086#1074#1080#1090#1100
    TabOrder = 5
    OnClick = btnRefreshClick
  end
  object fdpdtsqlTrip: TFDUpdateSQL
    Connection = UniMainModule.confd
    Left = 984
    Top = 16
  end
  object fdqryTrip: TFDQuery
    Connection = UniMainModule.confd
    Transaction = UniMainModule.fdtrnsctnRead
    UpdateTransaction = UniMainModule.fdtrnsctnWrite
    FetchOptions.AssignedValues = [evItems]
    FetchOptions.Items = [fiBlobs, fiDetails]
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate, uvGeneratorName]
    UpdateOptions.GeneratorName = 'GEN_USERS_ID'
    UpdateObject = fdpdtsqlTrip
    SQL.Strings = (
      'SELECT  users.name, trip.tripdate,  trip.triptype, trip.comment'
      'FROM users'
      'INNER JOIN trip on (users.id = trip.admin_id)'
      
        'WHERE ((trip.user_id = :id)  and  (trip.tripdate between :d1 and' +
        ' :d2))')
    Left = 912
    Top = 16
    ParamData = <
      item
        Name = 'ID'
        DataType = ftLargeint
        ParamType = ptInput
      end
      item
        Name = 'D1'
        DataType = ftDate
        ParamType = ptInput
      end
      item
        Name = 'D2'
        DataType = ftDate
        ParamType = ptInput
      end>
  end
  object dsTrip: TDataSource
    DataSet = fdqryTrip
    Left = 848
    Top = 24
  end
end
