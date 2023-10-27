unit ReservoirKindDirectoryAccessService;

interface

uses

  ReservoirKindDirectoryAccessRights,
  Employee,
  DomainException;

type

  TReservoirKindDirectoryAccessServiceException =
    class (TDomainException)

    end;
    
  IReservoirKindDirectoryAccessService = interface

    function GetReservoirKindDirectoryAccessRightsForEmployee(
      Employee: TEmployee
    ): TReservoirKindDirectoryAccessRights;

    function EnsureAndGetReservoirKindDirectoryAccessRightsForEmployee(
      Employee: TEmployee
    ): TReservoirKindDirectoryAccessRights;
    
  end;
  
implementation

end.
