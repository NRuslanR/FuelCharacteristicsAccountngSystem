unit MockRandomCalculationElectronicMetroshtok;

interface

uses

  ElectronicMetroshtok,
  AbstractDomainService,
  ElectronicMetroshtokCalculationResult,
  SysUtils,
  Classes;

type

  TFuelCharacteristicFloatValueRange = record

    LowerBound: Single;
    UpperBound: Single;

    constructor Create(LowerBound, UpperBound: Single);

  end;
  
  TMockRandomCalculationElectronicMetroshtok  =
    class (TAbstractDomainService, IElectronicMetroshtok)

      private

        FFuelTemperatureRange: TFuelCharacteristicFloatValueRange;
        FFuelRiseLevelRange: TFuelCharacteristicFloatValueRange;
        FFuelDensityRange: TFuelCharacteristicFloatValueRange;
        FBottomWaterLevelRange: TFuelCharacteristicFloatValueRange;

        function GetRandomFloatValueFromRange(
          const LowerBound, UpperBound: Single
        ): Single;
        
      public

        constructor Create(
          FuelTemperatureRange: TFuelCharacteristicFloatValueRange;
          FuelRiseLevelRange: TFuelCharacteristicFloatValueRange;
          FuelDensityRange: TFuelCharacteristicFloatValueRange;
          BottomWaterLevelRange: TFuelCharacteristicFloatValueRange
        );

        function PerformCalculation: TElectronicMetroshtokCalculationResult;
    
    end;

implementation

{ TMockRandomCalculationElectronicMetroshtok }

constructor TMockRandomCalculationElectronicMetroshtok.Create(
  FuelTemperatureRange, FuelRiseLevelRange, FuelDensityRange,
  BottomWaterLevelRange: TFuelCharacteristicFloatValueRange);
begin

  inherited Create;

  Randomize;
  
  FFuelTemperatureRange := FuelTemperatureRange;
  FFuelRiseLevelRange := FuelRiseLevelRange;
  FFuelDensityRange := FuelDensityRange;
  FBottomWaterLevelRange := BottomWaterLevelRange;

end;

function TMockRandomCalculationElectronicMetroshtok.
  GetRandomFloatValueFromRange(
    const LowerBound, UpperBound: Single
  ): Single;
begin

  Result := LowerBound + Round(Random * (UpperBound - LowerBound));
  
end;

function TMockRandomCalculationElectronicMetroshtok.
  PerformCalculation: TElectronicMetroshtokCalculationResult;
begin

  Result := TElectronicMetroshtokCalculationResult.Create;

  try

    Result.FuelTemperature :=
      GetRandomFloatValueFromRange(
        FFuelTemperatureRange.LowerBound, FFuelTemperatureRange.UpperBound
      );

    Result.FuelRiseLevel :=
      GetRandomFloatValueFromRange(
        FFuelRiseLevelRange.LowerBound, FFuelRiseLevelRange.UpperBound
      );

    Result.FuelDensity :=
      GetRandomFloatValueFromRange(
        FFuelDensityRange.LowerBound, FFuelDensityRange.UpperBound
      );

    Result.BottomWaterLevel :=
      GetRandomFloatValueFromRange(
        FBottomWaterLevelRange.LowerBound, FBottomWaterLevelRange.UpperBound
      );
      
  except

    on e: Exception do begin

      FreeAndNil(Result);

      raise;
      
    end;

  end;

end;

{ TFuelCharacteristicFloatValueRange }

constructor TFuelCharacteristicFloatValueRange.Create(LowerBound,
  UpperBound: Single);
begin

  Self.LowerBound := LowerBound;
  Self.UpperBound := UpperBound;
  
end;

end.
