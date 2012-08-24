unit LndmrkEpcrsFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DBNAVSTATFRM, StdCtrls, DBCtrls, Grids, DBGrids, ImgList, Menus,
  ComCtrls, ToolWin;

type
  TLndmrkEpcrsForm = class(TDBNavStatForm)
    dbgrd1: TDBGrid;
    dbmmoLeInfo: TDBMemo;
    procedure dbgrd1EditButtonClick(Sender: TObject);
    procedure sbAcceptClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure sbCancelClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  LndmrkEpcrsForm: TLndmrkEpcrsForm;

implementation

uses DMU, PeopleFrm;

{$R *.dfm}

procedure TLndmrkEpcrsForm.dbgrd1EditButtonClick(Sender: TObject);
begin
  inherited;
  //if dbgrd1.Columns[1].FieldName = 'PplName' then
  PeopleForm.ShowModal;
  with DM, tblLndmrkEpcrs do
  if PeopleForm.ModalResult = mrOk then
    begin
      Insert;
      dtfldLndmrkEpcrsLeDate.Value := Date;
      intgrfldLndmrkEpcrsLePplID.Value := atncfldPEOPLEPeopleID.Value;
    end;  
end;

procedure TLndmrkEpcrsForm.sbAcceptClick(Sender: TObject);
begin
  inherited;
  DM.tblLndmrkEpcrs.Post
end;

procedure TLndmrkEpcrsForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  with DM, tblLndmrkEpcrs do
    Cancel
end;

procedure TLndmrkEpcrsForm.sbCancelClick(Sender: TObject);
begin
  inherited;
  DM.tblLndmrkEpcrs.Cancel
end;

end.
