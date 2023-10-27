unit StandardReservoirKindRemovingRule;

interface

uses

  EmployeeReservoirKindWorkingRule,
  AbstractEmployeeReservoirKindWorkingRule,
  ReservoirKindRemovingRule,
  Employee,
  unIReservoirKind,
  SysUtils,
  Classes;

type

  TStandardReservoirKindRemovingRule =
    class (TAbstractEmployeeReservoirKindWorkingRule, IReservoirKindRemovingRule)

      public

        procedure EnsureSatisfiedBy(
          Employee: TEmployee;
          ReservoirKind: IReservoirKind
        ); override;
        
      public

        procedure EnsureEmployeeMayRemoveReservoirKind(
          Employee: TEmployee;
          ReservoirKind: IReservoirKind
        ); virtual;

        function MayEmployeeRemoveReservoirKind(
          Employee: TEmployee;
          ReservoirKind: IReservoirKind
        ): Boolean; virtual;
        
    end;

  
implementation

{ TStandardReservoirKindRemovingRule }

procedure TStandardReservoirKindRemovingRule.EnsureEmployeeMayRemoveReservoirKind(
  Employee: TEmployee; ReservoirKind: IReservoirKind);
begin

  EnsureSatisfiedBy(Employee, ReservoirKind);
  
end;

procedure TStandardReservoirKindRemovingRule.EnsureSatisfiedBy(
  Employee: TEmployee; ReservoirKind: IReservoirKind);
begin

  if not Employee.IsWarehouseHead then begin

    raise TEmployeeReservoirKindWorkingRuleException.CreateFmt(
      'У сотрудника "%s" отсутствуют права ' +
      'на удаление информации о типе резервуаров "%s"',
      [
        Employee.FullName,
        ReservoirKind.Name
      ]
    );
    
  end;

end;

function TStandardReservoirKindRemovingRule.MayEmployeeRemoveReservoirKind(
  Employee: TEmployee; ReservoirKind: IReservoirKind): Boolean;
begin

  Result := IsSatisfiedBy(Employee, ReservoirKind);
  
end;

end.

