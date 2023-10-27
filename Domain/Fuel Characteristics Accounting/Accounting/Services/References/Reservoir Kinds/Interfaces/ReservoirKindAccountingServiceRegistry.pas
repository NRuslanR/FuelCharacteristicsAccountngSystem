unit ReservoirKindAccountingServiceRegistry;

interface

uses

  DomainException,
  ReservoirKindAccessService,
  ReservoirKindReferenceSuiteAccessService,
  ReservoirKindAccountingService,
  ReservoirSubLayerKindAccountingService,
  ReservoirKindReferenceSuiteAccountingService,
  ReservoirCalibrationChartRegistry;

type

  TReservoirKindAccountingServiceRegistryException = class (TDomainException)

  end;

  IReservoirKindAccountingServiceRegistry = interface

    procedure Clear;

    procedure RegisterReservoirSubLayerKindAccountingService(
      ReservoirSubLayerKindAccountingService:
        IReservoirSubLayerKindAccountingService
    );

    function GetReservoirSubLayerKindAccountingService:
      IReservoirSubLayerKindAccountingService;

    procedure RegisterStandardReservoirSubLayerKindAccountingService;
    
    procedure RegisterReservoirKindAccessService(
      ReservoirKindAccessService: IReservoirKindAccessService
    );

    function GetReservoirKindAccessService: IReservoirKindAccessService;

    procedure RegisterStandardReservoirKindAccessService;


    procedure RegisterReservoirKindAccountingService(
      ReservoirKindAccountingService: IReservoirKindAccountingService
    );

    function GetReservoirKindAccountingService: IReservoirKindAccountingService;

    procedure RegisterStandardReservoirKindAccountingService;


    procedure RegisterReservoirKindReferenceSuiteAccessService(
      ReservoirKindReferenceSuiteAccessService:
        IReservoirKindReferenceSuiteAccessService
    );

    function GetReservoirKindReferenceSuiteAccessService:
      IReservoirKindReferenceSuiteAccessService;

    procedure RegisterStandardReservoirKindReferenceSuiteAccessService;


    procedure RegisterReservoirKindReferenceSuiteAccountingService(
      ReservoirKindReferenceSuiteAccountingService:
        IReservoirKindReferenceSuiteAccountingService
    );

    function GetReservoirKindReferenceSuiteAccountingService:
      IReservoirKindReferenceSuiteAccountingService;

    procedure RegisterStandardReservoirKindReferenceSuiteAccountingService;

    procedure RegisterReservoirCalibrationChartRegistry(
      ReservoirCalibrationChartRegistry: IReservoirCalibrationChartRegistry
    );

    function GetReservoirCalibrationChartRegistry: IReservoirCalibrationChartRegistry;

    procedure RegisterStandardReservoirKindAccountingServices;
    
  end;

implementation

end.
