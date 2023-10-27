unit FuelCharacteristicsAccountingRepositoryRegistry;

interface

uses

  DomainObjectRepositoryRegistry,
  Role,
  RoleRepository,
  Employee,
  EmployeeRepository,
  FuelCharacteristicsCalculationCardRepository,
  ReservoirKindRepository,
  ReservoirKindReferenceSuiteRepository,
  WorkingTimeConditionsRepository,
  ISessionUnit;

type

  IFuelCharacteristicsAccountingRepositoryRegistry =
    interface (IDomainObjectRepositoryRegistry)
    ['{F67A05B7-26A2-406C-B4C8-4A16759B353D}']

      procedure Clear;

      procedure RegisterFuelCharacteristicsCalculationCardRepository(
        FuelCharacteristicsCalculationCardRepository:
          IFuelCharacteristicsCalculationCardRepository
      );

      function GetFuelCharacteristicsCalculationCardRepository:
        IFuelCharacteristicsCalculationCardRepository;

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

      procedure RegisterRoleRepository(
        RoleRepository: IRoleRepository
      );

      function GetRoleRepository: IRoleRepository;

      procedure RegisterEmployeeRepository(
        EmployeeRepository: IEmployeeRepository
      );

      function GetEmployeeRepository: IEmployeeRepository;

      procedure RegisterWorkingTimeConditionsRepository(
        WorkingTimeConditionsRepository: IWorkingTimeConditionsRepository
      );

      function GetWorkingTimeConditionsRepository:
        IWorkingTimeConditionsRepository;

    end;

implementation

end.
