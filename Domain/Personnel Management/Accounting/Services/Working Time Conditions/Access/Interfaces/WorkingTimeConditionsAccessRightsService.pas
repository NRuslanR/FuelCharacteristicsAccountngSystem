unit WorkingTimeConditionsAccessRightsService;

interface

uses

  DomainService,
  DomainException,
  WorkingTimeConditionsAccessRights,
  WorkingTimeConditions,
  Employee,
  SysUtils;

type

  TWorkingTimeConditionsAccessRightsServiceException =
    class (TDomainException)

    end;

  IWorkingTimeConditionsAccessRightsService = interface (IDomainService)

    function EnsureAndGetWorkingTimeConditionsAccessRightsForEmployee(
      WorkingTimeConditions: TWorkingTimeConditions;
      Employee: TEmployee
    ): TWorkingTimeConditionsAccessRights;
    
  end;
  
implementation

end.
