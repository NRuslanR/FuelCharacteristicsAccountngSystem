unit unFuelCharacteristicsAccountingReferenceForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxGraphics,
  cxLookAndFeels, cxLookAndFeelPainters, Menus, dxSkinsCore,
  dxSkinsDefaultPainters, cxControls, cxStyles, dxSkinscxPC3Painter,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, DB, cxDBData,
  cxLocalization, ActnList, ImgList, PngImageList, cxGridLevel, cxClasses,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxGrid, ComCtrls, ExtCtrls, StdCtrls, cxButtons, ToolWin,
  FuelCharacteristicsAccountingReferenceDataSetHolder,
  FuelCharacteristicsAccountingReferenceFormViewModel,
  FuelCharacteristicsAccountingReferenceRecordViewModel,
  TableViewFilterFormUnit, unFuelCharacteristicsAccountingReferenceFilterForm,
  unBaseFuelCharacteristicsAccountingReferenceForm,
  ReferenceFormViewModel, ReferenceFormDataSetHolder, ReferenceFormRecordViewModel;

type

  TFuelCharacteristicsAccountingReferenceForm = class(TBaseFuelCharacteristicsAccountingReferenceForm)
    TemperatureColumn: TcxGridDBColumn;
    DensityColumn: TcxGridDBColumn;
    FuelRiseLevelColumn: TcxGridDBColumn;
    FuelMassColumn: TcxGridDBColumn;
    PerformedCalculationEmployeeNameColumn: TcxGridDBColumn;
    CalculationPerformingDateTimeColumn: TcxGridDBColumn;
    FuelKindColumn: TcxGridDBColumn;
    ReservoirNumberColumn: TcxGridDBColumn;
    PerformedCalculationEmployeeIdColumn: TcxGridDBColumn;

    protected

      procedure CreateTableColumnLayoutFrom(
        DataSetFieldDefs: TReferenceFormDataSetFieldDefs
      ); override;

      function DataSetHolder: TFuelCharacteristicsAccountingReferenceDataSetHolder;

    protected

      function GetMessageAboutThatUserAssuredThatWantDeleteSelectedRecords: String; override;
      function GetTotalRecordCountPanelLabel: String; override;

    protected

      function GetReferenceFormRecordViewModelClass: TReferenceFormRecordViewModelClass; override;

      procedure FillRecordViewModelFromGridRecord(
        RecordViewModel: TReferenceFormRecordViewModel;
        GridRecord: TcxCustomGridRecord
      ); override;

      procedure InternalSetCurrentDataSetRecordFieldValuesFromViewModel(
        RecordViewModel: TReferenceFormRecordViewModel
      ); override;
      
    end;

implementation

{$R *.dfm}

{ TFuelCharacteristicsAccountingReferenceForm }



{ TFuelCharacteristicsAccountingReferenceForm }

procedure TFuelCharacteristicsAccountingReferenceForm.CreateTableColumnLayoutFrom(
  DataSetFieldDefs: TReferenceFormDataSetFieldDefs);
begin

  inherited;

  with DataSetFieldDefs as TFuelCharacteristicsAccountingReferenceDataSetFieldDefs
  do begin

    TemperatureColumn.DataBinding.FieldName := TemperatureFieldName;
    DensityColumn.DataBinding.FieldName := DensityFieldName;
    FuelRiseLevelColumn.DataBinding.FieldName := FuelRiseLevelFieldName;
    FuelMassColumn.DataBinding.FieldName := FuelMassFieldName;
    FuelKindColumn.DataBinding.FieldName := FuelKindFieldName;
    ReservoirNumberColumn.DataBinding.FieldName := ReservoirNumberFieldName;
    PerformedCalculationEmployeeIdColumn.DataBinding.FieldName := PerformedCalculationEmployeeIdFieldName;
    PerformedCalculationEmployeeNameColumn.DataBinding.FieldName := PerformedCalculationEmployeeNameFieldName;
    CalculationPerformingDateTimeColumn.DataBinding.FieldName := CalculationPerformingDateTimeFieldName;

  end;         

end;

function TFuelCharacteristicsAccountingReferenceForm.DataSetHolder: TFuelCharacteristicsAccountingReferenceDataSetHolder;
begin

  Result := TFuelCharacteristicsAccountingReferenceDataSetHolder(inherited DataSetHolder);

end;

procedure TFuelCharacteristicsAccountingReferenceForm.FillRecordViewModelFromGridRecord(
  RecordViewModel: TReferenceFormRecordViewModel;
  GridRecord: TcxCustomGridRecord);
begin

  inherited;

  with GridRecord,
       RecordViewModel as TFuelCharacteristicsAccountingReferenceRecordViewModel
  do begin

    Temperature := Values[TemperatureColumn.Index];
    Density := Values[DensityColumn.Index];
    FuelRiseLevel := Values[FuelRiseLevelColumn.Index];
    FuelMass := Values[FuelMassColumn.Index];
    FuelKind := Values[FuelKindColumn.Index];
    ReservoirNumber := Values[ReservoirNumberColumn.Index];
    PerformedCalculationEmployeeId := Values[PerformedCalculationEmployeeIdColumn.Index];
    PerformedCalculationEmployeeName := Values[PerformedCalculationEmployeeNameColumn.Index];
    CalculationPerformingDateTime := Values[CalculationPerformingDateTimeColumn.Index];

  end;

end;

function TFuelCharacteristicsAccountingReferenceForm.GetMessageAboutThatUserAssuredThatWantDeleteSelectedRecords: String;
begin

  Result := 'Вы уверены, что хотите удалить выбранные расчёты ?';

end;

function TFuelCharacteristicsAccountingReferenceForm.GetReferenceFormRecordViewModelClass: TReferenceFormRecordViewModelClass;
begin
                      
  Result := TFuelCharacteristicsAccountingReferenceRecordViewModel;
  
end;

function TFuelCharacteristicsAccountingReferenceForm.GetTotalRecordCountPanelLabel: String;
begin

  Result := 'Количество расчётов: ';

end;

procedure TFuelCharacteristicsAccountingReferenceForm.
  InternalSetCurrentDataSetRecordFieldValuesFromViewModel(
    RecordViewModel: TReferenceFormRecordViewModel
  );
begin

  inherited;

  with DataSetHolder,
       RecordViewModel as TFuelCharacteristicsAccountingReferenceRecordViewModel
  do begin

    TemperatureFieldValue := Temperature;
    DensityFieldValue := Density;
    FuelRiseLevelFieldValue := FuelRiseLevel;
    FuelMassFieldValue := FuelMass;
    FuelKindFieldValue := FuelKind;
    ReservoirNumberFieldValue := ReservoirNumber;
    PerformedCalculationEmployeeIdFieldValue := PerformedCalculationEmployeeId;
    PerformedCalculationEmployeeNameFieldValue := PerformedCalculationEmployeeName;
    CalculationPerformingDateTimeFieldValue := CalculationPerformingDateTime;
    
  end;

end;

end.