unit StandardWorkingTimeConditionsAccountingServiceRegistry;

interface

uses

  WorkingTimeConditionsAccountingServiceRegistry,
  WorkingTimeConditionsAccessRightsService,
  WorkingTimeConditionsAccountingService,
  SysUtils;

type

  TWorkingTimeConditionsAccountingServiceRegistry =
    class (TInterfacedObject, IWorkingTimeConditionsAccountingServiceRegistry)

      private

        class var FInstance: IWorkingTimeConditionsAccountingServiceRegistry;

        class function GetInstance: IWorkingTimeConditionsAccountingServiceRegistry; static;

      protected

        FWorkingTimeConditionsAccessRightsService:
          IWorkingTimeConditionsAccessRightsService;

        FWorkingTimeConditionsAccountingService:
          IWorkingTimeConditionsAccountingService;

        procedure RaiseExceptionIfWorkingTimeConditionsAccountingServiceRegistrationOrderIsNotValid;
        procedure RaiseExceptionIfWorkingTimeConditionsAccessRightsServiceRegistrationOrderIsNotValid;
      
      public

        procedure RegisterWorkingTimeConditionsAccessRightsService(
          WorkingTimeConditionsAccessRightsService:
            IWorkingTimeConditionsAccessRightsService
        );

        function GetWorkingTimeConditionsAccessRightsService:
          IWorkingTimeConditionsAccessRightsService;

        procedure RegisterStandardWorkingTimeConditionsAccessRightsService;

      public

        procedure RegisterWorkingTimeConditionsAccountingService(
          WorkingTimeConditionsAccountingService:
            IWorkingTimeConditionsAccountingService
        );

        function GetWorkingTimeConditionsAccountingService:
          IWorkingTimeConditionsAccountingService;

        procedure RegisterStandardWorkingTimeConditionsAccountingService;

      public

        procedure Clear;
        
        class property Current: IWorkingTimeConditionsAccountingServiceRegistry
        read GetInstance write FInstance;
    end;


implementation

uses

  StandardWorkingTimeConditionsAccountingService,
  StandardWorkingTimeConditionsAccessRightsService,
  StandardWorkingTimeConditionsStorageServiceRegistry;

{ TWorkingTimeConditionsAccountingServiceRegistry }

procedure TWorkingTimeConditionsAccountingServiceRegistry.Clear;
begin

  FWorkingTimeConditionsAccessRightsService := nil;
  FWorkingTimeConditionsAccountingService := nil;
  
end;

class function TWorkingTimeConditionsAccountingServiceRegistry.
  GetInstance: IWorkingTimeConditionsAccountingServiceRegistry;
begin

  if not Assigned(FInstance) then
    FInstance := TWorkingTimeConditionsAccountingServiceRegistry.Create;
    
  Result := FInstance;

end;

function TWorkingTimeConditionsAccountingServiceRegistry.
  GetWorkingTimeConditionsAccessRightsService:
    IWorkingTimeConditionsAccessRightsService;
begin

  Result := FWorkingTimeConditionsAccessRightsService;
  
end;

function TWorkingTimeConditionsAccountingServiceRegistry.
  GetWorkingTimeConditionsAccountingService:
    IWorkingTimeConditionsAccountingService;
begin

  Result := FWorkingTimeConditionsAccountingService;
  
end;

procedure TWorkingTimeConditionsAccountingServiceRegistry.
  RaiseExceptionIfWorkingTimeConditionsAccessRightsServiceRegistrationOrderIsNotValid;
begin

  if Assigned(FWorkingTimeConditionsAccountingService) then begin

    raise TWorkingTimeConditionsAccountingServiceRegistryException.Create(
      'Неправильный порядок регистрации ' +
      'предметной службы'
    );
    
  end;

end;

procedure TWorkingTimeConditionsAccountingServiceRegistry.
  RaiseExceptionIfWorkingTimeConditionsAccountingServiceRegistrationOrderIsNotValid;
begin

  if
    not Assigned(FWorkingTimeConditionsAccessRightsService) or
    not Assigned(
      TWorkingTimeConditionsStorageServiceRegistry
        .Current
          .GetWorkingTimeConditionsDirectory
    )
  then begin

    raise TWorkingTimeConditionsAccountingServiceRegistryException.Create(
      'Неправильный порядок регистрации ' +
      'предметной службы'
    );
    
  end;
  
end;

procedure TWorkingTimeConditionsAccountingServiceRegistry.
  RegisterStandardWorkingTimeConditionsAccessRightsService;
begin

  RaiseExceptionIfWorkingTimeConditionsAccessRightsServiceRegistrationOrderIsNotValid;
  
  FWorkingTimeConditionsAccessRightsService :=
    TStandardWorkingTimeConditionsAccessRightsService.Create;

end;

procedure TWorkingTimeConditionsAccountingServiceRegistry.
  RegisterStandardWorkingTimeConditionsAccountingService;
begin

  if not Assigned(FWorkingTimeConditionsAccessRightsService) then
    RegisterStandardWorkingTimeConditionsAccessRightsService;

  RaiseExceptionIfWorkingTimeConditionsAccountingServiceRegistrationOrderIsNotValid;

  FWorkingTimeConditionsAccountingService :=
    TStandardWorkingTimeConditionsAccountingService.Create(

      TWorkingTimeConditionsStorageServiceRegistry
        .Current
          .GetWorkingTimeConditionsDirectory,

      FWorkingTimeConditionsAccessRightsService
      
    );

end;

procedure TWorkingTimeConditionsAccountingServiceRegistry.
  RegisterWorkingTimeConditionsAccessRightsService(

    WorkingTimeConditionsAccessRightsService:
      IWorkingTimeConditionsAccessRightsService

  );
begin

  RaiseExceptionIfWorkingTimeConditionsAccessRightsServiceRegistrationOrderIsNotValid;
  
  FWorkingTimeConditionsAccessRightsService :=
    WorkingTimeConditionsAccessRightsService;

end;

procedure TWorkingTimeConditionsAccountingServiceRegistry.
  RegisterWorkingTimeConditionsAccountingService(
  
    WorkingTimeConditionsAccountingService:
      IWorkingTimeConditionsAccountingService

  );
begin

  RaiseExceptionIfWorkingTimeConditionsAccountingServiceRegistrationOrderIsNotValid;
  
  FWorkingTimeConditionsAccountingService :=
    WorkingTimeConditionsAccountingService;
    
end;

end.
