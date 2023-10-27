inherited BaseFuelCharacteristicsAccountingReferenceForm: TBaseFuelCharacteristicsAccountingReferenceForm
  Caption = 'BaseFuelCharacteristicsAccountingReferenceForm'
  ExplicitWidth = 320
  ExplicitHeight = 240
  PixelsPerInch = 96
  TextHeight = 13
  inherited DataOperationToolBar: TToolBar
    inherited ChooseRecordsToolButton: TToolButton
      ExplicitWidth = 72
      ExplicitHeight = 38
    end
    inherited ChooseRecordsSeparator: TToolButton
      Left = 0
      Wrap = True
      Visible = False
      ExplicitLeft = 0
      ExplicitHeight = 46
    end
    inherited AddDataToolButton: TToolButton
      Left = 0
      Top = 46
      ExplicitLeft = 0
      ExplicitTop = 46
      ExplicitWidth = 72
      ExplicitHeight = 38
    end
    inherited CopySelectedDataRecordsToolButton: TToolButton
      Left = 72
      Top = 46
      ExplicitLeft = 72
      ExplicitTop = 46
      ExplicitWidth = 72
      ExplicitHeight = 38
    end
    inherited ChangeDataToolButton: TToolButton
      Left = 144
      Top = 46
      ExplicitLeft = 144
      ExplicitTop = 46
      ExplicitWidth = 72
      ExplicitHeight = 38
    end
    inherited DeleteDataToolButton: TToolButton
      Left = 216
      Top = 46
      ExplicitLeft = 216
      ExplicitTop = 46
    end
    inherited RefreshDataToolButton: TToolButton
      Left = 288
      Top = 46
      ExplicitLeft = 288
      ExplicitTop = 46
    end
    inherited ReserveToolButton1: TToolButton
      Left = 360
      Top = 46
      ExplicitLeft = 360
      ExplicitTop = 46
    end
    inherited ReserveToolButton2: TToolButton
      Left = 432
      Top = 46
      ExplicitLeft = 432
      ExplicitTop = 46
    end
    inherited RefreshSeparator: TToolButton
      Left = 504
      Top = 46
      Wrap = False
      Visible = False
      ExplicitLeft = 504
      ExplicitTop = 46
      ExplicitHeight = 38
    end
    inherited SelectFilterDataToolButton: TToolButton
      Left = 512
      ExplicitLeft = 512
    end
    inherited SelectFilteredRecordsSeparator: TToolButton
      Left = 584
      Enabled = False
      ExplicitLeft = 584
    end
    inherited PrintDataToolButton: TToolButton
      Left = 592
      Enabled = False
      ExplicitLeft = 592
    end
    inherited ExportDataToolButton: TToolButton
      Left = 664
      ExplicitLeft = 664
      ExplicitWidth = 72
    end
    inherited ExportDataSeparator: TToolButton
      Left = 751
      Enabled = False
      Visible = False
      ExplicitLeft = 751
    end
    inherited ExitToolButton: TToolButton
      Left = 759
      ExplicitLeft = 759
    end
  end
  inherited DataRecordMovingToolBar: TToolBar
    Visible = False
    inherited FirstDataRecordToolButton: TToolButton
      ExplicitWidth = 46
    end
    inherited PrevDataRecordToolButton: TToolButton
      ExplicitWidth = 46
    end
    inherited NextDataRecordToolButton: TToolButton
      ExplicitWidth = 46
    end
    inherited LastDataRecordToolButton: TToolButton
      ExplicitWidth = 46
    end
  end
  inherited ClientAreaPanel: TPanel
    inherited DataRecordGrid: TcxGrid
      LookAndFeel.SkinName = 'UserSkin'
      inherited DataRecordGridTableView: TcxGridDBTableView
        OptionsData.CancelOnExit = False
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsView.CellAutoHeight = True
        OptionsView.ColumnAutoWidth = True
        OptionsView.HeaderAutoHeight = True
      end
    end
  end
  inherited DataOperationActionList: TActionList
    inherited actExit: TAction
      Visible = False
    end
    inherited actExportDataToXML: TAction
      Visible = False
    end
    inherited actExportDataToHTML: TAction
      Visible = False
    end
    inherited actChooseRecords: TAction
      Visible = False
    end
  end
end
