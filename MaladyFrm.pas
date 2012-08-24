unit MaladyFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DBNAVSTATFRM, Grids, DBGrids, ImgList, Menus, ComCtrls, ToolWin,
  StdCtrls, DBCtrls, ExtCtrls;

type
  TMaladyForm = class(TDBNavStatForm)
    dbgrd1: TDBGrid;
    dbmmoMuTreatStndrd: TDBMemo;
    dbgrd2: TDBGrid;
    pnl1: TPanel;
    procedure dbgrd1DblClick(Sender: TObject);
    procedure sbAcceptClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MaladyForm: TMaladyForm;

implementation

uses DMU;

{$R *.dfm}

procedure TMaladyForm.dbgrd1DblClick(Sender: TObject);
begin
  inherited;
  ModalResult := 1
end;

procedure TMaladyForm.sbAcceptClick(Sender: TObject);
begin
  inherited;
  with DM.tbMaladyUnit do
    Delete;
end;

end.
