object frmMain: TfrmMain
  Left = 0
  Top = 0
  ClientHeight = 669
  ClientWidth = 1096
  Caption = 'frmMain'
  OldCreateOrder = False
  Menu = unmnmnMain
  MonitoredKeys.Keys = <>
  PixelsPerInch = 96
  TextHeight = 13
  object undbgrdClient: TUniDBGrid
    Left = 0
    Top = 56
    Width = 1088
    Height = 361
    Hint = ''
    LoadMask.Message = 'Loading data...'
    TabOrder = 0
  end
  object unmdbnvgtrClient: TUnimDBNavigator
    Left = 0
    Top = 32
    Width = 1088
    Height = 23
    Hint = ''
    VisibleButtons = [nbFirst, nbPrior, nbNext, nbLast, nbInsert, nbDelete, nbPost, nbCancel]
    TabOrder = 1
  end
  object unmnmnMain: TUniMainMenu
    Left = 24
    Top = 424
    object unmntmOption: TUniMenuItem
      Caption = #1054#1087#1094#1080#1080
      object unmntmMode: TUniMenuItem
        Caption = #1055#1077#1088#1077#1081#1090#1080' '#1074' '#1088#1072#1073#1086#1095#1080#1081' '#1088#1077#1078#1080#1084
      end
    end
    object unmntmHelp: TUniMenuItem
      Caption = #1055#1086#1084#1086#1097#1100
    end
  end
end
