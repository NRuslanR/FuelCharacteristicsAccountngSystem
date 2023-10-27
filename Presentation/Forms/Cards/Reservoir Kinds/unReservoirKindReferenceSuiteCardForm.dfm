inherited ReservoirKindReferenceSuiteCardForm: TReservoirKindReferenceSuiteCardForm
  Caption = #1057#1087#1088#1072#1074#1086#1095#1085#1099#1077' '#1076#1072#1085#1085#1099#1077' '#1090#1080#1087#1072' '#1088#1077#1079#1077#1088#1074#1091#1072#1088#1086#1074
  ClientHeight = 156
  ClientWidth = 489
  Position = poMainFormCenter
  ExplicitWidth = 505
  ExplicitHeight = 195
  PixelsPerInch = 96
  TextHeight = 13
  object ReservoirKindNameLabel: TLabel [0]
    Left = 16
    Top = 14
    Width = 90
    Height = 13
    Caption = #1058#1080#1087' '#1088#1077#1079#1077#1088#1074#1091#1072#1088#1086#1074':'
  end
  object HSCLabel: TLabel [1]
    Left = 60
    Top = 51
    Width = 46
    Height = 13
    Hint = #1042#1099#1089#1086#1090#1085#1099#1081' '#1090#1088#1072#1092#1072#1088#1077#1090' '#1087#1086#1089#1090#1086#1103#1085#1085#1099#1081
    Caption = #1042#1058#1055' ('#1084#1084'):'
    ParentShowHint = False
    ShowHint = True
  end
  object CalibrationChartLocationLabel: TLabel [2]
    Left = 18
    Top = 80
    Width = 88
    Height = 26
    Caption = #1043#1088#1072#1076#1091#1080#1088#1086#1074#1086#1095#1085#1072#1103'                '#1090#1072#1073#1083#1080#1094#1072':'
    WordWrap = True
  end
  inherited btnOK: TcxButton
    Left = 313
    Top = 123
    TabOrder = 3
    LookAndFeel.SkinName = 'UserSkin'
    ExplicitLeft = 313
    ExplicitTop = 123
  end
  inherited btnCancel: TcxButton
    Left = 406
    Top = 123
    TabOrder = 4
    LookAndFeel.SkinName = 'UserSkin'
    ExplicitLeft = 406
    ExplicitTop = 123
  end
  object CalibrationChartLocationEdit: TcxButtonEdit
    Left = 112
    Top = 83
    Anchors = [akLeft, akTop, akRight]
    Properties.Buttons = <
      item
        Caption = #1042#1099#1073#1088#1072#1090#1100'...'
        Default = True
        Kind = bkText
      end>
    Properties.MaskKind = emkRegExpr
    Properties.EditMask = '.+'
    Properties.MaxLength = 0
    Properties.ReadOnly = True
    Properties.OnButtonClick = CalibrationChartLocationEditPropertiesButtonClick
    Properties.OnChange = CalibrationChartLocationEditPropertiesChange
    Properties.OnValidate = CalibrationChartLocationEditPropertiesValidate
    TabOrder = 2
    Width = 363
  end
  object HSCEdit: TRegExprValidateEdit
    Left = 112
    Top = 48
    Width = 363
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 1
    InvalidHint = #1053#1077#1082#1086#1088#1088#1077#1082#1090#1085#1086#1077' '#1079#1085#1072#1095#1077#1085#1080#1077' '#1074#1099#1089#1086#1090#1085#1086#1075#1086' '#1090#1088#1072#1092#1072#1088#1077#1090#1072' '#1087#1086#1089#1090#1086#1103#1085#1085#1086#1075#1086
    InvalidColor = 10520575
    RegularExpression = '.*'
  end
  object ReservoirKindNameEdit: TRegExprValidateEdit
    Left = 112
    Top = 8
    Width = 363
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 0
    InvalidHint = #1053#1077#1082#1086#1088#1088#1077#1082#1090#1085#1086#1077' '#1085#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' '#1090#1080#1087#1072' '#1088#1077#1079#1077#1088#1074#1091#1072#1088#1086#1074
    InvalidColor = 10520575
    RegularExpression = '.+'
  end
end
