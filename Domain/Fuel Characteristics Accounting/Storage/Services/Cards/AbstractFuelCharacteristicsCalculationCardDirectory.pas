unit AbstractFuelCharacteristicsCalculationCardDirectory;

interface

uses

  AbstractDomainService,
  FuelCharacteristicsCalculationCardDirectory,
  FuelCharacteristicsCalculationCard,
  SysUtils,
  Classes;

type

  TAbstractFuelCharacteristicsCalculationCardDirectory =
    class abstract (
      TAbstractDomainService,
      IFuelCharacteristicsCalculationCardDirectory
    )

      protected

        function InternalFindFuelCharacteristicsCalculationCard(
          const CardIdentity: Variant
        ): TFuelCharacteristicsCalculationCard; virtual; abstract;

        procedure InternalPutFuelCharacteristicsCalculationCard(
          FuelCharacteristicsCalculationCard: TFuelCharacteristicsCalculationCard
        ); virtual; abstract;

        procedure InternalModifyFuelCharacteristicsCalculationCard(
          FuelCharacteristicsCalculationCard: TFuelCharacteristicsCalculationCard
        ); virtual; abstract;

        procedure InternalRemoveFuelCharacteristicsCalculationCard(
          FuelCharacteristicsCalculationCard: TFuelCharacteristicsCalculationCard
        ); virtual; abstract;

      public

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

uses

  StandardEmployeeFuelCharacteristicsCalculationCardWorkingRuleRegistry;
  
{ TAbstractFuelCharacteristicsCalculationCardDirectory }

function TAbstractFuelCharacteristicsCalculationCardDirectory.
  FindFuelCharacteristicsCalculationCard(
    const CardIdentity: Variant
  ): TFuelCharacteristicsCalculationCard;
begin

  Result := InternalFindFuelCharacteristicsCalculationCard(CardIdentity);

  if not Assigned(Result) then begin

    raise
    TFuelCharacteristicsCalculationCardDirectoryException.Create(
      'Затребованная карточка расчёта ' +
      'показателей топлива не найдена'
    );

  end;

  Result.WorkingRules :=
    TEmployeeFuelCharacteristicsCalculationCardWorkingRuleRegistry
      .Current
      .GetEmployeeFuelCharacteristicsCalculationCardWorkingRules;
  
end;

procedure TAbstractFuelCharacteristicsCalculationCardDirectory.
  ModifyFuelCharacteristicsCalculationCard(
    FuelCharacteristicsCalculationCard: TFuelCharacteristicsCalculationCard
  );
begin

  InternalModifyFuelCharacteristicsCalculationCard(
    FuelCharacteristicsCalculationCard
  );

end;

procedure TAbstractFuelCharacteristicsCalculationCardDirectory.
  PutFuelCharacteristicsCalculationCard(
    FuelCharacteristicsCalculationCard: TFuelCharacteristicsCalculationCard
  );
begin

  InternalPutFuelCharacteristicsCalculationCard(
    FuelCharacteristicsCalculationCard
  );

end;

procedure TAbstractFuelCharacteristicsCalculationCardDirectory.
  RemoveFuelCharacteristicsCalculationCard(
    FuelCharacteristicsCalculationCard: TFuelCharacteristicsCalculationCard
  );
begin

  InternalRemoveFuelCharacteristicsCalculationCard(
    FuelCharacteristicsCalculationCard
  );

end;

end.
