unit FuelCharacteristicsCalculationCardAccountingServiceRegistry;

interface

uses

  DomainException,
  FuelCharacteristicsCalculationCardAccountingService,
  FuelCharacteristicsCalculationCardAccessService,
  FuelCharacteristicsCalculationCardContextInfoAssigningService,
  FuelCharacteristicsCalculationCardCreatingService;

type

  TFuelCharacteristicsCalculationCardAccountingServiceRegistryException =
    class (TDomainException)

    end;


  IFuelCharacteristicsCalculationCardAccountingServiceRegistry = interface

    procedure Clear;
    
    procedure RegisterFuelCharacteristicsCalculationCardAccountingService(
      FuelCharacteristicsCalculationCardAccountingService:
        IFuelCharacteristicsCalculationCardAccountingService
    );

    function GetFuelCharacteristicsCalculationCardAccountingService:
      IFuelCharacteristicsCalculationCardAccountingService;

    procedure RegisterStandardFuelCharacteristicsCalculationCardAccountingService;


    procedure RegisterFuelCharacteristicsCalculationCardAccessService(
      FuelCharacteristicsCalculationCardAccessService:
        IFuelCharacteristicsCalculationCardAccessService
    );

    function GetFuelCharacteristicsCalculationCardAccessService:
      IFuelCharacteristicsCalculationCardAccessService;

    procedure RegisterStandardFuelCharacteristicsCalculationCardAccessService;


    procedure RegisterFuelCharacteristicsCalculationCardContextInfoAssigningService(
      FuelCharacteristicsCalculationCardContextInfoAssigningService:
        IFuelCharacteristicsCalculationCardContextInfoAssigningService
    );

    function GetFuelCharacteristicsCalculationCardContextInfoAssigningService:
      IFuelCharacteristicsCalculationCardContextInfoAssigningService;

    procedure RegisterStandardFuelCharacteristicsCalculationCardContextInfoAssigningService;


    procedure RegisterFuelCharacteristicsCalculationCardCreatingService(
      FuelCharacteristicsCalculationCardCreatingService:
        IFuelCharacteristicsCalculationCardCreatingService
    );

    function GetFuelCharacteristicsCalculationCardCreatingService:
      IFuelCharacteristicsCalculationCardCreatingService;

    procedure RegisterStandardFuelCharacteristicsCalculationCardCreatingService;


    procedure RegisterStandardFuelCharacteristicsCalculationCardAccountingServices;
    
  end;
  
implementation

end.
