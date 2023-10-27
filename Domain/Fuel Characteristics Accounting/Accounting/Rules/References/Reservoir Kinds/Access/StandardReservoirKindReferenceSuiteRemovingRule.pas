unit StandardReservoirKindReferenceSuiteRemovingRule;

interface

uses

  AbstractEmployeeReservoirKindReferenceSuiteWorkingRule,
  ReservoirKindReferenceSuiteRemovingRule,
  EmployeeReservoirKindReferenceSuiteWorkingRule,
  Employee,
  unIReservoirKindReferenceSuite,
  SysUtils,
  Classes;

type

  TStandardReservoirKindReferenceSuiteRemovingRule =
    class (
      TAbstractEmployeeReservoirKindReferenceSuiteWorkingRule,
      IReservoirKindReferenceSuiteRemovingRule
    )

      public

        procedure EnsureSatisfiedBy(
          Employee: TEmployee;
          ReservoirKindReferenceSuite: IReservoirKindReferenceSuite
        ); override;
        
      public

        procedure EnsureEmployeeMayRemoveReservoirKindReferenceSuite(
          Employee: TEmployee;
          ReservoirKindReferenceSuite: IReservoirKindReferenceSuite
        ); virtual;

        function MayEmployeeRemoveReservoirKindReferenceSuite(
          Employee: TEmployee;
          ReservoirKindReferenceSuite: IReservoirKindReferenceSuite
        ): Boolean; virtual;

    end;
  

implementation

{ TStandardReservoirKindReferenceSuiteRemovingRule }

procedure TStandardReservoirKindReferenceSuiteRemovingRule.
  EnsureEmployeeMayRemoveReservoirKindReferenceSuite(
    Employee: TEmployee;
    ReservoirKindReferenceSuite: IReservoirKindReferenceSuite
  );
begin

  EnsureSatisfiedBy(Employee, ReservoirKindReferenceSuite);

end;

procedure TStandardReservoirKindReferenceSuiteRemovingRule.EnsureSatisfiedBy(
  Employee: TEmployee;
  ReservoirKindReferenceSuite: IReservoirKindReferenceSuite);
begin

  if not Employee.IsWarehouseHead then begin

    raise TEmployeeReservoirKindReferenceSuiteWorkingRuleException.CreateFmt(
      '” сотрудника "%s" отсутствуют права ' +
      'на удаление справочных данных ' +
      'дл€ типа резервуаров "%s"',
      [
        Employee.FullName,
        ReservoirKindReferenceSuite.ReservoirKindName
      ]
    );
    
  end;

end;

function TStandardReservoirKindReferenceSuiteRemovingRule.
  MayEmployeeRemoveReservoirKindReferenceSuite(
    Employee: TEmployee;
    ReservoirKindReferenceSuite: IReservoirKindReferenceSuite
  ): Boolean;
begin

  Result := IsSatisfiedBy(Employee, ReservoirKindReferenceSuite);
  
end;

end.
