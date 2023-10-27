unit EmployeeReservoirKindReferenceSuiteWorkingRuleRegistry;

interface

uses

  EmployeeReservoirKindReferenceSuiteWorkingRules;

type

  IEmployeeReservoirKindReferenceSuiteWorkingRuleRegistry = interface

    procedure RegisterEmployeeReservoirKindReferenceSuiteWorkingRules(
      EmployeeReservoirKindReferenceSuiteWorkingRules:
        TEmployeeReservoirKindReferenceSuiteWorkingRules
    );

    function GetEmployeeReservoirKindReferenceSuiteWorkingRules:
      TEmployeeReservoirKindReferenceSuiteWorkingRules;

    procedure RegisterStandardEmployeeReservoirKindReferenceSuiteWorkingRules;
    
  end;
  
implementation

end.
