unit FuelCharacteristicsCalculationCardFuelInfoViewingRule;

interface

uses

  EmployeeFuelCharacteristicsCalculationCardWorkingRule,
  Employee,
  unIFuelCharacteristicsCalculationCard;

type

  IFuelCharacteristicsCalculationCardFuelInfoViewingRule =
    interface (IEmployeeFuelCharacteristicsCalculationCardWorkingRule)

      procedure EnsureEmployeeMayViewFuelCharacteristicsCalculationCardFuelInfo(
        Employee: TEmployee;
        FuelCharacteristicsCalculationCard: IFuelCharacteristicsCalculationCard
      );

      function MayEmployeeViewFuelCharacteristicsCalculationCardFuelInfo(
        Employee: TEmployee;
        FuelCharacteristicsCalculationCard: IFuelCharacteristicsCalculationCard
      ): Boolean;

    end;
  

implementation

end.
