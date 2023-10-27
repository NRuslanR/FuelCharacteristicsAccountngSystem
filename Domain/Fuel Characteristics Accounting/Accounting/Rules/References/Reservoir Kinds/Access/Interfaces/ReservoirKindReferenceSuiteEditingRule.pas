unit ReservoirKindReferenceSuiteEditingRule;

interface

uses

  Employee,
  unIReservoirKindReferenceSuite,
  EmployeeReservoirKindReferenceSuiteWorkingRule;

type

  IReservoirKindReferenceSuiteEditingRule =
    interface (IEmployeeReservoirKindReferenceSuiteWorkingRule)

      procedure EnsureEmployeeMayEditReservoirKindReferenceSuite(
        Employee: TEmployee;
        ReservoirKindReferenceSuite: IReservoirKindReferenceSuite
      );

      function MayEmployeeEditReservoirKindReferenceSuite(
        Employee: TEmployee;
        ReservoirKindReferenceSuite: IReservoirKindReferenceSuite
      ): Boolean;
      
    end;
    
implementation

end.
