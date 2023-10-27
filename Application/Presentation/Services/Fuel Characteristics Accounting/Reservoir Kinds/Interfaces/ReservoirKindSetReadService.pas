unit ReservoirKindSetReadService;

interface

uses

  ReservoirKindSetHolder,
  ApplicationService;

type

  TReservoirKindSetReadServiceException = class (TApplicationServiceException)

  end;
  
  IReservoirKindSetReadService = interface (IApplicationService)

    function GetAllReservoirKindSet: TReservoirKindSetHolder;
    
  end;


implementation

end.
