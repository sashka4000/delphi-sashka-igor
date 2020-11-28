object frmParm: TfrmParm
  Left = 0
  Top = 0
  Caption = #1055#1072#1088#1072#1084#1077#1090#1088#1099' '#1082#1083#1080#1077#1085#1090#1072
  ClientHeight = 561
  ClientWidth = 984
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pnlTop: TPanel
    Left = 0
    Top = 0
    Width = 984
    Height = 29
    Align = alTop
    TabOrder = 0
  end
  object pnlLeft: TPanel
    Left = 0
    Top = 29
    Width = 633
    Height = 385
    Align = alClient
    TabOrder = 1
    object dbchtParm: TDBChart
      Left = 1
      Top = 1
      Width = 631
      Height = 383
      Title.Text.Strings = (
        #1043#1088#1072#1092#1080#1082' '#1087#1072#1088#1072#1084#1077#1090#1088#1072)
      BottomAxis.LabelsSeparation = 0
      BottomAxis.Title.Caption = #1055#1072#1088#1072#1084#1077#1090#1088
      LeftAxis.Title.Caption = #1044#1072#1090#1072
      Legend.Title.Text.Strings = (
        #1057#1074#1086#1081#1089#1090#1074#1086' '#1087#1072#1088#1072#1084#1077#1090#1088#1086#1074)
      Align = alClient
      TabOrder = 0
      ExplicitTop = 0
      DefaultCanvas = 'TGDIPlusCanvas'
      ColorPaletteIndex = 13
      object lnsrsChLine: TLineSeries
        DataSource = DM_fireDAC.fdqry_Chart_Par
        XLabelsSource = #1055#1040#1056#1040#1052#1045#1058#1056
        Brush.BackColor = clDefault
        Pointer.InflateMargins = True
        Pointer.Style = psRectangle
        XValues.Name = 'X'
        XValues.Order = loAscending
        YValues.DateTime = True
        YValues.Name = 'Y'
        YValues.Order = loNone
        YValues.ValueSource = #1042#1056#1045#1052#1071
      end
    end
  end
  object pnlFooter: TPanel
    Left = 0
    Top = 414
    Width = 984
    Height = 147
    Align = alBottom
    TabOrder = 3
    object dtpBegin: TDateTimePicker
      Left = 19
      Top = 40
      Width = 200
      Height = 25
      Date = 44162.000000000000000000
      Time = 0.799752048609661900
      TabOrder = 0
      OnChange = dtpBeginChange
    end
    object dtpEnd: TDateTimePicker
      Left = 257
      Top = 40
      Width = 200
      Height = 25
      Date = 44162.000000000000000000
      Time = 0.799752048609661900
      TabOrder = 1
      OnChange = dtpEndChange
    end
    object btnRefresh: TButton
      Left = 742
      Top = 40
      Width = 200
      Height = 25
      Caption = #1054#1073#1085#1086#1074#1080#1090#1100
      TabOrder = 2
      OnClick = btnRefreshClick
    end
  end
  object pnlRight: TPanel
    Left = 633
    Top = 29
    Width = 351
    Height = 385
    Align = alRight
    TabOrder = 2
    object dbgrdPar: TDBGrid
      Left = 1
      Top = 1
      Width = 349
      Height = 383
      Align = alClient
      DataSource = ds_Par
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
    end
  end
  object ds_Par: TDataSource
    DataSet = DM_fireDAC.fdqryParam
    Left = 645
    Top = 46
  end
end
