unit ReservoirKindEditingRule;

interface

uses

  EmployeeReservoirKindWorkingRule,
  Employee,
  unIReservoirKind;

type

  IReservoirKindEditingRule = interface (IEmployeeReservoirKindWorkingRule)

    procedure EnsureEmployeeMayEditReservoirKind(
      Employee: TEmployee;
      ReservoirKind: IReservoirKind
    );

    function MayEmployeeEditReservoirKind(
      Employee: TEmployee;
      ReservoirKind: IReservoirKind
    ): Boolean;
    
  end;

implementation

end.

