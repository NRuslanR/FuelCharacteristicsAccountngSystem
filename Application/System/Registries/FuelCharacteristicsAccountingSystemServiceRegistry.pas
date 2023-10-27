unit FuelCharacteristicsAccountingSystemServiceRegistry;

interface

uses

  ApplicationServiceRegistry,
  FuelCharacteristicsAccountingSystemAuthorizationService,
  EmployeeAccountsManagementService,
  SystemAuthentificationService,
  EmployeeLogOnInfoService,
  SystemAdministrationService;

type

  IFuelCharacteristicsAccountingSystemServiceRegistry =
    interface (IApplicationServiceRegistry)

      procedure RegisterSystemAuthorizationService(
        SystemAuthorizationService: IFuelCharacteristicsAccountingSystemAuthorizationService
      );

      function GetSystemAuthorizationService: IFuelCharacteristicsAccountingSystemAuthorizationService;

      procedure RegisterSystemAuthentificationService(
        SystemAuthentificationService: ISystemAuthentificationService
      );

      function GetSystemAuthentificationService: ISystemAuthentificationService;

      procedure RegisterSystemAdministrationService(
        SystemAdministrationService: ISystemAdministrationService
      );

      function GetSystemAdministrationService: ISystemAdministrationService;

      procedure RegisterEmployeeLogOnInfoService(
        EmployeeLogOnInfoService: IEmployeeLogOnInfoService
      );

      function GetEmployeeLogOnInfoService: IEmployeeLogOnInfoService;
      
      procedure RegisterEmployeeAccountsManagementService(
        EmployeeAccountsManagementService:
          IEmployeeAccountsManagementService
      );

      function GetEmployeeAccountsManagementService:
        IEmployeeAccountsManagementService;

    end;
  
implementation

end.
