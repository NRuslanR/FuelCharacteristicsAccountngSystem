unit WorkingTimeConditionsAccountingAppService;

interface

uses

  WorkingTimeConditionsInfo,
  WorkingTimeConditionsDto,
  WorkingTimeConditionsAccessRightsDto,
  ApplicationService,
  SysUtils;

type

  TWorkingTimeConditionsAccountingAppServiceException =
    class (TApplicationServiceException)

    end;
    
  IWorkingTimeConditionsAccountingAppService = interface (IApplicationService)

    function GetActiveWorkingTimeConditionsInfo(
      const ClientIdentity: Variant
    ): TWorkingTimeConditionsInfo;

    function GetWorkingTimeConditionsInfo(
      const ClientIdentity: Variant;
      const WorkingTimeConditionsId: Variant
    ): TWorkingTimeConditionsInfo;

    procedure AccountExistingWorkingTimeConditions(
      const ClientIdentity: Variant;
      const WorkingTimeConditionsDto: TWorkingTimeConditionsDto
    );
    
  end;

implementation

end.
