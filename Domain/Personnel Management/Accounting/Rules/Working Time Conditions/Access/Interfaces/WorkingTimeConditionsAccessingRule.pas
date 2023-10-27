unit WorkingTimeConditionsAccessingRule;

interface

uses

  unIWorkingTimeConditions,
  Employee,
  EmployeeDomainObjectRule;

type

  TWorkingTimeConditionsAccessingRuleException =
    class (TEmployeeDomainObjectRuleException)

    end;
    
  IWorkingTimeConditionsAccessingRule = interface (IEmployeeDomainObjectRule)

    procedure EnsureWorkingTimeConditionsMayBeAccessedByEmployee(
      WorkingTimeConditions: IWorkingTimeConditions;
      Employee: TEmployee
    );

    function MayWorkingTimeConditionsBeAccessedByEmployee(
      WorkingTimeConditions: IWorkingTimeConditions;
      Employee: TEmployee
    ): Boolean;

  end;

implementation

end.
