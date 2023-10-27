unit StandardFuelCharacteristicsCalculationAppService;

interface

uses

  FuelCharacteristicsCalculationAppService,
  FuelCharacteristicsCalculationInputDto,
  FuelCharacteristicsCalculationDto,
  FuelCharacteristicsCalculationService,
  FuelCharacteristicsCalculation,
  ReservoirSubLayerCharacteristicsCalculationInput,
  ReservoirSubLayerKind,
  EmployeeRepository,
  Employee,
  SysUtils,
  Classes;

type

  TStandardFuelCharacteristicsCalculationAppService =
    class (TInterfacedObject, IFuelCharacteristicsCalculationAppService)

      private

        FEmployeeRepository: IEmployeeRepository;

        FFuelCharacteristicsCalculationService:
          IFuelCharacteristicsCalculationService;

        function GetEmployeeFromRepository(
          const EmployeeId: Variant;
          const NotFoundExceptionMessage: String = ''
        ): TEmployee;
        
        function MapFuelCharacteristicsCalculationInputFrom(
          FuelCharacteristicsCalculationInputDto:
            TFuelCharacteristicsCalculationInputDto
        ): TFuelCharacteristicsCalculationInput;

        function MapFuelCharacteristicsCalculationDtoFrom(
          FuelCharacteristicsCalculation: TFuelCharacteristicsCalculation
        ): TFuelCharacteristicsCalculationDto;

      public

        constructor Create(
          EmployeeRepository: IEmployeeRepository;

          FuelCharacteristicsCalculationService:
            IFuelCharacteristicsCalculationService
        );

        function CalculateFuelCharacteristics(
          const ClientIdentity: Variant;
          const Input: TFuelCharacteristicsCalculationInputDto
        ): TFuelCharacteristicsCalculationDto;

    end;
  
implementation

uses

  IDomainObjectBaseUnit;

{ TStandardFuelCharacteristicsCalculationAppService }

function TStandardFuelCharacteristicsCalculationAppService.
  CalculateFuelCharacteristics(
    const ClientIdentity: Variant;
    const Input: TFuelCharacteristicsCalculationInputDto
  ): TFuelCharacteristicsCalculationDto;
var Employee: TEmployee;
    FreeEmployee: IDomainObjectBase;
    
    FuelCharacteristicsCalculationInput:
      TFuelCharacteristicsCalculationInput;

    FreeFuelCharacteristicsCalculationInput: IDomainObjectBase;

    FuelCharacteristicsCalculation: TFuelCharacteristicsCalculation;
    FreeFuelCharacteristicsCalculation: IDomainObjectBase;

    FuelCharacteristicsCalculationDto: TFuelCharacteristicsCalculationDto;
begin

  Employee :=
    GetEmployeeFromRepository(
      ClientIdentity,
      'Информация о сотруднике, затребовавшем ' +
      'расчёт показателей топлива, не найдена'
    );

  FreeEmployee := Employee;

  FuelCharacteristicsCalculationInput :=
    MapFuelCharacteristicsCalculationInputFrom(Input);

  FreeFuelCharacteristicsCalculationInput :=
    FuelCharacteristicsCalculationInput;

  FuelCharacteristicsCalculation :=
    FFuelCharacteristicsCalculationService.
      CalculateFuelCharacteristicsOnBehalfOfEmployee(
        FuelCharacteristicsCalculationInput,
        Employee
      );

  FreeFuelCharacteristicsCalculation := FuelCharacteristicsCalculation;

  Result :=
    MapFuelCharacteristicsCalculationDtoFrom(FuelCharacteristicsCalculation);

end;

constructor TStandardFuelCharacteristicsCalculationAppService.Create(
  EmployeeRepository: IEmployeeRepository;
  FuelCharacteristicsCalculationService: IFuelCharacteristicsCalculationService
);
begin

  inherited Create;

  FEmployeeRepository := EmployeeRepository;
  
  FFuelCharacteristicsCalculationService :=
    FuelCharacteristicsCalculationService;

end;

function TStandardFuelCharacteristicsCalculationAppService.
  GetEmployeeFromRepository(
    const EmployeeId: Variant;
    const NotFoundExceptionMessage: String
  ): TEmployee;
begin

  Result := FEmployeeRepository.FindEmployeeById(EmployeeId);

  if not Assigned(Result) and (NotFoundExceptionMessage <> '')
  then begin

    raise TFuelCharacteristicsCalculationAppServiceException.Create(
      NotFoundExceptionMessage
    );
    
  end;
  
end;

function TStandardFuelCharacteristicsCalculationAppService.
  MapFuelCharacteristicsCalculationDtoFrom(
    FuelCharacteristicsCalculation: TFuelCharacteristicsCalculation
  ): TFuelCharacteristicsCalculationDto;
begin

  Result := TFuelCharacteristicsCalculationDto.Create;

  Result.FuelMass := FuelCharacteristicsCalculation.FuelMass;
  
end;

function TStandardFuelCharacteristicsCalculationAppService.
  MapFuelCharacteristicsCalculationInputFrom(
    FuelCharacteristicsCalculationInputDto:
      TFuelCharacteristicsCalculationInputDto
  ): TFuelCharacteristicsCalculationInput;
begin

  Result := TFuelCharacteristicsCalculationInput.Create;

  try

    with FuelCharacteristicsCalculationInputDto do begin

      Result.ReservoirKindName := ReservoirKindId;
      Result.FuelTemperature := FuelTemperature;
      Result.FuelRiseLevel := FuelRiseLevel;
      Result.FuelDensity := FuelDensity;

      if
        ReservoirSubLayerCharacteristicsCalculationInputDto is
        TBottomWaterCharacteristicsCalculationInputDto
      then begin

        Result.ReservoirSubLayerCharacteristicsCalculationInput :=
          TBottomWaterCharacteristicsCalculationInput.Create(

            ReservoirSubLayerCharacteristicsCalculationInputDto.ReservoirSubLayerKindId,

            TBottomWaterCharacteristicsCalculationInputDto(
              ReservoirSubLayerCharacteristicsCalculationInputDto
            ).BottomWaterLevel

          );
          
      end

      else if
        ReservoirSubLayerCharacteristicsCalculationInputDto is
        TIceLayerCharacteristicsCalculationInputDto
      then begin

        Result.ReservoirSubLayerCharacteristicsCalculationInput :=
          TIceLayerCharacteristicsCalculationInput.Create(

            ReservoirSubLayerCharacteristicsCalculationInputDto.ReservoirSubLayerKindId,
            
            TIceLayerCharacteristicsCalculationInputDto(
              ReservoirSubLayerCharacteristicsCalculationInputDto
            ).AltitudinalActualStencil

          );
          
      end

      else begin

        raise TFuelCharacteristicsCalculationAppServiceException.Create(
          'Программная ошибка. Службе не удалось ' +
          'определить входные данные о ' +
          'резервуарном подслое для ' +
          'проведения расчёта массы топлива'
        );

      end;

    end;

  except

    on E: Exception do begin

      FreeAndNil(Result);

      raise;
      
    end;

  end;

end;

end.
