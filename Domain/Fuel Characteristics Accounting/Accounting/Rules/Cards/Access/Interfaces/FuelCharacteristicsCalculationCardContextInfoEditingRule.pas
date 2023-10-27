unit FuelCharacteristicsCalculationCardContextInfoEditingRule;

interface

uses

  EmployeeFuelCharacteristicsCalculationCardWorkingRule,
  Employee,
  unIFuelCharacteristicsCalculationCard;

type

  IFuelCharacteristicsCalculationCardContextInfoEditingRule =
    interface (IEmployeeFuelCharacteristicsCalculationCardWorkingRule)

      procedure EnsureEmployeeMayEditFuelCharacteristicsCalculationCardContextInfo(
        Employee: TEmployee;
        FuelCharacteristicsCalculationCard: IFuelCharacteristicsCalculationCard
      );

      function MayEmployeeEditFuelCharacteristicsCalculationCardContextInfo(
        Employee: TEmployee;
        FuelCharacteristicsCalculationCard: IFuelCharacteristicsCalculationCard
      ): Boolean;
      
    end;

implementation

end.
