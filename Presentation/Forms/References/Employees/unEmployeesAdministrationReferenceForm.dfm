inherited EmployeesAdministrationReferenceForm: TEmployeesAdministrationReferenceForm
  Caption = 'EmployeesAdministrationReferenceForm'
  ExplicitWidth = 769
  ExplicitHeight = 719
  PixelsPerInch = 96
  TextHeight = 13
  inherited DataOperationToolBar: TToolBar
    inherited ChooseRecordsSeparator: TToolButton
      ExplicitHeight = 46
    end
    inherited RefreshSeparator: TToolButton
      Left = 504
      ExplicitLeft = 504
    end
    inherited SelectFilterDataToolButton: TToolButton
      Left = 512
      ExplicitLeft = 512
    end
    inherited SelectFilteredRecordsSeparator: TToolButton
      Left = 584
      ExplicitLeft = 584
    end
    inherited PrintDataToolButton: TToolButton
      Left = 592
      ExplicitLeft = 592
    end
    inherited ExportDataToolButton: TToolButton
      ExplicitWidth = 87
    end
    inherited ExportDataSeparator: TToolButton
      Left = 751
      ExplicitLeft = 751
    end
    inherited ExitToolButton: TToolButton
      Left = 759
      ExplicitLeft = 759
    end
  end
  inherited DataRecordMovingToolBar: TToolBar
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
    BevelOuter = bvNone
    ExplicitTop = 122
    ExplicitHeight = 508
    inherited DataRecordGrid: TcxGrid
      Left = 0
      Top = 0
      Width = 753
      Height = 520
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 753
      ExplicitHeight = 508
      inherited DataRecordGridTableView: TcxGridDBTableView
        object RoleNameColumn: TcxGridDBColumn
          Caption = #1056#1086#1083#1100
        end
        object LoginColumn: TcxGridDBColumn
          Caption = #1051#1086#1075#1080#1085
        end
      end
    end
  end
end
