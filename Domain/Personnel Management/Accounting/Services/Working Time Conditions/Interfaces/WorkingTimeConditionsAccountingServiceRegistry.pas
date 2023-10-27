unit WorkingTimeConditionsAccountingServiceRegistry;

interface

uses

  DomainException,
  WorkingTimeConditionsAccessRightsService,
  WorkingTimeConditionsAccountingService;

type

  TWorkingTimeConditionsAccountingServiceRegistryException =
    class (TDomainException)

    end;
    
  IWorkingTimeConditionsAccountingServiceRegistry = interface

    procedure Clear;
    
    procedure RegisterWorkingTimeConditionsAccessRightsService(
      WorkingTimeConditionsAccessRightsService:
        IWorkingTimeConditionsAccessRightsService
    );

    function GetWorkingTimeConditionsAccessRightsService:
      IWorkingTimeConditionsAccessRightsService;

    procedure RegisterStandardWorkingTimeConditionsAccessRightsService;


    procedure RegisterWorkingTimeConditionsAccountingService(
      WorkingTimeConditionsAccountingService:
        IWorkingTimeConditionsAccountingService
    );

    function GetWorkingTimeConditionsAccountingService:
      IWorkingTimeConditionsAccountingService;

    procedure RegisterStandardWorkingTimeConditionsAccountingService;
    
  end;


implementation

end.
