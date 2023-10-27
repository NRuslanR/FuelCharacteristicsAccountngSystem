unit ReservoirSubLayerKindAccountingAppService;

interface

uses

  ApplicationService,
  ReservoirSubLayerKindDto;

type

  IReservoirSubLayerKindAccountingAppService = interface (IApplicationService)

    function GetAllReservoirSubLayerKinds: TReservoirSubLayerKindDtos;

    function GetReservoirSubLayerKindByName(
      const ReservoirSubLayerKindName: String
    ): TReservoirSubLayerKindDto;

  end;

implementation

end.
