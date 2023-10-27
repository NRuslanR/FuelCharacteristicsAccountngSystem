unit FuelCharacteristicsCalculationAccessRule;

interface

uses

  Employee,
  DomainException;

type

  TFuelCharacteristicsCalculationAccessRuleException =
    class (TDomainException)

    end;

  IFuelCharacteristicsCalculationAccessRule = interface

    procedure EnsureEmployeeHasFuelCharacteristicsCalculationAccess(
      Employee: TEmployee
    );

    function HasEmployeeFuelCharacteristicsCalculationAccess(
      Employee: TEmployee
    ): Boolean;
    
  end;

implementation

end.
