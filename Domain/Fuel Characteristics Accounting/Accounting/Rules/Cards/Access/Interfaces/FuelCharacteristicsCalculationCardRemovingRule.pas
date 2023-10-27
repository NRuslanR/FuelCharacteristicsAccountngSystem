unit FuelCharacteristicsCalculationCardRemovingRule;

interface

uses

  EmployeeFuelCharacteristicsCalculationCardWorkingRule,
  Employee,
  unIFuelCharacteristicsCalculationCard;

type

  IFuelCharacteristicsCalculationCardRemovingRule =
    interface (IEmployeeFuelCharacteristicsCalculationCardWorkingRule)

      procedure EnsureEmployeeMayRemoveFuelCharacteristicsCalculationCard(
        Employee: TEmployee;
        FuelCharacteristicsCalculationCard: IFuelCharacteristicsCalculationCard
      );

      function MayEmployeeRemoveFuelCharacteristicsCalculationCard(
        Employee: TEmployee;
        FuelCharacteristicsCalculationCard: IFuelCharacteristicsCalculationCard
      ): Boolean;
      
    end;
  
implementation

end.
