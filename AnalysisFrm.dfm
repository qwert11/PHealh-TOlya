inherited AnalysisForm: TAnalysisForm
  Left = 490
  Top = 317
  Width = 456
  Caption = 'AnalysisForm'
  PixelsPerInch = 96
  TextHeight = 13
  inherited tlbNavigationBar: TToolBar
    Width = 448
  end
  inherited stbStatusBar: TStatusBar
    Width = 448
  end
  object dbgrd1: TDBGrid [2]
    Left = 0
    Top = 24
    Width = 448
    Height = 224
    Align = alClient
    DataSource = DM.ds3
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'TaTitle'
        Width = 261
        Visible = True
      end>
  end
end
