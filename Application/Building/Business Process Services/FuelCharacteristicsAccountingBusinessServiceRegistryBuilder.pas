unit FuelCharacteristicsAccountingBusinessServiceRegistryBuilder;

interface

uses

  FuelCharacteristicsAccountingBusinessServiceRegistry,
  FuelCharacteristicsAccountingPresentationServiceRegistry,
  FuelCharacteristicsCalculationCardAccountingAppService,
  ReservoirKindAccountingAppService,
  ReservoirKindReferenceSuiteAccountingAppService,
  ReservoirKindReferenceService,
  ReservoirKindReferenceSuiteReferenceService,
  FuelCharacteristicsCalculationAppService,
  ReservoirSubLayerKindAccountingAppService,
  SpecialityAccountingAppService,
  WorkingTimeConditionsAccountingAppService,
  SysUtils,
  Classes;

type

  TFuelCharacteristicsAccountingBusinessServiceRegistryBuilder = class

    private

      FBusinessServiceRegistry:
        IFuelCharacteristicsAccountingBusinessServiceRegistry;

    public

      function UseStandardFuelCharacteristicsCalculationCardAccountingAppService(

        PresentationServiceRegistry:
          IFuelCharacteristicsAccountingPresentationServiceRegistry

      ): TFuelCharacteristicsAccountingBusinessServiceRegistryBuilder;

      function UseStandardReservoirKindAccountingAppService(
        
        PresentationServiceRegistry:
          IFuelCharacteristicsAccountingPresentationServiceRegistry

      ): TFuelCharacteristicsAccountingBusinessServiceRegistryBuilder;

      function UseStandardReservoirKindReferenceSuiteAccountingAppService(
        
        PresentationServiceRegistry:
          IFuelCharacteristicsAccountingPresentationServiceRegistry

      ): TFuelCharacteristicsAccountingBusinessServiceRegistryBuilder;

      function UseStandardReservoirKindReferenceService(
        
        PresentationServiceRegistry:
          IFuelCharacteristicsAccountingPresentationServiceRegistry

      ): TFuelCharacteristicsAccountingBusinessServiceRegistryBuilder;

      function UseStandardReservoirKindReferenceSuiteReferenceService(
        
        PresentationServiceRegistry:
          IFuelCharacteristicsAccountingPresentationServiceRegistry

      ): TFuelCharacteristicsAccountingBusinessServiceRegistryBuilder;

      function UseStandardSpecialityAccountingAppService(
        
        PresentationServiceRegistry:
          IFuelCharacteristicsAccountingPresentationServiceRegistry

      ): TFuelCharacteristicsAccountingBusinessServiceRegistryBuilder;

      function UseStandardFuelCharacteristicsCalculationAppService:
        TFuelCharacteristicsAccountingBusinessServiceRegistryBuilder;

      function UseStandardReservoirSubLayerKindAccountingAppService:
        TFuelCharacteristicsAccountingBusinessServiceRegistryBuilder;

      function UseStandardWorkingTimeConditionsAccountingAppService:
        TFuelCharacteristicsAccountingBusinessServiceRegistryBuilder;
      
    public

      function UseFuelCharacteristicsCalculationCardAccountingAppService(
        FuelCharacteristicsCalculationCardAccountingAppService:
          IFuelCharacteristicsCalculationCardAccountingAppService
      ): TFuelCharacteristicsAccountingBusinessServiceRegistryBuilder;

      function UseReservoirKindAccountingAppService(
        ReservoirKindAccountingAppService: IReservoirKindAccountingAppService
      ): TFuelCharacteristicsAccountingBusinessServiceRegistryBuilder;

      function UseReservoirKindReferenceSuiteAccountingAppService(
        ReservoirKindReferenceSuiteAccountingAppService:
          IReservoirKindReferenceSuiteAccountingAppService
      ): TFuelCharacteristicsAccountingBusinessServiceRegistryBuilder;

      function UseReservoirKindReferenceService(
        ReservoirKindReferenceService: IReservoirKindReferenceService
      ): TFuelCharacteristicsAccountingBusinessServiceRegistryBuilder;

      function UseReservoirKindReferenceSuiteReferenceService(
        ReservoirKindReferenceSuiteReferenceService:
          IReservoirKindReferenceSuiteReferenceService
      ): TFuelCharacteristicsAccountingBusinessServiceRegistryBuilder;

      function UseSpecialityAccountingAppService(
        SpecialityAccountingAppService: ISpecialityAccountingAppService
      ): TFuelCharacteristicsAccountingBusinessServiceRegistryBuilder;

      function UseFuelCharacteristicsCalculationAppService(

        FuelCharacteristicsCalculationAppService:
          IFuelCharacteristicsCalculationAppService

      ): TFuelCharacteristicsAccountingBusinessServiceRegistryBuilder;

      function UseReservoirSubLayerKindAccountingAppService(

        ReservoirSubLayerKindAccountingAppService:
          IReservoirSubLayerKindAccountingAppService

      ): TFuelCharacteristicsAccountingBusinessServiceRegistryBuilder;

      function UseWorkingTimeConditionsAccountingAppService(
      
        WorkingTimeConditionsAccountingAppService:
          IWorkingTimeConditionsAccountingAppService

      ): TFuelCharacteristicsAccountingBusinessServiceRegistryBuilder;

    public

      constructor Create;

      function ClearBusinessServiceRegistry:
        TFuelCharacteristicsAccountingBusinessServiceRegistryBuilder;

      function UseStandardBusinessServices(

        PresentationServiceRegistry:
          IFuelCharacteristicsAccountingPresentationServiceRegistry

      ): TFuelCharacteristicsAccountingBusinessServiceRegistryBuilder;

      function Build: IFuelCharacteristicsAccountingBusinessServiceRegistry;

  end;

implementation

uses

  StandardFuelCharacteristicsCalculationAppService,
  StandardReservoirSubLayerKindAccountingAppService,
  StandardFuelCharacteristicsAccountingRepositoryRegistry,
  StandardFuelCharacteristicsCalculationServiceRegistry,
  StandardFuelCharacteristicsCalculationCardAccountingServiceRegistry,
  StandardReservoirKindAccountingServiceRegistry,
  StandardReservoirKindStorageServiceRegistry,
  StandardEmployeeQualificationServiceRegistry,
  InMemoryFuelCharacteristicsAccountingBusinessServiceRegistry,
  StandardFuelCharacteristicsCalculationCardAccountingAppService,
  StandardReservoirKindAccountingAppService,
  StandardReservoirKindReferenceSuiteAccountingAppService,
  StandardWorkingTimeConditionsAccountingServiceRegistry,
  StandardWorkingTimeConditionsAccountingAppService,
  StandardReservoirKindReferenceService,
  StandardReservoirKindReferenceSuiteReferenceService,
  NumericReservoirSubLayerKindIdResolver,
  StandardSpecialityAccountingAppService;

{ TFuelCharacteristicsAccountingBusinessServiceRegistryBuilder }

function TFuelCharacteristicsAccountingBusinessServiceRegistryBuilder.
  Build: IFuelCharacteristicsAccountingBusinessServiceRegistry;
begin

  Result := FBusinessServiceRegistry;

end;

function TFuelCharacteristicsAccountingBusinessServiceRegistryBuilder.
  ClearBusinessServiceRegistry:
    TFuelCharacteristicsAccountingBusinessServiceRegistryBuilder;
begin

  FBusinessServiceRegistry.Clear;

  Result := Self;
  
end;

constructor TFuelCharacteristicsAccountingBusinessServiceRegistryBuilder.
  Create;
begin

  inherited;

  FBusinessServiceRegistry :=
    TInMemoryFuelCharacteristicsAccountingBusinessServiceRegistry.Create;

end;

function TFuelCharacteristicsAccountingBusinessServiceRegistryBuilder.
  UseStandardBusinessServices(

    PresentationServiceRegistry:
      IFuelCharacteristicsAccountingPresentationServiceRegistry

  ): TFuelCharacteristicsAccountingBusinessServiceRegistryBuilder;
begin

  UseStandardFuelCharacteristicsCalculationCardAccountingAppService(
    PresentationServiceRegistry
  );

  UseStandardReservoirKindAccountingAppService(
    PresentationServiceRegistry
  );
  
  UseStandardReservoirKindReferenceSuiteAccountingAppService(
    PresentationServiceRegistry
  );
  
  UseStandardReservoirKindReferenceService(
    PresentationServiceRegistry
  );
  
  UseStandardReservoirKindReferenceSuiteReferenceService(
    PresentationServiceRegistry
  );

  UseStandardSpecialityAccountingAppService(
    PresentationServiceRegistry
  );

  UseStandardFuelCharacteristicsCalculationAppService;

  UseStandardReservoirSubLayerKindAccountingAppService;

  UseStandardWorkingTimeConditionsAccountingAppService;
  
  Result := Self;
  
end;

function TFuelCharacteristicsAccountingBusinessServiceRegistryBuilder.
  UseStandardFuelCharacteristicsCalculationAppService:
    TFuelCharacteristicsAccountingBusinessServiceRegistryBuilder;
begin

  Result :=
    UseFuelCharacteristicsCalculationAppService(

      TStandardFuelCharacteristicsCalculationAppService.Create(

        TFuelCharacteristicsAccountingRepositoryRegistry
          .Current
            .GetEmployeeRepository,

        TFuelCharacteristicsCalculationServiceRegistry
          .Current
            .GetFuelCharacteristicsCalculationService
      )
    );

end;

function TFuelCharacteristicsAccountingBusinessServiceRegistryBuilder.
  UseStandardFuelCharacteristicsCalculationCardAccountingAppService(

    PresentationServiceRegistry:
      IFuelCharacteristicsAccountingPresentationServiceRegistry

  ): TFuelCharacteristicsAccountingBusinessServiceRegistryBuilder;
begin

  Result :=
    UseFuelCharacteristicsCalculationCardAccountingAppService(

      TStandardFuelCharacteristicsCalculationCardAccountingAppService.Create(
        TFuelCharacteristicsAccountingRepositoryRegistry
          .Current
            .GetSessionManager,

        TFuelCharacteristicsAccountingRepositoryRegistry
          .Current
            .GetEmployeeRepository,

        TFuelCharacteristicsCalculationCardAccountingServiceRegistry
          .Current
            .GetFuelCharacteristicsCalculationCardAccountingService
      )

    );

end;

function TFuelCharacteristicsAccountingBusinessServiceRegistryBuilder.
  UseStandardReservoirKindAccountingAppService(

    PresentationServiceRegistry:
      IFuelCharacteristicsAccountingPresentationServiceRegistry

  ): TFuelCharacteristicsAccountingBusinessServiceRegistryBuilder;
begin

  Result :=
    UseReservoirKindAccountingAppService(

      TStandardReservoirKindAccountingAppService.Create(

        TFuelCharacteristicsAccountingRepositoryRegistry
          .Current
            .GetSessionManager,

        TFuelCharacteristicsAccountingRepositoryRegistry
          .Current
            .GetEmployeeRepository,

        TReservoirKindAccountingServiceRegistry
          .Current
            .GetReservoirKindAccountingService

      )
    );

end;

function TFuelCharacteristicsAccountingBusinessServiceRegistryBuilder.
  UseStandardReservoirKindReferenceService(

    PresentationServiceRegistry:
      IFuelCharacteristicsAccountingPresentationServiceRegistry

  ): TFuelCharacteristicsAccountingBusinessServiceRegistryBuilder;
begin

  Result :=
    UseReservoirKindReferenceService(

      TStandardReservoirKindReferenceService.Create(

        TFuelCharacteristicsAccountingRepositoryRegistry
          .Current
            .GetEmployeeRepository,

        TReservoirKindStorageServiceRegistry
          .Current
            .GetReservoirKindDirectoryAccessService,

        PresentationServiceRegistry
          .GetReservoirKindSetReadService

      )
    );
    
end;

function TFuelCharacteristicsAccountingBusinessServiceRegistryBuilder.
  UseStandardReservoirKindReferenceSuiteAccountingAppService(

    PresentationServiceRegistry:
      IFuelCharacteristicsAccountingPresentationServiceRegistry

  ): TFuelCharacteristicsAccountingBusinessServiceRegistryBuilder;
begin

  Result :=
    UseReservoirKindReferenceSuiteAccountingAppService(

      TStandardReservoirKindReferenceSuiteAccountingAppService.Create(

        TFuelCharacteristicsAccountingRepositoryRegistry
          .Current
            .GetSessionManager,

        TFuelCharacteristicsAccountingRepositoryRegistry
          .Current
            .GetEmployeeRepository,

        TReservoirKindAccountingServiceRegistry
          .Current
            .GetReservoirKindReferenceSuiteAccountingService

        )
    );
    
end;

function TFuelCharacteristicsAccountingBusinessServiceRegistryBuilder.
  UseStandardReservoirKindReferenceSuiteReferenceService(

    PresentationServiceRegistry:
      IFuelCharacteristicsAccountingPresentationServiceRegistry

  ): TFuelCharacteristicsAccountingBusinessServiceRegistryBuilder;
begin

  Result :=
    UseReservoirKindReferenceSuiteReferenceService(

      TStandardReservoirKindReferenceSuiteReferenceService.Create(

        TFuelCharacteristicsAccountingRepositoryRegistry
          .Current
            .GetEmployeeRepository,

        TReservoirKindStorageServiceRegistry
          .Current
            .GetReservoirKindReferenceSuiteDirectoryAccessService,

        PresentationServiceRegistry
          .GetReservoirKindReferenceSuiteSetReadService

      )
    );
    
end;

function TFuelCharacteristicsAccountingBusinessServiceRegistryBuilder.
  UseStandardReservoirSubLayerKindAccountingAppService:
    TFuelCharacteristicsAccountingBusinessServiceRegistryBuilder;
begin

  Result :=
    UseReservoirSubLayerKindAccountingAppService(

      TStandardReservoirSubLayerKindAccountingAppService.Create(

        TReservoirKindAccountingServiceRegistry
          .Current
            .GetReservoirSubLayerKindAccountingService,

        TNumericReservoirSubLayerKindIdResolver.Create

      )
    );
    
end;

function TFuelCharacteristicsAccountingBusinessServiceRegistryBuilder.
  UseStandardSpecialityAccountingAppService(

    PresentationServiceRegistry:
      IFuelCharacteristicsAccountingPresentationServiceRegistry

  ): TFuelCharacteristicsAccountingBusinessServiceRegistryBuilder;
begin

  Result :=
    UseSpecialityAccountingAppService(

      TStandardSpecialityAccountingAppService.Create(
      
        TEmployeeQualificationServiceRegistry
          .Current
            .GetSpecialityAccountingService
      )
    );

end;

function TFuelCharacteristicsAccountingBusinessServiceRegistryBuilder.
  UseStandardWorkingTimeConditionsAccountingAppService:
    TFuelCharacteristicsAccountingBusinessServiceRegistryBuilder;
begin

  Result :=
    UseWorkingTimeConditionsAccountingAppService(

      TStandardWorkingTimeConditionsAccountingAppService.Create(

        TFuelCharacteristicsAccountingRepositoryRegistry
          .Current
            .GetSessionManager,

        TFuelCharacteristicsAccountingRepositoryRegistry
          .Current
            .GetEmployeeRepository,

        TWorkingTimeConditionsAccountingServiceRegistry
          .Current
            .GetWorkingTimeConditionsAccountingService
      )
    );
    
end;

function TFuelCharacteristicsAccountingBusinessServiceRegistryBuilder.
  UseWorkingTimeConditionsAccountingAppService(

    WorkingTimeConditionsAccountingAppService:
      IWorkingTimeConditionsAccountingAppService

  ): TFuelCharacteristicsAccountingBusinessServiceRegistryBuilder;
begin

  FBusinessServiceRegistry.RegisterWorkingTimeConditionsAccountingAppService(
    WorkingTimeConditionsAccountingAppService
  );

  Result := Self;
  
end;

function TFuelCharacteristicsAccountingBusinessServiceRegistryBuilder.
  UseFuelCharacteristicsCalculationAppService(

    FuelCharacteristicsCalculationAppService:
      IFuelCharacteristicsCalculationAppService

  ): TFuelCharacteristicsAccountingBusinessServiceRegistryBuilder;
begin

  FBusinessServiceRegistry
    .RegisterFuelCharacteristicsCalculationAppService(
      FuelCharacteristicsCalculationAppService
    );
    
  Result := Self;

end;

function TFuelCharacteristicsAccountingBusinessServiceRegistryBuilder.
  UseFuelCharacteristicsCalculationCardAccountingAppService(
    FuelCharacteristicsCalculationCardAccountingAppService:
      IFuelCharacteristicsCalculationCardAccountingAppService
  ): TFuelCharacteristicsAccountingBusinessServiceRegistryBuilder;
begin

  FBusinessServiceRegistry
    .RegisterFuelCharacteristicsCalculationCardAccountingAppService(
      FuelCharacteristicsCalculationCardAccountingAppService
    );

  Result := Self;
  
end;

function TFuelCharacteristicsAccountingBusinessServiceRegistryBuilder.
  UseReservoirKindAccountingAppService(
    ReservoirKindAccountingAppService: IReservoirKindAccountingAppService
  ): TFuelCharacteristicsAccountingBusinessServiceRegistryBuilder;
begin

  FBusinessServiceRegistry.RegisterReservoirKindAccountingAppService(
    ReservoirKindAccountingAppService
  );

  Result := Self;
  
end;

function TFuelCharacteristicsAccountingBusinessServiceRegistryBuilder.
  UseReservoirKindReferenceService(
    ReservoirKindReferenceService: IReservoirKindReferenceService
  ): TFuelCharacteristicsAccountingBusinessServiceRegistryBuilder;
begin

  FBusinessServiceRegistry.RegisterReservoirKindReferenceService(
    ReservoirKindReferenceService
  );

  Result := Self;
  
end;

function TFuelCharacteristicsAccountingBusinessServiceRegistryBuilder.
  UseReservoirKindReferenceSuiteAccountingAppService(
    ReservoirKindReferenceSuiteAccountingAppService:
      IReservoirKindReferenceSuiteAccountingAppService
  ): TFuelCharacteristicsAccountingBusinessServiceRegistryBuilder;
begin

  FBusinessServiceRegistry.
    RegisterReservoirKindReferenceSuiteAccountingAppService(
      ReservoirKindReferenceSuiteAccountingAppService
    );

  Result := Self;
  
end;

function TFuelCharacteristicsAccountingBusinessServiceRegistryBuilder.
  UseReservoirKindReferenceSuiteReferenceService(
    ReservoirKindReferenceSuiteReferenceService:
      IReservoirKindReferenceSuiteReferenceService
  ): TFuelCharacteristicsAccountingBusinessServiceRegistryBuilder;
begin

  FBusinessServiceRegistry.RegisterReservoirKindReferenceSuiteReferenceService(
    ReservoirKindReferenceSuiteReferenceService
  );

  Result := Self;
  
end;

function TFuelCharacteristicsAccountingBusinessServiceRegistryBuilder.
  UseReservoirSubLayerKindAccountingAppService(

    ReservoirSubLayerKindAccountingAppService:
      IReservoirSubLayerKindAccountingAppService

  ): TFuelCharacteristicsAccountingBusinessServiceRegistryBuilder;
begin

  FBusinessServiceRegistry
    .RegisterReservoirSubLayerKindAccountingAppService(
      ReservoirSubLayerKindAccountingAppService
    );

  Result := Self;
  
end;

function TFuelCharacteristicsAccountingBusinessServiceRegistryBuilder.
  UseSpecialityAccountingAppService(
    SpecialityAccountingAppService: ISpecialityAccountingAppService
  ): TFuelCharacteristicsAccountingBusinessServiceRegistryBuilder;
begin

  FBusinessServiceRegistry.RegisterSpecialityAccountingAppService(
    SpecialityAccountingAppService
  );

  Result := Self;
  
end;

end.
