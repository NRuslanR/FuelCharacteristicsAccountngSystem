unit StubFuelCharacteristicsAccountingReferenceFormController;

interface

uses

  Forms,
  AbstractDataSetHolder,
  ReferenceFormViewModel,
  FuelCharacteristicsAccountingReferenceFormViewModel,
  BaseFuelCharacteristicsAccountingReferenceFormController,
  FuelCharacteristicsAccountingReferenceDataSetHolder,
  SysUtils,
  Classes;

type

  TStubFuelCharacteristicsAccountingReferenceFormController =
    class (TBaseFuelCharacteristicsAccountingReferenceFormController)

      protected

        function CreateReferenceFormViewModel: TReferenceFormViewModel; override;
        
    end;

implementation

uses

  TestDataSetModule;

{ TStubFuelCharacteristicsAccountingReferenceFormController }

function TStubFuelCharacteristicsAccountingReferenceFormController.
  CreateReferenceFormViewModel: TReferenceFormViewModel;
begin

  Result := TFuelCharacteristicsAccountingReferenceFormViewModel.Create;

  Result.AddingRecordAllowed := True;
  Result.EditingRecordAllowed := True;
  Result.RemovingRecordAllowed := True;

  Result.DataSetHolder :=
    TFuelCharacteristicsAccountingReferenceDataSetHolder.CreateFrom(
      TestDataSetModule.TDataModule1.Create(Application).TestMemDataSet
    );

  Result.DataSetHolder.FieldDefs :=
    TFuelCharacteristicsAccountingReferenceDataSetFieldDefs.Create;

  Result.DataSetHolder.RecordIdGenerator :=
    TNegativeIntegerDataSetRecordIdGenerator.Create(
      TIntegerDataSetRecordIdGenerator.Create
    );

  with
    Result.DataSetHolder as TFuelCharacteristicsAccountingReferenceDataSetHolder
  do begin

    IdFieldName := 'id';
    FieldDefs.IsRecordIdGeneratedFieldName := 'is_id_generated';
    TemperatureFieldName := 'temperature';
    DensityFieldName := 'density';
    FuelRiseLevelFieldName := 'fuel_rise_level';
    FuelMassFieldName := 'fuel_mass';
    FuelKindFieldName := 'fuel_kind';
    ReservoirNumberFieldName := 'reservoir_number';
    PerformedCalculationEmployeeIdFieldName := 'performed_calculation_employee_id';
    PerformedCalculationEmployeeNameFieldName := 'performed_calculation_employee_name';
    CalculationPerformingDateTimeFieldName := 'calculation_performing_datetime';
    CanBeChangedFieldName := 'can_be_changed';
    CanBeRemovedFieldName := 'can_be_removed';

  end;

end;

end.
