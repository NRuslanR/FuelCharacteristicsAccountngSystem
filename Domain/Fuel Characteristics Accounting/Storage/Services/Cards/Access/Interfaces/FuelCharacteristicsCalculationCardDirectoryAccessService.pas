unit FuelCharacteristicsCalculationCardDirectoryAccessService;

interface

uses

  DomainService,
  FuelCharacteristicsCalculationCardDirectoryAccessRights,
  Employee,
  DomainException;

type

  TFuelCharacteristicsCalculationCardDirectoryAccessServiceException =
    class (TDomainException)

    end;

  IFuelCharacteristicsCalculationCardDirectoryAccessService =
    interface (IDomainService)

      function GetFuelCharacteristicsCalculationCardDirectoryAccessRightsForEmployee(
        Employee: TEmployee
      ): TFuelCharacteristicsCalculationCardDirectoryAccessRights;

      function EnsureAndGetFuelCharacteristicsCalculationCardDirectoryAccessRightsForEmployee(
        Employee: TEmployee
      ): TFuelCharacteristicsCalculationCardDirectoryAccessRights;

    end;
  
implementation

end.
