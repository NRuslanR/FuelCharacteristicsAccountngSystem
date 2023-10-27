unit FuelCharacteristicsCalculationCardCreatingService;

interface

uses

  DomainException,
  Employee,
  DomainService,
  unIFuelCharacteristicsCalculationCard,
  FuelCharacteristicsCalculationCardAccessRights;

type

  TFuelCharacteristicsCalculationCardCreatingServiceException =
    class (TDomainException)
        
    end;

  IFuelCharacteristicsCalculationCardCreatingService =
    interface (IDomainService)

      procedure CreateFuelCharacteristicsCalculationCardForEmployee(
        Employee: TEmployee;
        var Card: IFuelCharacteristicsCalculationCard;
        var CardAccessRights: TFuelCharacteristicsCalculationCardAccessRights
      );

    end;

implementation

end.
