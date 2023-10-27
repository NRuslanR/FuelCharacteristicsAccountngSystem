unit InMemoryFuelCharacteristicsAccountingPresentationServiceRegistry;

interface

uses

  FuelCharacteristicsAccountingPresentationServiceRegistry,
  FuelCharacteristicsCalculationCardSetReadService,
  ReservoirKindSetReadService,
  ReservoirKindReferenceSuiteSetReadService,
  EmployeeAccountSetReadService,
  ApplicationServiceRegistry,
  InMemoryApplicationServiceRegistry,
  SysUtils,
  Classes;

type

  TInMemoryFuelCharacteristicsAccountingPresentationServiceRegistry =
    class (
      TInMemoryApplicationServiceRegistry,
      IFuelCharacteristicsAccountingPresentationServiceRegistry
    )

      public

        procedure RegisterFuelCharacteristicsCalculationCardSetReadService(
          FuelCharacteristicsCalculationCardSetReadService:
            IFuelCharacteristicsCalculationCardSetReadService
        );

        function GetFuelCharacteristicsCalculationCardSetReadService:
          IFuelCharacteristicsCalculationCardSetReadService;

        procedure RegisterReservoirKindSetReadService(
          ReservoirKindSetReadService: IReservoirKindSetReadService
        );

        function GetReservoirKindSetReadService: IReservoirKindSetReadService;

        procedure RegisterReservoirKindReferenceSuiteSetReadService(
          ReservoirKindReferenceSuiteSetReadService:
            IReservoirKindReferenceSuiteSetReadService
        );

        function GetReservoirKindReferenceSuiteSetReadService:
          IReservoirKindReferenceSuiteSetReadService;

        procedure RegisterEmployeeAccountSetReadService(
          EmployeeAccountSetReadService: IEmployeeAccountSetReadService
        );

        function GetEmployeeAccountSetReadService:
          IEmployeeAccountSetReadService;

    end;
    
implementation

uses

  TypInfo;

{ TInMemoryFuelCharacteristicsAccountingPresentationServiceRegistry }

function TInMemoryFuelCharacteristicsAccountingPresentationServiceRegistry.
  GetEmployeeAccountSetReadService: IEmployeeAccountSetReadService;
begin

  Result :=
    IEmployeeAccountSetReadService(
      GetApplicationService(TypeInfo(IEmployeeAccountSetReadService))
    );
    
end;

function TInMemoryFuelCharacteristicsAccountingPresentationServiceRegistry.
  GetFuelCharacteristicsCalculationCardSetReadService:
    IFuelCharacteristicsCalculationCardSetReadService;
begin

  Result :=
    IFuelCharacteristicsCalculationCardSetReadService(
      GetApplicationService(
        TypeInfo(IFuelCharacteristicsCalculationCardSetReadService)
      )
    );
  
end;

function TInMemoryFuelCharacteristicsAccountingPresentationServiceRegistry.
  GetReservoirKindReferenceSuiteSetReadService:
    IReservoirKindReferenceSuiteSetReadService;
begin

  Result :=
    IReservoirKindReferenceSuiteSetReadService(
      GetApplicationService(
        TypeInfo(IReservoirKindReferenceSuiteSetReadService)
      )
    );
    
end;

function TInMemoryFuelCharacteristicsAccountingPresentationServiceRegistry.
  GetReservoirKindSetReadService: IReservoirKindSetReadService;
begin

  Result :=
    IReservoirKindSetReadService(
      GetApplicationService(
        TypeInfo(IReservoirKindSetReadService)
      )
    );
    
end;

procedure TInMemoryFuelCharacteristicsAccountingPresentationServiceRegistry.
  RegisterEmployeeAccountSetReadService(
    EmployeeAccountSetReadService: IEmployeeAccountSetReadService
  );
begin

  RegisterOrUpdateApplicationService(
    TypeInfo(IEmployeeAccountSetReadService),
    EmployeeAccountSetReadService
  );
  
end;

procedure TInMemoryFuelCharacteristicsAccountingPresentationServiceRegistry.
  RegisterFuelCharacteristicsCalculationCardSetReadService(
    FuelCharacteristicsCalculationCardSetReadService:
      IFuelCharacteristicsCalculationCardSetReadService
  );
begin

  RegisterOrUpdateApplicationService(
    TypeInfo(IFuelCharacteristicsCalculationCardSetReadService),
    FuelCharacteristicsCalculationCardSetReadService
  );

end;

procedure TInMemoryFuelCharacteristicsAccountingPresentationServiceRegistry.
  RegisterReservoirKindReferenceSuiteSetReadService(
    ReservoirKindReferenceSuiteSetReadService:
      IReservoirKindReferenceSuiteSetReadService
  );
begin

  RegisterOrUpdateApplicationService(
    TypeInfo(IReservoirKindReferenceSuiteSetReadService),
    ReservoirKindReferenceSuiteSetReadService
  );
  
end;

procedure TInMemoryFuelCharacteristicsAccountingPresentationServiceRegistry.
  RegisterReservoirKindSetReadService(
    ReservoirKindSetReadService: IReservoirKindSetReadService
  );
begin

  RegisterOrUpdateApplicationService(
    TypeInfo(IReservoirKindSetReadService),
    ReservoirKindSetReadService
  );
  
end;

end.
