object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 505
  ClientWidth = 824
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object rg1: TRadioGroup
    Left = 8
    Top = 8
    Width = 577
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
    Width = 577
    Height = 105
    Caption = #1055#1072#1088#1072#1084#1077#1090#1088#1099' '#1087#1077#1095#1072#1090#1080
    ItemIndex = 0
    Items.Strings = (
      #1054#1076#1080#1085' '#1088#1080#1089#1091#1085#1086#1082' '#1085#1072' '#1083#1080#1089#1090#1077
      #1044#1074#1072' '#1088#1080#1089#1091#1085#1082#1072' '#1085#1072' '#1083#1080#1089#1090#1077)
    TabOrder = 1
  end
  object btn1: TButton
    Left = 510
    Top = 248
    Width = 75
    Height = 25
    Caption = 'btn1'
    TabOrder = 2
    OnClick = btn1Click
  end
  object frxrprt1: TfrxReport
    Version = '6.2.1'
    DataSet = frxDBDataset1
    DataSetName = 'frxDBDataset1'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick, pbCopy, pbSelection]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 43829.457077442100000000
    ReportOptions.LastChange = 43829.619619294000000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    Left = 232
    Top = 248
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
      Duplex = dmVertical
      Frame.Typ = []
      object Picture1: TfrxPictureView
        AllowVectorExport = True
        Left = 11.338590000000000000
        Top = 15.118120000000000000
        Width = 532.913730000000000000
        Height = 695.433520000000000000
        DataField = 'Image'
        DataSet = frxDBDataset1
        DataSetName = 'frxDBDataset1'
        Frame.Typ = []
        HightQuality = False
        Transparent = False
        TransparentColor = clWhite
      end
      object Picture2: TfrxPictureView
        AllowVectorExport = True
        Left = 566.929500000000000000
        Top = 11.338590000000000000
        Width = 472.441250000000000000
        Height = 702.992580000000000000
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
    Left = 48
    Top = 248
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
    Left = 120
    Top = 248
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
    Left = 40
    Top = 320
  end
  object DS1: TDataSource
    DataSet = fdmtb1
    Left = 32
    Top = 376
  end
  object frxDBDataset1: TfrxDBDataset
    UserName = 'frxDBDataset1'
    CloseDataSource = False
    DataSet = fdmtb1
    BCDToCurrency = False
    Left = 32
    Top = 432
  end
end
