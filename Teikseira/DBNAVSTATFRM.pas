{
Copyright © 1999 by Delphi 5 Developer's Guide - Xavier Pacheco and Steve Teixeira
}

unit DBNavStatFrm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DbModeFrm, ComCtrls, ToolWin, Menus, ExtCtrls, ImgList;

type
  TDBNavStatForm = class(TDBModeForm)
    mmFormMenu: TMainMenu;
    mmiRecord: TMenuItem;
    mmiInsert: TMenuItem;
    mmiEdit: TMenuItem;
    mmiDelete: TMenuItem;
    mmiCancel: TMenuItem;
    N2: TMenuItem;
    mmiFind: TMenuItem;
    N1: TMenuItem;
    mmiFirst: TMenuItem;
    mmiPrevious: TMenuItem;
    mmiNext: TMenuItem;
    mmiLast: TMenuItem;
    tlbNavigationBar: TToolBar;
    sbAccept: TToolButton;
    sbCancel: TToolButton;
    tb1: TToolButton;
    sbInsert: TToolButton;
    sbDelete: TToolButton;
    tb2: TToolButton;
    sbFind: TToolButton;
    sbBrowse: TToolButton;
    tb3: TToolButton;
    sbFirst: TToolButton;
    sbPrev: TToolButton;
    sbNext: TToolButton;
    sbLast: TToolButton;
    stbStatusBar: TStatusBar;
    sbEdit: TToolButton;
    mmiFile: TMenuItem;
    ilNavigationBar: TImageList;
    procedure sbAcceptClick(Sender: TObject);
    procedure sbInsertClick(Sender: TObject);
    procedure sbEditClick(Sender: TObject);
  private
    { Private declarations }
  protected
    procedure Setbuttons; virtual;
    procedure SetStatusBar; virtual;
    procedure SetFormMode(AValue: TFormMode); override;
  public
    constructor Create(AOwner: TComponent); overload; override;
    constructor Create(AOwner: TComponent; AParent: TWinControl); overload;
    procedure Loaded; override;
    procedure SetToolBarParent(AParent: TWinControl);
    procedure SetStatusBarParent(AParent: TWinControl);
    procedure RefreshToolBar;
  end;

var
  DBNavStatForm: TDBNavStatForm;

implementation

{$R *.DFM}

{ TDBModeForm3 }

procedure TDBNavStatForm.SetFormMode(AValue: TFormMode);
begin
  inherited SetFormMode(AValue);
  SetButtons;
  SetStatusBar;
end;

procedure TDBNavStatForm.Setbuttons;

  procedure SetBrowseButtons;
  begin
    sbAccept.Enabled  := False;
    sbCancel.Enabled  := False;

    sbInsert.Enabled  := True;
    sbDelete.Enabled  := True; 
    sbEdit.Enabled    := True;

    sbFind.Enabled    := True;
    sbBrowse.Enabled  := True;


    sbFirst.Enabled   := True ;
    sbPrev.Enabled    := True ;
    sbNext.Enabled    := True ;
    sbLast.Enabled    := True ;
  end;

  procedure SetInsertButtons;
  begin
    sbAccept.Enabled  := True;
    sbCancel.Enabled  := True;

    sbInsert.Enabled  := False;
    sbDelete.Enabled  := False;
    sbEdit.Enabled    := False;

    sbFind.Enabled    := False;
    sbBrowse.Enabled  := False;

    sbFirst.Enabled   := False;
    sbPrev.Enabled    := False;
    sbNext.Enabled    := False;
    sbLast.Enabled    := False;
  end;

  procedure SetEditButtons;
  begin
    sbAccept.Enabled  := True;
    sbCancel.Enabled  := True;

    sbInsert.Enabled  := False;
    sbDelete.Enabled  := False;
    sbEdit.Enabled    := False;

    sbFind.Enabled    := False;
    sbBrowse.Enabled  := True;

    sbFirst.Enabled   := False;
    sbPrev.Enabled    := False;
    sbNext.Enabled    := False;
    sbLast.Enabled    := False;
  end;

begin
  case FormMode of
    fmBrowse: SetBrowseButtons;
    fmInsert: SetInsertButtons;
    fmEdit:   SetEditButtons;
  end; { case }

end;

procedure TDBNavStatForm.SetStatusBar;
begin
  case FormMode of
    fmBrowse: stbStatusBar.Panels[1].Text := 'Browsing';
    fmInsert: stbStatusBar.Panels[1].Text := 'Inserting';
    fmEdit:   stbStatusBar.Panels[1].Text := 'Edit';
  end;

  mmiInsert.Enabled := sbInsert.Enabled;
  mmiEdit.Enabled   := sbEdit.Enabled;
  mmiDelete.Enabled := sbDelete.Enabled;
  mmiCancel.Enabled := sbCancel.Enabled;
  mmiFind.Enabled   := sbFind.Enabled;

  mmiNext.Enabled   := sbNext.Enabled;
  mmiPrevious.Enabled := sbPrev.Enabled;
  mmiFirst.Enabled  := sbFirst.Enabled;
  mmiLast.Enabled   := sbLast.Enabled;

end;

procedure TDBNavStatForm.sbAcceptClick(Sender: TObject);
begin
  inherited;
   FormMode := fmBrowse;
end;

procedure TDBNavStatForm.sbInsertClick(Sender: TObject);
begin
  inherited;
  FormMode := fmInsert;
end;

procedure TDBNavStatForm.sbEditClick(Sender: TObject);
begin
  inherited;
  FormMode := fmEdit;
end;

constructor TDBNavStatForm.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

constructor TDBNavStatForm.Create(AOwner: TComponent; AParent: TWinControl);
begin
  inherited Create(AOwner, AParent);
end;

procedure TDBNavStatForm.SetStatusBarParent(AParent: TWinControl);
begin
  stbStatusBar.Parent := AParent;
end;

procedure TDBNavStatForm.SetToolBarParent(AParent: TWinControl);
begin
  tlbNavigationBar.Parent := AParent;
end;

procedure TDBNavStatForm.Loaded;
begin
  inherited Loaded;
//  FormMode := fmBrowse;
end;

procedure TDBNavStatForm.RefreshToolBar;
begin
  tlbNavigationBar.Refresh;
end;

end.
