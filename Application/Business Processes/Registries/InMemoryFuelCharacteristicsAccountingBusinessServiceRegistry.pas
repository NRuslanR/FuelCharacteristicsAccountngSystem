unit InMemoryFuelCharacteristicsAccountingBusinessServiceRegistry;

interface

uses

  FuelCharacteristicsAccountingBusinessServiceRegistry,
  FuelCharacteristicsCalculationCardAccountingAppService,
  ReservoirKindAccountingAppService,
  ReservoirKindReferenceSuiteAccountingAppService,
  ReservoirSubLayerKindAccountingAppService,
  ReservoirKindReferenceService,
  ReservoirKindReferenceSuiteReferenceService,
  SpecialityAccountingAppService,
  InMemoryApplicationServiceRegistry,
  FuelCharacteristicsCalculationAppService,
  WorkingTimeConditionsAccountingAppService,
  SysUtils,
  Classes;

type

  TInMemoryFuelCharacteristicsAccountingBusinessServiceRegistry =
    class (
      TInMemoryApplicationServiceRegistry,
      IFuelCharacteristicsAccountingBusinessServiceRegistry
    )

      public

        procedure RegisterFuelCharacteristicsCalculationCardAccountingAppService(
          FuelCharacteristicsCalculationCardAccountingAppService:
            IFuelCharacteristicsCalculationCardAccountingAppService
        );

        function GetFuelCharacteristicsCalculationCardAccountingAppService:
          IFuelCharacteristicsCalculationCardAccountingAppService;

      public

        procedure RegisterFuelCharacteristicsCalculationAppService(
          FuelCharacteristicsCalculationAppService:
            IFuelCharacteristicsCalculationAppService
        );

        function GetFuelCharacteristicsCalculationAppService:
          IFuelCharacteristicsCalculationAppService;

      public

        procedure RegisterReservoirKindAccountingAppService(
          ReservoirKindAccountingAppService: IReservoirKindAccountingAppService
        );

        function GetReservoirKindAccountingAppService:
          IReservoirKindAccountingAppService;

        procedure RegisterReservoirKindReferenceSuiteAccountingAppService(
          ReservoirKindReferenceSuiteAccountingAppService:
            IReservoirKindReferenceSuiteAccountingAppService
        );

        function GetReservoirKindReferenceSuiteAccountingAppService:
          IReservoirKindReferenceSuiteAccountingAppService;

        procedure RegisterReservoirKindReferenceService(
          ReservoirKindReferenceService: IReservoirKindReferenceService
        );

        function GetReservoirKindReferenceService: IReservoirKindReferenceService;

        procedure RegisterReservoirKindReferenceSuiteReferenceService(
          ReservoirKindReferenceSuiteReferenceService:
            IReservoirKindReferenceSuiteReferenceService
        );

        function GetReservoirKindReferenceSuiteReferenceService:
          IReservoirKindReferenceSuiteReferenceService;

      public

        procedure RegisterSpecialityAccountingAppService(
          SpecialityAccountingAppService: ISpecialityAccountingAppService
        );

        function GetSpecialityAccountingAppService: ISpecialityAccountingAppService;

      public

        procedure RegisterReservoirSubLayerKindAccountingAppService(
          ReservoirSubLayerKindAccountingAppService:
            IReservoirSubLayerKindAccountingAppService
        );

        function GetReservoirSubLayerKindAccountingAppService:
          IReservoirSubLayerKindAccountingAppService;

      public

        procedure RegisterWorkingTimeConditionsAccountingAppService(
          WorkingTimeConditionsAccountingAppService:
            IWorkingTimeConditionsAccountingAppService
        );

        function GetWorkingTimeConditionsAccountingAppService:
          IWorkingTimeConditionsAccountingAppService;

    end;

implementation

{ TInMemoryFuelCharacteristicsAccountingBusinessServiceRegistry }

function TInMemoryFuelCharacteristicsAccountingBusinessServiceRegistry.
  GetFuelCharacteristicsCalculationAppService:
    IFuelCharacteristicsCalculationAppService;
begin

  Result :=
    IFuelCharacteristicsCalculationAppService(
      GetApplicationService(
        TypeInfo(IFuelCharacteristicsCalculationAppService)
      )
    );
    
end;

function TInMemoryFuelCharacteristicsAccountingBusinessServiceRegistry.
  GetFuelCharacteristicsCalculationCardAccountingAppService:
    IFuelCharacteristicsCalculationCardAccountingAppService;
begin

  Result :=
    IFuelCharacteristicsCalculationCardAccountingAppService(
      GetApplicationService(
        TypeInfo(IFuelCharacteristicsCalculationCardAccountingAppService)
      )
    );

end;

function TInMemoryFuelCharacteristicsAccountingBusinessServiceRegistry.
  GetReservoirKindAccountingAppService: IReservoirKindAccountingAppService;
begin

  Result :=
    IReservoirKindAccountingAppService(
      GetApplicationService(
        TypeInfo(IReservoirKindAccountingAppService)
      )
    );
    
end;

function TInMemoryFuelCharacteristicsAccountingBusinessServiceRegistry.
  GetReservoirKindReferenceService: IReservoirKindReferenceService;
begin

  Result :=
    IReservoirKindReferenceService(
      GetApplicationService(
        TypeInfo(IReservoirKindReferenceService)
      )
    );
    
end;

function TInMemoryFuelCharacteristicsAccountingBusinessServiceRegistry.
  GetReservoirKindReferenceSuiteAccountingAppService:
    IReservoirKindReferenceSuiteAccountingAppService;
begin

  Result :=
    IReservoirKindReferenceSuiteAccountingAppService(
      GetApplicationService(
        TypeInfo(IReservoirKindReferenceSuiteAccountingAppService)
      )
    );
    
end;

function TInMemoryFuelCharacteristicsAccountingBusinessServiceRegistry.
  GetReservoirKindReferenceSuiteReferenceService:
    IReservoirKindReferenceSuiteReferenceService;
begin

  Result :=
    IReservoirKindReferenceSuiteReferenceService(
      GetApplicationService(
        TypeInfo(IReservoirKindReferenceSuiteReferenceService)
      )
    );
    
end;

function TInMemoryFuelCharacteristicsAccountingBusinessServiceRegistry.
  GetReservoirSubLayerKindAccountingAppService:
    IReservoirSubLayerKindAccountingAppService;
begin

  Result :=
    IReservoirSubLayerKindAccountingAppService(
      GetApplicationService(
        TypeInfo(IReservoirSubLayerKindAccountingAppService)
      )
    );

end;

function TInMemoryFuelCharacteristicsAccountingBusinessServiceRegistry.
  GetSpecialityAccountingAppService: ISpecialityAccountingAppService;
begin

  Result :=
    ISpecialityAccountingAppService(
      GetApplicationService(
        TypeInfo(ISpecialityAccountingAppService)
      )
    );
    
end;

function TInMemoryFuelCharacteristicsAccountingBusinessServiceRegistry.
  GetWorkingTimeConditionsAccountingAppService:
    IWorkingTimeConditionsAccountingAppService;
begin

  Result :=
    IWorkingTimeConditionsAccountingAppService(
      GetApplicationService(
        TypeInfo(IWorkingTimeConditionsAccountingAppService)
      )
    );
    
end;

procedure TInMemoryFuelCharacteristicsAccountingBusinessServiceRegistry.
  RegisterFuelCharacteristicsCalculationAppService(
  
    FuelCharacteristicsCalculationAppService:
      IFuelCharacteristicsCalculationAppService

  );
begin

  RegisterApplicationService(
    TypeInfo(IFuelCharacteristicsCalculationAppService),
    FuelCharacteristicsCalculationAppService
  );

end;

procedure TInMemoryFuelCharacteristicsAccountingBusinessServiceRegistry.
  RegisterFuelCharacteristicsCalculationCardAccountingAppService(
    FuelCharacteristicsCalculationCardAccountingAppService:
      IFuelCharacteristicsCalculationCardAccountingAppService
  );
begin

  RegisterOrUpdateApplicationService(
    TypeInfo(IFuelCharacteristicsCalculationCardAccountingAppService),
    FuelCharacteristicsCalculationCardAccountingAppService
  );

end;

procedure TInMemoryFuelCharacteristicsAccountingBusinessServiceRegistry.
  RegisterReservoirKindAccountingAppService(
    ReservoirKindAccountingAppService: IReservoirKindAccountingAppService
  );
begin

  RegisterOrUpdateApplicationService(
    TypeInfo(IReservoirKindAccountingAppService),
    ReservoirKindAccountingAppService
  );
  
end;

procedure TInMemoryFuelCharacteristicsAccountingBusinessServiceRegistry.
  RegisterReservoirKindReferenceService(
    ReservoirKindReferenceService: IReservoirKindReferenceService
  );
begin

  RegisterOrUpdateApplicationService(
    TypeInfo(IReservoirKindReferenceService),
    ReservoirKindReferenceService
  );
  
end;

procedure TInMemoryFuelCharacteristicsAccountingBusinessServiceRegistry.
  RegisterReservoirKindReferenceSuiteAccountingAppService(
    ReservoirKindReferenceSuiteAccountingAppService:
      IReservoirKindReferenceSuiteAccountingAppService
  );
begin

  RegisterOrUpdateApplicationService(
    TypeInfo(IReservoirKindReferenceSuiteAccountingAppService),
    ReservoirKindReferenceSuiteAccountingAppService
  );
  
end;

procedure TInMemoryFuelCharacteristicsAccountingBusinessServiceRegistry.
  RegisterReservoirKindReferenceSuiteReferenceService(
    ReservoirKindReferenceSuiteReferenceService:
      IReservoirKindReferenceSuiteReferenceService
  );
begin

  RegisterOrUpdateApplicationService(
    TypeInfo(IReservoirKindReferenceSuiteReferenceService),
    ReservoirKindReferenceSuiteReferenceService
  );

end;

procedure TInMemoryFuelCharacteristicsAccountingBusinessServiceRegistry.
  RegisterReservoirSubLayerKindAccountingAppService(
  
    ReservoirSubLayerKindAccountingAppService:
      IReservoirSubLayerKindAccountingAppService

  );
begin

  RegisterApplicationService(
    TypeInfo(IReservoirSubLayerKindAccountingAppService),
    ReservoirSubLayerKindAccountingAppService
  );

end;

procedure TInMemoryFuelCharacteristicsAccountingBusinessServiceRegistry.
  RegisterSpecialityAccountingAppService(
    SpecialityAccountingAppService: ISpecialityAccountingAppService
  );
begin

  RegisterOrUpdateApplicationService(
    TypeInfo(ISpecialityAccountingAppService),
    SpecialityAccountingAppService
  );

end;

procedure TInMemoryFuelCharacteristicsAccountingBusinessServiceRegistry.
  RegisterWorkingTimeConditionsAccountingAppService(

    WorkingTimeConditionsAccountingAppService:
      IWorkingTimeConditionsAccountingAppService

  );
begin

  RegisterOrUpdateApplicationService(
    TypeInfo(IWorkingTimeConditionsAccountingAppService),
    WorkingTimeConditionsAccountingAppService
  );

end;

end.
