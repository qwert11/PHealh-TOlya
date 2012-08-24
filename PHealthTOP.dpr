program PHealthTOP;

uses
  Forms,
  MainFrm in 'MainFrm.pas' {MainForm},
  DMU in 'DMU.pas' {DM: TDataModule},
  ChildFrm in 'Teikseira\ChildFrm.pas' {ChildForm},
  DBModeFrm in 'Teikseira\DbModeFrm.pas' {DBModeForm},
  DBNavStatFrm in 'Teikseira\DBNAVSTATFRM.pas' {DBNavStatForm},
  PeopleFrm in 'PeopleFrm.pas' {PeopleForm},
  MaladyFrm in 'MaladyFrm.pas' {MaladyForm},
  AnalysisFrm in 'AnalysisFrm.pas' {AnalysisForm},
  JournalComingsFrm in 'JournalComingsFrm.pas' {JournalComingsForm},
  CardPatientFrm in 'CardPatientFrm.pas' {CardPatientForm},
  AsAnalysisFrm in 'AsAnalysisFrm.pas' {AsAnalysisForm},
  Auto1 in 'Auto1.pas',
  LndmrkEpcrsFrm in 'LndmrkEpcrsFrm.pas' {LndmrkEpcrsForm},
  MedicationFrm in 'MedicationFrm.pas' {MedicationForm};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TMaladyForm, MaladyForm);
  Application.CreateForm(TAnalysisForm, AnalysisForm);
  Application.CreateForm(TCardPatientForm, CardPatientForm);
  Application.CreateForm(TAsAnalysisForm, AsAnalysisForm);
  Application.CreateForm(TLndmrkEpcrsForm, LndmrkEpcrsForm);
  Application.CreateForm(TMedicationForm, MedicationForm);
  //Application.CreateForm(TJournalComingsForm, JournalComingsForm);
  //Application.CreateForm(TChildForm, ChildForm);
  //Application.CreateForm(TDBModeForm, DBModeForm);
  //Application.CreateForm(TDBNavStatForm, DBNavStatForm);
  Application.CreateForm(TPeopleForm, PeopleForm);
  Application.Run;
end.
