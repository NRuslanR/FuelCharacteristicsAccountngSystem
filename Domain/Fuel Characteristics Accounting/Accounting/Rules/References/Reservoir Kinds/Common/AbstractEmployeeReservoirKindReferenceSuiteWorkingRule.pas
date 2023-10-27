unit AbstractEmployeeReservoirKindReferenceSuiteWorkingRule;

interface

uses

  Employee,
  unIReservoirKindReferenceSuite,
  EmployeeReservoirKindReferenceSuiteWorkingRule;

type

  TAbstractEmployeeReservoirKindReferenceSuiteWorkingRule =
    class abstract (
      TInterfacedObject,
      IEmployeeReservoirKindReferenceSuiteWorkingRule
    )

      public

        procedure EnsureSatisfiedBy(
          Employee: TEmployee;
          ReservoirKindReferenceSuite: IReservoirKindReferenceSuite
        ); virtual; abstract;

        function IsSatisfiedBy(
          Employee: TEmployee;
          ReservoirKindReferenceSuite: IReservoirKindReferenceSuite
        ): Boolean; virtual;

    end;
  
implementation

{ TAbstractEmployeeReservoirKindReferenceSuiteWorkingRule }

function TAbstractEmployeeReservoirKindReferenceSuiteWorkingRule.IsSatisfiedBy(
  Employee: TEmployee;
  ReservoirKindReferenceSuite: IReservoirKindReferenceSuite
): Boolean;
begin

  try

    EnsureSatisfiedBy(Employee, ReservoirKindReferenceSuite);

    Result := True;

  except

    on e: TEmployeeReservoirKindReferenceSuiteWorkingRuleException
    do Result := False;

  end;

end;

end.
