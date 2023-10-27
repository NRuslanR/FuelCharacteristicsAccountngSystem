unit EmployeeReservoirKindWorkingRuleRegistry;

interface

uses

  EmployeeReservoirKindWorkingRules;

type

  IEmployeeReservoirKindWorkingRuleRegistry = interface

    procedure RegisterEmployeeReservoirKindWorkingRules(
      EmployeeReservoirKindWorkingRules: TEmployeeReservoirKindWorkingRules
    );

    function GetEmployeeReservoirKindWorkingRules:
      TEmployeeReservoirKindWorkingRules;

    procedure RegisterStandardEmployeeReservoirKindWorkingRules;

  end;
  
implementation

end.
