inherited PeopleForm: TPeopleForm
  Left = 159
  Top = 187
  Width = 993
  Height = 387
  Caption = 'PeopleForm'
  PixelsPerInch = 96
  TextHeight = 13
  inherited tlbNavigationBar: TToolBar
    Width = 985
  end
  inherited stbStatusBar: TStatusBar
    Top = 314
    Width = 985
  end
  object dbgrd1: TDBGrid [2]
    Left = 0
    Top = 24
    Width = 985
    Height = 290
    Align = alClient
    DataSource = DM.ds1
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    OnDblClick = dbgrd1DblClick
  end
end
