unit DMU;

interface

uses
  SysUtils, Classes, DB, DBTables, Variants;

type
  TDM = class(TDataModule)
    DB: TDatabase;
    tbPEOPLE: TTable;
    tbMaladyUnit: TTable;
    tbTAnalysis: TTable;
    tbAsAnalys: TTable;
    ds1: TDataSource;
    ds2: TDataSource;
    ds3: TDataSource;
    ds4: TDataSource;
    qrDispCard: TQuery;
    ds6: TDataSource;
    atncfldAsAnalysAaID: TAutoIncField;
    strngfldAsAnalysAaResult: TStringField;
    dtfldDispCardDcBegObsrv: TDateField;
    dtfldDispCardDcEndObsrv: TDateField;
    dtfldDispCardVDate: TDateField;
    strngfldDispCardPSurname: TStringField;
    strngfldDispCardPName: TStringField;
    strngfldDispCardPSurname_1: TStringField;
    strngfldDispCardPName_1: TStringField;
    strngfldDispCardMuTitle: TStringField;
    strngfldDispCardVComplaint: TStringField;
    dtfldDispCardVReDate: TDateField;
    intgrfldDispCardVID: TIntegerField;
    strngfldDispCardPPatronymic: TStringField;
    strngfldDispCardPPatronymic_1: TStringField;
    atncfldTAnalysisTaID: TAutoIncField;
    strngfldTAnalysisTaTitle: TStringField;
    atncfldPEOPLEPeopleID: TAutoIncField;
    strngfldPEOPLEPSurname: TStringField;
    strngfldPEOPLEPName: TStringField;
    strngfldPEOPLEPPatronymic: TStringField;
    intgrfldDispCardPeopleID: TIntegerField;
    intgrfldDispCardPeopleID_1: TIntegerField;
    qryQuery: TQuery;
    intgrfldDispCardDcID: TIntegerField;
    intgrfldAsAnalysAaVisit: TIntegerField;
    intgrfldAsAnalysAaTAnalysis: TIntegerField;
    strngfldAsAnalysTitle: TStringField;
    qryQuery2: TQuery;
    atncfldMaladyUnitMuID: TAutoIncField;
    strngfldMaladyUnitMuTitle: TStringField;
    strngfldMaladyUnitMuInfo: TStringField;
    intgrfldDispCardMuID: TIntegerField;
    intgrfldMaladyUnitMuPerObsrv: TIntegerField;
    intgrfldMaladyUnitMuIntervalReturn: TIntegerField;
    dtfldDispCardPBirthDay: TDateField;
    dtfldPEOPLEPBirthDay: TDateField;
    strngfldMaladyUnitMuCodeDiagn: TStringField;
    mfldMaladyUnitMuTreatStndrd: TMemoField;
    mfldDispCardTrInstruction: TMemoField;
    tblPlannedSurvey: TTable;
    ds5: TDataSource;
    atncfldPlannedSurveyPsID: TAutoIncField;
    intgrfldPlannedSurveyPsTaID: TIntegerField;
    intgrfldPlannedSurveyPsMuID: TIntegerField;
    strngfldPlannedSurveyTAnalis: TStringField;
    mfldDispCardCmTitle: TMemoField;
    strngfldDispCardMuCodeDiagn: TStringField;
    tblLndmrkEpcrs: TTable;
    ds7: TDataSource;
    atncfldLndmrkEpcrsLeID: TAutoIncField;
    intgrfldLndmrkEpcrsLePplID: TIntegerField;
    dtfldLndmrkEpcrsLeDate: TDateField;
    mfldLndmrkEpcrsLeInfo: TMemoField;
    strngfldLndmrkEpcrsPplName: TStringField;
    strngfldLndmrkEpcrsPplSurname: TStringField;
    strngfldLndmrkEpcrsPplPatronymic: TStringField;
    dtfldLndmrkEpcrsPplBirthDay: TDateField;
    qryQuery3: TQuery;
    strngfldPEOPLEPContacts: TStringField;
    strngfldPEOPLEPAddress: TStringField;
    tblMEDICATION: TTable;
    ds8: TDataSource;
    procedure strngfldDispCardPSurnameGetText(Sender: TField;
      var Text: String; DisplayText: Boolean);
    procedure strngfldDispCardPSurname_1GetText(Sender: TField;
      var Text: String; DisplayText: Boolean);
    procedure ExecuteDispCard(D: TDateTime);
    procedure mfldDispCardTrInstructionGetText(Sender: TField;
      var Text: String; DisplayText: Boolean);
    procedure mfldDispCardCmTitleGetText(Sender: TField; var Text: String;
      DisplayText: Boolean);
    procedure strngfldLndmrkEpcrsPplNameGetText(Sender: TField;
      var Text: String; DisplayText: Boolean);
    procedure tbPEOPLEBeforeDelete(DataSet: TDataSet);
    procedure tbMaladyUnitBeforeDelete(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DM: TDM;

implementation

uses Auto1;

{$R *.dfm}

procedure TDM.ExecuteDispCard(D: TDateTime);
begin
  with DM, qrDispCard do
    begin
      Close;
      ParamByName('Date').Value := D;
      Open;
    end;
end;

procedure TDM.strngfldDispCardPSurnameGetText(Sender: TField;
  var Text: String; DisplayText: Boolean);
begin
  Text := strngfldDispCardPSurname.Value + ' ' + strngfldDispCardPName.Value +
    ' ' + strngfldDispCardPPatronymic.Value + ' (' + dtfldDispCardPBirthDay.AsString + ')'
end;

procedure TDM.strngfldDispCardPSurname_1GetText(Sender: TField;
  var Text: String; DisplayText: Boolean);
  function initials(s: string): string;
  begin
    Result := '';
    if s <> '' then
      Result := s[1] + '.'
  end;
begin
  Text := strngfldDispCardPSurname_1.Value + ' ' + initials(strngfldDispCardPName_1.Value) +
    initials(strngfldDispCardPPatronymic_1.Value)
end;

function grabmemoasstring(thefield: tmemofield): string;
begin
  if thefield.isnull then
   result := ''
  else
   with tblobstream.create(thefield, bmread) do
    begin
      SetLength(Result, 255);
      if size >= 255 then
      begin
         read(result[1], 255);
         SetLength(result, 255);
       end
      else
      begin
       read(result[1], size);
       SetLength(result, size);
      end;
       free;
      while pos(#10, result) > 0 do
       result[pos(#10, result)] := ' ';
      while pos(#13, result) > 0 do
       result[pos(#13, result)] := ' ';
    end;
end;

procedure TDM.mfldDispCardTrInstructionGetText(Sender: TField;
  var Text: String; DisplayText: Boolean);
begin
  Text := grabmemoasstring(tmemofield(sender));
end;

procedure TDM.mfldDispCardCmTitleGetText(Sender: TField; var Text: String;
  DisplayText: Boolean);
begin
  Text := grabmemoasstring(tmemofield(sender));
end;

procedure TDM.strngfldLndmrkEpcrsPplNameGetText(Sender: TField;
  var Text: String; DisplayText: Boolean);
begin
  Text := strngfldLndmrkEpcrsPplSurname.Value + ' ' +
    strngfldLndmrkEpcrsPplName.Value + ' ' +
      strngfldLndmrkEpcrsPplPatronymic.Value + '(' + dtfldLndmrkEpcrsPplBirthDay.AsString + ')'
end;

procedure TDM.tbPEOPLEBeforeDelete(DataSet: TDataSet);
begin
  { TODO 5 -otbPEOPLEBeforeDelete -cDELETE : удаление из табл. tbPeople }
  quQuery('SELECT DcID FROM DispensaryCard WHERE DcPatient = ' +
    atncfldPEOPLEPeopleID.AsString);
  with qryQuery do
    begin
      First;
      while not Eof do
      begin
        quQuery2('SELECT VID FROM VISIT WHERE VDispCard = ' + qryQuery.Fields[0].AsString);
        qryQuery2.First;
        while not qryQuery2.Eof do
          begin
            quQuery3('DELETE FROM AssignedAnalysises WHERE AaVisit = ' + qryQuery2.Fields[0].AsString);
            quQuery3('DELETE FROM CompanyMalady WHERE CmVID = ' + qryQuery2.Fields[0].AsString);
            quQuery3('DELETE FROM TREAT WHERE TrVID = ' + qryQuery2.Fields[0].AsString);
            quQuery3('DELETE FROM VISIT WHERE VID = ' + qryQuery2.Fields[0].AsString);
            quQuery3('DELETE FROM LandmarkEpicrisis WHERE LePplID = ' + qryQuery.Fields[0].AsString);
            qryQuery2.Next; // удаляем из VISIT
          end;
        quQuery3('DELETE FROM DispensaryCard WHERE DcID = ' + qryQuery.Fields[0].AsString);
        qryQuery.Next; // удаляем из DispensaryCard
      end;
    end;
end;

procedure TDM.tbMaladyUnitBeforeDelete(DataSet: TDataSet);
begin
  { TODO 5 otbMaladyUnitBeforeDelete -cDELETE : удудаление из табл. tbMaladyUnit -> PlanedSurvey и TypeAnalisies }
  if quQuery('SELECT COUNT(Maladyunit.MuID) FROM "MaladyUnit.DB" Maladyunit INNER JOIN "DispensaryCard.DB" Dispensarycard ON  (Dispensarycard.DcMaladyUnit = Maladyunit.MuID)') > 0 then
    Abort;
  with tblPlannedSurvey do
    begin
      First;
      while not Eof do
        Delete;
    end;
end;

end.
