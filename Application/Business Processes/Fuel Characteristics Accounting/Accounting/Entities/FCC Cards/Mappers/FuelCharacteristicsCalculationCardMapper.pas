unit FuelCharacteristicsCalculationCardMapper;

interface

uses

  EmployeeRepository,
  EmployeeMapper,
  Employee,
  FuelCharacteristicsCalculationCard,
  FuelCharacteristicsCalculationCardDto,
  SysUtils,
  Classes;

type

  TFuelCharacteristicsCalculationCardMapper = class

    private

      FEmployeeRepository: IEmployeeRepository;
      FEmployeeMapper: TEmployeeMapper;

      function GetFuelCharacteristicsCalculationPerformer(
        const CalculationPerformerId: Variant
      ): TEmployee;
      
    public

      destructor Destroy; override;
      
      constructor Create(
        EmployeeRepository: IEmployeeRepository
      );
      
      function ToDto(
        FuelCharacteristicsCalculationCard: TFuelCharacteristicsCalculationCard
      ): TFuelCharacteristicsCalculationCardDto;

      procedure FillEntityFromDto(
        Card: TFuelCharacteristicsCalculationCard;
        CardDto: TFuelCharacteristicsCalculationCardDto
      );

  end;

implementation

uses

  AuxVariantFunctions,
  IDomainObjectBaseUnit;
  
{ TFuelCharacteristicsCalculationCardMapper }

constructor TFuelCharacteristicsCalculationCardMapper.Create(
  EmployeeRepository: IEmployeeRepository
);
begin

  inherited Create;

  FEmployeeRepository := EmployeeRepository;
  FEmployeeMapper := TEmployeeMapper.Create;
  
end;

destructor TFuelCharacteristicsCalculationCardMapper.Destroy;
begin

  FreeAndNil(FEmployeeMapper);
  
  inherited;

end;

procedure TFuelCharacteristicsCalculationCardMapper.FillEntityFromDto(
  Card: TFuelCharacteristicsCalculationCard;
  CardDto: TFuelCharacteristicsCalculationCardDto
);
begin

  if Assigned(Card.FuelCharacteristicsInfoEditingEmployee)
  then begin

    Card.FuelTemperature := CardDto.FuelTemperature;
    Card.FuelDensity := CardDto.FuelDensity;
    Card.FuelRiseLevel := CardDto.FuelRiseLevel;
    Card.FuelMass := CardDto.FuelMass;
    Card.FuelKind := CardDto.FuelKind;
    Card.ReservoirNumber := CardDto.ReservoirNumber;
    
  end;

  if Assigned(Card.CalculationContextInfoEditingEmployee)
  then begin

    Card.CalculationPerformingDateTime := CardDto.CalculationPerformingDateTime;
    Card.PerformedCalculationEmployeeId := CardDto.PerformedCalculationEmployeeDto.Id;
    
  end;
  
end;

function TFuelCharacteristicsCalculationCardMapper.
  GetFuelCharacteristicsCalculationPerformer(
    const CalculationPerformerId: Variant
  ): TEmployee;
begin

  if VarIsNullOrEmpty(CalculationPerformerId) then begin

    raise Exception.Create(
      'Обнаружен недействительный идентификатор ' +
      'сотрудника, выполнившего ' +
      'расчёт показателей топлива'
    );

  end;

  Result := FEmployeeRepository.FindEmployeeById(CalculationPerformerId);

  if not Assigned(Result) then begin

    raise Exception.Create(
      'Информация о сотрудник, выполнившем ' +
      'расчёт показателей топлива, не найдена'
    );
    
  end;

end;

function TFuelCharacteristicsCalculationCardMapper.ToDto(
  FuelCharacteristicsCalculationCard: TFuelCharacteristicsCalculationCard
): TFuelCharacteristicsCalculationCardDto;
var CalculationPerformer: TEmployee;
    Free: IDomainObjectBase;
begin

  Result := TFuelCharacteristicsCalculationCardDto.Create;

  try

    Result.Id := FuelCharacteristicsCalculationCard.Identity;
    Result.FuelTemperature := FuelCharacteristicsCalculationCard.FuelTemperature;
    Result.FuelDensity := FuelCharacteristicsCalculationCard.FuelDensity;
    Result.FuelRiseLevel := FuelCharacteristicsCalculationCard.FuelRiseLevel;
    Result.FuelMass := FuelCharacteristicsCalculationCard.FuelMass;
    Result.FuelKind := FuelCharacteristicsCalculationCard.FuelKind;
    Result.ReservoirNumber := FuelCharacteristicsCalculationCard.ReservoirNumber;
    Result.CalculationPerformingDateTime := FuelCharacteristicsCalculationCard.CalculationPerformingDateTime;

    if
      not VarIsNullOrEmpty(
        FuelCharacteristicsCalculationCard.PerformedCalculationEmployeeId
      )
    then begin
    
      CalculationPerformer :=
        GetFuelCharacteristicsCalculationPerformer(
          FuelCharacteristicsCalculationCard.PerformedCalculationEmployeeId
        );


      Free := CalculationPerformer;

      Result.PerformedCalculationEmployeeDto :=
        FEmployeeMapper.ToDto(CalculationPerformer);

    end;

  except

    on e: Exception do begin

      FreeAndNil(Result);

      raise;
      
    end;

  end;

end;

end.
