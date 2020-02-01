object UniMainModule: TUniMainModule
  OldCreateOrder = False
  OnCreate = UniGUIMainModuleCreate
  MonitoredKeys.Keys = <>
  Height = 426
  Width = 635
  object fdmtblOne: TFDMemTable
    Active = True
    BeforePost = fdmtblOneBeforePost
    FieldDefs = <
      item
        Name = 'ID'
        DataType = ftAutoInc
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
      end
      item
        Name = 'Status'
        DataType = ftBoolean
      end
      item
        Name = 'Assignment'
        DataType = ftString
        Size = 50
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
    Connected = True
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
    Left = 24
    Top = 96
  end
  object ds1: TDataSource
    DataSet = fdmtblOne
    Left = 96
    Top = 96
  end
end
