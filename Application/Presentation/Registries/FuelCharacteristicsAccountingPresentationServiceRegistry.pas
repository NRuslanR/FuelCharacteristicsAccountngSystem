unit FuelCharacteristicsAccountingPresentationServiceRegistry;

interface

uses

  FuelCharacteristicsCalculationCardSetReadService,
  ReservoirKindSetReadService,
  ReservoirKindReferenceSuiteSetReadService,
  EmployeeAccountSetReadService,
  ApplicationServiceRegistry;

type

  IFuelCharacteristicsAccountingPresentationServiceRegistry =
    interface (IApplicationServiceRegistry)

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

end.
