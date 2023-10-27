unit ReservoirSubLayerKindAccountingService;

interface

uses

  DomainService,
  DomainException,
  ReservoirSubLayerKind;

type

  TReservoirSubLayerKindAccountingServiceException =
    class (TDomainException)

    end;
    
  IReservoirSubLayerKindAccountingService = interface (IDomainService)

    function TakeAllReservoirSubLayerKinds: TReservoirSubLayerKinds;

    function TakeReservoirSubLayerKind(
      const ReservoirSubLayerKindName: String
    ): TReservoirSubLayerKind;

  end;

implementation

end.
