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
    ExplicitLeft = 749
    ExplicitTop = 228
    ExplicitWidth = 185
    ExplicitHeight = 41
    object dbchtParm: TDBChart
      Left = 1
      Top = 1
      Width = 631
      Height = 383
      Title.Text.Strings = (
        #1043#1088#1072#1092#1080#1082' '#1087#1072#1088#1072#1084#1077#1090#1088#1072)
      Align = alClient
      TabOrder = 0
      ExplicitLeft = 30
      ExplicitTop = 28
      ExplicitWidth = 400
      ExplicitHeight = 250
      DefaultCanvas = 'TGDIPlusCanvas'
      ColorPaletteIndex = 13
      object lnsrsChLine: TLineSeries
        Brush.BackColor = clDefault
        Pointer.InflateMargins = True
        Pointer.Style = psRectangle
        XValues.Name = 'X'
        XValues.Order = loAscending
        YValues.Name = 'Y'
        YValues.Order = loNone
      end
    end
  end
  object pnlFooter: TPanel
    Left = 0
    Top = 414
    Width = 984
    Height = 147
    Align = alBottom
    TabOrder = 2
    object dtpBegin: TDateTimePicker
      Left = 19
      Top = 40
      Width = 200
      Height = 25
      Date = 44162.000000000000000000
      Time = 0.799752048609661900
      TabOrder = 0
    end
    object dtpEnd: TDateTimePicker
      Left = 257
      Top = 40
      Width = 200
      Height = 25
      Date = 44162.000000000000000000
      Time = 0.799752048609661900
      TabOrder = 1
    end
    object btnRefresh: TButton
      Left = 742
      Top = 40
      Width = 200
      Height = 25
      Caption = #1054#1073#1085#1086#1074#1080#1090#1100
      TabOrder = 2
    end
  end
  object pnlRight: TPanel
    Left = 633
    Top = 29
    Width = 351
    Height = 385
    Align = alRight
    TabOrder = 3
    object dbgrdPar: TDBGrid
      Left = 1
      Top = 1
      Width = 349
      Height = 383
      Align = alClient
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
    end
  end
end
