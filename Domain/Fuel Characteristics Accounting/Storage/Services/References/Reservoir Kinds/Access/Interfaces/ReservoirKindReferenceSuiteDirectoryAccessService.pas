unit ReservoirKindReferenceSuiteDirectoryAccessService;

interface

uses

  ReservoirKindReferenceSuiteDirectoryAccessRights,
  Employee,
  DomainException;

type

  TReservoirKindReferenceSuiteDirectoryAccessServiceException =
    class (TDomainException)

    end;
    
  IReservoirKindReferenceSuiteDirectoryAccessService = interface

    function GetReservoirKindReferenceSuiteDirectoryAccessRightsForEmployee(
      Employee: TEmployee
    ): TReservoirKindReferenceSuiteDirectoryAccessRights;

    function EnsureAndGetReservoirKindReferenceSuiteDirectoryAccessRightsForEmployee(
      Employee: TEmployee
    ): TReservoirKindReferenceSuiteDirectoryAccessRights;
    
  end;
  
implementation

end.

