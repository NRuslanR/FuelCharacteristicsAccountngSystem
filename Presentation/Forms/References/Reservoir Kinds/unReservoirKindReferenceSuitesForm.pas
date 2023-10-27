unit unReservoirKindReferenceSuitesForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, unBaseFuelCharacteristicsAccountingReferenceForm, cxGraphics,
  cxLookAndFeels, cxLookAndFeelPainters, Menus, cxControls, cxStyles,
  dxSkinsCore, dxSkinsDefaultPainters, dxSkinscxPC3Painter, cxCustomData,
  cxFilter, cxData, cxDataStorage, cxEdit, DB, cxDBData, cxLocalization,
  ActnList, ImgList, PngImageList, cxGridLevel, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxClasses, cxGridCustomView, cxGrid,
  ComCtrls, ExtCtrls, StdCtrls, cxButtons, ToolWin,
  ReferenceFormDataSetHolder, ReferenceFormRecordViewModel,
  ReferenceFormViewModel, ReservoirKindReferenceSuitesFormViewModel,
  ReservoirKindReferenceSuitesDataSetHolder,
  ReservoirKindReferenceSuiteRecordViewModel;

type
  TReservoirKindReferenceSuitesForm =
    class(TBaseFuelCharacteristicsAccountingReferenceForm)
      HSCColumn: TcxGridDBColumn;
      CalibrationChartLocationColumn: TcxGridDBColumn;

    private

      function GetReservoirKindReferenceSuitesFormViewModel:
        TReservoirKindReferenceSuitesFormViewModel;

      procedure SetReservoirKindReferenceSuitesFormViewModel(
        const Value: TReservoirKindReferenceSuitesFormViewModel
      );

    protected

      function GetTotalRecordCountPanelLabel: String; override;
      
    protected

      function DataSetHolder: TReservoirKindReferenceSuitesDataSetHolder;

      procedure CreateTableColumnLayoutFrom(
        DataSetFieldDefs: TReferenceFormDataSetFieldDefs
      ); override;

    protected

      function GetReferenceFormRecordViewModelClass: TReferenceFormRecordViewModelClass; override;

      procedure FillRecordViewModelFromGridRecord(
        RecordViewModel: TReferenceFormRecordViewModel;
        GridRecord: TcxCustomGridRecord
      ); override;

      procedure InternalSetCurrentDataSetRecordFieldValuesFromViewModel(
        RecordViewModel: TReferenceFormRecordViewModel
      ); override;

    public

      property ViewModel: TReservoirKindReferenceSuitesFormViewModel
      read GetReservoirKindReferenceSuitesFormViewModel
      write SetReservoirKindReferenceSuitesFormViewModel;
      
    end;

var
  ReservoirKindReferenceSuitesForm: TReservoirKindReferenceSuitesForm;

implementation

{$R *.dfm}

{ TReservoirKindReferenceSuitesForm }

procedure TReservoirKindReferenceSuitesForm.CreateTableColumnLayoutFrom(
  DataSetFieldDefs: TReferenceFormDataSetFieldDefs);
begin

  inherited;

  with DataSetFieldDefs as TReservoirKindReferenceSuitesDataSetFieldDefs
  do begin

    HSCColumn.DataBinding.FieldName := HSCValueFieldName;

    CalibrationChartLocationColumn.DataBinding.FieldName :=
      CalibrationChartLocationFieldName;

  end;

end;

function TReservoirKindReferenceSuitesForm.
  DataSetHolder: TReservoirKindReferenceSuitesDataSetHolder;
begin

  Result :=
    TReservoirKindReferenceSuitesDataSetHolder(inherited DataSetHolder);
    
end;

procedure TReservoirKindReferenceSuitesForm.FillRecordViewModelFromGridRecord(
  RecordViewModel: TReferenceFormRecordViewModel;
  GridRecord: TcxCustomGridRecord);
begin

  inherited;

  with RecordViewModel as TReservoirKindReferenceSuiteRecordViewModel
  do begin

    HSCValue := GridRecord.Values[HSCColumn.Index];
    CalibrationChartLocation := GridRecord.Values[CalibrationChartLocationColumn.Index];

  end;

end;

function TReservoirKindReferenceSuitesForm.
  GetReferenceFormRecordViewModelClass: TReferenceFormRecordViewModelClass;
begin

  Result := TReservoirKindReferenceSuiteRecordViewModel;
  
end;

function TReservoirKindReferenceSuitesForm.
  GetReservoirKindReferenceSuitesFormViewModel:
    TReservoirKindReferenceSuitesFormViewModel;
begin

  Result := TReservoirKindReferenceSuitesFormViewModel(inherited ViewModel);
  
end;

function TReservoirKindReferenceSuitesForm.GetTotalRecordCountPanelLabel: String;
begin

  Result := 'Количество типов резервуаров: ';

end;

procedure TReservoirKindReferenceSuitesForm.
  InternalSetCurrentDataSetRecordFieldValuesFromViewModel(
    RecordViewModel: TReferenceFormRecordViewModel
  );
begin

  inherited;

  with RecordViewModel as TReservoirKindReferenceSuiteRecordViewModel
  do begin

    DataSetHolder.HSCValueFieldValue := HSCValue;
    DataSetHolder.CalibrationChartLocationFieldValue := CalibrationChartLocation;
    
  end;

end;

procedure TReservoirKindReferenceSuitesForm.
  SetReservoirKindReferenceSuitesFormViewModel(
    const Value: TReservoirKindReferenceSuitesFormViewModel
  );
begin

  SetViewModel(Value);
  
end;

end.
