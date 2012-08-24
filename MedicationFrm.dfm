inherited MedicationForm: TMedicationForm
  Width = 683
  Height = 411
  Caption = #1052#1077#1076#1080#1082#1072#1084#1077#1085#1090#1099
  PixelsPerInch = 96
  TextHeight = 13
  inherited tlbNavigationBar: TToolBar
    Width = 675
    inherited sbDelete: TToolButton
      OnClick = sbDeleteClick
    end
  end
  inherited stbStatusBar: TStatusBar
    Top = 338
    Width = 675
  end
  object dbgrd1: TDBGrid [2]
    Left = 0
    Top = 24
    Width = 675
    Height = 240
    Align = alClient
    DataSource = DM.ds8
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'MeTitle'
        Width = 609
        Visible = True
      end>
  end
  object dbmmoMeDscrptn: TDBMemo [3]
    Left = 0
    Top = 264
    Width = 675
    Height = 74
    Align = alBottom
    DataField = 'MeDscrptn'
    DataSource = DM.ds8
    TabOrder = 3
  end
end
