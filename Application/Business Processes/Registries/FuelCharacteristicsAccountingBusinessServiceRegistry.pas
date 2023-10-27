unit FuelCharacteristicsAccountingBusinessServiceRegistry;

interface

uses

  ApplicationServiceRegistry,
  FuelCharacteristicsCalculationCardAccountingAppService,
  FuelCharacteristicsCalculationAppService,
  ReservoirKindAccountingAppService,
  ReservoirKindReferenceSuiteAccountingAppService,
  ReservoirKindReferenceService,
  ReservoirKindReferenceSuiteReferenceService,
  ReservoirSubLayerKindAccountingAppService,
  WorkingTimeConditionsAccountingAppService,
  SpecialityAccountingAppService;

type

  IFuelCharacteristicsAccountingBusinessServiceRegistry =
    interface (IApplicationServiceRegistry)

      procedure RegisterFuelCharacteristicsCalculationCardAccountingAppService(
        FuelCharacteristicsCalculationCardAccountingAppService:
          IFuelCharacteristicsCalculationCardAccountingAppService
      );

      function GetFuelCharacteristicsCalculationCardAccountingAppService:
        IFuelCharacteristicsCalculationCardAccountingAppService;

      procedure RegisterFuelCharacteristicsCalculationAppService(
        FuelCharacteristicsCalculationAppService:
          IFuelCharacteristicsCalculationAppService
      );

      function GetFuelCharacteristicsCalculationAppService:
        IFuelCharacteristicsCalculationAppService;
        
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

      procedure RegisterSpecialityAccountingAppService(
        SpecialityAccountingAppService: ISpecialityAccountingAppService
      );

      function GetSpecialityAccountingAppService: ISpecialityAccountingAppService;

      procedure RegisterReservoirSubLayerKindAccountingAppService(
        ReservoirSubLayerKindAccountingAppService:
          IReservoirSubLayerKindAccountingAppService
      );

      function GetReservoirSubLayerKindAccountingAppService:
        IReservoirSubLayerKindAccountingAppService;

      procedure RegisterWorkingTimeConditionsAccountingAppService(
        WorkingTimeConditionsAccountingAppService:
          IWorkingTimeConditionsAccountingAppService
      );

      function GetWorkingTimeConditionsAccountingAppService:
        IWorkingTimeConditionsAccountingAppService;
        
    end;

implementation

end.
