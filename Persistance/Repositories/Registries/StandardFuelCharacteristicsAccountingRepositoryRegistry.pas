unit StandardFuelCharacteristicsAccountingRepositoryRegistry;

interface

uses

  FuelCharacteristicsAccountingRepositoryRegistry,
  StandardDomainObjectRepositoryRegistry,
  DomainObjectRepositoryRegistry,
  Role,
  RoleRepository,
  Employee,
  EmployeeRepository,
  FuelCharacteristicsCalculationCard,
  FuelCharacteristicsCalculationCardRepository,
  ReservoirKind,
  ReservoirKindRepository,
  ReservoirKindReferenceSuite,
  ReservoirKindReferenceSuiteRepository,
  WorkingTimeConditions,
  WorkingTimeConditionsRepository,
  SysUtils,
  Classes;

type

  TFuelCharacteristicsAccountingRepositoryRegistry =
    class (
      TDomainObjectRepositoryRegistry,
      IFuelCharacteristicsAccountingRepositoryRegistry,
      IDomainObjectRepositoryRegistry
    )

      private
      
        class function GetFuelCharacteristicsAccountingRepositoryRegistry:
          IFuelCharacteristicsAccountingRepositoryRegistry; static;

        class procedure SetFuelCharacteristicsAccountingRepositoryRegistry(
          const Value: IFuelCharacteristicsAccountingRepositoryRegistry
        ); static;

      public

        procedure RegisterFuelCharacteristicsCalculationCardRepository(
          FuelCharacteristicsCalculationCardRepository:
            IFuelCharacteristicsCalculationCardRepository
        );

        function GetFuelCharacteristicsCalculationCardRepository:
          IFuelCharacteristicsCalculationCardRepository;

      public

        procedure RegisterReservoirKindRepository(
          ReservoirKindRepository: IReservoirKindRepository
        );

        function GetReservoirKindRepository: IReservoirKindRepository;

        procedure RegisterReservoirKindReferenceSuiteRepository(
          ReservoirKindReferenceSuiteRepository:
            IReservoirKindReferenceSuiteRepository
        );

        function GetReservoirKindReferenceSuiteRepository:
          IReservoirKindReferenceSuiteRepository;

      public

        procedure RegisterRoleRepository(
          RoleRepository: IRoleRepository
        );

        function GetRoleRepository: IRoleRepository;

      public

        procedure RegisterEmployeeRepository(
          EmployeeRepository: IEmployeeRepository
        );

        function GetEmployeeRepository: IEmployeeRepository;

      public

        procedure RegisterWorkingTimeConditionsRepository(
          WorkingTimeConditionsRepository: IWorkingTimeConditionsRepository
        );

        function GetWorkingTimeConditionsRepository:
          IWorkingTimeConditionsRepository;
        
      public
      
        class property Current: IFuelCharacteristicsAccountingRepositoryRegistry
        read GetFuelCharacteristicsAccountingRepositoryRegistry
        write SetFuelCharacteristicsAccountingRepositoryRegistry;
        
    end;

implementation


{ TFuelCharacteristicsAccountingRepositoryRegistry }

function TFuelCharacteristicsAccountingRepositoryRegistry.GetEmployeeRepository: IEmployeeRepository;
begin

  Result :=
    IEmployeeRepository(
      GetDomainObjectRepository(TEmployee)
    );

end;

class function TFuelCharacteristicsAccountingRepositoryRegistry.
  GetFuelCharacteristicsAccountingRepositoryRegistry:
    IFuelCharacteristicsAccountingRepositoryRegistry;
begin

  if not Assigned(FInstance) then
    FInstance := TFuelCharacteristicsAccountingRepositoryRegistry.Create;

  Result := IFuelCharacteristicsAccountingRepositoryRegistry(FInstance);
  
end;

function TFuelCharacteristicsAccountingRepositoryRegistry.
  GetFuelCharacteristicsCalculationCardRepository:
    IFuelCharacteristicsCalculationCardRepository;
begin

  Result :=
    IFuelCharacteristicsCalculationCardRepository(
      GetDomainObjectRepository(TFuelCharacteristicsCalculationCard)
    );
    
end;

function TFuelCharacteristicsAccountingRepositoryRegistry.
  GetReservoirKindReferenceSuiteRepository:
    IReservoirKindReferenceSuiteRepository;
begin

  Result :=
    IReservoirKindReferenceSuiteRepository(
      GetDomainObjectRepository(TReservoirKindReferenceSuite)
    );
    
end;

function TFuelCharacteristicsAccountingRepositoryRegistry.
  GetReservoirKindRepository: IReservoirKindRepository;
begin

  Result :=
    IReservoirKindRepository(GetDomainObjectRepository(TReservoirKind));
    
end;

function TFuelCharacteristicsAccountingRepositoryRegistry.
  GetRoleRepository: IRoleRepository;
begin

  Result := IRoleRepository(GetDomainObjectRepository(TRole));
  
end;

function TFuelCharacteristicsAccountingRepositoryRegistry.
  GetWorkingTimeConditionsRepository: IWorkingTimeConditionsRepository;
begin

  Result :=
    IWorkingTimeConditionsRepository(
      GetDomainObjectRepository(TWorkingTimeConditions)
    );

end;

procedure TFuelCharacteristicsAccountingRepositoryRegistry.
  RegisterEmployeeRepository(
    EmployeeRepository: IEmployeeRepository
  );
begin

  RegisterDomainObjectRepository(TEmployee, EmployeeRepository);
  
end;

procedure TFuelCharacteristicsAccountingRepositoryRegistry.
  RegisterFuelCharacteristicsCalculationCardRepository(
    FuelCharacteristicsCalculationCardRepository:
      IFuelCharacteristicsCalculationCardRepository
  );
begin

  RegisterDomainObjectRepository(
    TFuelCharacteristicsCalculationCard,
    FuelCharacteristicsCalculationCardRepository
  );
  
end;

procedure TFuelCharacteristicsAccountingRepositoryRegistry.
  RegisterReservoirKindReferenceSuiteRepository(
    ReservoirKindReferenceSuiteRepository:
      IReservoirKindReferenceSuiteRepository
  );
begin

  RegisterDomainObjectRepository(
    TReservoirKindReferenceSuite,
    ReservoirKindReferenceSuiteRepository
  );

end;

procedure TFuelCharacteristicsAccountingRepositoryRegistry.
  RegisterReservoirKindRepository(
    ReservoirKindRepository: IReservoirKindRepository
  );
begin

  RegisterDomainObjectRepository(
    TReservoirKind,
    ReservoirKindRepository
  );

end;

procedure TFuelCharacteristicsAccountingRepositoryRegistry.
  RegisterRoleRepository(
    RoleRepository: IRoleRepository
  );
begin

  RegisterDomainObjectRepository(TRole, RoleRepository);
  
end;

procedure TFuelCharacteristicsAccountingRepositoryRegistry.
  RegisterWorkingTimeConditionsRepository(
    WorkingTimeConditionsRepository: IWorkingTimeConditionsRepository
  );
begin

  RegisterDomainObjectRepository(
    TWorkingTimeConditions, WorkingTimeConditionsRepository
  );
  
end;

class procedure TFuelCharacteristicsAccountingRepositoryRegistry.
  SetFuelCharacteristicsAccountingRepositoryRegistry(
    const Value: IFuelCharacteristicsAccountingRepositoryRegistry
  );
begin

  SetCurrent(Value);

end;

end.
