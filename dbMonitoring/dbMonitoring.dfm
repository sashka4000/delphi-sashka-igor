object Fdb: TFdb
  Left = 0
  Top = 0
  Caption = 'Fdb'
  ClientHeight = 661
  ClientWidth = 980
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pnlTop: TPanel
    Left = 0
    Top = 0
    Width = 980
    Height = 25
    Align = alTop
    TabOrder = 0
    object lblNameGrid: TLabel
      Left = 1
      Top = 1
      Width = 978
      Height = 16
      Align = alTop
      Alignment = taCenter
      Caption = #1050#1083#1080#1077#1085#1090#1089#1082#1080#1077' '#1087#1086#1076#1082#1083#1102#1095#1077#1085#1080#1103' '#1072#1082#1090#1080#1074#1085#1099#1077' '#1087#1086#1089#1083#1077#1076#1085#1080#1077' 60 '#1089#1091#1090#1086#1082'.'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      ExplicitWidth = 333
    end
  end
  object pnlDown: TPanel
    Left = 0
    Top = 544
    Width = 980
    Height = 117
    Align = alBottom
    TabOrder = 2
    object lblCountClient: TLabel
      Left = 307
      Top = 27
      Width = 4
      Height = 16
      Alignment = taCenter
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object lblCountData: TLabel
      Left = 565
      Top = 26
      Width = 143
      Height = 37
      Alignment = taCenter
      AutoSize = False
      Caption = ' '#1059#1082#1072#1078#1080#1090#1077' '#1082#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1076#1085#1077#1081' '#1076#1083#1103' '#1087#1086#1082#1072#1079#1072
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      WordWrap = True
    end
    object dbnvgr_db: TDBNavigator
      Left = 1
      Top = 1
      Width = 978
      Height = 18
      DataSource = ds_db
      VisibleButtons = [nbFirst, nbPrior, nbNext, nbLast]
      Align = alTop
      TabOrder = 0
    end
    object chk_bd: TCheckBox
      Left = 22
      Top = 25
      Width = 238
      Height = 17
      Caption = #1054#1090#1086#1073#1088#1072#1078#1072#1090#1100' '#1082#1083#1080#1077#1085#1090#1086#1074' '#1074#1085#1091#1090#1088#1080' '#1058#1077#1082#1086#1085#1072' '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnClick = chk_bdClick
    end
    object btn_db_find: TButton
      Left = 295
      Top = 65
      Width = 75
      Height = 25
      Caption = #1053#1072#1081#1090#1080
      TabOrder = 2
      OnClick = btn_db_findClick
    end
    object lbledt_db: TLabeledEdit
      Left = 25
      Top = 68
      Width = 261
      Height = 21
      EditLabel.Width = 87
      EditLabel.Height = 16
      EditLabel.Caption = 'GUID '#1082#1083#1080#1077#1085#1090#1072'  '
      EditLabel.Font.Charset = DEFAULT_CHARSET
      EditLabel.Font.Color = clWindowText
      EditLabel.Font.Height = -13
      EditLabel.Font.Name = 'Tahoma'
      EditLabel.Font.Style = []
      EditLabel.ParentFont = False
      TabOrder = 4
    end
    object btnVer: TButton
      Left = 840
      Top = 68
      Width = 110
      Height = 25
      Caption = #1042#1077#1088#1089#1080#1080' SCADA '
      TabOrder = 3
      OnClick = btnVerClick
    end
    object edtDate: TEdit
      Left = 594
      Top = 69
      Width = 90
      Height = 21
      Alignment = taRightJustify
      TabOrder = 5
    end
    object btnRefresh: TBitBtn
      Left = 709
      Top = 68
      Width = 110
      Height = 25
      Caption = #1054#1073#1085#1086#1074#1080#1090#1100
      TabOrder = 6
      OnClick = btnRefreshClick
    end
  end
  object pnlMiddle: TPanel
    Left = 0
    Top = 25
    Width = 980
    Height = 519
    Align = alClient
    AutoSize = True
    TabOrder = 1
    object dbgrd_IDS: TDBGrid
      Left = 1
      Top = 1
      Width = 978
      Height = 517
      Align = alClient
      DataSource = ds_db
      ReadOnly = True
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
      OnDblClick = dbgrd_IDSDblClick
      Columns = <
        item
          Expanded = False
          FieldName = 'ID'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'GUID'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'REG_DATE'
          Width = 150
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'IP'
          Width = 64
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'LAST_ACCESS'
          Width = 150
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'SCADAVERSION'
          Width = 64
          Visible = True
        end>
    end
  end
  object ds_db: TDataSource
    DataSet = DM_fireDAC.fdqryLog_db
    Left = 77
    Top = 117
  end
end
