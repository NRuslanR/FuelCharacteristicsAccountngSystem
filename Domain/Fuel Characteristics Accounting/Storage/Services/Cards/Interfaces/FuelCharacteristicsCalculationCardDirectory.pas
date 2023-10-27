unit FuelCharacteristicsCalculationCardDirectory;

interface

uses

  DomainService,
  FuelCharacteristicsCalculationCard,
  DomainException;

type

  TFuelCharacteristicsCalculationCardDirectoryException =
    class (TDomainException)

    end;
    
  IFuelCharacteristicsCalculationCardDirectory = interface (IDomainService)

    function FindFuelCharacteristicsCalculationCard(
      const CardIdentity: Variant
    ): TFuelCharacteristicsCalculationCard;
    
    procedure PutFuelCharacteristicsCalculationCard(
      FuelCharacteristicsCalculationCard: TFuelCharacteristicsCalculationCard
    );

    procedure ModifyFuelCharacteristicsCalculationCard(
      FuelCharacteristicsCalculationCard: TFuelCharacteristicsCalculationCard
    );

    procedure RemoveFuelCharacteristicsCalculationCard(
      FuelCharacteristicsCalculationCard: TFuelCharacteristicsCalculationCard
    );

  end;


implementation

end.
