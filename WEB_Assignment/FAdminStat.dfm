object frmAdminStat: TfrmAdminStat
  Left = 0
  Top = 0
  ClientHeight = 522
  ClientWidth = 970
  Caption = 'frmAdminStat'
  OnShow = UniFormShow
  OldCreateOrder = False
  MonitoredKeys.Keys = <>
  PixelsPerInch = 96
  TextHeight = 13
  object unchrt1: TUniChart
    Left = 16
    Top = 72
    Width = 400
    Height = 300
    Hint = ''
    Legend.Visible = False
    LayoutConfig.BodyPadding = '10'
    object unpsrs1: TUniPieSeries
      Colors.Strings = (
        '#0000FF'
        '#00FF00'
        '#FF0000'
        '#00FFFF'
        '#FFFF00'
        '#FF00FF')
      SeriesLabel.Display = 'inside'
      DataSource = ds1
      YValues.ValueSource = 'COUNT'
      XLabelsSource = 'TT'
    end
  end
  object unchrt2: TUniChart
    Left = 472
    Top = 72
    Width = 400
    Height = 300
    Hint = ''
    LayoutConfig.BodyPadding = '10'
    object unhrzbrsrs1: TUniHorizBarSeries
      Title = 'unhrzbrsrs1'
      DataSource = ds1
      YValues.ValueSource = 'COUNT'
      XLabelsSource = 'TT'
    end
  end
  object fdqry1: TFDQuery
    Active = True
    Connection = UniMainModule.confd
    SQL.Strings = (
      ' select count (*), user_id from TRIP t'
      ' where t.triptype = 0'
      ' group by t.user_id')
    Left = 120
    Top = 416
    object intgrfldfdqry1COUNT: TIntegerField
      AutoGenerateValue = arDefault
      FieldName = 'COUNT'
      Origin = '"COUNT"'
      ProviderFlags = []
      ReadOnly = True
    end
    object lrgntfldfdqry1USER_ID: TLargeintField
      FieldName = 'USER_ID'
      Origin = 'USER_ID'
      Required = True
    end
    object strngfldfdqry1TT: TStringField
      FieldKind = fkLookup
      FieldName = 'TT'
      LookupDataSet = UniMainModule.fdqryUsers
      LookupKeyFields = 'ID'
      LookupResultField = 'NAME'
      KeyFields = 'USER_ID'
      Lookup = True
    end
  end
  object ds1: TDataSource
    DataSet = fdqry1
    Left = 160
    Top = 416
  end
end
