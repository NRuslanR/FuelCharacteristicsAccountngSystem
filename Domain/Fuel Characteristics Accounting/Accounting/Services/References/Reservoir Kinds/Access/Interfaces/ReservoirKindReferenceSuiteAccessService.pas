unit ReservoirKindReferenceSuiteAccessService;

interface

uses

  DomainException,
  DomainService,
  ReservoirKindReferenceSuiteAccessRights,
  ReservoirKindReferenceSuite,
  Employee;

type

  TReservoirKindReferenceSuiteAccessServiceException =
    class (TDomainException)

    end;
    
  IReservoirKindReferenceSuiteAccessService = interface (IDomainService)

    function GetReservoirKindReferenceSuiteAccessRightsForEmployee(
      ReservoirKindReferenceSuite: TReservoirKindReferenceSuite;
      Employee: TEmployee
    ): TReservoirKindReferenceSuiteAccessRights;

    function EnsureAndGetReservoirKindReferenceSuiteAccessRightsForEmployee(
      ReservoirKindReferenceSuite: TReservoirKindReferenceSuite;
      Employee: TEmployee
    ): TReservoirKindReferenceSuiteAccessRights;

    procedure EnsureReservoirKindReferenceSuiteAccessRightsForEmployee(
      ReservoirKindReferenceSuite: TReservoirKindReferenceSuite;
      Employee: TEmployee
    );
    
  end;

implementation

end.
