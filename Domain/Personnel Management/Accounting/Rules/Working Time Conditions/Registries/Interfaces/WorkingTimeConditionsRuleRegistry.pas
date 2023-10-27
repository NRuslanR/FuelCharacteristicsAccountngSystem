unit WorkingTimeConditionsRuleRegistry;

interface

uses

  WorkingTimeConditionsRules,
  SysUtils;

type

  IWorkingTimeConditionsRuleRegistry = interface

    procedure RegisterWorkingTimeConditionsRules(
      WorkingTimeConditionsRules: TWorkingTimeConditionsRules
    );

    function GetWorkingTimeConditionsRules:
      TWorkingTimeConditionsRules;

    procedure RegisterStandardWorkingTimeConditionsRules;

  end;

implementation

end.
