unit StandardWorkingTimeConditionsAccountingService;

interface

uses

  AbstractDomainService,
  WorkingTimeConditionsAccountingService,
  WorkingTimeConditions,
  unIWorkingTimeConditions,
  WorkingTimeConditionsAccessRights,
  Employee,
  WorkingTimeConditionsDirectory,
  WorkingTimeConditionsAccessRightsService,
  SysUtils,
  Classes;

type

  TStandardWorkingTimeConditionsAccountingService =
    class (TAbstractStandardDomainService, IWorkingTimeConditionsAccountingService)

      private

        FWorkingTimeConditionsDirectory: IWorkingTimeConditionsDirectory;

        FWorkingTimeConditionsAccessRightsService:
          IWorkingTimeConditionsAccessRightsService;

      public

        constructor Create(
          WorkingTimeConditionsDirectory: IWorkingTimeConditionsDirectory;

          WorkingTimeConditionsAccessRightsService:
            IWorkingTimeConditionsAccessRightsService
        );

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

uses

  StandardWorkingTimeConditionsRuleRegistry;

{ TStandardWorkingTimeConditionsAccountingService }

constructor TStandardWorkingTimeConditionsAccountingService.Create(
  WorkingTimeConditionsDirectory: IWorkingTimeConditionsDirectory;
  WorkingTimeConditionsAccessRightsService: IWorkingTimeConditionsAccessRightsService
);
begin

  inherited Create;

  FWorkingTimeConditionsDirectory := WorkingTimeConditionsDirectory;
  FWorkingTimeConditionsAccessRightsService := WorkingTimeConditionsAccessRightsService;

end;

procedure TStandardWorkingTimeConditionsAccountingService.
  PerformExistingWorkingTimeConditionsAccounting(
    RequestingEmployee: TEmployee;
    WorkingTimeConditions: IWorkingTimeConditions
  );
var ConcreteWorkingTimeConditions: TWorkingTimeConditions;
begin

  ConcreteWorkingTimeConditions :=
    TWorkingTimeConditions(WorkingTimeConditions.Self);

  ConcreteWorkingTimeConditions
    .Rules
      .AccessingRule
        .EnsureWorkingTimeConditionsMayBeAccessedByEmployee(
          ConcreteWorkingTimeConditions, RequestingEmployee
        );

  FWorkingTimeConditionsDirectory.ModifyWorkingTimeConditions(
    ConcreteWorkingTimeConditions
  );
  
end;

procedure TStandardWorkingTimeConditionsAccountingService.
  PerformNewWorkingTimeConditionsAccounting(
    RequestingEmployee: TEmployee;
    WorkingTimeConditions: IWorkingTimeConditions
  );
var ConcreteWorkingTimeConditions: TWorkingTimeConditions;
begin

  ConcreteWorkingTimeConditions :=
    TWorkingTimeConditions(WorkingTimeConditions.Self);

  ConcreteWorkingTimeConditions
    .Rules
      .AccessingRule
        .EnsureWorkingTimeConditionsMayBeAccessedByEmployee(
          ConcreteWorkingTimeConditions, RequestingEmployee
        );

  FWorkingTimeConditionsDirectory.PutWorkingTimeConditions(
    ConcreteWorkingTimeConditions
  );

end;

procedure TStandardWorkingTimeConditionsAccountingService.
  RemoveWorkingTimeConditions(
    RequestingEmployee: TEmployee;
    const WorkingTimeConditionsId: Variant
  );
var WorkingTimeConditions: TWorkingTimeConditions;
    Free: IWorkingTimeConditions;
begin

  WorkingTimeConditions :=
    FWorkingTimeConditionsDirectory.FindWorkingTimeConditions(
      WorkingTimeConditionsId
    );

  Free := WorkingTimeConditions;

  WorkingTimeConditions
    .Rules
      .AccessingRule
        .EnsureWorkingTimeConditionsMayBeAccessedByEmployee(
          WorkingTimeConditions, RequestingEmployee
        );

  FWorkingTimeConditionsDirectory.RemoveWorkingTimeConditions(
    WorkingTimeConditions
  );

end;

procedure TStandardWorkingTimeConditionsAccountingService.
  TakeActiveWorkingTimeConditionsAndAccessRights(
    RequestingEmployee: TEmployee;
    var WorkingTimeConditions: IWorkingTimeConditions;
    var AccessRights: TWorkingTimeConditionsAccessRights
  );
begin

  WorkingTimeConditions :=
    FWorkingTimeConditionsDirectory.FindActiveWorkingTimeConditions;

  if not Assigned(WorkingTimeConditions) then begin

    raise TWorkingTimeConditionsAccountingServiceException.Create(
      'Информация об активном режиме ' +
      'рабочего времени не найдена'
    );
    
  end;

  AccessRights :=
    FWorkingTimeConditionsAccessRightsService
      .EnsureAndGetWorkingTimeConditionsAccessRightsForEmployee(
        TWorkingTimeConditions(WorkingTimeConditions.Self),
        RequestingEmployee
      );

  try

    if AccessRights.CanBeEdited then
      WorkingTimeConditions.EditingEmployee := RequestingEmployee;

  except

    on E: Exception do begin

      FreeAndNil(AccessRights);

      raise;
      
    end;

  end;

end;

procedure TStandardWorkingTimeConditionsAccountingService.
  TakeNewWorkingTimeConditionsAndAccessRights(
    RequestingEmployee: TEmployee;
    var WorkingTimeConditions: IWorkingTimeConditions;
    var AccessRights: TWorkingTimeConditionsAccessRights
  );
var ConcreteWorkingTimeConditions: TWorkingTimeConditions;
begin

  ConcreteWorkingTimeConditions := TWorkingTimeConditions.Create;

  WorkingTimeConditions := ConcreteWorkingTimeConditions;

  ConcreteWorkingTimeConditions.Rules :=
    TWorkingTimeConditionsRuleRegistry.Current.GetWorkingTimeConditionsRules;

  AccessRights :=
    FWorkingTimeConditionsAccessRightsService
      .EnsureAndGetWorkingTimeConditionsAccessRightsForEmployee(
        ConcreteWorkingTimeConditions, RequestingEmployee
      );

  try

    if AccessRights.CanBeEdited then
      WorkingTimeConditions.EditingEmployee := RequestingEmployee;

  except

    on E: Exception do begin

      FreeAndNil(AccessRights);

      raise;

    end;

  end;

end;

procedure TStandardWorkingTimeConditionsAccountingService.
  TakeWorkingTimeConditionsAndAccessRights(
    RequestingEmployee: TEmployee;
    const WorkingTimeConditionsId: Variant;
    var WorkingTimeConditions: IWorkingTimeConditions;
    var AccessRights: TWorkingTimeConditionsAccessRights
  );
begin

  WorkingTimeConditions :=
    FWorkingTimeConditionsDirectory.FindWorkingTimeConditions(
      WorkingTimeConditionsId
    );

  if not Assigned(WorkingTimeConditions) then begin

    raise TWorkingTimeConditionsAccountingServiceException.Create(
      'Информация о режиме ' +
      'рабочего времени не найдена'
    );
    
  end;
  
  AccessRights :=
    FWorkingTimeConditionsAccessRightsService
      .EnsureAndGetWorkingTimeConditionsAccessRightsForEmployee(
        TWorkingTimeConditions(WorkingTimeConditions.Self),
        RequestingEmployee
      );

  try

    if AccessRights.CanBeEdited then
      WorkingTimeConditions.EditingEmployee := RequestingEmployee;

  except

    on E: Exception do begin

      FreeAndNil(AccessRights);

      raise;

    end;

  end;
  
end;

end.
