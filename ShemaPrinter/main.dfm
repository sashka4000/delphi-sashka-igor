object Form1: TForm1
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #1054#1090#1095#1105#1090
  ClientHeight = 255
  ClientWidth = 162
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  Visible = True
  PixelsPerInch = 96
  TextHeight = 13
  object rg1: TRadioGroup
    Left = 8
    Top = 8
    Width = 105
    Height = 105
    Caption = #1050#1072#1082' '#1085#1072#1087#1077#1095#1072#1090#1072#1090#1100
    ItemIndex = 0
    Items.Strings = (
      #1053#1072' '#1087#1088#1080#1085#1090#1077#1088
      #1042' Word'
      #1042' PDF')
    TabOrder = 0
  end
  object rg2: TRadioGroup
    Left = 8
    Top = 119
    Width = 145
    Height = 105
    Caption = #1055#1072#1088#1072#1084#1077#1090#1088#1099' '#1087#1077#1095#1072#1090#1080
    ItemIndex = 0
    Items.Strings = (
      #1054#1076#1080#1085' '#1088#1080#1089#1091#1085#1086#1082' '#1085#1072' '#1083#1080#1089#1090#1077
      #1044#1074#1072' '#1088#1080#1089#1091#1085#1082#1072' '#1085#1072' '#1083#1080#1089#1090#1077)
    TabOrder = 1
  end
  object btn1: TButton
    Left = 46
    Top = 225
    Width = 75
    Height = 25
    Caption = #1042#1099#1087#1086#1083#1085#1080#1090#1100
    TabOrder = 2
    OnClick = btn1Click
  end
  object frxrprtSmall: TfrxReport
    Version = '6.2.1'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick, pbCopy, pbSelection]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 43829.457077442100000000
    ReportOptions.LastChange = 43829.932456932900000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    Left = 120
    Top = 48
    Datasets = <
      item
        DataSet = frxDBDataset1
        DataSetName = 'frxDBDataset1'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxReportPage
      Orientation = poLandscape
      PaperWidth = 297.000000000000000000
      PaperHeight = 210.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      Columns = 2
      ColumnWidth = 138.500000000000000000
      ColumnPositions.Strings = (
        '0'
        '138,50')
      Frame.Typ = []
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Frame.Typ = []
        Height = 661.417750000000000000
        Top = 18.897650000000000000
        Width = 523.464905000000000000
        DataSet = frxDBDataset1
        DataSetName = 'frxDBDataset1'
        RowCount = 0
        object Picture1: TfrxPictureView
          AllowVectorExport = True
          Left = 37.795300000000000000
          Top = 30.236240000000000000
          Width = 449.764070000000000000
          Height = 574.488560000000000000
          DataField = 'Image'
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          Frame.Typ = []
          HightQuality = False
          Transparent = False
          TransparentColor = clWhite
        end
      end
    end
  end
  object frxpdfxprt1: TfrxPDFExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    DataOnly = False
    OpenAfterExport = False
    PrintOptimized = False
    Outline = False
    Background = False
    HTMLTags = True
    Quality = 95
    Transparency = False
    Author = 'FastReport'
    Subject = 'FastReport PDF export'
    ProtectionFlags = [ePrint, eModify, eCopy, eAnnot]
    HideToolbar = False
    HideMenubar = False
    HideWindowUI = False
    FitWindow = False
    CenterWindow = False
    PrintScaling = False
    PdfA = False
    Left = 16
    Top = 232
  end
  object frxrtfxprt1: TfrxRTFExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    DataOnly = False
    PictureType = gpPNG
    OpenAfterExport = False
    Wysiwyg = True
    Creator = 'FastReport'
    SuppressPageHeadersFooters = False
    HeaderFooterMode = hfText
    AutoSize = False
    Left = 56
    Top = 232
  end
  object fdmtb1: TFDMemTable
    Active = True
    FieldDefs = <
      item
        Name = 'ID'
        DataType = ftInteger
      end
      item
        Name = 'Name'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'Image'
        DataType = ftBlob
      end>
    IndexDefs = <>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    StoreDefs = True
    Left = 152
    Top = 16
    object intgrfldfdmtb1ID: TIntegerField
      FieldName = 'ID'
    end
    object strngfldfdmtb1Name: TStringField
      FieldName = 'Name'
      Size = 50
    end
    object blbfldfdmtb1Image: TBlobField
      FieldName = 'Image'
    end
  end
  object frxDBDataset1: TfrxDBDataset
    UserName = 'frxDBDataset1'
    CloseDataSource = False
    DataSet = fdmtb1
    BCDToCurrency = False
    Left = 120
    Top = 96
  end
  object frxrprtBig: TfrxReport
    Version = '6.2.1'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick, pbCopy, pbSelection]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 43829.457077442100000000
    ReportOptions.LastChange = 43829.932456932900000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    Left = 120
    Top = 8
    Datasets = <
      item
        DataSet = frxDBDataset1
        DataSetName = 'frxDBDataset1'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      Columns = 1
      ColumnWidth = 277.000000000000000000
      ColumnPositions.Strings = (
        '0')
      DataSet = frxDBDataset1
      DataSetName = 'frxDBDataset1'
      Frame.Typ = []
      object Picture1: TfrxPictureView
        AllowVectorExport = True
        Left = 52.913420000000000000
        Top = 94.488250000000000000
        Width = 597.165740000000000000
        Height = 842.835190000000000000
        DataField = 'Image'
        DataSet = frxDBDataset1
        DataSetName = 'frxDBDataset1'
        Frame.Typ = []
        HightQuality = False
        Transparent = False
        TransparentColor = clWhite
      end
    end
  end
end
