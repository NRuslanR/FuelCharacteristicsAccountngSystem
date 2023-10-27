unit StandardReservoirKindReferenceSuiteEditingRule;

interface

uses

  AbstractEmployeeReservoirKindReferenceSuiteWorkingRule,
  ReservoirKindReferenceSuiteEditingRule,
  EmployeeReservoirKindReferenceSuiteWorkingRule,
  Employee,
  unIReservoirKindReferenceSuite,
  SysUtils,
  Classes;

type

  TStandardReservoirKindReferenceSuiteEditingRule =
    class (
      TAbstractEmployeeReservoirKindReferenceSuiteWorkingRule,
      IReservoirKindReferenceSuiteEditingRule
    )

      public

        procedure EnsureSatisfiedBy(
          Employee: TEmployee;
          ReservoirKindReferenceSuite: IReservoirKindReferenceSuite
        ); override;

      public

        procedure EnsureEmployeeMayEditReservoirKindReferenceSuite(
          Employee: TEmployee;
          ReservoirKindReferenceSuite: IReservoirKindReferenceSuite
        ); virtual;

        function MayEmployeeEditReservoirKindReferenceSuite(
          Employee: TEmployee;
          ReservoirKindReferenceSuite: IReservoirKindReferenceSuite
        ): Boolean; virtual;

    end;

implementation

uses

  StrUtils;

{ TStandardReservoirKindReferenceSuiteEditingRule }

procedure TStandardReservoirKindReferenceSuiteEditingRule.
  EnsureEmployeeMayEditReservoirKindReferenceSuite(
    Employee: TEmployee;
    ReservoirKindReferenceSuite: IReservoirKindReferenceSuite
  );
begin

  EnsureSatisfiedBy(Employee, ReservoirKindReferenceSuite);

end;

procedure TStandardReservoirKindReferenceSuiteEditingRule.EnsureSatisfiedBy(
  Employee: TEmployee;
  ReservoirKindReferenceSuite: IReservoirKindReferenceSuite
);
begin

  if not Employee.IsWarehouseHead then begin

    raise TEmployeeReservoirKindReferenceSuiteWorkingRuleException.CreateFmt(
      '” сотрудника "%s" отсутствуют права ' +
      'на редактирование справочных данных ' +
      'дл€ типа резервуаров%s',
      [
        Employee.FullName,
        IfThen(
          Trim(ReservoirKindReferenceSuite.ReservoirKindName) <> '',
          ' "' + ReservoirKindReferenceSuite.ReservoirKindName + '"'
        )
      ]
    );
    
  end;

end;

function TStandardReservoirKindReferenceSuiteEditingRule.
  MayEmployeeEditReservoirKindReferenceSuite(
    Employee: TEmployee;
    ReservoirKindReferenceSuite: IReservoirKindReferenceSuite
  ): Boolean;
begin

  Result := IsSatisfiedBy(Employee, ReservoirKindReferenceSuite);
  
end;

end.
