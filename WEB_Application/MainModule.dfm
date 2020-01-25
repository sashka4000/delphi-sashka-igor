object UniMainModule: TUniMainModule
  OldCreateOrder = False
  OnCreate = UniGUIMainModuleCreate
  MonitoredKeys.Keys = <>
  Height = 426
  Width = 635
  object fdmtblOne: TFDMemTable
    Active = True
    FieldDefs = <
      item
        Name = 'ID'
        DataType = ftInteger
      end
      item
        Name = 'UserName'
        DataType = ftString
        Size = 30
      end
      item
        Name = 'Login'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'Password'
        DataType = ftString
        Size = 20
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
    Top = 40
  end
  object con1: TFDConnection
    Params.Strings = (
      'DriverID=SQLite')
    LoginPrompt = False
    Left = 96
    Top = 40
  end
  object fdlclsql: TFDLocalSQL
    Connection = con1
    Active = True
    DataSets = <
      item
        DataSet = fdmtblOne
        Name = 'Tb1'
      end>
    Left = 160
    Top = 40
  end
  object fdqryfdq: TFDQuery
    Connection = con1
    Left = 216
    Top = 40
  end
  object fdstnstrgjsnlnk1: TFDStanStorageJSONLink
    Left = 56
    Top = 120
  end
end
