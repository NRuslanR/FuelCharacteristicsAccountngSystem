unit StandardReservoirKindReferenceSuiteViewingRule;

interface

uses

  AbstractEmployeeReservoirKindReferenceSuiteWorkingRule,
  ReservoirKindReferenceSuiteViewingRule,
  EmployeeReservoirKindReferenceSuiteWorkingRule,
  Employee,
  unIReservoirKindReferenceSuite,
  SysUtils,
  Classes;

type

  TStandardReservoirKindReferenceSuiteViewingRule =
    class (
      TAbstractEmployeeReservoirKindReferenceSuiteWorkingRule,
      IReservoirKindReferenceSuiteViewingRule
    )

      public

        procedure EnsureSatisfiedBy(
          Employee: TEmployee;
          ReservoirKindReferenceSuite: IReservoirKindReferenceSuite
        ); override;
        
      public

        procedure EnsureEmployeeMayViewReservoirKindReferenceSuite(
          Employee: TEmployee;
          ReservoirKindReferenceSuite: IReservoirKindReferenceSuite
        ); virtual;

        function MayEmployeeViewReservoirKindReferenceSuite(
          Employee: TEmployee;
          ReservoirKindReferenceSuite: IReservoirKindReferenceSuite
        ): Boolean; virtual;

    end;


implementation

{ TStandardReservoirKindReferenceSuiteViewingRule }

procedure TStandardReservoirKindReferenceSuiteViewingRule.
  EnsureEmployeeMayViewReservoirKindReferenceSuite(
    Employee: TEmployee;
    ReservoirKindReferenceSuite: IReservoirKindReferenceSuite
  );
begin

  EnsureSatisfiedBy(Employee, ReservoirKindReferenceSuite);
  
end;

procedure TStandardReservoirKindReferenceSuiteViewingRule.
  EnsureSatisfiedBy(
    Employee: TEmployee;
    ReservoirKindReferenceSuite: IReservoirKindReferenceSuite
  );
begin

  if not Employee.IsWarehouseHead then begin

    raise TEmployeeReservoirKindReferenceSuiteWorkingRuleException.CreateFmt(
      '” сотрудника "%s" отсутствуют права ' +
      'на просмотр справочных данных дл€ ' +
      'типа резервуаров "%s"',
      [
        Employee.FullName,
        ReservoirKindReferenceSuite.ReservoirKindName
      ]
    );
    
  end;

end;

function TStandardReservoirKindReferenceSuiteViewingRule.
  MayEmployeeViewReservoirKindReferenceSuite(
    Employee: TEmployee;
    ReservoirKindReferenceSuite: IReservoirKindReferenceSuite
  ): Boolean;
begin

  Result := IsSatisfiedBy(Employee, ReservoirKindReferenceSuite);

end;

end.
