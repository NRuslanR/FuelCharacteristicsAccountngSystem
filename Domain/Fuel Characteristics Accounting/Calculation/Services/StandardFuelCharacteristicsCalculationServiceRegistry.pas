unit StandardFuelCharacteristicsCalculationServiceRegistry;

interface

uses

  FuelCharacteristicsCalculationServiceRegistry,
  ElectronicMetroshtok,
  ReservoirCalibrationChartRegistry,
  ReservoirSubLayerKindAccountingService,
  FuelCharacteristicsCalculationService;

type

  TFuelCharacteristicsCalculationServiceRegistry =
    class (TInterfacedObject, IFuelCharacteristicsCalculationServiceRegistry)

      private

        FElectronicMetroshtok: IElectronicMetroshtok;

        FFuelCharacteristicsCalculationService:
          IFuelCharacteristicsCalculationService;

      private

        class var FInstance: IFuelCharacteristicsCalculationServiceRegistry;
        
        class function GetInstance:
          IFuelCharacteristicsCalculationServiceRegistry; static;

      private

        procedure RaiseExceptionIfFuelCharacteristicsCalculationServiceRegistrationOrderIsNotValid;

      public

        procedure RegisterElectronicMetroshtok(
          ElectronicMetroshtok: IElectronicMetroshtok
        );

        function GetElectronicMetroshtok: IElectronicMetroshtok;

      public
      
        procedure RegisterFuelCharacteristicsCalculationService(
          FuelCharacteristicsCalculationService:
            IFuelCharacteristicsCalculationService
        );

        function GetFuelCharacteristicsCalculationService:
          IFuelCharacteristicsCalculationService;

        procedure RegisterStandardFuelCharacteristicsCalculationService;

      public

        procedure Clear;

        class property Current: IFuelCharacteristicsCalculationServiceRegistry
        read GetInstance write FInstance;
        
    end;

implementation

uses

  StandardReservoirSubLayerKindAccountingService,
  StandardFuelCharacteristicsCalculationService,
  StandardReservoirKindStorageServiceRegistry,
  StandardReservoirKindAccountingServiceRegistry;

{ TFuelCharacteristicsCalculationServiceRegistry }

procedure TFuelCharacteristicsCalculationServiceRegistry.Clear;
begin

  FElectronicMetroshtok := nil;
  FFuelCharacteristicsCalculationService := nil;
  
end;

function TFuelCharacteristicsCalculationServiceRegistry.
  GetElectronicMetroshtok: IElectronicMetroshtok;
begin

  Result := FElectronicMetroshtok;

end;

function TFuelCharacteristicsCalculationServiceRegistry.
  GetFuelCharacteristicsCalculationService: IFuelCharacteristicsCalculationService;
begin

  Result := FFuelCharacteristicsCalculationService;

end;

class function TFuelCharacteristicsCalculationServiceRegistry.
  GetInstance: IFuelCharacteristicsCalculationServiceRegistry;
begin

  if not Assigned(FInstance) then
    FInstance := TFuelCharacteristicsCalculationServiceRegistry.Create;
    
  Result := FInstance;

end;

procedure TFuelCharacteristicsCalculationServiceRegistry.
  RaiseExceptionIfFuelCharacteristicsCalculationServiceRegistrationOrderIsNotValid;
begin

  if
    not Assigned(FElectronicMetroshtok) or
    not Assigned(
      TReservoirKindAccountingServiceRegistry
        .Current
          .GetReservoirCalibrationChartRegistry
    ) or
    not Assigned(
      TReservoirKindStorageServiceRegistry
        .Current
          .GetReservoirKindReferenceSuiteDirectory
    ) or
    not Assigned(
      TReservoirKindAccountingServiceRegistry
        .Current
          .GetReservoirSubLayerKindAccountingService
    )
  then begin

    raise TFuelCharacteristicsCalculationServiceRegistryException.Create(
      'Неправильный порядок регистрации ' +
      'предметной службы'
    );

  end;

end;

procedure TFuelCharacteristicsCalculationServiceRegistry.RegisterElectronicMetroshtok(
  ElectronicMetroshtok: IElectronicMetroshtok);
begin

  if Assigned(FFuelCharacteristicsCalculationService) then begin

    raise TFuelCharacteristicsCalculationServiceRegistryException.Create(
      'Неправильный порядок регистрации ' +
      'предметной службы'
    );

  end;

  FElectronicMetroshtok := ElectronicMetroshtok;
  
end;

procedure TFuelCharacteristicsCalculationServiceRegistry.
  RegisterFuelCharacteristicsCalculationService(
    FuelCharacteristicsCalculationService: IFuelCharacteristicsCalculationService
  );
begin

  RaiseExceptionIfFuelCharacteristicsCalculationServiceRegistrationOrderIsNotValid;
  
  FFuelCharacteristicsCalculationService := FuelCharacteristicsCalculationService;
  
end;

procedure TFuelCharacteristicsCalculationServiceRegistry.
  RegisterStandardFuelCharacteristicsCalculationService;
begin

  RaiseExceptionIfFuelCharacteristicsCalculationServiceRegistrationOrderIsNotValid;

  FFuelCharacteristicsCalculationService :=
    TStandardFuelCharacteristicsCalculationService.Create(

      TReservoirKindAccountingServiceRegistry
        .Current
          .GetReservoirSubLayerKindAccountingService,
      
      TReservoirKindStorageServiceRegistry
        .Current
          .GetReservoirKindReferenceSuiteDirectory,

      TReservoirKindAccountingServiceRegistry
        .Current
          .GetReservoirCalibrationChartRegistry
    );

end;

end.
