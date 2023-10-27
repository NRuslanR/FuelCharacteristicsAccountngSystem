unit FuelCharacteristicsCalculationCardInfo;

interface

uses

  FuelCharacteristicsCalculationCardDto,
  FuelCharacteristicsCalculationCardAccessRightsDto,
  SysUtils;

type

  TFuelCharacteristicsCalculationCardInfo = class

    private

      FFuelCharacteristicsCalculationCardDto:
        TFuelCharacteristicsCalculationCardDto;

      FFuelCharacteristicsCalculationCardAccessRightsDto:
        TFuelCharacteristicsCalculationCardAccessRightsDto;

      procedure SetFuelCharacteristicsCalculationCardAccessRightsDto(
        const Value: TFuelCharacteristicsCalculationCardAccessRightsDto
      );

      procedure SetFuelCharacteristicsCalculationCardDto(
        const Value: TFuelCharacteristicsCalculationCardDto
      );

    public

      destructor Destroy; override;
      
      constructor Create;
      constructor CreateFrom(
        FuelCharacteristicsCalculationCardDto:
          TFuelCharacteristicsCalculationCardDto;

        FuelCharacteristicsCalculationCardAccessRightsDto:
          TFuelCharacteristicsCalculationCardAccessRightsDto
      );

      property FuelCharacteristicsCalculationCardDto:
        TFuelCharacteristicsCalculationCardDto
      read FFuelCharacteristicsCalculationCardDto
      write SetFuelCharacteristicsCalculationCardDto;
        
      property FuelCharacteristicsCalculationCardAccessRightsDto:
        TFuelCharacteristicsCalculationCardAccessRightsDto
      read FFuelCharacteristicsCalculationCardAccessRightsDto
      write SetFuelCharacteristicsCalculationCardAccessRightsDto;

  end;

implementation

{ TFuelCharacteristicsCalculationCardInfo }

constructor TFuelCharacteristicsCalculationCardInfo.Create;
begin

  inherited Create;

  FFuelCharacteristicsCalculationCardDto :=
    TFuelCharacteristicsCalculationCardDto.Create;

  FFuelCharacteristicsCalculationCardAccessRightsDto :=
    TFuelCharacteristicsCalculationCardAccessRightsDto.Create;
    
end;

constructor TFuelCharacteristicsCalculationCardInfo.CreateFrom(
  FuelCharacteristicsCalculationCardDto:
    TFuelCharacteristicsCalculationCardDto;

  FuelCharacteristicsCalculationCardAccessRightsDto:
    TFuelCharacteristicsCalculationCardAccessRightsDto
);
begin

  inherited Create;

  FFuelCharacteristicsCalculationCardDto :=
    FuelCharacteristicsCalculationCardDto;

  FFuelCharacteristicsCalculationCardAccessRightsDto :=
    FuelCharacteristicsCalculationCardAccessRightsDto;
    
end;

destructor TFuelCharacteristicsCalculationCardInfo.Destroy;
begin

  FreeAndNil(FFuelCharacteristicsCalculationCardDto);
  FreeAndNil(FFuelCharacteristicsCalculationCardAccessRightsDto);
  
  inherited;

end;

procedure TFuelCharacteristicsCalculationCardInfo.
  SetFuelCharacteristicsCalculationCardAccessRightsDto(
    const Value: TFuelCharacteristicsCalculationCardAccessRightsDto
  );
begin

  if FFuelCharacteristicsCalculationCardAccessRightsDto = Value then
    Exit;

  FreeAndNil(FFuelCharacteristicsCalculationCardAccessRightsDto);
  
  FFuelCharacteristicsCalculationCardAccessRightsDto := Value;

end;

procedure TFuelCharacteristicsCalculationCardInfo.
  SetFuelCharacteristicsCalculationCardDto(
    const Value: TFuelCharacteristicsCalculationCardDto
  );
begin

  if FFuelCharacteristicsCalculationCardDto = Value then
    Exit;

  FreeAndNil(FFuelCharacteristicsCalculationCardDto);
  
  FFuelCharacteristicsCalculationCardDto := Value;

end;

end.
