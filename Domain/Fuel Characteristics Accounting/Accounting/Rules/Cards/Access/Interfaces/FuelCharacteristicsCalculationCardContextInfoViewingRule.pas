unit FuelCharacteristicsCalculationCardContextInfoViewingRule;

interface

uses

  EmployeeFuelCharacteristicsCalculationCardWorkingRule,
  Employee,
  unIFuelCharacteristicsCalculationCard;

type

  IFuelCharacteristicsCalculationCardContextInfoViewingRule =
    interface (IEmployeeFuelCharacteristicsCalculationCardWorkingRule)

      procedure EnsureEmployeeMayViewFuelCharacteristicsCalculationCardContextInfo(
        Employee: TEmployee;
        FuelCharacteristicsCalculationCard: IFuelCharacteristicsCalculationCard
      );

      function MayEmployeeViewFuelCharacteristicsCalculationCardContextInfo(
        Employee: TEmployee;
        FuelCharacteristicsCalculationCard: IFuelCharacteristicsCalculationCard
      ): Boolean;
      
    end;


implementation

end.
