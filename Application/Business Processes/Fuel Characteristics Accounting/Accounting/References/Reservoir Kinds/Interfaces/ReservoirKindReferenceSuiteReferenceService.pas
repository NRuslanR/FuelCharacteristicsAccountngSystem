unit ReservoirKindReferenceSuiteReferenceService;

interface

uses

  ReservoirKindReferenceSuiteSetHolder,
  ApplicationService;

type

  TReservoirKindReferenceSuiteReferenceServiceException =
    class (TApplicationServiceException)

    end;

  IReservoirKindReferenceSuiteReferenceService =
    interface (IApplicationService)

      function HasEmployeeAccessRightsForReservoirKindReferenceSuites(
        const EmployeeId: Variant
      ): Boolean;

      function GetAllReservoirKindReferenceSuiteSetForEmployee(
        const EmployeeId: Variant
      ): TReservoirKindReferenceSuiteSetHolder;

      

    end;
  

implementation

end.
