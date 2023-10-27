unit FuelCharacteristicsAutomaticCalculationFormControllerEvents;

interface

uses

  Event,
  SysUtils,
  FuelCharacteristicsCalculationCardFormViewModel,
  FuelCharacteristicsAutomaticCalculationFormViewModel,
  Classes;

type

  TFuelCharacteristicsAutomaticCalculationRequestedEvent = class (TEvent)

    private

      FFuelCharacteristicsCalculationCardFormViewModel:
        TFuelCharacteristicsCalculationCardFormViewModel;

    public

      constructor Create(
        FuelCharacteristicsCalculationCardFormViewModel:
          TFuelCharacteristicsCalculationCardFormViewModel
      );

      property FuelCharacteristicsCalculationCardFormViewModel:
        TFuelCharacteristicsCalculationCardFormViewModel
      read FFuelCharacteristicsCalculationCardFormViewModel;

  end;

  TCalculatedFuelCharacteristicsApplyingRequestedEvent = class (TEvent)

    private

      FFuelCharacteristicsAutomaticCalculationFormViewModel:
        TFuelCharacteristicsAutomaticCalculationFormViewModel;

    public

      constructor Create(
        FuelCharacteristicsAutomaticCalculationFormViewModel:
          TFuelCharacteristicsAutomaticCalculationFormViewModel
      );

      property FuelCharacteristicsAutomaticCalculationFormViewModel:
        TFuelCharacteristicsAutomaticCalculationFormViewModel
      read FFuelCharacteristicsAutomaticCalculationFormViewModel;

  end;
  
implementation

{ TCalculatedFuelCharacteristicsApplyingRequestedEvent }

constructor TCalculatedFuelCharacteristicsApplyingRequestedEvent.Create(

  FuelCharacteristicsAutomaticCalculationFormViewModel:
    TFuelCharacteristicsAutomaticCalculationFormViewModel

  );
begin

  inherited Create;

  FFuelCharacteristicsAutomaticCalculationFormViewModel :=
    FuelCharacteristicsAutomaticCalculationFormViewModel;

end;

{ TFuelCharacteristicsAutomaticCalculationRequestedEvent }

constructor TFuelCharacteristicsAutomaticCalculationRequestedEvent.Create(

  FuelCharacteristicsCalculationCardFormViewModel:
    TFuelCharacteristicsCalculationCardFormViewModel

);
begin

  inherited Create;

  FFuelCharacteristicsCalculationCardFormViewModel :=
    FuelCharacteristicsCalculationCardFormViewModel;

end;

end.
