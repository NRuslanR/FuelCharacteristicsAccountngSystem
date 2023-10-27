unit WorkingTimeConditionsAccountingService;

interface

uses

  DomainService,
  DomainException,
  Employee,
  unIWorkingTimeConditions,
  WorkingTimeConditionsAccessRights,
  SysUtils;

type

  TWorkingTimeConditionsAccountingServiceException = class (TDomainException)

  end;
  
  IWorkingTimeConditionsAccountingService = interface (IDomainService)

    procedure TakeNewWorkingTimeConditionsAndAccessRights(
      RequestingEmployee: TEmployee;
      var WorkingTimeConditions: IWorkingTimeConditions;
      var AccessRights: TWorkingTimeConditionsAccessRights
    );
    
    procedure TakeWorkingTimeConditionsAndAccessRights(
      RequestingEmployee: TEmployee;
      const WorkingTimeConditionsId: Variant;
      var WorkingTimeConditions: IWorkingTimeConditions;
      var AccessRights: TWorkingTimeConditionsAccessRights
    );

    procedure TakeActiveWorkingTimeConditionsAndAccessRights(
      RequestingEmployee: TEmployee;
      var WorkingTimeConditions: IWorkingTimeConditions;
      var AccessRights: TWorkingTimeConditionsAccessRights
    );

    procedure PerformNewWorkingTimeConditionsAccounting(
      RequestingEmployee: TEmployee;
      WorkingTimeConditions: IWorkingTimeConditions
    );

    procedure PerformExistingWorkingTimeConditionsAccounting(
      RequestingEmployee: TEmployee;
      WorkingTimeConditions: IWorkingTimeConditions
    );

    procedure RemoveWorkingTimeConditions(
      RequestingEmployee: TEmployee;
      const WorkingTimeConditionsId: Variant
    );
    
  end;

implementation

end.
