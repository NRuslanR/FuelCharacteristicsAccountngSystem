unit FuelCharacteristicsCalculationCardContextInfoAssigningService;

interface

uses

  DomainService,
  FuelCharacteristicsCalculationCard,
  Employee,
  DomainException;

type

  TFuelCharacteristicsCalculationCardContextInfoAssigningServiceException =
    class (TDomainException)

    end;
    
  IFuelCharacteristicsCalculationCardContextInfoAssigningService =
    interface (IDomainService)

      function IsCalculationContextInfoAssignedToFuelCharacteristicsCalculationCard(
        FuelCharacteristicsCalculationCard: TFuelCharacteristicsCalculationCard;
        PerformedCalculationEmployee: TEmployee
      ): Boolean;

      procedure AssignCalculationContextInfoToFuelCharacteristicsCalculationCard(
        FuelCharacteristicsCalculationCard: TFuelCharacteristicsCalculationCard;
        PerformedCalculationEmployee: TEmployee
      );

    end;


implementation

end.
