unit JournalComingsFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DBNAVSTATFRM, ImgList, Menus, ComCtrls, ToolWin, ActnList,
  Grids, DBGrids, Buttons, StdCtrls, ExtCtrls, DB;

type
  TJournalComingsForm = class(TDBNavStatForm)
    actlst1: TActionList;
    actNewComing: TAction;
    actPlannedComing: TAction;
    mniNewComing: TMenuItem;
    mniPlannedComing: TMenuItem;
    btn1: TToolButton;
    btnNewComing: TToolButton;
    btnPlannedComing: TToolButton;
    dbgrdJComings: TDBGrid;
    pm1: TPopupMenu;
    mniNewComing1: TMenuItem;
    mniPlannedComing1: TMenuItem;
    pnlFind: TPanel;
    edtFindSurname: TEdit;
    btnFindMaladyUnit: TSpeedButton;
    actFindMaladyUnit: TAction;
    lblFindMaladyUnit: TLabel;
    dtp1: TDateTimePicker;
    dtpDate: TDateTimePicker;
    mniN3: TMenuItem;
    mniDelete: TMenuItem;
    dbgrd1: TDBGrid;
    btn2: TToolButton;
    btnPeople: TToolButton;
    procedure actNewComingExecute(Sender: TObject);
    procedure actPlannedComingExecute(Sender: TObject);
    procedure actPlannedComingUpdate(Sender: TObject);
    procedure sbDeleteClick(Sender: TObject);
    procedure actFindMaladyUnitExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure dtpDateChange(Sender: TObject);
    procedure lblFindMaladyUnitDblClick(Sender: TObject);
    procedure edtFindSurnameChange(Sender: TObject);
    procedure sbEditClick(Sender: TObject);
    procedure edtFindSurnameDblClick(Sender: TObject);
    procedure btnPeopleClick(Sender: TObject);
    procedure dbgrdJComingsDrawColumnCell(Sender: TObject;
      const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
  private
    { Private declarations }
    procedure FilterDispCard;
  public
    { Public declarations }
  end;

var
  JournalComingsForm: TJournalComingsForm;

implementation

uses DMU, CardPatientFrm, Auto1, MaladyFrm, PeopleFrm;

{$R *.dfm}

procedure TJournalComingsForm.actNewComingExecute(Sender: TObject);
begin
  inherited;
  CardPatientForm.FTargetVisit := tvMergency;
  CardPatientForm.ShowModal;
  if CardPatientForm.ModalResult = mrOk then
    begin
      DM.qrDispCard.Close;
      DM.qrDispCard.Open;
    end;

end;


procedure TJournalComingsForm.actPlannedComingExecute(Sender: TObject);
begin
  inherited;
  CardPatientForm.FTargetVisit := tvPlanned;
  CardPatientForm.ShowModal;
  if CardPatientForm.ModalResult = mrOk then
    begin
      DM.qrDispCard.Close;
      DM.qrDispCard.Open;
    end;
end;

procedure TJournalComingsForm.actPlannedComingUpdate(Sender: TObject);
begin
  inherited;
  (Sender as TAction).Enabled := Not DM.qrDispCard.IsEmpty
end;

procedure TJournalComingsForm.sbDeleteClick(Sender: TObject);
begin
  inherited;
  with DM, qryQuery do
  case MessageDlg('------Удаление записи------' + #13#10 + #13#10 +
    'YesToAll - удалит все записи' + #13#10 +
    'Yes - удалит данную запись' + #13#10 +
    'Cancel - отменяет удаление', mtWarning, [mbYes, mbYesToAll, mbCancel], 0) of
    mrYes:
      begin
        quQuery('DELETE FROM AssignedAnalysises WHERE AaVisit = ' + intgrfldDispCardVID.AsString);
        quQuery('DELETE FROM CompanyMalady WHERE CmVID = ' + intgrfldDispCardVID.AsString);
        quQuery('DELETE FROM TREAT WHERE TrVID = ' + intgrfldDispCardVID.AsString);
        quQuery('DELETE FROM VISIT WHERE VID = ' + intgrfldDispCardVID.AsString);
        if quQuery('SELECT COUNT(VID) FROM VISIT WHERE VDispCard = ' + intgrfldDispCardDcID.AsString) = 0 then
          quQuery('DELETE FROM DispensaryCard WHERE DcID = ' + intgrfldDispCardDcID.AsString);
        DM.qrDispCard.Close;
        DM.qrDispCard.Open;
      end;
    mrYesToAll:
      begin
        quQuery('SELECT VID FROM VISIT WHERE VDispCard = ' + intgrfldDispCardDcID.AsString);
        while not qryQuery.Eof do
          with qryQuery2 do
            begin
              Close;
              SQL.Clear;
              SQL.Add('DELETE FROM AssignedAnalysises WHERE AaVisit = ' + qryQuery.Fields[0].AsString);
              ExecSQL;
              SQL.Clear;
              SQL.Add('DELETE FROM CompanyMalady WHERE CmVID = ' + intgrfldDispCardVID.AsString);
              ExecSQL;
              SQL.Clear;
              SQL.Add('DELETE FROM TREAT WHERE TrVID = ' + intgrfldDispCardVID.AsString);
              ExecSQL;
              qryQuery.Next;
            end;
        quQuery('DELETE FROM VISIT WHERE VDispCard = ' + intgrfldDispCardDcID.AsString);
        quQuery('DELETE FROM DispensaryCard WHERE DcID = ' + intgrfldDispCardDcID.AsString);

        DM.qrDispCard.Close;
        DM.qrDispCard.Open;
      end;
  else ;
  end;
end;

procedure TJournalComingsForm.actFindMaladyUnitExecute(Sender: TObject);
begin
  inherited;
  MaladyForm.ShowModal;
  with DM do
  if MaladyForm.ModalResult = mrOk then
    begin
      lblFindMaladyUnit.Caption := strngfldMaladyUnitMuTitle.AsString;
      lblFindMaladyUnit.Tag := atncfldMaladyUnitMuID.Value;
      FilterDispCard
    end;    
end;

procedure TJournalComingsForm.FormShow(Sender: TObject);
begin
  inherited;
  dtpDate.Date := Date;
  DM.ExecuteDispCard(dtpDate.Date);
  if not TestReferenceWholeness then
    MessageDlg('Нарушена ссылочная целостность обратитесь к разработчику',
      mtError, [mbOK], 0);
  FilterDispCard;
end;

procedure TJournalComingsForm.FilterDispCard;
  procedure AddF(var F: string; const s: string);
  begin
    if (F <> '') and (s <> '') then
      F := F + ' AND ';
    if s <> '' then
      F := F + s;
  end;
var
  F: string;
begin
  F := '';
  with DM, qrDispCard do
  begin
    Filtered := False;
    if lblFindMaladyUnit.Caption <> '' then
      AddF(F, 'MuID = ' + IntToStr(lblFindMaladyUnit.Tag));
    if edtFindSurname.Text <> '' then
      AddF(F, 'PSurname = ''' + edtFindSurname.Text + '*''');

    Filter := F;            
    Filtered := True;
  end;
end;

procedure TJournalComingsForm.dtpDateChange(Sender: TObject);
begin
  inherited;
  DM.ExecuteDispCard(dtpDate.Date);
  FilterDispCard
end;

procedure TJournalComingsForm.lblFindMaladyUnitDblClick(Sender: TObject);
begin
  inherited;
  lblFindMaladyUnit.Caption := '';
  FilterDispCard
end;

procedure TJournalComingsForm.edtFindSurnameChange(Sender: TObject);
begin
  inherited;
  FilterDispCard
end;

procedure TJournalComingsForm.sbEditClick(Sender: TObject);
begin
  inherited;
  CardPatientForm.FTargetVisit := tvEdit;
  CardPatientForm.ShowModal;
  if CardPatientForm.ModalResult = mrOk then
    begin
      DM.qrDispCard.Close;
      DM.qrDispCard.Open;
    end;
end;

procedure TJournalComingsForm.edtFindSurnameDblClick(Sender: TObject);
begin
  inherited;
  edtFindSurname.Clear;
  FilterDispCard
end;

procedure TJournalComingsForm.btnPeopleClick(Sender: TObject);
begin
  inherited;
  PeopleForm.ShowModal
end;

procedure TJournalComingsForm.dbgrdJComingsDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  inherited;
  with DM, dbgrdJComings.Canvas do
  if dtfldDispCardVDate.Value < Date then
    begin
      Brush.Color := clGray;
      FillRect(Rect);
      Font.Color := clWhite;
      if Column.Field.DataType in [ftString, ftMemo] then
      //В строковых полях текст прижимается влево
        TextOut(Rect.Left + 2, Rect.Top + 2, Column.Field.Text)
      else
      //В остальных полях – вправо
        TextOut(Rect.Right - TextWidth(Column.Field.Text) -
          2, Rect.Top + 2, Column.Field.Text)
    end
end;

end.
