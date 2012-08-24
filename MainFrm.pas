unit MainFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, ExtCtrls, Menus, ComCtrls, ActnList, StdCtrls,
  JournalComingsFrm;

type
  TMainForm = class(TForm)
    mm1: TMainMenu;
    mniFile: TMenuItem;
    pnlParent: TPanel;
    stat1: TStatusBar;
    actlst1: TActionList;
    actShowJournalComings: TAction;
    mniShowJournalComings: TMenuItem;
    actNewPatient: TAction;
    actLndmrkEpcrs: TAction;
    mniLndmrkEpcrs: TMenuItem;
    mniMedication: TMenuItem;
    procedure actShowJournalComingsExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure actLndmrkEpcrsExecute(Sender: TObject);
    procedure mniMedicationClick(Sender: TObject);
  private
    { Private declarations }
    FJournalComingsForm: TJournalComingsForm;
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

uses DMU, LndmrkEpcrsFrm, MedicationFrm;

{$R *.dfm}

procedure TMainForm.actShowJournalComingsExecute(Sender: TObject);
begin
  if not Assigned(FJournalComingsForm) then
    begin
      FJournalComingsForm := TJournalComingsForm.Create(Application, pnlParent);
      //mm1.Merge(FJournalComingsForm.mmFormMenu);
      FJournalComingsForm.Show;
      pnlParent.Height := pnlParent.Height - 1
    end;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  if not Assigned(FJournalComingsForm) then
    begin
      FJournalComingsForm := TJournalComingsForm.Create(Application, pnlParent);
      //mm1.Merge(FJournalComingsForm.mmFormMenu);
      FJournalComingsForm.Show;
      pnlParent.Height := pnlParent.Height - 1
    end;
end;

procedure TMainForm.FormShow(Sender: TObject);
begin
  WindowState := wsMaximized
end;

procedure TMainForm.actLndmrkEpcrsExecute(Sender: TObject);
begin
  LndmrkEpcrsForm.ShowModal
end;

procedure TMainForm.mniMedicationClick(Sender: TObject);
begin
  MedicationForm.ShowModal
end;

end.
