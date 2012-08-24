unit PeopleFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DBNAVSTATFRM, ImgList, Menus, ComCtrls, ToolWin, Grids, DBGrids;

type
  TPeopleForm = class(TDBNavStatForm)
    dbgrd1: TDBGrid;
    procedure dbgrd1DblClick(Sender: TObject);
    procedure sbAcceptClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  PeopleForm: TPeopleForm;

implementation

uses DMU;

{$R *.dfm}

procedure TPeopleForm.dbgrd1DblClick(Sender: TObject);
begin
  inherited;
  ModalResult := 1
end;

procedure TPeopleForm.sbAcceptClick(Sender: TObject);
begin
  inherited;
  with DM do
    if MessageDlg('Вы действительно хотите удалить пациента ' +
        strngfldPEOPLEPSurname.AsString + ' ' + strngfldPEOPLEPName.AsString +
        strngfldPEOPLEPSurname.AsString +
        ' и всю его историю болезни',
        mtWarning, mbOKCancel, 0) <> mrOK then
      Exit;
  DM.tbPEOPLE.Delete;
end;

end.
