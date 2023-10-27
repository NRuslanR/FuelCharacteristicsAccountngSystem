unit ReservoirKindReferenceService;

interface

uses

  ReservoirKindSetHolder,
  ApplicationService;

type

  TReservoirKindReferenceServiceException =
    class (TApplicationServiceException)

    end;
  
  IReservoirKindReferenceService = interface (IApplicationService)

    function GetAllReservoirKindsForEmployee(
      const EmployeeId: Variant
    ): TReservoirKindSetHolder;

  end;
  
implementation

end.
