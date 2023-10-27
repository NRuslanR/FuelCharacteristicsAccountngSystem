unit FuelCharacteristicsCalculationCardOwningRule;

interface

uses

  Employee,
  unIFuelCharacteristicsCalculationCard,
  EmployeeFuelCharacteristicsCalculationCardWorkingRule;

type

  IFuelCharacteristicsCalculationCardOwningRule =
    interface (IEmployeeFuelCharacteristicsCalculationCardWorkingRule)

      procedure EnsureEmployeeIsFuelCharacteristicsCalculationCardOwner(
        Employee: TEmployee;
        FuelCharacteristicsCalculationCard: IFuelCharacteristicsCalculationCard
      );

      function IsEmployeeFuelCharacteristicsCalculationCardOwner(
        Employee: TEmployee;
        FuelCharacteristicsCalculationCard: IFuelCharacteristicsCalculationCard
      ): Boolean;
      
    end;

implementation

end.
