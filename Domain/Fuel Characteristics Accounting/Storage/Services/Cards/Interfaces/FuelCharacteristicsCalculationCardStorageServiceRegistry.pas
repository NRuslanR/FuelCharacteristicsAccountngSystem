unit FuelCharacteristicsCalculationCardStorageServiceRegistry;

interface

uses

  DomainException,
  FuelCharacteristicsCalculationCardDirectoryAccessService,
  FuelCharacteristicsCalculationCardDirectory;

type

  TFuelCharacteristicsCalculationCardStorageServiceRegistryException =
    class (TDomainException)

    end;
    
  IFuelCharacteristicsCalculationCardStorageServiceRegistry =
    interface

      procedure Clear;
      
      procedure RegisterFuelCharacteristicsCalculationCardDirectory(
        FuelCharacteristicsCalculationCardDirectory:
          IFuelCharacteristicsCalculationCardDirectory
      );

      function GetFuelCharacteristicsCalculationCardDirectory:
        IFuelCharacteristicsCalculationCardDirectory;


      procedure RegisterFuelCharacteristicsCalculationCardDirectoryAccessService(
        FuelCharacteristicsCalculationCardDirectoryAccessService:
          IFuelCharacteristicsCalculationCardDirectoryAccessService
      );

      function GetFuelCharacteristicsCalculationCardDirectoryAccessService:
        IFuelCharacteristicsCalculationCardDirectoryAccessService;

      procedure RegisterStandardFuelCharacteristicsCalculationCardDirectoryAccessService;
      
    end;

implementation

end.
