unit FuelCharacteristicsCalculationCardAccountingService;

interface

uses

  DomainException,
  DomainService,
  unIFuelCharacteristicsCalculationCard,
  FuelCharacteristicsCalculationCardAccessRights,
  Employee;

type

  TFuelCharacteristicsCalculationCardAccountingServiceException =
    class (TDomainException)

    end;
    
  IFuelCharacteristicsCalculationCardAccountingService =
    interface (IDomainService)

      function TakeFuelCharacteristicsCalculationCardAccessRights(
        RequestingEmployee: TEmployee;
        CardIdentity: Variant
      ): TFuelCharacteristicsCalculationCardAccessRights;
      
      procedure TakeNewFuelCharacteristicsCalculationCardAndAccessRights(
        RequestingEmployee: TEmployee;
        var Card: IFuelCharacteristicsCalculationCard;
        var CardAccessRights: TFuelCharacteristicsCalculationCardAccessRights
      );
      
      procedure TakeFuelCharacteristicsCalculationCardAndAccessRights(
        RequestingEmployee: TEmployee;
        CardIdentity: Variant;
        var Card: IFuelCharacteristicsCalculationCard;
        var CardAccessRights: TFuelCharacteristicsCalculationCardAccessRights
      );

      procedure PerformNewFuelCharacteristicsCalculationCardAccounting(
        FuelCharacteristicsCalculationCard: IFuelCharacteristicsCalculationCard;
        RequestingEmployee: TEmployee
      );

      procedure PerformExistingFuelCharacteristicsCalculationCardAccounting(
        FuelCharacteristicsCalculationCard: IFuelCharacteristicsCalculationCard;
        RequestingEmployee: TEmployee
      );

      procedure RemoveFuelCharacteristicsCalculationCard(
        RequestingEmployee: TEmployee;
        CardIdentity: Variant
      );
    
    end;

implementation

end.
