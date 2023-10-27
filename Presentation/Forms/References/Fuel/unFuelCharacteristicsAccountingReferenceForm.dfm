inherited FuelCharacteristicsAccountingReferenceForm: TFuelCharacteristicsAccountingReferenceForm
  Caption = 'FuelCharacteristicsAccountingReferenceForm'
  ExplicitTop = -309
  ExplicitWidth = 769
  ExplicitHeight = 719
  PixelsPerInch = 96
  TextHeight = 13
  inherited DataOperationToolBar: TToolBar
    ButtonWidth = 85
    inherited ChooseRecordsToolButton: TToolButton
      ExplicitWidth = 85
    end
    inherited ChooseRecordsSeparator: TToolButton
      Left = 85
      Wrap = False
      ExplicitLeft = 85
      ExplicitHeight = 38
    end
    inherited AddDataToolButton: TToolButton
      Left = 93
      Top = 0
      ExplicitLeft = 93
      ExplicitTop = 0
      ExplicitWidth = 85
    end
    inherited CopySelectedDataRecordsToolButton: TToolButton
      Left = 178
      Top = 0
      ExplicitLeft = 178
      ExplicitTop = 0
      ExplicitWidth = 85
    end
    inherited ChangeDataToolButton: TToolButton
      Left = 263
      Top = 0
      ExplicitLeft = 263
      ExplicitTop = 0
      ExplicitWidth = 85
    end
    inherited DeleteDataToolButton: TToolButton
      Left = 348
      Top = 0
      ExplicitLeft = 348
      ExplicitTop = 0
      ExplicitWidth = 85
    end
    inherited RefreshDataToolButton: TToolButton
      Left = 433
      Top = 0
      ExplicitLeft = 433
      ExplicitTop = 0
      ExplicitWidth = 85
    end
    inherited ReserveToolButton1: TToolButton
      Left = 518
      Top = 0
      ExplicitLeft = 518
      ExplicitTop = 0
      ExplicitWidth = 85
    end
    inherited ReserveToolButton2: TToolButton
      Left = 603
      Top = 0
      ExplicitLeft = 603
      ExplicitTop = 0
      ExplicitWidth = 85
    end
    inherited RefreshSeparator: TToolButton
      Left = 0
      Top = 0
      Wrap = True
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitHeight = 46
    end
    inherited SelectFilterDataToolButton: TToolButton
      Left = 0
      ExplicitLeft = 0
      ExplicitWidth = 85
    end
    inherited SelectFilteredRecordsSeparator: TToolButton
      Left = 85
      ExplicitLeft = 85
    end
    inherited PrintDataToolButton: TToolButton
      Left = 93
      ExplicitLeft = 93
      ExplicitWidth = 85
    end
    inherited ExportDataToolButton: TToolButton
      Left = 178
      ExplicitLeft = 178
      ExplicitWidth = 100
    end
    inherited ExportDataSeparator: TToolButton
      Left = 278
      ExplicitLeft = 278
    end
    inherited ExitToolButton: TToolButton
      Left = 286
      ExplicitLeft = 286
      ExplicitWidth = 85
    end
  end
  inherited SearchByColumnPanel: TScrollBox
    inherited btnNextFoundOccurrence: TcxButton
      LookAndFeel.Kind = lfStandard
    end
  end
  inherited DataRecordMovingToolBar: TToolBar
    ExplicitTop = 100
    inherited FirstDataRecordToolButton: TToolButton
      ExplicitWidth = 24
    end
    inherited PrevDataRecordToolButton: TToolButton
      ExplicitWidth = 24
    end
    inherited NextDataRecordToolButton: TToolButton
      ExplicitWidth = 24
    end
    inherited LastDataRecordToolButton: TToolButton
      ExplicitWidth = 24
    end
  end
  inherited ClientAreaPanel: TPanel
    ExplicitTop = 122
    ExplicitHeight = 508
    inherited DataLoadingCanceledPanel: TPanel
      ExplicitTop = 58
    end
    inherited WaitDataLoadingPanel: TPanel
      ExplicitTop = 136
    end
    inherited DataRecordGrid: TcxGrid
      ExplicitHeight = 506
      inherited DataRecordGridTableView: TcxGridDBTableView
        DataController.KeyFieldNames = 'card_id'
        OptionsSelection.InvertSelect = False
        inherited IdColumn: TcxGridDBColumn
          DataBinding.FieldName = 'card_id'
        end
        inherited CanBeChangedColumn: TcxGridDBColumn
          DataBinding.FieldName = 'can_be_changed'
        end
        inherited CanBeRemovedColumn: TcxGridDBColumn
          DataBinding.FieldName = 'can_be_removed'
        end
        object TemperatureColumn: TcxGridDBColumn
          Caption = #1058#1077#1084#1087#1077#1088#1072#1090#1091#1088#1072' ('#176#1057')'
          DataBinding.FieldName = 'fuel_temperature'
          Width = 72
        end
        object DensityColumn: TcxGridDBColumn
          Caption = #1055#1083#1086#1090#1085#1086#1089#1090#1100' ('#1082#1075'/'#1084'3)'
          DataBinding.FieldName = 'fuel_density'
          Width = 67
        end
        object FuelRiseLevelColumn: TcxGridDBColumn
          Caption = #1059#1088#1086#1074#1077#1085#1100' '#1074#1079#1083#1080#1074#1072' ('#1084#1084')'
          DataBinding.FieldName = 'fuel_rise_level'
          Width = 92
        end
        object FuelMassColumn: TcxGridDBColumn
          Caption = #1052#1072#1089#1089#1072' '#1090#1086#1087#1083#1080#1074#1072' ('#1082#1075')'
          DataBinding.FieldName = 'fuel_volume'
          Width = 100
        end
        object FuelKindColumn: TcxGridDBColumn
          Caption = #1058#1080#1087' '#1090#1086#1087#1083#1080#1074#1072
          DataBinding.FieldName = 'fuel_kind'
          Width = 77
        end
        object ReservoirNumberColumn: TcxGridDBColumn
          Caption = #1053#1086#1084#1077#1088' '#1088#1077#1079#1077#1088#1074#1091#1072#1088#1072
          DataBinding.FieldName = 'reservoir_number'
          Width = 64
        end
        object PerformedCalculationEmployeeIdColumn: TcxGridDBColumn
          DataBinding.FieldName = 'calculation_performer_id'
          Visible = False
          VisibleForCustomization = False
        end
        object PerformedCalculationEmployeeNameColumn: TcxGridDBColumn
          Caption = #1042#1099#1087#1086#1083#1085#1080#1074#1096#1080#1081' '#1088#1072#1089#1095#1105#1090
          DataBinding.FieldName = 'performer_full_name'
          Width = 161
        end
        object CalculationPerformingDateTimeColumn: TcxGridDBColumn
          Caption = #1044#1072#1090#1072' '#1080' '#1074#1088#1077#1084#1103' '#1088#1072#1089#1095#1105#1090#1072
          DataBinding.FieldName = 'calculation_performing_datetime'
          Width = 104
        end
      end
    end
  end
  inherited imgLstDisabled: TPngImageList
    Left = 440
    Top = 120
  end
  inherited imgLstEnabled: TPngImageList
    Left = 344
    Top = 120
  end
  inherited DataOperationActionList: TActionList
    Left = 464
    Top = 56
    inherited actAddData: TAction
      Caption = #1053#1086#1074#1099#1081' '#1088#1072#1089#1095#1105#1090
      Hint = #1042#1099#1087#1086#1083#1085#1080#1090#1100' '#1085#1086#1074#1099#1081' '#1088#1072#1089#1095#1105#1090' '#1093#1072#1088#1072#1082#1090#1077#1088#1080#1089#1090#1080#1082' '#1090#1086#1087#1083#1080#1074#1072
    end
    inherited actRefreshData: TAction
      Hint = #1047#1072#1075#1088#1091#1079#1080#1090#1100' '#1087#1086#1089#1083#1077#1076#1085#1080#1077' '#1088#1072#1089#1095#1105#1090#1099
    end
    inherited actPrevDataRecord: TAction
      Visible = False
    end
    inherited actFirstDataRecord: TAction
      Visible = False
    end
    inherited actLastDataRecord: TAction
      Visible = False
    end
    inherited actNextDataRecord: TAction
      Visible = False
    end
  end
  inherited DataOperationPopupMenu: TPopupMenu
    Left = 600
    Top = 56
  end
  inherited TargetDataSource: TDataSource
    Left = 352
    Top = 56
  end
  inherited ExportDataPopupMenu: TPopupMenu
    Left = 656
    Top = 120
  end
  inherited ExportDataDialog: TSaveDialog
    Left = 544
    Top = 120
  end
  inherited Localizer: TcxLocalizer
    Left = 704
  end
end
