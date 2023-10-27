unit FuelCharacteristicsCalculation;

interface

uses

  DomainObjectValueUnit;

type

  TFuelCharacteristicsCalculation = class (TDomainObjectValue)

    private

      {FFuelTemperature: Single;
      FFuelRiseLevel: Single;
      FFuelDensity: Single;}
      FFuelMass: Single;
      
      {procedure SetFuelDensity(const Value: Single);
      procedure SetFuelRiseLevel(const Value: Single);
      procedure SetFuelTemperature(const Value: Single);}
      procedure SetFuelMass(const Value: Single);
      
    published

      {property FuelTemperature: Single
      read FFuelTemperature write SetFuelTemperature;
      
      property FuelRiseLevel: Single
      read FFuelRiseLevel write SetFuelRiseLevel;

      property FuelDensity: Single
      read FFuelDensity write SetFuelDensity;
      }

      property FuelMass: Single
      read FFuelMass write SetFuelMass;

  end;
  
implementation

{ TFuelCharacteristicsCalculation }

procedure TFuelCharacteristicsCalculation.SetFuelMass(
  const Value: Single);
begin

  FFuelMass := Value;
  
end;
                                {
procedure TFuelCharacteristicsCalculation.SetFuelDensity(const Value: Single);
begin

  FFuelDensity := Value;

end;

procedure TFuelCharacteristicsCalculation.SetFuelRiseLevel(const Value: Single);
begin

  FFuelRiseLevel := Value;

end;

procedure TFuelCharacteristicsCalculation.SetFuelTemperature(const Value: Single);
begin

  FFuelTemperature := Value;

end;        }

end.
