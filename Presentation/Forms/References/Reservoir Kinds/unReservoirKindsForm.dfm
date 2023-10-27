inherited ReservoirKindsForm: TReservoirKindsForm
  Caption = #1058#1080#1087#1099' '#1088#1077#1079#1077#1088#1074#1091#1072#1088#1086#1074
  ClientHeight = 461
  ClientWidth = 748
  Position = poMainFormCenter
  ExplicitTop = -40
  ExplicitWidth = 764
  ExplicitHeight = 500
  PixelsPerInch = 96
  TextHeight = 13
  inherited DataOperationToolBar: TToolBar
    Width = 748
    ExplicitHeight = 210
    inherited ChooseRecordsSeparator: TToolButton
      Left = 72
      Wrap = False
      ExplicitLeft = 72
      ExplicitHeight = 38
    end
    inherited AddDataToolButton: TToolButton
      Left = 80
      Top = 0
      ExplicitLeft = 80
      ExplicitTop = 0
    end
    inherited CopySelectedDataRecordsToolButton: TToolButton
      Left = 152
      Top = 0
      ExplicitLeft = 152
      ExplicitTop = 0
    end
    inherited ChangeDataToolButton: TToolButton
      Left = 224
      Top = 0
      ExplicitLeft = 224
      ExplicitTop = 0
    end
    inherited DeleteDataToolButton: TToolButton
      Left = 296
      Top = 0
      ExplicitLeft = 296
      ExplicitTop = 0
    end
    inherited RefreshDataToolButton: TToolButton
      Left = 368
      Top = 0
      ExplicitLeft = 368
      ExplicitTop = 0
    end
    inherited ReserveToolButton1: TToolButton
      Left = 440
      Top = 0
      ExplicitLeft = 440
      ExplicitTop = 0
    end
    inherited ReserveToolButton2: TToolButton
      Left = 512
      Top = 0
      ExplicitLeft = 512
      ExplicitTop = 0
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
    end
    inherited SelectFilteredRecordsSeparator: TToolButton
      Left = 72
      ExplicitLeft = 72
    end
    inherited PrintDataToolButton: TToolButton
      Left = 80
      ExplicitLeft = 80
    end
    inherited ExportDataToolButton: TToolButton
      Left = 152
      ExplicitLeft = 152
      ExplicitWidth = 87
    end
    inherited ExportDataSeparator: TToolButton
      Left = 239
      ExplicitLeft = 239
    end
    inherited ExitToolButton: TToolButton
      Left = 247
      ExplicitLeft = 247
    end
  end
  inherited StatisticsInfoStatusBar: TStatusBar
    Top = 442
    Width = 748
  end
  inherited SearchByColumnPanel: TScrollBox
    Top = 411
    Width = 748
  end
  inherited DataRecordMovingToolBar: TToolBar
    Width = 748
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
    Width = 748
    Height = 301
    ExplicitTop = 122
    ExplicitHeight = 508
    inherited DataLoadingCanceledPanel: TPanel
      Left = 80
      Top = 22
      ExplicitTop = 58
    end
    inherited WaitDataLoadingPanel: TPanel
      Left = 32
      Top = 61
      ExplicitTop = 136
    end
    inherited DataRecordGrid: TcxGrid
      Width = 746
      Height = 299
      ExplicitHeight = 506
      inherited DataRecordGridTableView: TcxGridDBTableView
        OptionsView.GroupByBox = False
        inherited IdColumn: TcxGridDBColumn
          Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' '#1090#1080#1087#1072
          Visible = True
          HeaderAlignmentHorz = taCenter
          HeaderAlignmentVert = vaCenter
          Width = 200
        end
      end
    end
  end
end
