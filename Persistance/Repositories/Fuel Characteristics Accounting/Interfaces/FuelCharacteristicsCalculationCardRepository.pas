unit FuelCharacteristicsCalculationCardRepository;

interface

uses

  DomainObjectRepository,
  VariantListUnit,
  FuelCharacteristicsCalculationCard;

type

  IFuelCharacteristicsCalculationCardRepository =
    interface (IDomainObjectRepository)
      ['{EE0F9205-4EB3-4933-AD7C-A04B7AAD180F}']

      function AddFuelCharacteristicsCalculationCard(
        FuelCharacteristicsCalculationCard: TFuelCharacteristicsCalculationCard
      ): Boolean;
      
      function AddFuelCharacteristicsCalculationCards(
        FuelCharacteristicsCalculationCards: TFuelCharacteristicsCalculationCards
      ): Boolean;
      
      function UpdateFuelCharacteristicsCalculationCard(
        FuelCharacteristicsCalculationCard: TFuelCharacteristicsCalculationCard
      ): Boolean;

      function UpdateFuelCharacteristicsCalculationCards(
        FuelCharacteristicsCalculationCards: TFuelCharacteristicsCalculationCards
      ): Boolean;
      
      function RemoveFuelCharacteristicsCalculationCard(
        FuelCharacteristicsCalculationCard: TFuelCharacteristicsCalculationCard
      ): Boolean;
      
      function RemoveFuelCharacteristicsCalculationCards(
        FuelCharacteristicsCalculationCards: TFuelCharacteristicsCalculationCards
      ): Boolean;
      
      function FindFuelCharacteristicsCalculationCardByIdentity(
        Identity: Variant
      ): TFuelCharacteristicsCalculationCard;
      
      function FindFuelCharacteristicsCalculationCardsByIdentities(
        const Identities: TVariantList
      ): TFuelCharacteristicsCalculationCards;

      function LoadAllFuelCharacteristicsCalculationCards:
        TFuelCharacteristicsCalculationCards;
      
    end;
    
implementation

end.
