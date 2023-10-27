unit FuelCharacteristicsAccountingMainFormControllerEvents;

interface

uses

  Event,
  unFuelCharacteristicsAccountingMainForm,
  SysUtils,
  Classes;

type

  TFuelCharacteristicsAccountingMainFormCreatedEvent = class (TEvent)

    private

      FFuelCharacteristicsAccountingMainForm: TFuelCharacteristicsAccountingMainForm;

    public

      constructor Create(
        FuelCharacteristicsAccountingMainForm: TFuelCharacteristicsAccountingMainForm
      );

      property FuelCharacteristicsAccountingMainForm:
        TFuelCharacteristicsAccountingMainForm
      read FFuelCharacteristicsAccountingMainForm
      write FFuelCharacteristicsAccountingMainForm;

  end;

  TFuelCharacteristicsAccountingAdministrationFormRequestedEvent = class (TEvent)

  end;

implementation

{ TFuelCharacteristicsAccountingMainFormCreated }

constructor TFuelCharacteristicsAccountingMainFormCreatedEvent.Create(
  FuelCharacteristicsAccountingMainForm: TFuelCharacteristicsAccountingMainForm
);
begin

  inherited Create;

  FFuelCharacteristicsAccountingMainForm := FuelCharacteristicsAccountingMainForm;

end;

end.
