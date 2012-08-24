object AsAnalysisForm: TAsAnalysisForm
  Left = 466
  Top = 252
  Width = 333
  Height = 377
  Caption = 'AsAnalysisForm'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object btn1: TBitBtn
    Left = 224
    Top = 312
    Width = 75
    Height = 25
    TabOrder = 0
    Kind = bkOK
  end
  object lstAsAnalysis: TListBox
    Left = 0
    Top = 0
    Width = 321
    Height = 297
    ItemHeight = 13
    MultiSelect = True
    TabOrder = 1
  end
  object btnNewAnalis: TButton
    Left = 8
    Top = 312
    Width = 81
    Height = 25
    Caption = #1053#1086#1074#1099#1081' '#1072#1085#1072#1083#1080#1079
    TabOrder = 2
    OnClick = btnNewAnalisClick
  end
end
