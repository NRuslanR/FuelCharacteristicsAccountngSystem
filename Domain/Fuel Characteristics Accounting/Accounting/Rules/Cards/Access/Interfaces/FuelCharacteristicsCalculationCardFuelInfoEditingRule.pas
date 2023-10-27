unit FuelCharacteristicsCalculationCardFuelInfoEditingRule;

interface

uses

  EmployeeFuelCharacteristicsCalculationCardWorkingRule,
  Employee,
  unIFuelCharacteristicsCalculationCard;

type

  IFuelCharacteristicsCalculationCardFuelInfoEditingRule =
    interface (IEmployeeFuelCharacteristicsCalculationCardWorkingRule)

      procedure EnsureEmployeeMayEditFuelCharacteristicsCalculationCardFuelInfo(
        Employee: TEmployee;
        FuelCharacteristicsCalculationCard: IFuelCharacteristicsCalculationCard
      );

      function MayEmployeeEditFuelCharacteristicsCalculationCardFuelInfo(
        Employee: TEmployee;
        FuelCharacteristicsCalculationCard: IFuelCharacteristicsCalculationCard
      ): Boolean;

    end;

implementation

end.
