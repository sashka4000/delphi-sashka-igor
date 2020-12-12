object frmMain: TfrmMain
  Left = 0
  Top = 0
  Caption = 'frmMain'
  ClientHeight = 559
  ClientWidth = 761
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
  object spl1: TSplitter
    Left = 0
    Top = 325
    Width = 761
    Height = 3
    Cursor = crVSplit
    Align = alBottom
    ExplicitTop = 0
    ExplicitWidth = 249
  end
  object pnl1: TPanel
    Left = 0
    Top = 328
    Width = 761
    Height = 231
    Align = alBottom
    TabOrder = 1
    DesignSize = (
      761
      231)
    object mmo1: TMemo
      Left = 11
      Top = 37
      Width = 649
      Height = 173
      Anchors = [akLeft, akTop, akRight, akBottom]
      Lines.Strings = (
        ' 0=1.jpg'
        ' 1=2.jpg; S:test.wav; N:'#1042#1082#1083#1102#1095#1077#1085#1080#1077'; A:0'
        ' 2=3.jpg; N:'#1040#1074#1072#1088#1080#1103)
      TabOrder = 1
    end
    object btnDoValues: TButton
      Left = 666
      Top = 36
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = #1042' '#1090#1072#1073#1083#1080#1094#1091
      TabOrder = 0
      OnClick = btnDoValuesClick
    end
  end
  object pnl2: TPanel
    Left = 0
    Top = 0
    Width = 761
    Height = 325
    Align = alClient
    TabOrder = 0
    DesignSize = (
      761
      325)
    object dbgrd1: TDBGrid
      Left = 11
      Top = 45
      Width = 649
      Height = 251
      Anchors = [akLeft, akTop, akRight, akBottom]
      DataSource = dsTb
      TabOrder = 1
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
      Columns = <
        item
          Expanded = False
          FieldName = 'Value'
          Title.Alignment = taCenter
          Title.Caption = #1047#1085#1072#1095#1077#1085#1080#1077
          Width = 80
          Visible = True
        end
        item
          ButtonStyle = cbsEllipsis
          Expanded = False
          FieldName = 'ImageFile'
          Title.Alignment = taCenter
          Title.Caption = #1048#1084#1103' '#1092#1072#1081#1083#1072' '#1080#1079#1086#1073#1088#1072#1078#1077#1085#1080#1103
          Width = 130
          Visible = True
        end
        item
          ButtonStyle = cbsEllipsis
          Expanded = False
          FieldName = 'SoundFile'
          Title.Alignment = taCenter
          Title.Caption = #1048#1084#1103' '#1079#1074#1091#1082#1086#1074#1086#1075#1086' '#1092#1072#1081#1083#1072
          Width = 130
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'AlertName'
          Title.Alignment = taCenter
          Title.Caption = #1053#1072#1079#1074#1072#1085#1080#1077' '#1089#1086#1073#1099#1090#1080#1103
          Width = 120
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Alert'
          PickList.Strings = (
            ''
            '0')
          Title.Alignment = taCenter
          Title.Caption = #1040#1074#1072#1088#1080#1103
          Width = 50
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Commanf'
          Title.Alignment = taCenter
          Title.Caption = #1050#1086#1084#1072#1085#1076#1072
          Width = 80
          Visible = True
        end>
    end
    object dbnvgr1: TDBNavigator
      Left = 11
      Top = 15
      Width = 650
      Height = 25
      DataSource = dsTb
      TabOrder = 0
    end
    object btnDoText: TButton
      Left = 666
      Top = 272
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = #1042' '#1058#1077#1082#1089#1090
      TabOrder = 2
      OnClick = btnDoTextClick
    end
  end
  object fdmtbl1: TFDMemTable
    Active = True
    FieldDefs = <
      item
        Name = 'Value'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'ImageFile'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'SoundFile'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'AlertName'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'Alert'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'Commanf'
        DataType = ftInteger
      end>
    IndexDefs = <>
    DetailFields = ' Alert ;AlertName;Commanf;ImageFile;SounDFile;value'
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvPersistent, rvSilentMode]
    ResourceOptions.Persistent = True
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    StoreDefs = True
    Left = 715
    Top = 23
    Content = {
      414442530F00741ED3020000FF00010001FF02FF0304000E000000660064006D
      00740062006C00310005000A0000005400610062006C00650006000000000007
      0000080032000000090000FF0AFF0B04000A000000560061006C007500650005
      000A000000560061006C00750065000C00010000000E000D000F001400000010
      000111000112000113000114000115000116000A000000560061006C00750065
      00170014000000FEFF0B04001200000049006D00610067006500460069006C00
      650005001200000049006D00610067006500460069006C0065000C0002000000
      0E000D000F001400000010000111000112000113000114000115000116001200
      000049006D00610067006500460069006C006500170014000000FEFF0B040012
      00000053006F0075006E006400460069006C00650005001200000053006F0075
      006E006400460069006C0065000C00030000000E000D000F0014000000100001
      11000112000113000114000115000116001200000053006F0075006E00640046
      0069006C006500170014000000FEFF0B04001200000041006C00650072007400
      4E0061006D00650005001200000041006C006500720074004E0061006D006500
      0C00040000000E000D000F001400000010000111000112000113000114000115
      000116001200000041006C006500720074004E0061006D006500170014000000
      FEFF0B04000A00000041006C0065007200740005000A00000041006C00650072
      0074000C00050000000E000D000F001400000010000111000112000113000114
      000115000116000A00000041006C00650072007400170014000000FEFF0B0400
      0E00000043006F006D006D0061006E00660005000E00000043006F006D006D00
      61006E0066000C00060000000E00180010000111000112000113000114000115
      000116000E00000043006F006D006D0061006E006600FEFEFF19FEFF1AFEFF1B
      FEFEFEFF1CFEFF1D1E0005000000FF1FFEFEFE0E004D0061006E006100670065
      0072001E00550070006400610074006500730052006500670069007300740072
      00790012005400610062006C0065004C006900730074000A005400610062006C
      00650008004E0061006D006500140053006F0075007200630065004E0061006D
      0065000A0054006100620049004400240045006E0066006F0072006300650043
      006F006E00730074007200610069006E00740073001E004D0069006E0069006D
      0075006D0043006100700061006300690074007900180043006800650063006B
      004E006F0074004E0075006C006C00140043006F006C0075006D006E004C0069
      00730074000C0043006F006C0075006D006E00100053006F0075007200630065
      004900440018006400740041006E007300690053007400720069006E00670010
      00440061007400610054007900700065000800530069007A0065001400530065
      006100720063006800610062006C006500120041006C006C006F0077004E0075
      006C006C000800420061007300650014004F0041006C006C006F0077004E0075
      006C006C0012004F0049006E0055007000640061007400650010004F0049006E
      00570068006500720065001A004F0072006900670069006E0043006F006C004E
      0061006D006500140053006F007500720063006500530069007A0065000E0064
      00740049006E007400330032001C0043006F006E00730074007200610069006E
      0074004C00690073007400100056006900650077004C006900730074000E0052
      006F0077004C006900730074001800520065006C006100740069006F006E004C
      006900730074001C0055007000640061007400650073004A006F00750072006E
      0061006C001200530061007600650050006F0069006E0074000E004300680061
      006E00670065007300}
    object fdmtbl1Value: TStringField
      FieldName = 'Value'
    end
    object fdmtbl1ImageFile: TStringField
      FieldName = 'ImageFile'
    end
    object fdmtbl1SoundFile: TStringField
      FieldName = 'SoundFile'
    end
    object fdmtbl1AlertName: TStringField
      FieldName = 'AlertName'
    end
    object fdmtbl1Alert: TStringField
      FieldName = 'Alert'
    end
    object fdmtbl1Commanf: TIntegerField
      FieldName = 'Commanf'
    end
  end
  object dsTb: TDataSource
    DataSet = fdmtbl1
    Left = 716
    Top = 75
  end
  object dlgOpenSound: TOpenDialog
    Filter = 
      'All (*.wav;*.mp3;*.aac;*.wma;*.flac)|*.wav;*.mp3;*.aac;*.wma;*.f' +
      'lac'
    Left = 695
    Top = 143
  end
  object dlgOpenPicImage: TOpenPictureDialog
    Left = 698
    Top = 215
  end
end
