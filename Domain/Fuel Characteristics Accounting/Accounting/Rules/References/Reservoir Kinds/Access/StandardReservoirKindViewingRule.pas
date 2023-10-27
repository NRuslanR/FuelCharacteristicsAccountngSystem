unit StandardReservoirKindViewingRule;

interface

uses

  EmployeeReservoirKindWorkingRule,
  AbstractEmployeeReservoirKindWorkingRule,
  ReservoirKindViewingRule,
  Employee,
  unIReservoirKind,
  SysUtils,
  Classes;

type

  TStandardReservoirKindViewingRule =
    class (TAbstractEmployeeReservoirKindWorkingRule, IReservoirKindViewingRule)

      public

        procedure EnsureSatisfiedBy(
          Employee: TEmployee;
          ReservoirKind: IReservoirKind
        ); override;
        
      public

        procedure EnsureEmployeeMayViewReservoirKind(
          Employee: TEmployee;
          ReservoirKind: IReservoirKind
        ); virtual;

        function MayEmployeeViewReservoirKind(
          Employee: TEmployee;
          ReservoirKind: IReservoirKind
        ): Boolean; virtual;
        
    end;

  
implementation

{ TStandardReservoirKindViewingRule }

procedure TStandardReservoirKindViewingRule.EnsureEmployeeMayViewReservoirKind(
  Employee: TEmployee; ReservoirKind: IReservoirKind);
begin

  EnsureSatisfiedBy(Employee, ReservoirKind);
  
end;

procedure TStandardReservoirKindViewingRule.EnsureSatisfiedBy(
  Employee: TEmployee; ReservoirKind: IReservoirKind);
begin

  if not Employee.IsWarehouseHead then begin

    raise TEmployeeReservoirKindWorkingRuleException.CreateFmt(
      'У сотрудника "%s" отсутствуют права ' +
      'на просмотр информации о типе резервуаров "%s"',
      [
        Employee.FullName,
        ReservoirKind.Name
      ]
    );
    
  end;

end;

function TStandardReservoirKindViewingRule.MayEmployeeViewReservoirKind(
  Employee: TEmployee; ReservoirKind: IReservoirKind): Boolean;
begin

  Result := IsSatisfiedBy(Employee, ReservoirKind);
  
end;

end.
