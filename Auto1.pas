unit Auto1;

interface

uses
  SysUtils, Variants;

procedure DefTakingDoc;
function quQuery(const QUERY: string): Variant;
function quQuery2(const QUERY: string): Variant;
function quQuery3(const QUERY: string): Variant;
function TestReferenceWholeness(): Boolean;

implementation

uses DMU;

procedure DefTakingDoc;
begin
  with DM, tbPEOPLE do
    FindFirst;
end;

function quQuery(const QUERY: string): Variant;
  function ifDataType(): Boolean;
  begin
    Result := False;
    if  (Pos('delete', LowerCase(QUERY)) > 0) or
        (Pos('update', LowerCase(QUERY)) > 0) or
        (Pos('insert', LowerCase(QUERY)) > 0)
        then
      Result := True;
  end;
var
  i: Integer;
begin
  if QUERY = '' then
    Exit;
  Sleep(50);
  Result := null;
  with DM, qryQuery do
  begin
    Close;
    SQL.Clear;
    SQL.Add(QUERY);
    if ifDataType then
      begin
        ExecSQL;
        Exit;
      end;
    Open;
    if Fields.Count > 1 then
      begin
        if VarIsNull(Fields[0].AsVariant) then
          Exit;
        Result := VarArrayCreate([1, Fields.Count], varVariant);
        for i := VarArrayLowBound(Result, 1) to VarArrayHighBound(Result, 1) do
          Result[i] := Fields[i - 1].AsVariant
      end
    else
      Result := Fields[0].AsVariant
  end;
end;

function quQuery2(const QUERY: string): Variant;
  function ifDataType(): Boolean;
  begin
    Result := False;
    if  (Pos('delete', LowerCase(QUERY)) > 0) or
        (Pos('update', LowerCase(QUERY)) > 0) or
        (Pos('insert', LowerCase(QUERY)) > 0)
        then
      Result := True;
  end;
var
  i: Integer;
begin
  if QUERY = '' then
    Exit;
  Sleep(50);
  Result := null;
  with DM, qryQuery2 do
  begin
    Close;
    SQL.Clear;
    SQL.Add(QUERY);
    if ifDataType then
      begin
        ExecSQL;
        Exit;
      end;
    Open;
    if Fields.Count > 1 then
      begin
        if VarIsNull(Fields[0].AsVariant) then
          Exit;
        Result := VarArrayCreate([1, Fields.Count], varVariant);
        for i := VarArrayLowBound(Result, 1) to VarArrayHighBound(Result, 1) do
          Result[i] := Fields[i - 1].AsVariant
      end
    else
      Result := Fields[0].AsVariant
  end;
end;

function quQuery3(const QUERY: string): Variant;
  function ifDataType(): Boolean;
  begin
    Result := False;
    if  (Pos('delete', LowerCase(QUERY)) > 0) or
        (Pos('update', LowerCase(QUERY)) > 0) or
        (Pos('insert', LowerCase(QUERY)) > 0)
        then
      Result := True;
  end;
var
  i: Integer;
begin
  if QUERY = '' then
    Exit;
  Sleep(50);
  Result := null;
  with DM, qryQuery3 do
  begin
    Close;
    SQL.Clear;
    SQL.Add(QUERY);
    if ifDataType then
      begin
        ExecSQL;
        Exit;
      end;
    Open;
    if Fields.Count > 1 then
      begin
        if VarIsNull(Fields[0].AsVariant) then
          Exit;
        Result := VarArrayCreate([1, Fields.Count], varVariant);
        for i := VarArrayLowBound(Result, 1) to VarArrayHighBound(Result, 1) do
          Result[i] := Fields[i - 1].AsVariant
      end
    else
      Result := Fields[0].AsVariant
  end;
end;


       { DONE 1 -cTest : доделать проверку ссылочной целостности }
function TestReferenceWholeness(): Boolean;
begin
  Result := True;
  // ссылочная целостность Assignedanalysises + VISIT
  if quQuery('SELECT COUNT(Assignedanalysises.AaID) FROM "AssignedAnalysises.DB" Assignedanalysises LEFT OUTER JOIN "VISIT.DB" Visit ON  (Assignedanalysises.AaVisit = Visit.VID) WHERE VID IS NULL') > 0 then
    Result := False;

  // чего нет в DispCard для VISIT
  if quQuery('SELECT COUNT(Visit.VID) FROM "VISIT.DB" VISIT LEFT OUTER JOIN "DispensaryCard.DB" DC ON  (VISIT.VDispCard = DC.DcID) WHERE DcID IS NULL') > 0 then
    Result := False;
  // чего нет в VISIT для DispCard
  if quQuery('SELECT COUNT(DC.DcID) FROM "DispensaryCard.DB" DC	LEFT OUTER JOIN "VISIT.DB" VISIT ON  (VISIT.VDispCard = DC.DcID) WHERE VID IS NULL') > 0 then
    Result := False;
    
  // чего нет в MaladyUnit для DispCard
  if quQuery('SELECT COUNT(DC.DcID) FROM "DispensaryCard.DB" DC	LEFT OUTER JOIN "MaladyUnit.DB" MU	ON  (MU.MuID = DC.DcMaladyUnit)	WHERE MuID IS NULL') > 0 then
    Result := False;
  // чего нет в VISIT для CompanyMalady
  if quQuery('SELECT COUNT(Companymalady.CmID) FROM "VISIT.DB" Visit RIGHT OUTER JOIN "CompanyMalady.DB" Companymalady ON  (Companymalady.CmVID = Visit.VID) WHERE VID IS NULL') > 0 then
    Result := False;
  // чего нет в VISIT для Treat
  if quQuery('SELECT COUNT(Treat.TrID) FROM "VISIT.DB" Visit RIGHT OUTER JOIN "TREAT.db" Treat	ON  (Treat.TrVID = Visit.VID)	WHERE VID IS NULL') > 0 then
    Result := False;
  // чего нет в MaladyUnit для PlanedSurvey
  if quQuery('SELECT COUNT(Plannedsurvey.PsID) FROM "MaladyUnit.DB" Maladyunit RIGHT OUTER JOIN "PlannedSurvey.db" Plannedsurvey ON  (Maladyunit.MuID = Plannedsurvey.PsMuID)  WHERE MuID IS NULL') > 0 then
    Result := False;
  // чего нет в TypesAnalysis для Plannedsurvey
  if quQuery('SELECT COUNT( Plannedsurvey.PsID) FROM "PlannedSurvey.db" Plannedsurvey LEFT OUTER JOIN "TypesAnalysis.DB" Typesanalysis ON  (Typesanalysis.TaID = Plannedsurvey.PsTaID) WHERE TaID IS NULL') > 0 then
    Result := False;
  { DONE 1 -oTestReferenceWholeness -cTEST : целостность для PlanedSurvey -> MaladyUnit}
  // чего нет в PEOPLE для Landmarkepicrisis
  if quQuery('SELECT COUNT(Landmarkepicrisis.LeID) FROM "LandmarkEpicrisis.db" Landmarkepicrisis LEFT OUTER JOIN "PEOPLE.DB" People ON  (People.PeopleID = Landmarkepicrisis.LePplID) WHERE PeopleID IS NULL') > 0 then
    Result := False;
  { DONE 1 -oTestReferenceWholeness -cTEST : целостность для LandmarkEpicrisis -> PEOPLE}
  // чего нет в TypeAnalisis для AssignAnalis
  if quQuery('SELECT COUNT(Assignedanalysises.AaID) FROM "TypesAnalysis.DB" Typesanalysis RIGHT OUTER JOIN "AssignedAnalysises.DB" Assignedanalysises ON  (Typesanalysis.TaID = Assignedanalysises.AaTAnalysis) WHERE TaID IS NULL') > 0 then
    Result := False;
  { DONE 1 -oTestReferenceWholeness -cTEST : целостность для TypesAnalysies -> AssignAnalysis }
end;

end.
