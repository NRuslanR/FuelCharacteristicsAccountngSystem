unit FuelCharacteristicsCalculationServiceRegistry;

interface

uses

  DomainException,
  ElectronicMetroshtok,
  ReservoirCalibrationChartRegistry,
  ReservoirSubLayerKindAccountingService,
  FuelCharacteristicsCalculationService;

type

  TFuelCharacteristicsCalculationServiceRegistryException =
    class (TDomainException)

    end;
    
  IFuelCharacteristicsCalculationServiceRegistry = interface

    procedure Clear;
    
    procedure RegisterElectronicMetroshtok(
      ElectronicMetroshtok: IElectronicMetroshtok
    );

    function GetElectronicMetroshtok: IElectronicMetroshtok;

    procedure RegisterFuelCharacteristicsCalculationService(
      FuelCharacteristicsCalculationService:
        IFuelCharacteristicsCalculationService
    );

    function GetFuelCharacteristicsCalculationService:
      IFuelCharacteristicsCalculationService;

    procedure RegisterStandardFuelCharacteristicsCalculationService;

  end;
  
implementation

end.
