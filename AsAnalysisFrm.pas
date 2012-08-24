unit AsAnalysisFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, CheckLst, Buttons;

type
  TAsAnalysisForm = class(TForm)
    btn1: TBitBtn;
    lstAsAnalysis: TListBox;
    btnNewAnalis: TButton;
    procedure FormShow(Sender: TObject);
    procedure btnNewAnalisClick(Sender: TObject);
  private
    { Private declarations }
    procedure FillList();
  public
    { Public declarations }
  end;

var
  AsAnalysisForm: TAsAnalysisForm;

implementation

uses DMU, DB, AnalysisFrm;

{$R *.dfm}

procedure TAsAnalysisForm.FillList;
begin
  lstAsAnalysis.Clear;
  with DM, tbTAnalysis do
    begin
      First;
      while not Eof do
        begin
          lstAsAnalysis.AddItem(strngfldTAnalysisTaTitle.Value,
            Pointer(atncfldTAnalysisTaID.Value));
          Next;
        end;
    end;
end;

procedure TAsAnalysisForm.FormShow(Sender: TObject);
begin
  FillList
end;

procedure TAsAnalysisForm.btnNewAnalisClick(Sender: TObject);
begin
  AnalysisForm.ShowModal;
  FillList
end;

end.
