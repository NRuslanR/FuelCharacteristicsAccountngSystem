inherited ReservoirKindReferenceSuitesForm: TReservoirKindReferenceSuitesForm
  Caption = #1057#1087#1088#1072#1074#1086#1095#1085#1099#1077' '#1076#1072#1085#1085#1099#1077' '#1090#1080#1087#1086#1074' '#1088#1077#1079#1077#1088#1074#1091#1072#1088#1086#1074
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  inherited DataRecordMovingToolBar: TToolBar
    ExplicitTop = 100
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
        inherited IdColumn: TcxGridDBColumn
          Caption = #1058#1080#1087' '#1088#1077#1079#1077#1088#1074#1091#1072#1088#1086#1074
          Visible = True
          Width = 194
        end
        object HSCColumn: TcxGridDBColumn
          Caption = #1042#1058#1055' ('#1084#1084')'
          Width = 100
        end
        object CalibrationChartLocationColumn: TcxGridDBColumn
          Caption = #1043#1088#1072#1076#1091#1080#1088#1086#1074#1086#1095#1085#1072#1103' '#1090#1072#1073#1083#1080#1094#1072
          Width = 443
        end
      end
    end
  end
end
