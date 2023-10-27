inherited FuelCharacteristicsAutomaticCalculationForm: TFuelCharacteristicsAutomaticCalculationForm
  Caption = #1056#1072#1089#1095#1105#1090' '#1084#1072#1089#1089#1099' '#1090#1086#1087#1083#1080#1074#1072
  ClientHeight = 406
  ClientWidth = 486
  Constraints.MaxHeight = 445
  Constraints.MinHeight = 445
  Constraints.MinWidth = 502
  Position = poMainFormCenter
  ExplicitWidth = 502
  ExplicitHeight = 445
  PixelsPerInch = 96
  TextHeight = 13
  inherited btnOK: TcxButton
    Left = 311
    Top = 373
    LookAndFeel.SkinName = 'UserSkin'
    ExplicitLeft = 311
    ExplicitTop = 373
  end
  inherited btnCancel: TcxButton
    Left = 403
    Top = 373
    LookAndFeel.SkinName = 'UserSkin'
    ExplicitLeft = 403
    ExplicitTop = 373
  end
  object ReservoirInfoGroupBox: TGroupBox
    Left = 8
    Top = 8
    Width = 470
    Height = 57
    Anchors = [akLeft, akTop, akRight]
    Caption = #1048#1085#1092#1086#1088#1084#1072#1094#1080#1103' '#1086' '#1088#1077#1079#1077#1088#1074#1091#1072#1088#1077
    TabOrder = 2
    DesignSize = (
      470
      57)
    object ReservoirKindLabel: TLabel
      Left = 13
      Top = 24
      Width = 84
      Height = 13
      Caption = #1058#1080#1087' '#1088#1077#1079#1077#1088#1074#1091#1072#1088#1072':'
    end
    object ReservoirKindEdit: TcxButtonEdit
      Left = 103
      Top = 21
      Anchors = [akLeft, akTop, akRight]
      Properties.Buttons = <
        item
          Caption = #1042#1099#1073#1088#1072#1090#1100'...'
          Default = True
          Kind = bkText
        end>
      Properties.ReadOnly = True
      Properties.OnButtonClick = ReservoirKindEditPropertiesButtonClick
      Properties.OnChange = ReservoirKindEditPropertiesChange
      Properties.OnValidate = ReservoirKindEditPropertiesValidate
      Style.LookAndFeel.Kind = lfUltraFlat
      Style.LookAndFeel.NativeStyle = False
      Style.LookAndFeel.SkinName = ''
      Style.Shadow = False
      Style.ButtonStyle = btsUltraFlat
      StyleDisabled.LookAndFeel.Kind = lfUltraFlat
      StyleDisabled.LookAndFeel.NativeStyle = False
      StyleDisabled.LookAndFeel.SkinName = ''
      StyleFocused.LookAndFeel.Kind = lfUltraFlat
      StyleFocused.LookAndFeel.NativeStyle = False
      StyleFocused.LookAndFeel.SkinName = ''
      StyleHot.LookAndFeel.Kind = lfUltraFlat
      StyleHot.LookAndFeel.NativeStyle = False
      StyleHot.LookAndFeel.SkinName = ''
      TabOrder = 0
      Width = 356
    end
  end
  object SubLayerInfoGroupBox: TGroupBox
    Left = 8
    Top = 71
    Width = 470
    Height = 90
    Anchors = [akLeft, akTop, akRight]
    Caption = #1048#1085#1092#1086#1088#1084#1072#1094#1080#1103' '#1086' '#1087#1086#1076#1089#1083#1086#1077
    TabOrder = 3
    object SubLayerKindPanel: TPanel
      Left = 2
      Top = 15
      Width = 466
      Height = 40
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 0
      DesignSize = (
        466
        40)
      object SubLayerKindLabel: TLabel
        Left = 20
        Top = 8
        Width = 67
        Height = 13
        Caption = #1058#1080#1087' '#1087#1086#1076#1089#1083#1086#1103':'
      end
      object SubLayerKindComboBox: TValidateComboBox
        Left = 93
        Top = 7
        Width = 364
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        ItemHeight = 13
        ParentShowHint = False
        ShowHint = False
        TabOrder = 0
        OnSelect = SubLayerKindComboBoxSelect
        InvalidateOnNonSelection = False
        InvalidHint = #1053#1077#1086#1073#1093#1086#1076#1080#1084#1086' '#1091#1082#1072#1079#1072#1090#1100' '#1090#1080#1087' '#1087#1086#1076#1089#1083#1086#1103
        InvalidColor = 10520575
        RegularExpression = '.+'
        UseDefaultInvalidColor = True
      end
    end
    object SubLayerDataPanel: TPanel
      Left = 2
      Top = 55
      Width = 466
      Height = 33
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 1
      DesignSize = (
        466
        33)
      object ReservoirSubLayerCalculationCharacteristicValueLabel: TLabel
        Left = 40
        Top = 1
        Width = 47
        Height = 13
        Hint = #1042#1099#1089#1086#1090#1085#1099#1081' '#1090#1088#1072#1092#1072#1088#1077#1090' '#1092#1072#1082#1090#1080#1095#1077#1089#1082#1080#1081
        Caption = #1042#1058#1060' ('#1084#1084'):'
        ParentShowHint = False
        ShowHint = True
      end
      object ReservoirSubLayerCalculationCharacteristicValueEdit: TRegExprValidateEdit
        Left = 93
        Top = 0
        Width = 364
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        TabOrder = 0
        InvalidHint = #1053#1077#1082#1086#1088#1088#1077#1082#1090#1085#1086#1077' '#1079#1085#1072#1095#1077#1085#1080#1077' '#1076#1083#1103' '#1074#1099#1089#1086#1090#1099' '#1088#1077#1079#1077#1088#1074#1091#1072#1088#1085#1086#1075#1086' '#1087#1086#1076#1089#1083#1086#1103
        InvalidColor = 10520575
        RegularExpression = '.*'
      end
    end
  end
  object MakeCalculationButton: TcxButton
    Left = 155
    Top = 373
    Width = 137
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = #1042#1099#1087#1086#1083#1085#1080#1090#1100' '#1088#1072#1089#1095#1105#1090
    TabOrder = 4
    OnClick = MakeCalculationButtonClick
    LookAndFeel.SkinName = 'UserSkin'
  end
  object FuelCharacteristicsGroupBox: TGroupBox
    Left = 8
    Top = 167
    Width = 470
    Height = 122
    Anchors = [akLeft, akTop, akRight]
    Caption = #1042#1093#1086#1076#1085#1099#1077' '#1093#1072#1088#1072#1082#1090#1077#1088#1080#1089#1090#1080#1082#1080' '#1090#1086#1087#1083#1080#1074#1072
    TabOrder = 5
    DesignSize = (
      470
      122)
    object TemperatureLabel: TLabel
      Left = 28
      Top = 20
      Width = 93
      Height = 13
      Caption = #1058#1077#1084#1087#1077#1088#1072#1090#1091#1088#1072' ('#176#1057'):'
    end
    object DensityLabel: TLabel
      Left = 25
      Top = 53
      Width = 96
      Height = 13
      Caption = #1055#1083#1086#1090#1085#1086#1089#1090#1100' ('#1082#1075'/'#1084'3):'
    end
    object FuelRiseLevelLabel: TLabel
      Left = 13
      Top = 88
      Width = 108
      Height = 13
      Caption = #1059#1088#1086#1074#1077#1085#1100' '#1074#1079#1083#1080#1074#1072' ('#1084#1084'):'
    end
    object TemperatureEdit: TRegExprValidateEdit
      Left = 127
      Top = 17
      Width = 332
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 0
      InvalidHint = #1053#1077#1082#1086#1088#1088#1077#1082#1090#1085#1086#1077' '#1079#1085#1072#1095#1077#1085#1080#1077' '#1090#1077#1084#1087#1077#1088#1072#1090#1091#1088#1099
      InvalidColor = 10520575
      RegularExpression = '^-?\d+(\.\d+)?$'
    end
    object DensityEdit: TRegExprValidateEdit
      Left = 127
      Top = 52
      Width = 332
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 1
      InvalidHint = #1053#1077#1082#1086#1088#1088#1077#1082#1090#1085#1086#1077' '#1079#1085#1072#1095#1077#1085#1080#1077' '#1087#1083#1086#1090#1085#1086#1089#1090#1080
      InvalidColor = 10520575
      RegularExpression = '^\d+(\.\d+)?$'
    end
    object FuelRiseLevelEdit: TRegExprValidateEdit
      Left = 127
      Top = 87
      Width = 332
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 2
      InvalidHint = #1053#1077#1082#1086#1088#1088#1077#1082#1090#1085#1086#1077' '#1079#1085#1072#1095#1077#1085#1080#1077' '#1091#1088#1086#1074#1085#1103' '#1074#1079#1083#1080#1074#1072
      InvalidColor = 10520575
      RegularExpression = '^\d+(\.\d+)?$'
    end
  end
  object OutputFuelCharacteristicsGroupBox: TGroupBox
    Left = 8
    Top = 295
    Width = 470
    Height = 66
    Anchors = [akLeft, akTop, akRight]
    Caption = #1042#1099#1095#1080#1089#1083#1103#1077#1084#1099#1077' '#1093#1072#1088#1072#1082#1090#1077#1088#1080#1089#1090#1080#1082#1080' '#1090#1086#1087#1083#1080#1074#1072
    TabOrder = 6
    DesignSize = (
      470
      66)
    object FuelMassLabel: TLabel
      Left = 20
      Top = 27
      Width = 101
      Height = 13
      Caption = #1052#1072#1089#1089#1072' '#1090#1086#1087#1083#1080#1074#1072' ('#1082#1075'):'
    end
    object FuelMassEdit: TRegExprValidateEdit
      Left = 127
      Top = 26
      Width = 332
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 0
      InvalidHint = #1053#1077#1082#1086#1088#1088#1077#1082#1090#1085#1086#1077' '#1079#1085#1072#1095#1077#1085#1080#1077' '#1084#1072#1089#1089#1099' '#1090#1086#1087#1083#1080#1074#1072
      InvalidColor = 10520575
      RegularExpression = '^\d+(\.\d+)?$'
    end
  end
end
