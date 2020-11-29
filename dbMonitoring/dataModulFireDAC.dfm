object DM_fireDAC: TDM_fireDAC
  OldCreateOrder = False
  Height = 414
  Width = 509
  object con_db: TFDConnection
    Params.Strings = (
      'User_Name=sysdba'
      'Password=masterkey'
      'Database=C:\DB\SCADALOGGER.GDB'
      'Protocol=TCPIP'
      'Server=localhost'
      'CharacterSet=UTF8'
      'DriverID=FB')
    TxOptions.ReadOnly = True
    Connected = True
    LoginPrompt = False
    Transaction = fdtrnsctnOne_db
    Left = 12
    Top = 66
  end
  object fdphysfbdrvrlnk_db: TFDPhysFBDriverLink
    VendorLib = 'C:\Program Files (x86)\Firebird\Firebird_2_5\bin\fbclient.dll'
    Left = 92
    Top = 76
  end
  object fdtrnsctnOne_db: TFDTransaction
    Options.ReadOnly = True
    Options.EnableNested = False
    Connection = con_db
    Left = 8
    Top = 124
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
    Left = 170
    Top = 34
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
    object intgrfldLog_dbID: TIntegerField
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object wdstrngfldLog_dbGUID: TWideStringField
      FieldName = 'GUID'
      Origin = 'GUID'
      Required = True
      Size = 45
    end
    object sqltmstmpfldLog_dbREG_DATE: TSQLTimeStampField
      FieldName = 'REG_DATE'
      Origin = 'REG_DATE'
      Required = True
    end
    object wdstrngfldLog_dbIP: TWideStringField
      FieldName = 'IP'
      Origin = 'IP'
      Required = True
      Size = 15
    end
    object sqltmstmpfldLog_dbLAST_ACCESS: TSQLTimeStampField
      FieldName = 'LAST_ACCESS'
      Origin = 'LAST_ACCESS'
      Required = True
    end
    object wdstrngfldLog_dbSCADAVERSION: TWideStringField
      FieldName = 'SCADAVERSION'
      Origin = 'SCADAVERSION'
      Required = True
      Size = 64
    end
  end
  object fdqryLog_mod: TFDQuery
    Connection = con_db
    SQL.Strings = (
      'select COUNT(*), SCADAVERSION  from IDS'
      'where ip <>  :p1 and  last_access  > :p2'
      ' group by SCADAVERSION'
      ' order by 2')
    Left = 89
    Top = 24
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
    object intgrfldLog_modCOUNT: TIntegerField
      AutoGenerateValue = arDefault
      FieldName = 'COUNT'
      Origin = '"COUNT"'
      ProviderFlags = []
      ReadOnly = True
    end
    object wdstrngfldLog_modSCADAVERSION: TWideStringField
      FieldName = 'SCADAVERSION'
      Origin = 'SCADAVERSION'
      Required = True
      Size = 64
    end
  end
  object fdqry_countClient: TFDQuery
    Connection = con_db
    Transaction = fdtrnsctnOne_db
    SQL.Strings = (
      'select COUNT(*) as userCount from IDS'
      'where ip <>  :p1 and  last_access  > :p2')
    Left = 273
    Top = 15
    ParamData = <
      item
        Name = 'P1'
        DataType = ftWideString
        ParamType = ptInput
        Size = 15
        Value = Null
      end
      item
        Name = 'P2'
        DataType = ftTimeStamp
        ParamType = ptInput
      end>
  end
  object fdqryParam: TFDQuery
    Connection = con_db
    Transaction = fdtrnsctnOne_db
    SQL.Strings = (
      'SELECT DISTINCT PARAM FROM EVENTS JOIN IDS ON CL_ID = IDS.ID'
      ' WHERE IDS.ID = :P')
    Left = 411
    Top = 79
    ParamData = <
      item
        Name = 'P'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
  end
  object fdqry_Chart_Par: TFDQuery
    Connection = con_db
    Transaction = fdtrnsctnOne_db
    SQL.Strings = (
      
        'SELECT PARAM "'#1055#1040#1056#1040#1052#1045#1058#1056'" , VALUE_INT "'#1047#1053#1040#1063#1045#1053#1048#1045'" , REC_TIME "'#1042#1056#1045#1052#1071 +
        '" , CL_ID "'#1055#1054#1051#1068#1047#1054#1042#1040#1058#1045#1051#1068'"'
      'FROM EVENTS'
      
        'WHERE PARAM =:P AND REC_TIME BETWEEN :TBEGIN AND :TEND AND CL_ID' +
        ' = :P1')
    Left = 314
    Top = 94
    ParamData = <
      item
        Name = 'P'
        DataType = ftWideString
        ParamType = ptInput
        Size = 32
        Value = Null
      end
      item
        Name = 'TBEGIN'
        DataType = ftTimeStamp
        ParamType = ptInput
      end
      item
        Name = 'TEND'
        DataType = ftTimeStamp
        ParamType = ptInput
      end
      item
        Name = 'P1'
        DataType = ftInteger
        ParamType = ptInput
      end>
  end
end
