unit ReservoirKindReferenceSuiteSetReadService;

interface

uses

  ReservoirKindReferenceSuiteSetHolder,
  ApplicationService;

type

  TReservoirKindReferenceSuiteSetReadServiceException =
    class (TApplicationServiceException)

    end;
    
  IReservoirKindReferenceSuiteSetReadService = interface (IApplicationService)

    function GetAllReservoirKindReferenceSuiteSet:
      TReservoirKindReferenceSuiteSetHolder;
      
  end;

implementation

end.
