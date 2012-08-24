unit CardPatientFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, Buttons, ExtCtrls, DBCtrls, CheckLst,
  ImgList;

type
  TTargetVisit = (tvMergency, tvPlanned, tvEdit);
  
  TCardPatientForm = class(TForm)
    lblFIOPatient: TLabel;
    lbl1: TLabel;
    lbl2: TLabel;
    btnPeople: TSpeedButton;
    dtpBOsrv: TDateTimePicker;
    lblMaladyUnit: TLabel;
    btnMaladyUnit: TSpeedButton;
    lbl4: TLabel;
    dtpEObsrv: TDateTimePicker;
    lbl5: TLabel;
    lbl6: TLabel;
    mmoComplaint: TMemo;
    lbl7: TLabel;
    mmoCmpnyMldyUnt: TMemo;
    lbl8: TLabel;
    dtpDateVisit: TDateTimePicker;
    lbl9: TLabel;
    dtpReDateVisit: TDateTimePicker;
    lstAsAnalysis: TListBox;
    lbl10: TLabel;
    btn1: TSpeedButton;
    btnOk: TBitBtn;
    lbl3: TLabel;
    lblDoctor: TLabel;
    btnDoctor: TSpeedButton;
    lbl12: TLabel;
    mmoTreat: TMemo;
    procedure btn1Click(Sender: TObject);
    procedure btnPeopleClick(Sender: TObject);
    procedure btnMaladyUnitClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    FTargetVisit: TTargetVisit;
  end;

var
  CardPatientForm: TCardPatientForm;

implementation

uses DMU, AsAnalysisFrm, PeopleFrm, MaladyFrm, Auto1;

{$R *.dfm}

procedure TCardPatientForm.btn1Click(Sender: TObject);
begin
  AsAnalysisForm.ShowModal;
  if AsAnalysisForm.ModalResult = mrOk then
    AsAnalysisForm.lstAsAnalysis.CopySelection(lstAsAnalysis);
end;

procedure TCardPatientForm.btnPeopleClick(Sender: TObject);
begin
  PeopleForm.ShowModal;
  with PeopleForm, DM do
  if ModalResult = mrOk then
    begin
      lblFIOPatient.Caption := strngfldPEOPLEPSurname.Value + ' ' +
        strngfldPEOPLEPName.Value + ' ' + strngfldPEOPLEPPatronymic.Value + '(' +
          dtfldPEOPLEPBirthDay.AsString + ')';
      lblFIOPatient.Tag := atncfldPEOPLEPeopleID.Value;
    end;
end;

procedure TCardPatientForm.btnMaladyUnitClick(Sender: TObject);
begin
  MaladyForm.ShowModal;
  with MaladyForm, DM, tblPlannedSurvey do
    if ModalResult = mrOk then
      begin
        lblMaladyUnit.Caption := strngfldMaladyUnitMuTitle.Value + '(МКБ: ' +
          strngfldMaladyUnitMuCodeDiagn.Value + ')';
        lblMaladyUnit.Tag := atncfldMaladyUnitMuID.Value;
        mmoTreat.Clear;
        mmoTreat.Text := Trim(mfldMaladyUnitMuTreatStndrd.Value);
        dtpEObsrv.Date := dtpBOsrv.Date + intgrfldMaladyUnitMuPerObsrv.Value;
        dtpReDateVisit.Date := dtpDateVisit.Date +
          intgrfldMaladyUnitMuIntervalReturn.Value;

        lstAsAnalysis.Clear;  
        First;
        while not Eof do
          begin
            lstAsAnalysis.AddItem(strngfldPlannedSurveyTAnalis.Value,
              Pointer(intgrfldPlannedSurveyPsTaID.Value));
            Next;
          end;
      end;  
end;

procedure TCardPatientForm.FormShow(Sender: TObject);
begin
  with DM do
  case FTargetVisit of
    tvMergency:
      begin
        DefTakingDoc;
        lblDoctor.Caption := strngfldPEOPLEPSurname.Value + ' ' +
          strngfldPEOPLEPName.Value[1] + '.' +
            strngfldPEOPLEPPatronymic.Value[1] + '.';
        lblDoctor.Tag := atncfldPEOPLEPeopleID.Value;
        lblFIOPatient.Caption := '';
        btnPeople.Enabled := True;
        lblMaladyUnit.Caption := '';
        btnMaladyUnit.Enabled := True;
        dtpBOsrv.Date := Date;
        dtpBOsrv.Enabled := True;
        dtpEObsrv.Date := Date;
        dtpDateVisit.Date := Date;
        dtpReDateVisit.Date := Date;
        mmoComplaint.Clear;
        mmoCmpnyMldyUnt.Clear;
        mmoTreat.Clear;
        lstAsAnalysis.Clear;
      end;
    tvPlanned:
      begin
        lblDoctor.Caption := strngfldDispCardPSurname_1.Value + ' ' + strngfldDispCardPName_1.Value[1] +
          '.' + strngfldDispCardPPatronymic_1.Value[1] + '.';
        lblDoctor.Tag := intgrfldDispCardPeopleID_1.Value;
        lblFIOPatient.Caption := strngfldDispCardPSurname.Value + ' ' + strngfldDispCardPName.Value +
          ' ' + strngfldDispCardPPatronymic.Value + '(' + dtfldDispCardPBirthDay.AsString + ')';
        btnPeople.Enabled := False;
        lblMaladyUnit.Caption := strngfldDispCardMuTitle.Value + '(МКБ: ' +
          strngfldDispCardMuCodeDiagn.Value + ')';
        btnMaladyUnit.Enabled := False;
        dtpBOsrv.Date := dtfldDispCardDcBegObsrv.Value;
        dtpBOsrv.Enabled := False;
        dtpEObsrv.Date := dtfldDispCardDcEndObsrv.Value;
        dtpDateVisit.Date := Date;

        tbMaladyUnit.Locate('MuID', intgrfldDispCardMuID.Value, []);
        dtpReDateVisit.Date := Date + intgrfldMaladyUnitMuIntervalReturn.Value;
        mmoComplaint.Clear;
        mmoCmpnyMldyUnt.Clear;
        mmoCmpnyMldyUnt.Text := Trim(mfldDispCardCmTitle.Value);
        mmoTreat.Clear;
        mmoTreat.Text := Trim(mfldDispCardTrInstruction.Value);

        // заполняем список
        lstAsAnalysis.Clear;
        with DM, tblPlannedSurvey do
          begin
            First;
            while not Eof do
              begin
                lstAsAnalysis.AddItem(strngfldPlannedSurveyTAnalis.Value,
                  Pointer(intgrfldPlannedSurveyPsTaID.Value));
                Next;
              end;
          end;
      end;
    tvEdit:
      begin
        lblDoctor.Caption := strngfldDispCardPSurname_1.Value + ' ' + strngfldDispCardPName_1.Value[1] +
          '.' + strngfldDispCardPPatronymic_1.Value[1] + '.';
        lblDoctor.Tag := intgrfldDispCardPeopleID_1.Value;

        lblFIOPatient.Caption := strngfldDispCardPSurname.Value + ' ' + strngfldDispCardPName.Value +
          ' ' + strngfldDispCardPPatronymic.Value + '(' + dtfldDispCardPBirthDay.AsString + ')';
        lblFIOPatient.Tag := intgrfldDispCardPeopleID.Value;

        lblMaladyUnit.Caption := strngfldDispCardMuTitle.Value + '(МКБ: ' +
          strngfldDispCardMuCodeDiagn.Value + ')';
        lblMaladyUnit.Tag := intgrfldDispCardMuID.Value;

        dtpBOsrv.Date := dtfldDispCardDcBegObsrv.Value;

        dtpEObsrv.Date := dtfldDispCardDcEndObsrv.Value;

        dtpDateVisit.Date := dtfldDispCardVDate.Value;

        dtpReDateVisit.Date := dtfldDispCardVReDate.Value;

        mmoComplaint.Clear;
        mmoComplaint.Text := Trim(strngfldDispCardVComplaint.Value);
        mmoCmpnyMldyUnt.Clear;
        mmoCmpnyMldyUnt.Text := Trim(mfldDispCardCmTitle.Value);
        mmoTreat.Clear;
        mmoTreat.Text := Trim(mfldDispCardTrInstruction.Value);

        // назначенные анализы
        lstAsAnalysis.Clear;
        with DM, tbAsAnalys do
          begin
            First;
            while not Eof do
              begin
                lstAsAnalysis.AddItem(strngfldAsAnalysTitle.Value,
                  Pointer(intgrfldAsAnalysAaTAnalysis.Value));
                Next;
              end;
          end;
      end;  
  end;
end;

procedure TCardPatientForm.btnOkClick(Sender: TObject);
var
  DcID,
  VID,
  I: Integer;
begin
  ModalResult := 0;
  if lblFIOPatient.Caption = '' then
    Exit;
  if lblMaladyUnit.Caption = '' then
    Exit;
  if lblDoctor.Caption = '' then
    Exit;
    
  DM.DB.StartTransaction;
  with DM do
  try
    case FTargetVisit of
      tvMergency:
        begin
  {1}     quQuery('INSERT INTO DispensaryCard (DcPatient, DcMaladyUnit, DcBegObsrv, DcEndObsrv) VALUES (' +
            IntToStr(lblFIOPatient.Tag) + ', ' + IntToStr(lblMaladyUnit.Tag) + ', "' + DateToStr(dtpBOsrv.Date) +
              '", "' + DateToStr(dtpEObsrv.Date) + '")');
          DcID := quQuery('SELECT MAX(DcID) FROM DispensaryCard');
  {2}     quQuery('INSERT INTO VISIT (VDate, VDoctor, VComplaint, VReDate, VDispCard) VALUES ("' +
            DateToStr(dtpDateVisit.Date) + '", ' + IntToStr(lblDoctor.Tag) + ', "' + mmoComplaint.Text + '", "' +
              DateToStr(dtpReDateVisit.Date) + '", ' + IntToStr(DcID) + ')');
          VID := quQuery('SELECT MAX(VID) FROM VISIT');

  {3}     quQuery('INSERT INTO CompanyMalady (CmVID, CmTitle) VALUES (' + IntToStr(VID) + ', "'+ mmoCmpnyMldyUnt.Text +'")');

  {4}     quQuery('INSERT INTO TREAT (TrVID, TrInstruction) VALUES (' + IntToStr(VID) + ', "' + mmoTreat.Text + '")');

          for I := 0 to lstAsAnalysis.Count - 1 do
  {5}       quQuery('INSERT INTO AssignedAnalysises (AaVisit, AaTAnalysis) VALUES (' +
              IntToStr(VID) + ', ' + IntToStr(Integer(lstAsAnalysis.Items.Objects[I])) + ')');
        end;
      tvPlanned:
        begin
  {1}     quQuery('INSERT INTO VISIT (VDate, VDoctor, VComplaint, VReDate, VDispCard) VALUES ("' +
            DateToStr(dtpDateVisit.Date) + '", ' + IntToStr(lblDoctor.Tag) + ', "' + mmoComplaint.Text + '", "' +
              DateToStr(dtpReDateVisit.Date) + '", ' + intgrfldDispCardDcID.AsString + ')');
          VID := quQuery('SELECT MAX(VID) FROM VISIT');
  {2}     quQuery('INSERT INTO CompanyMalady (CmVID, CmTitle) VALUES (' + IntToStr(VID) + ', "'+ mmoCmpnyMldyUnt.Text +'")');
  {3}     quQuery('INSERT INTO TREAT (TrInstruction, TrVID) VALUES ("' +
            mmoTreat.Text + '", ' + IntToStr(VID) + ')');
          for I := 0 to lstAsAnalysis.Count - 1 do
  {4}       quQuery('INSERT INTO AssignedAnalysises (AaVisit, AaTAnalysis) VALUES (' +
              IntToStr(VID) + ', ' + IntToStr(Integer(lstAsAnalysis.Items.Objects[I])) + ')');
        end;
      tvEdit:
        begin
  {1}     quQuery('UPDATE DispensaryCard SET DcPatient = ' + IntToStr(lblFIOPatient.Tag) + ', DcMaladyUnit = ' + IntToStr(lblMaladyUnit.Tag) + ', DcBegObsrv = "' + DateToStr(dtpBOsrv.Date) +
            '", DcEndObsrv = "' + DateToStr(dtpEObsrv.Date) + '" WHERE DcID = ' + intgrfldDispCardDcID.AsString);
  {2}     quQuery('UPDATE VISIT SET VDate = "' + DateToStr(dtpDateVisit.Date) + '", VDoctor = ' + IntToStr(lblDoctor.Tag) +
            ', VComplaint = "' + mmoComplaint.Text + '", VReDate = "' + DateToStr(dtpReDateVisit.Date) +
              '" WHERE VID = ' + intgrfldDispCardVID.AsString);
  {3}     quQuery('UPDATE CompanyMalady SET CmTitle = "'+ mmoCmpnyMldyUnt.Text +'" WHERE CmVID = ' +
            intgrfldDispCardVID.AsString);

  {4}     quQuery('UPDATE TREAT SET TrInstruction = "' + mmoTreat.Text + '" WHERE TrVID = ' + intgrfldDispCardVID.AsString);

          quQuery('DELETE FROM AssignedAnalysises WHERE AaVisit = ' + intgrfldDispCardVID.AsString);
          for I := 0 to lstAsAnalysis.Count - 1 do
  {5}       quQuery('INSERT INTO AssignedAnalysises (AaVisit, AaTAnalysis) VALUES (' +
              intgrfldDispCardVID.AsString + ', ' + IntToStr(Integer(lstAsAnalysis.Items.Objects[I])) +  ')');
        end;  
    end;
    DB.Commit;
    ModalResult := 1;
  except
    DB.Rollback;
  end;
end;

end.
