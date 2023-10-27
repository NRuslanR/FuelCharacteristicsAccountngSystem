unit ReservoirKindRemovingRule;

interface

uses

  EmployeeReservoirKindWorkingRule,
  Employee,
  unIReservoirKind;

type

  IReservoirKindRemovingRule = interface (IEmployeeReservoirKindWorkingRule)

    procedure EnsureEmployeeMayRemoveReservoirKind(
      Employee: TEmployee;
      ReservoirKind: IReservoirKind
    );

    function MayEmployeeRemoveReservoirKind(
      Employee: TEmployee;
      ReservoirKind: IReservoirKind
    ): Boolean;
    
  end;

implementation

end.

