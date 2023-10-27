unit EmployeeReservoirKindWorkingRule;

interface

uses

  DomainException,
  Employee,
  unIReservoirKind;

type

  TEmployeeReservoirKindWorkingRuleException = class (TDomainException)

  end;
  
  IEmployeeReservoirKindWorkingRule = interface

    procedure EnsureSatisfiedBy(
      Employee: TEmployee;
      ReservoirKind: IReservoirKind
    );

    function IsSatisfiedBy(
      Employee: TEmployee;
      ReservoirKind: IReservoirKind
    ): Boolean;
    
  end;
  
implementation

end.
