object MainForm: TMainForm
  Left = 97
  Top = 200
  Width = 1154
  Height = 500
  Caption = #1047#1076#1086#1088#1086#1074#1100#1077
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = mm1
  OldCreateOrder = False
  ShowHint = True
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pnlParent: TPanel
    Left = 0
    Top = 0
    Width = 1146
    Height = 427
    Align = alClient
    BevelInner = bvLowered
    Color = clAppWorkSpace
    TabOrder = 0
  end
  object stat1: TStatusBar
    Left = 0
    Top = 427
    Width = 1146
    Height = 19
    Panels = <>
  end
  object mm1: TMainMenu
    Left = 960
    Top = 344
    object mniFile: TMenuItem
      Caption = #1060#1072#1081#1083
    end
    object mniShowJournalComings: TMenuItem
      Action = actShowJournalComings
    end
    object mniLndmrkEpcrs: TMenuItem
      Action = actLndmrkEpcrs
    end
    object mniMedication: TMenuItem
      Caption = #1052#1077#1076#1080#1082#1072#1084#1077#1085#1090#1099
      OnClick = mniMedicationClick
    end
  end
  object actlst1: TActionList
    Left = 1000
    Top = 344
    object actShowJournalComings: TAction
      Caption = #1046#1091#1088#1085#1072#1083' '#1087#1086#1089#1090#1091#1087#1083#1077#1085#1080#1081
      Hint = #1046#1091#1088#1085#1072#1083' '#1087#1086#1089#1090#1091#1087#1083#1077#1085#1080#1081
      OnExecute = actShowJournalComingsExecute
    end
    object actNewPatient: TAction
      Caption = #1053#1086#1074#1099#1081' '#1087#1072#1094#1080#1077#1085#1090
    end
    object actLndmrkEpcrs: TAction
      Caption = #1069#1090#1072#1087#1085#1099#1081' '#1101#1087#1080#1082#1088#1080#1079
      OnExecute = actLndmrkEpcrsExecute
    end
  end
end
