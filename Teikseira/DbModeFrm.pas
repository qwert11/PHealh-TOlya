{
Copyright © 1999 by Delphi 5 Developer's Guide - Xavier Pacheco and Steve Teixeira
}

unit DBModeFrm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ChildFrm;

type

  TFormMode = (fmBrowse, fmInsert, fmEdit);

  TDBModeForm = class(TChildForm)
  private
    FFormMode      : TFormMode;
    FOnSetFormMode : TNotifyEvent;
  protected
    procedure SetFormMode(AValue: TFormMode); virtual;
    function  GetFormMode: TFormMode; virtual;
  public
    property FormMode: TFormMode read GetFormMode write SetFormMode;
  published
    property OnSetFormMode: TNotifyEvent read FOnSetFormMode write FOnSetFormMode;
  end;

var
  DBModeForm: TDBModeForm;

implementation

{$R *.DFM}

procedure TDBModeForm.SetFormMode(AValue: TFormMode);
begin
  FFormMode := AValue;
  if Assigned(FOnSetFormMode) then
    FOnSetFormMode(self);
end;

function TDBModeForm.GetFormMode: TFormMode;
begin
  Result := FFormMode;
end;

end.
