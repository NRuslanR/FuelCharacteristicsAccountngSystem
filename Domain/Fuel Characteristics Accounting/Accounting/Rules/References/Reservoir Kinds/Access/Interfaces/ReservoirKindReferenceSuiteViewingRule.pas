unit ReservoirKindReferenceSuiteViewingRule;

interface

uses

  unIReservoirKindReferenceSuite,
  EmployeeReservoirKindReferenceSuiteWorkingRule,
  Employee;

type

  IReservoirKindReferenceSuiteViewingRule =
    interface (IEmployeeReservoirKindReferenceSuiteWorkingRule)

      procedure EnsureEmployeeMayViewReservoirKindReferenceSuite(
        Employee: TEmployee;
        ReservoirKindReferenceSuite: IReservoirKindReferenceSuite
      );

      function MayEmployeeViewReservoirKindReferenceSuite(
        Employee: TEmployee;
        ReservoirKindReferenceSuite: IReservoirKindReferenceSuite
      ): Boolean;
      
    end;
  
implementation

end.
