unit BasedOnRepositoryFuelCharacteristicsCalculationCardDirectory;

interface

uses

  AbstractFuelCharacteristicsCalculationCardDirectory,
  FuelCharacteristicsCalculationCard,
  FuelCharacteristicsCalculationCardRepository,
  SysUtils,
  Classes;

type

  TBasedOnRepositoryFuelCharacteristicsCalculationCardDirectory =
    class (TAbstractFuelCharacteristicsCalculationCardDirectory)

      private

        FFuelCharacteristicsCalculationCardRepository:
          IFuelCharacteristicsCalculationCardRepository;
          
      protected

        function InternalFindFuelCharacteristicsCalculationCard(
          const CardIdentity: Variant
        ): TFuelCharacteristicsCalculationCard; override;

        procedure InternalPutFuelCharacteristicsCalculationCard(
          FuelCharacteristicsCalculationCard: TFuelCharacteristicsCalculationCard
        ); override;

        procedure InternalModifyFuelCharacteristicsCalculationCard(
          FuelCharacteristicsCalculationCard: TFuelCharacteristicsCalculationCard
        ); override;

        procedure InternalRemoveFuelCharacteristicsCalculationCard(
          FuelCharacteristicsCalculationCard: TFuelCharacteristicsCalculationCard
        ); override;

      public

        constructor Create(
          FuelCharacteristicsCalculationCardRepository:
            IFuelCharacteristicsCalculationCardRepository
        );

    end;
    
implementation

{ TBasedOnRepositoryFuelCharacteristicsCalculationCardDirectory }

constructor TBasedOnRepositoryFuelCharacteristicsCalculationCardDirectory.
  Create(
    FuelCharacteristicsCalculationCardRepository:
      IFuelCharacteristicsCalculationCardRepository
  );
begin

  inherited Create;

  FFuelCharacteristicsCalculationCardRepository :=
    FuelCharacteristicsCalculationCardRepository;
  
end;

function TBasedOnRepositoryFuelCharacteristicsCalculationCardDirectory.
  InternalFindFuelCharacteristicsCalculationCard(
    const CardIdentity: Variant
  ): TFuelCharacteristicsCalculationCard;
begin

  Result :=
    FFuelCharacteristicsCalculationCardRepository.
      FindFuelCharacteristicsCalculationCardByIdentity(CardIdentity);
      
end;

procedure TBasedOnRepositoryFuelCharacteristicsCalculationCardDirectory.
  InternalModifyFuelCharacteristicsCalculationCard(
    FuelCharacteristicsCalculationCard: TFuelCharacteristicsCalculationCard
  );
begin

  FFuelCharacteristicsCalculationCardRepository.
    UpdateFuelCharacteristicsCalculationCard(
      FuelCharacteristicsCalculationCard
    );

end;

procedure TBasedOnRepositoryFuelCharacteristicsCalculationCardDirectory.
  InternalPutFuelCharacteristicsCalculationCard(
    FuelCharacteristicsCalculationCard: TFuelCharacteristicsCalculationCard
  );
begin

  FFuelCharacteristicsCalculationCardRepository.
    AddFuelCharacteristicsCalculationCard(
      FuelCharacteristicsCalculationCard
    );

end;

procedure TBasedOnRepositoryFuelCharacteristicsCalculationCardDirectory.
  InternalRemoveFuelCharacteristicsCalculationCard(
    FuelCharacteristicsCalculationCard: TFuelCharacteristicsCalculationCard
  );
begin

  FFuelCharacteristicsCalculationCardRepository.
    RemoveFuelCharacteristicsCalculationCard(
      FuelCharacteristicsCalculationCard
    );

end;

end.
