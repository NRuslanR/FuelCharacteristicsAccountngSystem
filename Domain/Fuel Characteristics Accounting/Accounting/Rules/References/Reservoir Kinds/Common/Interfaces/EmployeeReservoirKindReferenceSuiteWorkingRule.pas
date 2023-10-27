unit EmployeeReservoirKindReferenceSuiteWorkingRule;

interface

uses

  DomainException,
  Employee,
  unIReservoirKindReferenceSuite;

type

  TEmployeeReservoirKindReferenceSuiteWorkingRuleException =
    class (TDomainException)

    end;
    
  IEmployeeReservoirKindReferenceSuiteWorkingRule = interface

    procedure EnsureSatisfiedBy(
      Employee: TEmployee;
      ReservoirKindReferenceSuite: IReservoirKindReferenceSuite
    );

    function IsSatisfiedBy(
      Employee: TEmployee;
      ReservoirKindReferenceSuite: IReservoirKindReferenceSuite
    ): Boolean;
    
  end;

implementation

end.
