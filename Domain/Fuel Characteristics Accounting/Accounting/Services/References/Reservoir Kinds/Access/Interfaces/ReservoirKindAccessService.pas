unit ReservoirKindAccessService;

interface

uses

  DomainService,
  DomainException,
  ReservoirKind,
  ReservoirKindAccessRights,
  Employee;

type

  TReservoirKindAccessServiceException = class (TDomainException)

  end;

  IReservoirKindAccessService = interface (IDomainService)

    function GetReservoirKindAccessRightsForEmployee(
      ReservoirKind: TReservoirKind;
      Employee: TEmployee
    ): TReservoirKindAccessRights;

    function EnsureAndGetReservoirKindAccessRightsForEmployee(
      ReservoirKind: TReservoirKind;
      Employee: TEmployee
    ): TReservoirKindAccessRights;
    
    procedure EnsureReservoirKindAccessRightsForEmployee(
      ReservoirKind: TReservoirKind;
      Employee: TEmployee
    );

  end;

implementation

end.
