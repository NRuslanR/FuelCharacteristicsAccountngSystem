unit StandardWorkingTimeConditionsAccessingRule;

interface

uses

  StandardEmployeeDomainObjectRule,
  WorkingTimeConditionsAccessingRule,
  unIWorkingTimeConditions,
  Employee,
  DomainObjectUnit,
  SysUtils;

type

  TStandardWorkingTimeConditionsAccessingRule =
    class (TStandardEmployeeDomainObjectRule, IWorkingTimeConditionsAccessingRule)

      public

        procedure EnsureSatisfiedBy(
          DomainObject: TDomainObject; Employee: TEmployee
        ); override;

      public

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

{ TStandardWorkingTimeConditionsAccessingRule }

procedure TStandardWorkingTimeConditionsAccessingRule.EnsureSatisfiedBy(
  DomainObject: TDomainObject;
  Employee: TEmployee
);
begin

  if not Employee.IsWarehouseHead then begin

    raise TWorkingTimeConditionsAccessingRuleException.CreateFmt(
      '” сотрудника "%s" отсутствует доступ к ' +
      'информации о режиме рабочего времени',
      [Employee.FullName]
    );

  end;

end;

procedure TStandardWorkingTimeConditionsAccessingRule.
  EnsureWorkingTimeConditionsMayBeAccessedByEmployee(
    WorkingTimeConditions: IWorkingTimeConditions;
    Employee: TEmployee
  );
begin

  EnsureSatisfiedBy(
    TDomainObject(WorkingTimeConditions.Self),
    Employee
  );

end;

function TStandardWorkingTimeConditionsAccessingRule.
  MayWorkingTimeConditionsBeAccessedByEmployee(
    WorkingTimeConditions: IWorkingTimeConditions;
    Employee: TEmployee
  ): Boolean;
begin

  Result := IsSatisfiedBy(TDomainObject(WorkingTimeConditions.Self), Employee);
  
end;

end.
