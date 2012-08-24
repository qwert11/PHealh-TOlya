object DM: TDM
  OldCreateOrder = False
  Left = 1098
  Top = 158
  Height = 565
  Width = 182
  object DB: TDatabase
    AliasName = 'P_Health'
    Connected = True
    DatabaseName = 'AAA'
    SessionName = 'Default'
    TransIsolation = tiDirtyRead
    Left = 136
    Top = 8
  end
  object tbPEOPLE: TTable
    Active = True
    BeforeDelete = tbPEOPLEBeforeDelete
    DatabaseName = 'AAA'
    SessionName = 'Default'
    TableName = 'PEOPLE.DB'
    Left = 24
    Top = 8
    object atncfldPEOPLEPeopleID: TAutoIncField
      DisplayWidth = 7
      FieldName = 'PeopleID'
      ReadOnly = True
    end
    object strngfldPEOPLEPSurname: TStringField
      DisplayWidth = 30
      FieldName = 'PSurname'
      Size = 25
    end
    object strngfldPEOPLEPName: TStringField
      DisplayWidth = 18
      FieldName = 'PName'
      Size = 25
    end
    object strngfldPEOPLEPPatronymic: TStringField
      DisplayWidth = 22
      FieldName = 'PPatronymic'
      Size = 25
    end
    object dtfldPEOPLEPBirthDay: TDateField
      DisplayWidth = 12
      FieldName = 'PBirthDay'
      Required = True
    end
    object strngfldPEOPLEPContacts: TStringField
      DisplayWidth = 32
      FieldName = 'PContacts'
      Size = 250
    end
    object strngfldPEOPLEPAddress: TStringField
      DisplayWidth = 51
      FieldName = 'PAddress'
      Size = 250
    end
  end
  object tbMaladyUnit: TTable
    Active = True
    BeforeDelete = tbMaladyUnitBeforeDelete
    DatabaseName = 'AAA'
    SessionName = 'Default'
    TableName = 'MaladyUnit.DB'
    Left = 24
    Top = 56
    object atncfldMaladyUnitMuID: TAutoIncField
      FieldName = 'MuID'
      ReadOnly = True
    end
    object strngfldMaladyUnitMuTitle: TStringField
      FieldName = 'MuTitle'
      Size = 100
    end
    object strngfldMaladyUnitMuInfo: TStringField
      FieldName = 'MuInfo'
      Size = 250
    end
    object intgrfldMaladyUnitMuPerObsrv: TIntegerField
      FieldName = 'MuPerObsrv'
    end
    object intgrfldMaladyUnitMuIntervalReturn: TIntegerField
      FieldName = 'MuIntervalReturn'
    end
    object strngfldMaladyUnitMuCodeDiagn: TStringField
      FieldName = 'MuCodeDiagn'
      Required = True
    end
    object mfldMaladyUnitMuTreatStndrd: TMemoField
      FieldName = 'MuTreatStndrd'
      BlobType = ftMemo
      Size = 240
    end
  end
  object tbTAnalysis: TTable
    Active = True
    DatabaseName = 'AAA'
    SessionName = 'Default'
    TableName = 'TypesAnalysis.db'
    Left = 24
    Top = 104
    object atncfldTAnalysisTaID: TAutoIncField
      FieldName = 'TaID'
      ReadOnly = True
    end
    object strngfldTAnalysisTaTitle: TStringField
      FieldName = 'TaTitle'
      Size = 50
    end
  end
  object tbAsAnalys: TTable
    Active = True
    DatabaseName = 'AAA'
    SessionName = 'Default'
    IndexName = 'Visit_AAnalysis'
    MasterFields = 'VID'
    MasterSource = ds6
    TableName = 'AssignedAnalysises.db'
    Left = 24
    Top = 152
    object atncfldAsAnalysAaID: TAutoIncField
      FieldName = 'AaID'
      ReadOnly = True
    end
    object strngfldAsAnalysAaResult: TStringField
      FieldName = 'AaResult'
      Size = 250
    end
    object intgrfldAsAnalysAaVisit: TIntegerField
      FieldName = 'AaVisit'
    end
    object intgrfldAsAnalysAaTAnalysis: TIntegerField
      FieldName = 'AaTAnalysis'
    end
    object strngfldAsAnalysTitle: TStringField
      FieldKind = fkLookup
      FieldName = 'Title'
      LookupDataSet = tbTAnalysis
      LookupKeyFields = 'TaID'
      LookupResultField = 'TaTitle'
      KeyFields = 'AaTAnalysis'
      Size = 100
      Lookup = True
    end
  end
  object ds1: TDataSource
    DataSet = tbPEOPLE
    Left = 72
    Top = 8
  end
  object ds2: TDataSource
    DataSet = tbMaladyUnit
    Left = 72
    Top = 56
  end
  object ds3: TDataSource
    DataSet = tbTAnalysis
    Left = 72
    Top = 104
  end
  object ds4: TDataSource
    DataSet = tbAsAnalys
    Left = 72
    Top = 152
  end
  object qrDispCard: TQuery
    DatabaseName = 'AAA'
    FilterOptions = [foCaseInsensitive]
    SessionName = 'Default'
    SQL.Strings = (
      
        'SELECT Dispensarycard.DcBegObsrv, Dispensarycard.DcEndObsrv, Vis' +
        'it.VDate, P1.PeopleID, P1.PSurname, P1.PName, P1.PPatronymic, P2' +
        '.PeopleID, P2.PSurname, P2.PName, P2.PPatronymic, Maladyunit.MuT' +
        'itle, Visit.VComplaint, Visit.VReDate, Visit.VID, Dispensarycard' +
        '.DcID, Maladyunit.MuID, P1.PBirthDay, Treat.TrInstruction, Compa' +
        'nymalady.CmTitle, Maladyunit.MuCodeDiagn'
      'FROM "DispensaryCard.DB" Dispensarycard'
      '   INNER JOIN "VISIT.DB" Visit'
      '   ON  (Dispensarycard.DcID = Visit.VDispCard)  '
      '   INNER JOIN "MaladyUnit.DB" Maladyunit'
      '   ON  (Dispensarycard.DcMaladyUnit = Maladyunit.MuID)  '
      '   INNER JOIN People P1'
      '   ON  (Dispensarycard.DcPatient = P1.PeopleID)  '
      '   INNER JOIN People P2'
      '   ON  (Visit.VDoctor = P2.PeopleID)  '
      '   FULL OUTER JOIN "TREAT.db" Treat'
      '   ON  (Visit.VID = Treat.TrVID)  '
      '   FULL OUTER JOIN "CompanyMalady.DB" Companymalady'
      '   ON  (Visit.VID = Companymalady.CmVID)  '
      'WHERE Visit.VDate = :Date OR Visit.VReDate = :Date')
    Left = 24
    Top = 256
    ParamData = <
      item
        DataType = ftDate
        Name = 'Date'
        ParamType = ptUnknown
      end
      item
        DataType = ftDate
        Name = 'Date'
        ParamType = ptUnknown
      end>
    object dtfldDispCardDcBegObsrv: TDateField
      FieldName = 'DcBegObsrv'
    end
    object dtfldDispCardDcEndObsrv: TDateField
      FieldName = 'DcEndObsrv'
    end
    object dtfldDispCardVDate: TDateField
      FieldName = 'VDate'
    end
    object strngfldDispCardPSurname: TStringField
      FieldName = 'PSurname'
      OnGetText = strngfldDispCardPSurnameGetText
      Size = 25
    end
    object strngfldDispCardPName: TStringField
      FieldName = 'PName'
      Size = 25
    end
    object strngfldDispCardPPatronymic: TStringField
      FieldName = 'PPatronymic'
      Size = 25
    end
    object strngfldDispCardPSurname_1: TStringField
      FieldName = 'PSurname_1'
      OnGetText = strngfldDispCardPSurname_1GetText
      Size = 25
    end
    object strngfldDispCardPName_1: TStringField
      FieldName = 'PName_1'
      Size = 25
    end
    object strngfldDispCardPPatronymic_1: TStringField
      FieldName = 'PPatronymic_1'
      Size = 25
    end
    object strngfldDispCardMuTitle: TStringField
      FieldName = 'MuTitle'
      Size = 100
    end
    object strngfldDispCardVComplaint: TStringField
      FieldName = 'VComplaint'
      Size = 250
    end
    object dtfldDispCardVReDate: TDateField
      FieldName = 'VReDate'
    end
    object intgrfldDispCardVID: TIntegerField
      FieldName = 'VID'
    end
    object intgrfldDispCardPeopleID: TIntegerField
      FieldName = 'PeopleID'
    end
    object intgrfldDispCardPeopleID_1: TIntegerField
      FieldName = 'PeopleID_1'
    end
    object intgrfldDispCardDcID: TIntegerField
      FieldName = 'DcID'
    end
    object intgrfldDispCardMuID: TIntegerField
      FieldName = 'MuID'
    end
    object dtfldDispCardPBirthDay: TDateField
      FieldName = 'PBirthDay'
    end
    object mfldDispCardTrInstruction: TMemoField
      FieldName = 'TrInstruction'
      OnGetText = mfldDispCardTrInstructionGetText
      BlobType = ftMemo
      Size = 240
    end
    object mfldDispCardCmTitle: TMemoField
      FieldName = 'CmTitle'
      OnGetText = mfldDispCardCmTitleGetText
      BlobType = ftMemo
      Size = 240
    end
    object strngfldDispCardMuCodeDiagn: TStringField
      FieldName = 'MuCodeDiagn'
    end
  end
  object ds6: TDataSource
    DataSet = qrDispCard
    Left = 72
    Top = 256
  end
  object qryQuery: TQuery
    DatabaseName = 'AAA'
    SessionName = 'Default'
    SQL.Strings = (
      'SELECT COUNT(Assignedanalysises.AaID)'
      'FROM "TypesAnalysis.DB" Typesanalysis'
      '   RIGHT OUTER JOIN "AssignedAnalysises.DB" Assignedanalysises'
      '   ON  (Typesanalysis.TaID = Assignedanalysises.AaTAnalysis)  '
      '   WHERE TaID IS NULL')
    Left = 24
    Top = 416
  end
  object qryQuery2: TQuery
    DatabaseName = 'AAA'
    SessionName = 'Default'
    Left = 72
    Top = 416
  end
  object tblPlannedSurvey: TTable
    Active = True
    DatabaseName = 'AAA'
    SessionName = 'Default'
    IndexName = 'PsMuID_MuID'
    MasterFields = 'MuID'
    MasterSource = ds2
    TableName = 'PlannedSurvey.db'
    Left = 24
    Top = 208
    object atncfldPlannedSurveyPsID: TAutoIncField
      FieldName = 'PsID'
      ReadOnly = True
    end
    object intgrfldPlannedSurveyPsTaID: TIntegerField
      FieldName = 'PsTaID'
    end
    object intgrfldPlannedSurveyPsMuID: TIntegerField
      FieldName = 'PsMuID'
    end
    object strngfldPlannedSurveyTAnalis: TStringField
      FieldKind = fkLookup
      FieldName = 'TAnalis'
      LookupDataSet = tbTAnalysis
      LookupKeyFields = 'TaID'
      LookupResultField = 'TaTitle'
      KeyFields = 'PsTaID'
      Size = 50
      Lookup = True
    end
  end
  object ds5: TDataSource
    DataSet = tblPlannedSurvey
    Left = 72
    Top = 208
  end
  object tblLndmrkEpcrs: TTable
    Active = True
    DatabaseName = 'AAA'
    SessionName = 'Default'
    TableName = 'LandmarkEpicrisis.db'
    Left = 24
    Top = 312
    object atncfldLndmrkEpcrsLeID: TAutoIncField
      FieldName = 'LeID'
      ReadOnly = True
    end
    object intgrfldLndmrkEpcrsLePplID: TIntegerField
      FieldName = 'LePplID'
    end
    object dtfldLndmrkEpcrsLeDate: TDateField
      FieldName = 'LeDate'
    end
    object mfldLndmrkEpcrsLeInfo: TMemoField
      FieldName = 'LeInfo'
      BlobType = ftMemo
      Size = 240
    end
    object strngfldLndmrkEpcrsPplName: TStringField
      FieldKind = fkLookup
      FieldName = 'PplName'
      LookupDataSet = tbPEOPLE
      LookupKeyFields = 'PeopleID'
      LookupResultField = 'PSurname'
      KeyFields = 'LePplID'
      OnGetText = strngfldLndmrkEpcrsPplNameGetText
      Size = 50
      Lookup = True
    end
    object strngfldLndmrkEpcrsPplSurname: TStringField
      FieldKind = fkLookup
      FieldName = 'PplSurname'
      LookupDataSet = tbPEOPLE
      LookupKeyFields = 'PeopleID'
      LookupResultField = 'PSurname'
      KeyFields = 'LePplID'
      Lookup = True
    end
    object strngfldLndmrkEpcrsPplPatronymic: TStringField
      FieldKind = fkLookup
      FieldName = 'PplPatronymic'
      LookupDataSet = tbPEOPLE
      LookupKeyFields = 'PeopleID'
      LookupResultField = 'PPatronymic'
      KeyFields = 'LePplID'
      Lookup = True
    end
    object dtfldLndmrkEpcrsPplBirthDay: TDateField
      FieldKind = fkLookup
      FieldName = 'PplBirthDay'
      LookupDataSet = tbPEOPLE
      LookupKeyFields = 'PeopleID'
      LookupResultField = 'PBirthDay'
      KeyFields = 'LePplID'
      Lookup = True
    end
  end
  object ds7: TDataSource
    DataSet = tblLndmrkEpcrs
    Left = 72
    Top = 312
  end
  object qryQuery3: TQuery
    DatabaseName = 'AAA'
    SessionName = 'Default'
    Left = 72
    Top = 464
  end
  object tblMEDICATION: TTable
    Active = True
    DatabaseName = 'AAA'
    SessionName = 'Default'
    IndexName = 'MeTitleFIND'
    TableName = 'MEDICATION.db'
    Left = 24
    Top = 360
  end
  object ds8: TDataSource
    DataSet = tblMEDICATION
    Left = 72
    Top = 360
  end
end
