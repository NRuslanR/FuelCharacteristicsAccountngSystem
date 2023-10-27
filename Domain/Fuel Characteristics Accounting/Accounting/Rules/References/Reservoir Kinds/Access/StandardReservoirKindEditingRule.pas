unit StandardReservoirKindEditingRule;

interface

uses

  EmployeeReservoirKindWorkingRule,
  AbstractEmployeeReservoirKindWorkingRule,
  ReservoirKindEditingRule,
  Employee,
  unIReservoirKind,
  SysUtils,
  Classes;

type

  TStandardReservoirKindEditingRule =
    class (TAbstractEmployeeReservoirKindWorkingRule, IReservoirKindEditingRule)

      public

        procedure EnsureSatisfiedBy(
          Employee: TEmployee;
          ReservoirKind: IReservoirKind
        ); override;
        
      public

        procedure EnsureEmployeeMayEditReservoirKind(
          Employee: TEmployee;
          ReservoirKind: IReservoirKind
        ); virtual;

        function MayEmployeeEditReservoirKind(
          Employee: TEmployee;
          ReservoirKind: IReservoirKind
        ): Boolean; virtual;
        
    end;

  
implementation

uses

  StrUtils;

{ TStandardReservoirKindEditingRule }

procedure TStandardReservoirKindEditingRule.EnsureEmployeeMayEditReservoirKind(
  Employee: TEmployee; ReservoirKind: IReservoirKind);
begin

  EnsureSatisfiedBy(Employee, ReservoirKind);
  
end;

procedure TStandardReservoirKindEditingRule.EnsureSatisfiedBy(
  Employee: TEmployee; ReservoirKind: IReservoirKind);
begin

  if not Employee.IsWarehouseHead then begin

    raise TEmployeeReservoirKindWorkingRuleException.CreateFmt(
      'У сотрудника "%s" отсутствуют права ' +
      'на редактирование информации о типе резервуаров%s',
      [
        Employee.FullName,
        IfThen(
          Trim(ReservoirKind.Name) <> '',
          ' "' + ReservoirKind.Name + '"'
        )
      ]
    );
    
  end;

end;

function TStandardReservoirKindEditingRule.MayEmployeeEditReservoirKind(
  Employee: TEmployee; ReservoirKind: IReservoirKind): Boolean;
begin

  Result := IsSatisfiedBy(Employee, ReservoirKind);
  
end;

end.

