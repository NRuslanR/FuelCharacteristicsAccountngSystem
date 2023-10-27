unit FuelCharacteristicsCalculationCardDtoMapper;

interface

uses

  FuelCharacteristicsCalculationCardFormViewModel,
  EntityDto,
  EntityDtoMapper,
  CardFormViewModel,
  EmployeeDto,
  FuelCharacteristicsCalculationCardDto,
  SysUtils,
  Classes;

type

  TFuelCharacteristicsCalculationCardDtoMapper = class (TEntityDtoMapper)

    protected

      function GetEntityDtoClass: TEntityDtoClass; override;

    public


      function MapFuelCharacteristicsCalculationCardDtoFrom(
      
        FuelCharacteristicsCalculationCardFormViewModel:
          TFuelCharacteristicsCalculationCardFormViewModel

      ): TFuelCharacteristicsCalculationCardDto;

      procedure FillFuelCharacteristicsCalculationCardDtoFrom(

        FuelCharacteristicsCalculationCardDto:
          TFuelCharacteristicsCalculationCardDto;

        FuelCharacteristicsCalculationCardFormViewModel:
          TFuelCharacteristicsCalculationCardFormViewModel
      );

      procedure FillEntityDtoFrom(
        EntityDto: TEntityDto;
        CardFormViewModel: TCardFormViewModel
      ); override;
      
  end;
  
implementation

uses

  Variants;
  
{ TFuelCharacteristicsCalculationCardDtoMapper }

procedure TFuelCharacteristicsCalculationCardDtoMapper.FillEntityDtoFrom(
  EntityDto: TEntityDto;
  CardFormViewModel: TCardFormViewModel
);
var CardDto: TFuelCharacteristicsCalculationCardDto;
begin

  inherited;

  CardDto := TFuelCharacteristicsCalculationCardDto(EntityDto);

  with CardFormViewModel as TFuelCharacteristicsCalculationCardFormViewModel
  do begin

    CardDto.FuelTemperature := FuelTemperature.Value;
    CardDto.FuelDensity := FuelDensity.Value;
    CardDto.FuelRiseLevel := FuelRiseLevel.Value;
    CardDto.FuelMass := FuelMass.Value;
    CardDto.FuelKind := FuelKind.Value;
    CardDto.ReservoirNumber := ReservoirNumber.Value;

    if
      (not CalculationPerformingDateTimeChangingEnabled) and not Id.IsAssigned
    then
      CardDto.CalculationPerformingDateTime := Null

    else begin

      CardDto.CalculationPerformingDateTime :=
        CalculationPerformingDateTime.Value;

    end;

    CardDto.PerformedCalculationEmployeeDto.Id :=
      PerformedCalculationEmployeeId.Value;

  end;
  
end;

procedure TFuelCharacteristicsCalculationCardDtoMapper.
  FillFuelCharacteristicsCalculationCardDtoFrom(

    FuelCharacteristicsCalculationCardDto:
      TFuelCharacteristicsCalculationCardDto;

    FuelCharacteristicsCalculationCardFormViewModel:
      TFuelCharacteristicsCalculationCardFormViewModel

  );
begin

  FillEntityDtoFrom(
    FuelCharacteristicsCalculationCardDto,
    FuelCharacteristicsCalculationCardFormViewModel
  );
  
end;

function TFuelCharacteristicsCalculationCardDtoMapper.
  GetEntityDtoClass: TEntityDtoClass;
begin

  Result := TFuelCharacteristicsCalculationCardDto;

end;

function TFuelCharacteristicsCalculationCardDtoMapper.
  MapFuelCharacteristicsCalculationCardDtoFrom(

    FuelCharacteristicsCalculationCardFormViewModel:
      TFuelCharacteristicsCalculationCardFormViewModel

  ): TFuelCharacteristicsCalculationCardDto;
begin

  Result :=
    TFuelCharacteristicsCalculationCardDto(
      MapEntityDtoFrom(FuelCharacteristicsCalculationCardFormViewModel)
    );

end;

end.
