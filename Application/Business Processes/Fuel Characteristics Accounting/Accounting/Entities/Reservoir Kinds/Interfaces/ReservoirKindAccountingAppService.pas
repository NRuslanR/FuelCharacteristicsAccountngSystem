unit ReservoirKindAccountingAppService;

interface

uses

  ReservoirKindInfo,
  ApplicationService;

type

  TReservoirKindAccountingAppServiceException =
    class (TApplicationServiceException)

    end;
    
  IReservoirKindAccountingAppService = interface (IApplicationService)

    function GetReservoirKindInfoForEmployee(
      const RequestingEmployeeId: Variant;
      const ReservoirKindId: Variant
    ): TReservoirKindInfo;
    
  end;

implementation

end.
