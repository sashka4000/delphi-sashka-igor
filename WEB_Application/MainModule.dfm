object UniMainModule: TUniMainModule
  OldCreateOrder = False
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
  object frxdbdtstOne: TfrxDBDataset
    UserName = 'frxDBDataset1'
    CloseDataSource = False
    DataSet = fdmtblOne
    BCDToCurrency = False
    Left = 40
    Top = 104
  end
  object ds1: TDataSource
    DataSet = fdmtblOne
    Left = 136
    Top = 56
  end
end
