object FMod: TFMod
  Left = 0
  Top = 0
  Caption = #1054#1090#1095#1105#1090' '#1087#1086' '#1074#1077#1088#1089#1080#1103#1084'  SCADA'
  ClientHeight = 561
  ClientWidth = 784
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object dbcht_db: TDBChart
    Left = 0
    Top = 0
    Width = 784
    Height = 465
    Foot.Text.Strings = (
      #1055#1088#1080#1084#1077#1088' '#1075#1088#1072#1092#1080#1082#1072' ')
    Title.Text.Strings = (
      #1057#1074#1086#1076#1085#1099#1081' '#1086#1090#1095#1077#1090' '#1087#1086' '#1074#1077#1088#1089#1080#1103#1084' SCADA')
    Legend.Visible = False
    Align = alTop
    BevelWidth = 2
    Color = 16645347
    TabOrder = 0
    DefaultCanvas = 'TGDIPlusCanvas'
    PrintMargins = (
      15
      20
      15
      20)
    ColorPaletteIndex = 13
    object brsrsSeries_db: TBarSeries
      DataSource = DM_fireDAC.fdqryLog_mod
      XLabelsSource = 'SCADAVERSION'
      XValues.Name = 'X'
      XValues.Order = loAscending
      XValues.ValueSource = 'COUNT'
      YValues.Name = 'Bar'
      YValues.Order = loNone
      YValues.ValueSource = 'COUNT'
    end
  end
end
