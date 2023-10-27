unit FuelCharacteristicsCalculationCardAccessService;

interface

uses

  Employee,
  DomainException,
  DomainService,
  FuelCharacteristicsCalculationCard,
  FuelCharacteristicsCalculationCardAccessRights,
  SysUtils;

type

  TFuelCharacteristicsCalculationCardAccessServiceException =
    class (TDomainException)

    end;
    
  IFuelCharacteristicsCalculationCardAccessService =
    interface (IDomainService)

      function GetFuelCharacteristicsCalculationCardAccessRightsForEmployee(
        FuelCharacteristicsCalculationCard: TFuelCharacteristicsCalculationCard;
        Employee: TEmployee
      ): TFuelCharacteristicsCalculationCardAccessRights;

      function EnsureAndGetFuelCharacteristicsCalculationCardAccessRightsForEmployee(
        FuelCharacteristicsCalculationCard: TFuelCharacteristicsCalculationCard;
        Employee: TEmployee
      ): TFuelCharacteristicsCalculationCardAccessRights;

      procedure EnsureFuelCharacteristicsCalculationCardAccessRightsForEmployee(
        FuelCharacteristicsCalculationCard: TFuelCharacteristicsCalculationCard;
        Employee: TEmployee
      );

    end;

implementation

end.
