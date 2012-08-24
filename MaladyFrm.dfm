inherited MaladyForm: TMaladyForm
  Left = 229
  Top = 294
  Width = 867
  Height = 371
  Caption = 'MaladyForm'
  PixelsPerInch = 96
  TextHeight = 13
  inherited tlbNavigationBar: TToolBar
    Width = 859
  end
  inherited stbStatusBar: TStatusBar
    Top = 298
    Width = 859
  end
  object dbmmoMuTreatStndrd: TDBMemo [2]
    Left = 0
    Top = 256
    Width = 859
    Height = 42
    Align = alBottom
    DataField = 'MuTreatStndrd'
    DataSource = DM.ds2
    TabOrder = 2
  end
  object pnl1: TPanel [3]
    Left = 0
    Top = 24
    Width = 859
    Height = 232
    Align = alClient
    Caption = 'pnl1'
    TabOrder = 3
    object dbgrd1: TDBGrid
      Left = 1
      Top = 1
      Width = 657
      Height = 230
      Align = alClient
      DataSource = DM.ds2
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      OnDblClick = dbgrd1DblClick
      Columns = <
        item
          Expanded = False
          FieldName = 'MuTitle'
          Title.Caption = #1053#1072#1079#1074#1072#1085#1080#1077
          Width = 172
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'MuCodeDiagn'
          Title.Caption = #1050#1086#1076' MK'#1041
          Width = 52
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'MuPerObsrv'
          Title.Caption = #1055#1077#1088'.'#1085#1072#1073#1083'.'
          Width = 59
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'MuIntervalReturn'
          Title.Caption = #1048#1085#1090#1077#1088#1074'.'#1087#1086#1089'.'
          Width = 69
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'MuInfo'
          Width = 284
          Visible = True
        end>
    end
    object dbgrd2: TDBGrid
      Left = 658
      Top = 1
      Width = 200
      Height = 230
      Align = alRight
      DataSource = DM.ds5
      TabOrder = 1
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      Columns = <
        item
          Expanded = False
          FieldName = 'TAnalis'
          Visible = True
        end>
    end
  end
  inherited mmFormMenu: TMainMenu
    Left = 352
    Top = 122
  end
  inherited ilNavigationBar: TImageList
    Left = 380
    Top = 120
  end
end
