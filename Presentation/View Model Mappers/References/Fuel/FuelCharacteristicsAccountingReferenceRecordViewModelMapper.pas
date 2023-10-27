unit FuelCharacteristicsAccountingReferenceRecordViewModelMapper;

interface

uses

  AbstractReferenceFormRecordViewModelMapper,
  FuelCharacteristicsCalculationCardFormViewModel,
  FuelCharacteristicsAccountingReferenceRecordViewModel,
  CardFormViewModel,
  ReferenceFormRecordViewModel,
  Disposable,

  SysUtils,
  Classes;

type

  TFuelCharacteristicsAccountingReferenceRecordViewModelMapper =
    class (TAbstractReferenceFormRecordViewModelMapper)

      protected

        function GetReferenceFormRecordViewModelClass: TReferenceFormRecordViewModelClass; override;

        procedure FillReferenceFormRecordViewModelFrom(
          ReferenceFormRecordViewModel: TReferenceFormRecordViewModel;
          CardFormViewModel: TCardFormViewModel;
          const CanBeChanged: Boolean = True;
          const CanBeRemoved: Boolean = True
        ); override;

    end;

implementation

uses

  Variants;

{ TFuelCharacteristicsAccountingReferenceRecordViewModelMapper }

procedure TFuelCharacteristicsAccountingReferenceRecordViewModelMapper.FillReferenceFormRecordViewModelFrom(
  ReferenceFormRecordViewModel: TReferenceFormRecordViewModel;
  CardFormViewModel: TCardFormViewModel; const CanBeChanged,
  CanBeRemoved: Boolean);
var FuelCharacteristicsCalculationCardFormViewModel: TFuelCharacteristicsCalculationCardFormViewModel;
begin

  inherited;

  FuelCharacteristicsCalculationCardFormViewModel :=
    CardFormViewModel as TFuelCharacteristicsCalculationCardFormViewModel;

  with
    ReferenceFormRecordViewModel as TFuelCharacteristicsAccountingReferenceRecordViewModel
  do begin

    Temperature := FuelCharacteristicsCalculationCardFormViewModel.FuelTemperature.Value;
    Density := FuelCharacteristicsCalculationCardFormViewModel.FuelDensity.Value;
    FuelRiseLevel := FuelCharacteristicsCalculationCardFormViewModel.FuelRiseLevel.Value;
    FuelMass := FuelCharacteristicsCalculationCardFormViewModel.FuelMass.Value;
    FuelKind := FuelCharacteristicsCalculationCardFormViewModel.FuelKind.Value;
    ReservoirNumber := FuelCharacteristicsCalculationCardFormViewModel.ReservoirNumber.Value;
    PerformedCalculationEmployeeId := FuelCharacteristicsCalculationCardFormViewModel.PerformedCalculationEmployeeId.Value;
    PerformedCalculationEmployeeName := FuelCharacteristicsCalculationCardFormViewModel.PerformedCalculationEmployeeName.Value;
    CalculationPerformingDateTime := FuelCharacteristicsCalculationCardFormViewModel.CalculationPerformingDateTime.Value;

  end;

end;

function TFuelCharacteristicsAccountingReferenceRecordViewModelMapper.GetReferenceFormRecordViewModelClass: TReferenceFormRecordViewModelClass;
begin

  Result := TFuelCharacteristicsAccountingReferenceRecordViewModel;
  
end;

end.
