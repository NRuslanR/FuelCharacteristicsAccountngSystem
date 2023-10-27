unit EmployeeFormControllersConfigurator;

interface

uses

  AbstractFormControllersConfigurator,
  EventBus,
  FuelCharacteristicsAccountingApplication,
  BaseEmployeesReferenceFormController,
  BaseEmployeeCardFormController,
  AbstractFormController,
  SysUtils,
  Classes;

type

  TEmployeeFormControllersConfigurator = class (TAbstractFormControllersConfigurator)

    private

      procedure RegisterWorkingTimeConditionsCardFormAdministrationServiceController(
        const AdministrationPrivilegeId: Variant;
        Application: IFuelCharacteristicsAccountingApplication;
        EventBus: IEventBus
      );


    protected

      procedure InternalConfigureControllers(
        Application: IFuelCharacteristicsAccountingApplication;
        EventBus: IEventBus
      ); override;

      function GetEntryFormController: TAbstractFormController; override;

  end;

implementation

uses

  Variants,
  ClientAccount,
  SystemAdministrationService,
  FuelCharacteristicsAccountingSystemAdministrationPrivileges,
  FuelCharacteristicsAccountingSystemServiceRegistry,
  FuelCharacteristicsAccountingBusinessServiceRegistry,
  EmployeesAdministrationReferenceFormServiceController,
  EmployeeAdministrationCardFormServiceController,
  StubEmployeeAdministrationCardFormController,
  EmployeeAdministrationCardFormViewModelMapper,
  BaseWorkingTimeConditionsCardFormController,
  WorkingTimeConditionsCardFormAdministrationServiceController,
  WorkingTimeConditionsManagementPrivilegeServices,
  EmployeesAdministrationPrivilegeServices,
  EmployeesAdministrationReferenceRecordViewModelMapper,
  WorkingTimeConditionsCardFormViewModelMapper,
  EmployeesAdministrationReferenceFormViewModelMapper;
  
{ TEmployeeFormControllersConfigurator }

function TEmployeeFormControllersConfigurator.
  GetEntryFormController: TAbstractFormController;
begin

  Result :=
    TAbstractFormController(
      FControllers[TBaseEmployeesReferenceFormController.ClassName]
    );
    
end;

procedure TEmployeeFormControllersConfigurator.InternalConfigureControllers(
  Application: IFuelCharacteristicsAccountingApplication;
  EventBus: IEventBus
);
var UserRoleAccount: TUserRoleAccount;

    SystemServiceRegistry: IFuelCharacteristicsAccountingSystemServiceRegistry;
    BusinessServiceRegistry: IFuelCharacteristicsAccountingBusinessServiceRegistry;

    SystemAdministrationService: ISystemAdministrationService;
    SystemAdministrationPrivileges: TFuelCharacteristicsAccountingSystemAdministrationPrivileges;
    EmployeesAdministrationPrivilegeServices: TEmployeesAdministrationPrivilegeServices;
begin

  SystemAdministrationPrivileges := nil;
  EmployeesAdministrationPrivilegeServices := nil;

  UserRoleAccount := Application.UserRoleAccount;
  
  SystemServiceRegistry :=
    Application.ServiceRegistries.GetSystemServiceRegistry;

  SystemAdministrationService :=
    SystemServiceRegistry.GetSystemAdministrationService;

  if
    SystemAdministrationService.HasClientSystemAdministrationPrivileges(
      UserRoleAccount.Identity
    )
  then begin
  
    try

      SystemAdministrationPrivileges :=
        SystemAdministrationService.GetAllSystemAdministrationPrivileges(
          UserRoleAccount.Identity
        ) as TFuelCharacteristicsAccountingSystemAdministrationPrivileges;

      EmployeesAdministrationPrivilegeServices :=
        SystemAdministrationService.GetSystemAdministrationPrivilegeServices(
          UserRoleAccount.Identity,
          SystemAdministrationPrivileges.EmployeesAdministrationPrivilege.Identity
        ) as TEmployeesAdministrationPrivilegeServices;

      BusinessServiceRegistry :=
        Application.ServiceRegistries.GetBusinessServiceRegistry;
        
      FControllers[TBaseEmployeesReferenceFormController.ClassName] :=
        TEmployeesAdministrationReferenceFormServiceController.Create(

          UserRoleAccount.Identity,

          EmployeesAdministrationPrivilegeServices,

          SystemServiceRegistry.GetSystemAuthorizationService,
          BusinessServiceRegistry.GetSpecialityAccountingAppService,

          TEmployeesAdministrationReferenceRecordViewModelMapper.Create,
          TEmployeesAdministrationReferenceFormViewModelMapper.Create,

          EventBus
        );

      RegisterWorkingTimeConditionsCardFormAdministrationServiceController(
        SystemAdministrationPrivileges.WorkingTimeConditionsManagementPrivilege.Identity,
        Application,
        EventBus
      );

    finally

      FreeAndNil(SystemAdministrationPrivileges);
      FreeAndNil(EmployeesAdministrationPrivilegeServices);
    
    end;

    FControllers[TBaseEmployeeCardFormController.ClassName] :=
      TEmployeeAdministrationCardFormServiceController.Create(
        UserRoleAccount.Identity,

        SystemServiceRegistry.GetSystemAuthorizationService,
        BusinessServiceRegistry.GetSpecialityAccountingAppService,
        SystemServiceRegistry.GetEmployeeAccountsManagementService,

        TEmployeeAdministrationCardFormViewModelMapper.Create,

        EventBus
      );
    
  end;

end;

procedure TEmployeeFormControllersConfigurator.
  RegisterWorkingTimeConditionsCardFormAdministrationServiceController(
    const AdministrationPrivilegeId: Variant;
    Application: IFuelCharacteristicsAccountingApplication;
    EventBus: IEventBus
  );
var WorkingTimeConditionsManagementPrivilegeServices:
      TWorkingTimeConditionsManagementPrivilegeServices;
begin

  WorkingTimeConditionsManagementPrivilegeServices :=
    Application
      .ServiceRegistries
        .GetSystemServiceRegistry
          .GetSystemAdministrationService
            .GetSystemAdministrationPrivilegeServices(
              Application.UserRoleAccount.Identity,
              AdministrationPrivilegeId
            )
            as TWorkingTimeConditionsManagementPrivilegeServices;

  try

    FControllers[TBaseWorkingTimeConditionsCardFormController.ClassName] :=
      TWorkingTimeConditionsCardFormAdministrationServiceController.Create(
        Application.UserRoleAccount.Identity,
        WorkingTimeConditionsManagementPrivilegeServices,
        TWorkingTimeConditionsCardFormViewModelMapper.Create,
        EventBus
      );
      
  finally

    FreeAndNil(WorkingTimeConditionsManagementPrivilegeServices);

  end;

end;

end.
