unit ReservoirKindReferenceSuiteRemovingRule;

interface

uses

  EmployeeReservoirKindReferenceSuiteWorkingRule,
  Employee,
  unIReservoirKindReferenceSuite;

type

  IReservoirKindReferenceSuiteRemovingRule =
    interface (IEmployeeReservoirKindReferenceSuiteWorkingRule)

      procedure EnsureEmployeeMayRemoveReservoirKindReferenceSuite(
        Employee: TEmployee;
        ReservoirKindReferenceSuite: IReservoirKindReferenceSuite
      );

      function MayEmployeeRemoveReservoirKindReferenceSuite(
        Employee: TEmployee;
        ReservoirKindReferenceSuite: IReservoirKindReferenceSuite
      ): Boolean;
      
    end;
  
implementation

end.
