unit FuelCharacteristicsCalculationService;

interface

uses

  Employee,
  DomainService,
  DomainObjectValueUnit,
  FuelCharacteristicsCalculation,
  ReservoirSubLayerCharacteristicsCalculationInput,
  DomainException,
  SysUtils;

type

  TFuelCharacteristicsCalculationServiceException = class (TDomainException)

  end;
  
  TFuelCharacteristicsCalculationInput = class (TDomainObjectValue)

    private

      FReservoirKindName: String;

      FFuelTemperature: Single;
      FFuelRiseLevel: Single;
      FFuelDensity: Single;

      FReservoirSubLayerCharacteristicsCalculationInput:
        TReservoirSubLayerCharacteristicsCalculationInput;

      procedure SetReservoirKindName(const Value: String);
      procedure SetFuelDensity(const Value: Single);
      procedure SetFuelRiseLevel(const Value: Single);
      procedure SetFuelTemperature(const Value: Single);
      
      procedure SetReservoirSubLayerCharacteristicsCalculationInput(
        const Value: TReservoirSubLayerCharacteristicsCalculationInput
      );
      
    public

      property ReservoirKindName: String
      read FReservoirKindName write SetReservoirKindName;

      property FuelTemperature: Single
      read FFuelTemperature write SetFuelTemperature;
      
      property FuelRiseLevel: Single
      read FFuelRiseLevel write SetFuelRiseLevel;

      property FuelDensity: Single
      read FFuelDensity write SetFuelDensity;

      property ReservoirSubLayerCharacteristicsCalculationInput:
        TReservoirSubLayerCharacteristicsCalculationInput
      read FReservoirSubLayerCharacteristicsCalculationInput
      write SetReservoirSubLayerCharacteristicsCalculationInput;
    
  end;
  
  IFuelCharacteristicsCalculationService = interface (IDomainService)

    function CalculateFuelCharacteristicsOnBehalfOfEmployee(
      Input: TFuelCharacteristicsCalculationInput;
      Employee: TEmployee
    ): TFuelCharacteristicsCalculation;

  end;

implementation

{ TFuelCharacteristicsCalculationInput }

procedure TFuelCharacteristicsCalculationInput.SetFuelDensity(
  const Value: Single);
begin

  FFuelDensity := Value;

end;

procedure TFuelCharacteristicsCalculationInput.SetFuelRiseLevel(
  const Value: Single);
begin

  FFuelRiseLevel := Value;

end;

procedure TFuelCharacteristicsCalculationInput.SetFuelTemperature(
  const Value: Single);
begin

  FFuelTemperature := Value;

end;

procedure TFuelCharacteristicsCalculationInput.SetReservoirKindName(
  const Value: String);
begin

  FReservoirKindName := Value;

end;

procedure TFuelCharacteristicsCalculationInput.
  SetReservoirSubLayerCharacteristicsCalculationInput(
    const Value: TReservoirSubLayerCharacteristicsCalculationInput
  );
begin

  if FReservoirSubLayerCharacteristicsCalculationInput = Value then
    Exit;

  FreeAndNil(FReservoirSubLayerCharacteristicsCalculationInput);
  
  FReservoirSubLayerCharacteristicsCalculationInput := Value;

end;

end.
