unit InMemoryFuelCharacteristicsAccountingSystemServiceRegistry;

interface

uses

  ApplicationService,
  FuelCharacteristicsAccountingSystemServiceRegistry,
  InMemoryApplicationServiceRegistry,
  FuelCharacteristicsAccountingSystemAuthorizationService,
  SystemAuthentificationService,
  SystemAuthorizationService,
  SystemAdministrationService,
  EmployeeLogOnInfoService,
  EmployeeAccountsManagementService,
  SysUtils,
  Classes;

type

  TInMemoryFuelCharacteristicsAccountingSystemServiceRegistry =
    class (
      TInMemoryApplicationServiceRegistry,
      IFuelCharacteristicsAccountingSystemServiceRegistry
    )

      public

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

uses

  TypInfo;

{ TInMemoryFuelCharacteristicsAccountingSystemServiceRegistry }

function TInMemoryFuelCharacteristicsAccountingSystemServiceRegistry.
  GetEmployeeAccountsManagementService: IEmployeeAccountsManagementService;
begin

  Result :=
    IEmployeeAccountsManagementService(
      GetApplicationService(
        TypeInfo(IEmployeeAccountsManagementService)
      )
    );

end;

function TInMemoryFuelCharacteristicsAccountingSystemServiceRegistry.
  GetEmployeeLogOnInfoService: IEmployeeLogOnInfoService;
begin

  Result :=
    IEmployeeLogOnInfoService(
      GetApplicationService(
        TypeInfo(IEmployeeLogOnInfoService)
      )
    );
    
end;

function TInMemoryFuelCharacteristicsAccountingSystemServiceRegistry.
  GetSystemAdministrationService: ISystemAdministrationService;
begin

  Result :=
    ISystemAdministrationService(
      GetApplicationService(
        TypeInfo(ISystemAdministrationService)
      )
    );
  
end;

function TInMemoryFuelCharacteristicsAccountingSystemServiceRegistry.
  GetSystemAuthentificationService: ISystemAuthentificationService;
begin

  Result :=
    ISystemAuthentificationService(
      GetApplicationService(
        TypeInfo(ISystemAuthentificationService)
      )
    );

end;

function TInMemoryFuelCharacteristicsAccountingSystemServiceRegistry.
  GetSystemAuthorizationService: IFuelCharacteristicsAccountingSystemAuthorizationService;
begin

  Result :=
    IFuelCharacteristicsAccountingSystemAuthorizationService(
      GetApplicationService(
        TypeInfo(IFuelCharacteristicsAccountingSystemAuthorizationService)
      )
    );
    
end;

procedure TInMemoryFuelCharacteristicsAccountingSystemServiceRegistry.
  RegisterEmployeeAccountsManagementService(
    EmployeeAccountsManagementService: IEmployeeAccountsManagementService
  );
begin

  RegisterOrUpdateApplicationService(
    TypeInfo(IEmployeeAccountsManagementService),
    EmployeeAccountsManagementService
  );
  
end;

procedure TInMemoryFuelCharacteristicsAccountingSystemServiceRegistry.
  RegisterEmployeeLogOnInfoService(
    EmployeeLogOnInfoService: IEmployeeLogOnInfoService
  );
begin

  RegisterOrUpdateApplicationService(
    TypeInfo(IEmployeeLogOnInfoService),
    EmployeeLogOnInfoService
  );
  
end;

procedure TInMemoryFuelCharacteristicsAccountingSystemServiceRegistry.
  RegisterSystemAdministrationService(
    SystemAdministrationService: ISystemAdministrationService
  );
begin

  RegisterOrUpdateApplicationService(
    TypeInfo(ISystemAdministrationService),
    SystemAdministrationService
  );

end;

procedure TInMemoryFuelCharacteristicsAccountingSystemServiceRegistry.
  RegisterSystemAuthentificationService(
    SystemAuthentificationService: ISystemAuthentificationService
  );
begin

  RegisterOrUpdateApplicationService(
    TypeInfo(ISystemAuthentificationService),
    SystemAuthentificationService
  );
  
end;

procedure TInMemoryFuelCharacteristicsAccountingSystemServiceRegistry.
  RegisterSystemAuthorizationService(
    SystemAuthorizationService: IFuelCharacteristicsAccountingSystemAuthorizationService
  );
begin

  RegisterOrUpdateApplicationService(
    TypeInfo(IFuelCharacteristicsAccountingSystemAuthorizationService),
    SystemAuthorizationService
  );
  
end;

end.
