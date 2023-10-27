unit EmployeeFuelCharacteristicsCalculationCardWorkingRuleRegistry;

interface

uses

  EmployeeFuelCharacteristicsCalculationCardWorkingRules;

type

  IEmployeeFuelCharacteristicsCalculationCardWorkingRuleRegistry =
    interface

      procedure RegisterEmployeeFuelCharacteristicsCalculationCardWorkingRules(
        EmployeeFuelCharacteristicsCalculationCardWorkingRules:
          TEmployeeFuelCharacteristicsCalculationCardWorkingRules
      );

      procedure RegisterStandardEmployeeFuelCharacteristicsCalculationCardWorkingRules;

      function GetEmployeeFuelCharacteristicsCalculationCardWorkingRules:
        TEmployeeFuelCharacteristicsCalculationCardWorkingRules;

    end;

implementation

end.
