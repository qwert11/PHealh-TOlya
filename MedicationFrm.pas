unit MedicationFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DBNAVSTATFRM, StdCtrls, DBCtrls, Grids, DBGrids, ImgList, Menus,
  ComCtrls, ToolWin;

type
  TMedicationForm = class(TDBNavStatForm)
    dbgrd1: TDBGrid;
    dbmmoMeDscrptn: TDBMemo;
    procedure sbDeleteClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MedicationForm: TMedicationForm;

implementation

uses DMU;

{$R *.dfm}

procedure TMedicationForm.sbDeleteClick(Sender: TObject);
begin
  inherited;
  with DM.tblMEDICATION do
    if not IsEmpty then
      Delete
end;

end.
