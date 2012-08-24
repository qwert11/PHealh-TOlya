unit AnalysisFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DBNAVSTATFRM, ImgList, Menus, ComCtrls, ToolWin, Grids, DBGrids;

type
  TAnalysisForm = class(TDBNavStatForm)
    dbgrd1: TDBGrid;
    procedure sbAcceptClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  AnalysisForm: TAnalysisForm;

implementation

uses DMU, Auto1;

{$R *.dfm}

procedure TAnalysisForm.sbAcceptClick(Sender: TObject);
begin
  inherited;
  with DM, tbTAnalysis do
    begin
      if quQuery('SELECT COUNT(AaID) FROM AssignedAnalysises WHERE AaTAnalysis = ' +
          atncfldTAnalysisTaID.AsString) = 0 then
        Exit;
      quQuery('DELETE FROM PlannedSurvey WHERE PsTaID = ' +
        atncfldTAnalysisTaID.AsString);
    end;

end;

end.
