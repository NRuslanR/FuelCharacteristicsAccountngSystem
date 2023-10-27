unit ReservoirKindViewingRule;

interface

uses

  EmployeeReservoirKindWorkingRule,
  Employee,
  unIReservoirKind;

type

  IReservoirKindViewingRule = interface (IEmployeeReservoirKindWorkingRule)

    procedure EnsureEmployeeMayViewReservoirKind(
      Employee: TEmployee;
      ReservoirKind: IReservoirKind
    );

    function MayEmployeeViewReservoirKind(
      Employee: TEmployee;
      ReservoirKind: IReservoirKind
    ): Boolean;
    
  end;

implementation

end.
