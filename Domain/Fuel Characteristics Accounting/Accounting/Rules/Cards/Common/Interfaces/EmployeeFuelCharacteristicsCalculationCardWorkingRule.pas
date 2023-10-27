unit EmployeeFuelCharacteristicsCalculationCardWorkingRule;

interface

uses

  unIFuelCharacteristicsCalculationCard,
  DomainException,
  Employee;

type

  TEmployeeFuelCharacteristicsCalculationCardWorkingRuleException =
    class (TDomainException)

    end;
    
  IEmployeeFuelCharacteristicsCalculationCardWorkingRule = interface

    function IsSatisfiedBy(
      Employee: TEmployee;
      FuelCharacteristicsCalculationCard: IFuelCharacteristicsCalculationCard
    ): Boolean;

    procedure EnsureSatisfiedBy(
      Employee: TEmployee;
      FuelCharacteristicsCalculationCard: IFuelCharacteristicsCalculationCard
    );
    
  end;

implementation

end.
