inherited EmployeesReferenceForm: TEmployeesReferenceForm
  Caption = 'EmployeesReferenceForm'
  PixelsPerInch = 96
  TextHeight = 13
  inherited DataOperationToolBar: TToolBar
    inherited ChooseRecordsSeparator: TToolButton
      ExplicitHeight = 38
    end
    inherited CopySelectedDataRecordsToolButton: TToolButton
      Enabled = False
    end
    inherited RefreshSeparator: TToolButton
      Left = 576
      ExplicitLeft = 576
    end
    inherited SelectFilterDataToolButton: TToolButton
      Left = 504
      Enabled = False
      ExplicitLeft = 504
    end
    inherited SelectFilteredRecordsSeparator: TToolButton
      Left = 656
      ExplicitLeft = 656
    end
    inherited PrintDataToolButton: TToolButton
      Left = 584
      ExplicitLeft = 584
    end
    inherited ExportDataSeparator: TToolButton
      Left = 823
      ExplicitLeft = 823
    end
    inherited ExitToolButton: TToolButton
      Left = 751
      ExplicitLeft = 751
    end
  end
  inherited ClientAreaPanel: TPanel
    inherited DataRecordGrid: TcxGrid
      inherited DataRecordGridTableView: TcxGridDBTableView
        object NameColumn: TcxGridDBColumn
          Caption = #1048#1084#1103
        end
        object SurnameColumn: TcxGridDBColumn
          Caption = #1060#1072#1084#1080#1083#1080#1103
        end
        object PatronymicColumn: TcxGridDBColumn
          Caption = #1054#1090#1095#1077#1089#1090#1074#1086
        end
        object BirthDateColumn: TcxGridDBColumn
          Caption = #1044#1072#1090#1072' '#1088#1086#1078#1076#1077#1085#1080#1103
        end
        object SpecialityColumn: TcxGridDBColumn
          Caption = #1044#1086#1083#1078#1085#1086#1089#1090#1100
        end
      end
    end
  end
  inherited imgLstDisabled: TPngImageList
    Left = 472
    Top = 56
  end
  inherited imgLstEnabled: TPngImageList
    Left = 440
    Top = 56
  end
  inherited DataOperationActionList: TActionList
    Left = 344
    Top = 56
  end
  inherited DataOperationPopupMenu: TPopupMenu
    Left = 376
    Top = 56
  end
  inherited TargetDataSource: TDataSource
    Left = 408
    Top = 56
  end
  inherited ExportDataPopupMenu: TPopupMenu
    Left = 536
    Top = 56
  end
  inherited ExportDataDialog: TSaveDialog
    Left = 504
    Top = 56
  end
  inherited Localizer: TcxLocalizer
    Left = 568
  end
end
