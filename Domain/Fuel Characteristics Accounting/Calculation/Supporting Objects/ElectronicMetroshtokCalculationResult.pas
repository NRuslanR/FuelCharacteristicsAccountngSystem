unit ElectronicMetroshtokCalculationResult;

interface

uses

  DomainObjectValueUnit,
  SysUtils,
  Classes;

type

  TElectronicMetroshtokCalculationResult = class (TDomainObjectValue)

    private

      FFuelTemperature: Single;
      FFuelRiseLevel: Single;
      FFuelDensity: Single;
      FBottomWaterLevel: Single;

      procedure SetBottomWaterLevel(const Value: Single);
      procedure SetFuelDensity(const Value: Single);
      procedure SetFuelRiseLevel(const Value: Single);
      procedure SetFuelTemperature(const Value: Single);

    published

      property FuelTemperature: Single
      read FFuelTemperature write SetFuelTemperature;
      
      property FuelRiseLevel: Single
      read FFuelRiseLevel write SetFuelRiseLevel;
      
      property FuelDensity: Single
      read FFuelDensity write SetFuelDensity;
      
      property BottomWaterLevel: Single
      read FBottomWaterLevel write SetBottomWaterLevel;

  end;

implementation

{ TElectronicMetroshtokCalculationResult }

procedure TElectronicMetroshtokCalculationResult.SetBottomWaterLevel(
  const Value: Single);
begin

  FBottomWaterLevel := Value;

end;

procedure TElectronicMetroshtokCalculationResult.SetFuelDensity(
  const Value: Single);
begin

  FFuelDensity := Value;

end;

procedure TElectronicMetroshtokCalculationResult.SetFuelRiseLevel(
  const Value: Single);
begin

  FFuelRiseLevel := Value;

end;

procedure TElectronicMetroshtokCalculationResult.SetFuelTemperature(
  const Value: Single);
begin

  FFuelTemperature := Value;
  
end;

end.
