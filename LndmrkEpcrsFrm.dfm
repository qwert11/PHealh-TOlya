inherited LndmrkEpcrsForm: TLndmrkEpcrsForm
  Width = 658
  Height = 381
  Caption = #1069#1090#1072#1087#1085#1099#1081' '#1101#1087#1080#1082#1088#1080#1079
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  inherited tlbNavigationBar: TToolBar
    Width = 650
    inherited sbCancel: TToolButton
      OnClick = sbCancelClick
    end
  end
  inherited stbStatusBar: TStatusBar
    Top = 308
    Width = 650
  end
  object dbgrd1: TDBGrid [2]
    Left = 0
    Top = 24
    Width = 650
    Height = 224
    Align = alClient
    DataSource = DM.ds7
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    OnEditButtonClick = dbgrd1EditButtonClick
    Columns = <
      item
        Expanded = False
        FieldName = 'LeDate'
        Visible = True
      end
      item
        ButtonStyle = cbsEllipsis
        Expanded = False
        FieldName = 'PplName'
        Width = 348
        Visible = True
      end>
  end
  object dbmmoLeInfo: TDBMemo [3]
    Left = 0
    Top = 248
    Width = 650
    Height = 60
    Align = alBottom
    DataField = 'LeInfo'
    DataSource = DM.ds7
    TabOrder = 3
  end
end
