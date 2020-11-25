object DM_fireDAC: TDM_fireDAC
  OldCreateOrder = False
  Height = 230
  Width = 273
  object con_db: TFDConnection
    Params.Strings = (
      'User_Name=sysdba'
      'Password=masterkey'
      'Database=D:\DB\SCADALOGGER.GDB'
      'Protocol=TCPIP'
      'Server=localhost'
      'CharacterSet=UTF8'
      'DriverID=FB')
    TxOptions.ReadOnly = True
    Connected = True
    LoginPrompt = False
    Transaction = fdtrnsctnOne_db
    Left = 107
    Top = 11
  end
  object fdphysfbdrvrlnk_db: TFDPhysFBDriverLink
    VendorLib = 'C:\Program Files (x86)\Firebird\Firebird_2_5\bin\fbclient.dll'
    Left = 21
    Top = 16
  end
  object fdtrnsctnOne_db: TFDTransaction
    Options.ReadOnly = True
    Options.EnableNested = False
    Connection = con_db
    Left = 52
    Top = 104
  end
  object fdqryLog_db: TFDQuery
    Connection = con_db
    Transaction = fdtrnsctnOne_db
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate, uvUpdateMode, uvFetchGeneratorsPoint, uvCheckUpdatable]
    UpdateOptions.EnableDelete = False
    UpdateOptions.EnableInsert = False
    UpdateOptions.EnableUpdate = False
    UpdateOptions.FetchGeneratorsPoint = gpNone
    SQL.Strings = (
      'select *  from IDS where ip <>  :p1 and'
      '  last_access  > :p2 order by SCADAVERSION')
    Left = 184
    Top = 97
    ParamData = <
      item
        Name = 'P1'
        ParamType = ptInput
      end
      item
        Name = 'P2'
        ParamType = ptInput
      end>
  end
  object fdqryLog_mod: TFDQuery
    Connection = con_db
    SQL.Strings = (
      'select COUNT(*), SCADAVERSION  from IDS'
      'where ip <>  :p1 and  last_access  > :p2'
      ' group by SCADAVERSION'
      ' order by 2')
    Left = 185
    Top = 39
    ParamData = <
      item
        Name = 'P1'
        DataType = ftWideString
        ParamType = ptInput
        Size = 15
      end
      item
        Name = 'P2'
        DataType = ftTimeStamp
        ParamType = ptInput
      end>
  end
end
