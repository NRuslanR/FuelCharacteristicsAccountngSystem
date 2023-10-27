unit StandardReservoirKindAccountingServiceRegistry;

interface

uses

  ReservoirKindAccountingServiceRegistry,
  ReservoirKindAccessService,
  ReservoirKindReferenceSuiteAccessService,
  ReservoirKindAccountingService,
  ReservoirSubLayerKindAccountingService,
  ReservoirKindReferenceSuiteAccountingService,
  ReservoirCalibrationChartRegistry;

type

  TReservoirKindAccountingServiceRegistry =
    class (TInterfacedObject, IReservoirKindAccountingServiceRegistry)

      private

        FReservoirSubLayerKindAccountingService:
          IReservoirSubLayerKindAccountingService;
          
        FReservoirKindAccessService: IReservoirKindAccessService;

        FReservoirKindReferenceSuiteAccessService:
          IReservoirKindReferenceSuiteAccessService;

        FReservoirKindAccountingService: IReservoirKindAccountingService;

        FReservoirKindReferenceSuiteAccountingService:
          IReservoirKindReferenceSuiteAccountingService;

        FReservoirCalibrationChartRegistry: IReservoirCalibrationChartRegistry;

      private

        class var FInstance: IReservoirKindAccountingServiceRegistry;

        class function GetInstance: IReservoirKindAccountingServiceRegistry; static;

      public

        procedure RegisterReservoirSubLayerKindAccountingService(
          ReservoirSubLayerKindAccountingService:
            IReservoirSubLayerKindAccountingService
        );

        function GetReservoirSubLayerKindAccountingService:
          IReservoirSubLayerKindAccountingService;

        procedure RegisterStandardReservoirSubLayerKindAccountingService;

      public

        procedure RegisterReservoirKindAccessService(
          ReservoirKindAccessService: IReservoirKindAccessService
        );

        function GetReservoirKindAccessService: IReservoirKindAccessService;

        procedure RegisterStandardReservoirKindAccessService;

      public

        procedure RegisterReservoirKindAccountingService(
          ReservoirKindAccountingService: IReservoirKindAccountingService
        );

        function GetReservoirKindAccountingService: IReservoirKindAccountingService;

        procedure RegisterStandardReservoirKindAccountingService;

      public

        procedure RegisterReservoirKindReferenceSuiteAccessService(
          ReservoirKindReferenceSuiteAccessService:
            IReservoirKindReferenceSuiteAccessService
        );

        function GetReservoirKindReferenceSuiteAccessService:
          IReservoirKindReferenceSuiteAccessService;

        procedure RegisterStandardReservoirKindReferenceSuiteAccessService;

      public

        procedure RegisterReservoirKindReferenceSuiteAccountingService(
          ReservoirKindReferenceSuiteAccountingService:
            IReservoirKindReferenceSuiteAccountingService
        );

        function GetReservoirKindReferenceSuiteAccountingService:
          IReservoirKindReferenceSuiteAccountingService;

        procedure RegisterStandardReservoirKindReferenceSuiteAccountingService;

      public

        procedure RegisterReservoirCalibrationChartRegistry(
          ReservoirCalibrationChartRegistry: IReservoirCalibrationChartRegistry
        );

        function GetReservoirCalibrationChartRegistry: IReservoirCalibrationChartRegistry;

      public

        procedure Clear;
        
        procedure RegisterStandardReservoirKindAccountingServices;
        
      public

        class property Current: IReservoirKindAccountingServiceRegistry
        read GetInstance write FInstance;
        
    end;

implementation

uses

  StandardReservoirSubLayerKindAccountingService,
  StandardReservoirKindAccessService,
  StandardReservoirKindAccountingService,
  StandardReservoirKindReferenceSuiteAccessService,
  StandardReservoirKindReferenceSuiteAccountingService,
  StandardFuelCharacteristicsCalculationServiceRegistry,
  StandardReservoirKindStorageServiceRegistry;
  
{ TReservoirKindAccountingServiceRegistry }

procedure TReservoirKindAccountingServiceRegistry.Clear;
begin

  FReservoirKindAccessService := nil;
  FReservoirSubLayerKindAccountingService := nil;
  FReservoirKindReferenceSuiteAccessService := nil;
  FReservoirKindAccountingService := nil;
  FReservoirKindReferenceSuiteAccountingService := nil;
  
end;

class function TReservoirKindAccountingServiceRegistry.
  GetInstance: IReservoirKindAccountingServiceRegistry;
begin

  if not Assigned(FInstance) then
    FInstance := TReservoirKindAccountingServiceRegistry.Create;
    
  Result := FInstance;

end;

function TReservoirKindAccountingServiceRegistry.
  GetReservoirCalibrationChartRegistry: IReservoirCalibrationChartRegistry;
begin

  Result := FReservoirCalibrationChartRegistry;
  
end;

function TReservoirKindAccountingServiceRegistry.
  GetReservoirKindAccessService: IReservoirKindAccessService;
begin

  Result := FReservoirKindAccessService;

end;

function TReservoirKindAccountingServiceRegistry.
  GetReservoirKindAccountingService: IReservoirKindAccountingService;
begin

  Result := FReservoirKindAccountingService;
  
end;

function TReservoirKindAccountingServiceRegistry.
  GetReservoirKindReferenceSuiteAccessService:
    IReservoirKindReferenceSuiteAccessService;
begin

  Result := FReservoirKindReferenceSuiteAccessService;
  
end;

function TReservoirKindAccountingServiceRegistry.
  GetReservoirKindReferenceSuiteAccountingService:
    IReservoirKindReferenceSuiteAccountingService;
begin

  Result := FReservoirKindReferenceSuiteAccountingService;
  
end;

function TReservoirKindAccountingServiceRegistry.
  GetReservoirSubLayerKindAccountingService:
    IReservoirSubLayerKindAccountingService;
begin

  Result := FReservoirSubLayerKindAccountingService;
  
end;

procedure TReservoirKindAccountingServiceRegistry.
  RegisterReservoirCalibrationChartRegistry(
    ReservoirCalibrationChartRegistry: IReservoirCalibrationChartRegistry
  );
begin

  if
    Assigned(
      TFuelCharacteristicsCalculationServiceRegistry
        .Current
          .GetFuelCharacteristicsCalculationService
    )
  then begin

    raise TReservoirKindAccountingServiceRegistryException.Create(
      'Неправильный порядок регистрации ' +
      'предметной службы'
    );

  end;

  FReservoirCalibrationChartRegistry := ReservoirCalibrationChartRegistry;

end;

procedure TReservoirKindAccountingServiceRegistry.RegisterReservoirKindAccessService(
  ReservoirKindAccessService: IReservoirKindAccessService);
begin

  if Assigned(FReservoirKindAccountingService) then begin

    raise
    TReservoirKindAccountingServiceRegistryException.Create(
      'Неправильный порядок регистрации ' +
      'предметной службы'
    );
    
  end;

  FReservoirKindAccessService := ReservoirKindAccessService;

end;

procedure TReservoirKindAccountingServiceRegistry.RegisterReservoirKindAccountingService(
  ReservoirKindAccountingService: IReservoirKindAccountingService);
begin

  if
    not Assigned(FReservoirKindAccessService) or
    not Assigned(
      TReservoirKindStorageServiceRegistry
        .Current
          .GetReservoirKindDirectory
    )
  then begin

    raise
    TReservoirKindAccountingServiceRegistryException.Create(
      'Неправильный порядок регистрации ' +
      'предметной службы'
    );
    
  end;

  FReservoirKindAccountingService := ReservoirKindAccountingService;
  
end;

procedure TReservoirKindAccountingServiceRegistry.
  RegisterReservoirKindReferenceSuiteAccessService(
    ReservoirKindReferenceSuiteAccessService:
      IReservoirKindReferenceSuiteAccessService
  );
begin

  if Assigned(FReservoirKindReferenceSuiteAccountingService)
  then begin

    raise
    TReservoirKindAccountingServiceRegistryException.Create(
      'Неправильный порядок регистрации ' +
      'предметной службы'
    );
    
  end;

  FReservoirKindReferenceSuiteAccessService :=
    ReservoirKindReferenceSuiteAccessService;
    
end;

procedure TReservoirKindAccountingServiceRegistry.
  RegisterReservoirKindReferenceSuiteAccountingService(
    ReservoirKindReferenceSuiteAccountingService:
      IReservoirKindReferenceSuiteAccountingService
  );
begin

  if
    not Assigned(FReservoirKindReferenceSuiteAccessService) or
    not Assigned(
      TReservoirKindStorageServiceRegistry
        .Current
          .GetReservoirKindReferenceSuiteDirectory
    )
    or
    not Assigned(FReservoirKindAccountingService) or
    not Assigned(FReservoirCalibrationChartRegistry)
  then begin

    raise
    TReservoirKindAccountingServiceRegistryException.Create(
      'Неправильный порядок регистрации ' +
      'предметной службы'
    );
    
  end;

  FReservoirKindReferenceSuiteAccountingService :=
    ReservoirKindReferenceSuiteAccountingService;
    
end;

procedure TReservoirKindAccountingServiceRegistry.
  RegisterReservoirSubLayerKindAccountingService(
    ReservoirSubLayerKindAccountingService:
      IReservoirSubLayerKindAccountingService
    );
begin

  FReservoirSubLayerKindAccountingService :=
    ReservoirSubLayerKindAccountingService;
    
end;

procedure TReservoirKindAccountingServiceRegistry.
  RegisterStandardReservoirKindAccessService;
begin

  FReservoirKindAccessService := TStandardReservoirKindAccessService.Create;
  
end;

procedure TReservoirKindAccountingServiceRegistry.
  RegisterStandardReservoirKindAccountingService;
begin

  if
    not Assigned(
      TReservoirKindStorageServiceRegistry
        .Current
          .GetReservoirKindDirectory
    )
  then begin

    raise
    TReservoirKindAccountingServiceRegistryException.Create(
      'Неправильный порядок регистрации ' +
      'предметной службы'
    );
    
  end;

  if not Assigned(FReservoirKindAccessService) then
    RegisterStandardReservoirKindAccessService;

  FReservoirKindAccountingService :=
    TStandardReservoirKindAccountingService.Create(

      TReservoirKindStorageServiceRegistry
        .Current
          .GetReservoirKindDirectory,

      FReservoirKindAccessService
    );
    
end;

procedure TReservoirKindAccountingServiceRegistry.
  RegisterStandardReservoirKindAccountingServices;
begin

  if not Assigned(FReservoirSubLayerKindAccountingService) then
    RegisterStandardReservoirSubLayerKindAccountingService;
    
  RegisterStandardReservoirKindAccountingService;
  RegisterStandardReservoirKindReferenceSuiteAccountingService;
  
end;

procedure TReservoirKindAccountingServiceRegistry.
  RegisterStandardReservoirKindReferenceSuiteAccessService;
begin

  FReservoirKindReferenceSuiteAccessService :=
    TStandardReservoirKindReferenceSuiteAccessService.Create;

end;

procedure TReservoirKindAccountingServiceRegistry.
  RegisterStandardReservoirKindReferenceSuiteAccountingService;
begin

  if
    not Assigned(
      TReservoirKindStorageServiceRegistry
        .Current
          .GetReservoirKindReferenceSuiteDirectory
    ) or
    not Assigned(FReservoirCalibrationChartRegistry)
  then begin

    raise
    TReservoirKindAccountingServiceRegistryException.Create(
      'Неправильный порядок регистрации ' +
      'предметной службы'
    );
    
  end;
  
  if not Assigned(FReservoirKindReferenceSuiteAccessService) then
    RegisterStandardReservoirKindReferenceSuiteAccessService;

  if not Assigned(FReservoirKindAccountingService) then
    RegisterStandardReservoirKindAccountingService;

  FReservoirKindReferenceSuiteAccountingService :=
    TStandardReservoirKindReferenceSuiteAccountingService.Create(

      TReservoirKindStorageServiceRegistry
        .Current
          .GetReservoirKindReferenceSuiteDirectory,
          
      FReservoirKindReferenceSuiteAccessService,

      FReservoirKindAccountingService,
      FReservoirCalibrationChartRegistry
    );

end;

procedure TReservoirKindAccountingServiceRegistry.
  RegisterStandardReservoirSubLayerKindAccountingService;
begin

  FReservoirSubLayerKindAccountingService :=
    TStandardReservoirSubLayerKindAccountingService.Create;


end;

end.
