unit FuelCharacteristicsCalculationCardDto;

interface

uses

  EntityDto,
  EmployeeDto,
  SysUtils,
  Classes;

type

  TFuelCharacteristicsCalculationCardDto = class (TEntityDto)

    private

      FPerformedCalculationEmployeeDto: TEmployeeDto;
      
      function GetPerformedCalculationEmployeeDto: TEmployeeDto;
      procedure SetPerformedCalculationEmployeeDto(const Value: TEmployeeDto);

    public

      
      FuelTemperature: Variant;
      FuelDensity: Variant;
      FuelRiseLevel: Variant;
      FuelMass: Variant;
      FuelKind: String;
      ReservoirNumber: Variant;
      CalculationPerformingDateTime: Variant;

      property PerformedCalculationEmployeeDto: TEmployeeDto
      read GetPerformedCalculationEmployeeDto
      write SetPerformedCalculationEmployeeDto;

      destructor Destroy; override;
      
      constructor Create; override;

  end;

implementation

uses

  Variants;
  
{ TFuelCharacteristicsCalculationCardDto }

constructor TFuelCharacteristicsCalculationCardDto.Create;
begin

  inherited Create;

  FuelTemperature := Null;
  FuelDensity := Null;
  FuelRiseLevel := Null;
  FuelMass := Null;
  ReservoirNumber := Null;
  CalculationPerformingDateTime := Null;

  FPerformedCalculationEmployeeDto := TEmployeeDto.Create;
  
end;

destructor TFuelCharacteristicsCalculationCardDto.Destroy;
begin

  FreeAndNil(FPerformedCalculationEmployeeDto);
  
  inherited;

end;

function TFuelCharacteristicsCalculationCardDto.
  GetPerformedCalculationEmployeeDto: TEmployeeDto;
begin

  Result := FPerformedCalculationEmployeeDto;

end;

procedure TFuelCharacteristicsCalculationCardDto.
  SetPerformedCalculationEmployeeDto(
    const Value: TEmployeeDto
  );
begin

  if FPerformedCalculationEmployeeDto = Value then
    Exit;

  FreeAndNil(FPerformedCalculationEmployeeDto);

  FPerformedCalculationEmployeeDto := Value;
  
end;

end.
