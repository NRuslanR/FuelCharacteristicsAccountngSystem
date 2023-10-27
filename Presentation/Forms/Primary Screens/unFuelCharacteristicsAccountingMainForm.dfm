object FuelCharacteristicsAccountingMainForm: TFuelCharacteristicsAccountingMainForm
  Left = 0
  Top = 0
  Caption = 'FuelCharacteristicsAccountingMainForm'
  ClientHeight = 360
  ClientWidth = 675
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = TopLevelMenu
  OldCreateOrder = False
  Position = poDesktopCenter
  WindowState = wsMaximized
  PixelsPerInch = 96
  TextHeight = 13
  object TopLevelMenu: TMainMenu
    Left = 16
    Top = 304
    object FileMenuItem: TMenuItem
      Caption = #1060#1072#1081#1083
      object N1: TMenuItem
        Action = actExitProgram
      end
    end
    object ReferenceDataMenuItem: TMenuItem
      Caption = #1057#1087#1088#1072#1074#1086#1095#1085#1099#1077' '#1076#1072#1085#1085#1099#1077
      object ReservoirsReferenceDataMenuItem: TMenuItem
        Action = actReservoirKindsReferenceData
      end
    end
    object N2: TMenuItem
      Action = actAdministration
    end
    object UserAppearanceSettingsMenuItem: TMenuItem
      Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1080
      object N3: TMenuItem
        Action = actFontSettings
      end
      object N4: TMenuItem
        Action = actChangeUserAccount
      end
    end
  end
  object UseCaseActionList: TActionList
    Left = 56
    Top = 304
    object actExitProgram: TAction
      Caption = #1042#1099#1081#1090#1080' '#1080#1079' '#1087#1088#1086#1075#1088#1072#1084#1084#1099
    end
    object actAdministration: TAction
      Caption = #1040#1076#1084#1080#1085#1080#1089#1090#1088#1080#1088#1086#1074#1072#1085#1080#1077
    end
    object actFontSettings: TAction
      Caption = #1064#1088#1080#1092#1090'...'
    end
    object actChangeUserAccount: TAction
      Caption = #1057#1084#1077#1085#1080#1090#1100' '#1091#1095#1105#1090#1085#1091#1102' '#1079#1072#1087#1080#1089#1100'...'
    end
    object actReservoirKindsReferenceData: TAction
      Caption = #1058#1080#1087#1099' '#1088#1077#1079#1077#1088#1074#1091#1072#1088#1086#1074'...'
    end
  end
end
