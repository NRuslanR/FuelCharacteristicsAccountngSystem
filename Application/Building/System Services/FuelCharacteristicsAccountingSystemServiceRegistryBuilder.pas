unit FuelCharacteristicsAccountingSystemServiceRegistryBuilder;

interface

uses

  FuelCharacteristicsAccountingSystemServiceRegistry,
  SystemAuthentificationService,
  FuelCharacteristicsAccountingSystemAuthorizationService,
  DatabaseServerRoleAuthentificationService,
  SystemAdministrationService,
  EmployeeAccountReferenceService,
  EmployeeAccountsAccessRightsService,
  FuelCharacteristicsAccountingPresentationServiceRegistry,
  FuelCharacteristicsAccountingBusinessServiceRegistry,
  EmployeeAccountSetReadService,
  EmployeeAccountsManagementService,
  EmployeeLogOnInfoService,
  BasedOnDBEmployeeLogOnInfoService,
  BasedOnPostgresRoleEmployeeLogOnInfoService,
  FuelCharacteristicsAccountingDBRoleAuthentificationService,
  ZConnection,
  ZConnectionFactory,
  ConnectionFactory,
  ZQueryExecutor,
  SysUtils,
  Classes;

type

  TFuelCharacteristicsAccountingSystemServiceRegistryBuilder = class

    private

      FSystemServiceRegistry:
        IFuelCharacteristicsAccountingSystemServiceRegistry;
      
    public

      function UseBasedOnZeosPostgresRoleAuthentificationService(

        FuelCharacteristicsAccountingSystemAuthentificationDbSchemaData:
          TFuelCharacteristicsAccountingSystemAuthentificationDbSchemaData = nil
          
      ): TFuelCharacteristicsAccountingSystemServiceRegistryBuilder;

      function UseBasedOnZeosPostgresRoleEmployeeLogOnInfoService(
        Connection: TZConnection;
        EmployeeLogOnInfoDbSchema: TEmployeeLogOnInfoDbSchema = nil
      ): TFuelCharacteristicsAccountingSystemServiceRegistryBuilder;

    public
    
      function UseStandardSystemAuthorizationService:
        TFuelCharacteristicsAccountingSystemServiceRegistryBuilder;

      function UseStandardSystemAdministrationService(

        PresentationServiceRegistry:
          IFuelCharacteristicsAccountingPresentationServiceRegistry;

        BusinessServiceRegistry:
          IFuelCharacteristicsAccountingBusinessServiceRegistry

      ): TFuelCharacteristicsAccountingSystemServiceRegistryBuilder;

      function UseStandardEmployeeAccountsManagementService:
        TFuelCharacteristicsAccountingSystemServiceRegistryBuilder;

    public

      function UseEmployeeLogOnInfoService(
        EmployeeLogOnInfoService: IEmployeeLogOnInfoService
      ): TFuelCharacteristicsAccountingSystemServiceRegistryBuilder;
      
      function UseSystemAuthentificationService(
      
        SystemAuthentificationService:
          ISystemAuthentificationService

      ): TFuelCharacteristicsAccountingSystemServiceRegistryBuilder;

      function UseSystemAuthorizationService(

        SystemAuthorizationService:
          IFuelCharacteristicsAccountingSystemAuthorizationService
          
      ): TFuelCharacteristicsAccountingSystemServiceRegistryBuilder;

      function UseSystemAdministrationService(

        SystemAdministrationService:
          ISystemAdministrationService
          
      ): TFuelCharacteristicsAccountingSystemServiceRegistryBuilder;

      function UseEmployeeAccountsManagementService(
        EmployeeAccountsManagementService:
          IEmployeeAccountsManagementService
      ): TFuelCharacteristicsAccountingSystemServiceRegistryBuilder;
      
    public

      function UseFullSuccessedStubSystemAuthentificationService: TFuelCharacteristicsAccountingSystemServiceRegistryBuilder;
      function UseFullSuccessedStubSystemAuthorizationService: TFuelCharacteristicsAccountingSystemServiceRegistryBuilder;
      function UseFullSuccessedStubSystemAdministrationService: TFuelCharacteristicsAccountingSystemServiceRegistryBuilder;

    public

      function ClearSystemServiceRegistry:
        TFuelCharacteristicsAccountingSystemServiceRegistryBuilder;

      constructor Create;

      function Build: IFuelCharacteristicsAccountingSystemServiceRegistry;

  end;
  

implementation

uses

  ZQueryExecutorFactory,
  QueryExecutorFactory,
  SchemaDefinition,
  EmployeeTableDefinition,
  EmployeeLogOnInfoTableDefinition,
  RoleTableDefinition,
  StubSession,
  StubEmployeeAccountSetReadService,
  StubEmployeeAccountsAccessRightsService,
  StandardEmployeeAccountReferenceService,
  StandardEmployeeAccountsAccessRightsService,
  StandardEmployeeAccountsManagementService,
  StandardEmployeeAccountingAppService,
  StandardFuelCharacteristicsAccountingRepositoryRegistry,
  StandardFuelCharacteristicsAccountingAdministrationService,
  StandardFuelCharacteristicsAccountingSystemAuthorizationService,
  FullSuccessedStubFuelCharacteristicsAccountingSystemAuthentificationService,
  FullSuccessedStubFuelCharacteristicsAccountingSystemAuthorizationService,
  InMemoryFuelCharacteristicsAccountingSystemServiceRegistry;
  
{ TFuelCharacteristicsAccountingSystemServiceRegistryBuilder }

function TFuelCharacteristicsAccountingSystemServiceRegistryBuilder.
  UseFullSuccessedStubSystemAdministrationService:
    TFuelCharacteristicsAccountingSystemServiceRegistryBuilder;
    
var SystemAdministrationService: ISystemAdministrationService;
    EmployeeAccountReferenceService: IEmployeeAccountReferenceService;
    EmployeeAccountsAccessRightsService: IEmployeeAccountsAccessRightsService;
    EmployeeAccountSetReadService: IEmployeeAccountSetReadService;
begin

  EmployeeAccountsAccessRightsService :=
    TStubEmployeeAccountsAccessRightsService.Create;

  EmployeeAccountSetReadService :=
    TStubEmployeeAccountSetReadService.Create;

  EmployeeAccountReferenceService :=
    TStandardEmployeeAccountReferenceService.Create(
      EmployeeAccountsAccessRightsService,
      EmployeeAccountSetReadService
    );

  SystemAdministrationService :=
    TStandardFuelCharacteristicsAccountingAdministrationService.Create(
      FSystemServiceRegistry.GetSystemAuthorizationService,
      EmployeeAccountReferenceService,
      nil
    );

  FSystemServiceRegistry.RegisterSystemAdministrationService(
    SystemAdministrationService
  );

  Result := Self;
  
end;

function TFuelCharacteristicsAccountingSystemServiceRegistryBuilder.
  UseFullSuccessedStubSystemAuthentificationService:
    TFuelCharacteristicsAccountingSystemServiceRegistryBuilder;
    
var SystemAuthentificationService: ISystemAuthentificationService;
begin

  SystemAuthentificationService :=
    TFullSuccessedStubFuelCharacteristicsAccountingSystemAuthentificationService.Create;

  FSystemServiceRegistry.RegisterSystemAuthentificationService(
    SystemAuthentificationService
  );

  Result := Self;
  
end;

function TFuelCharacteristicsAccountingSystemServiceRegistryBuilder.
  UseFullSuccessedStubSystemAuthorizationService:
    TFuelCharacteristicsAccountingSystemServiceRegistryBuilder;

var
  SystemAuthorizationService:
    IFuelCharacteristicsAccountingSystemAuthorizationService;
begin

  SystemAuthorizationService :=
    TFullSuccessedStubFuelCharacteristicsAccountingSystemAuthorizationService.
    Create;

  FSystemServiceRegistry.RegisterSystemAuthorizationService(
    SystemAuthorizationService
  );

  Result := Self;
  
end;

function TFuelCharacteristicsAccountingSystemServiceRegistryBuilder.
  UseStandardEmployeeAccountsManagementService:
    TFuelCharacteristicsAccountingSystemServiceRegistryBuilder;
begin

  if not Assigned(FSystemServiceRegistry.GetEmployeeLogOnInfoService)
  then begin

    raise Exception.Create(
      'Для регистрации стандартной службы ' +
      'управления учётными записями сотрудников ' +
      'необходимо предварительно зарегистрировать ' +
      'службу управления данными для входа в систему'
    );
    
  end;

  if not Assigned(FSystemServiceRegistry.GetSystemAuthorizationService)
  then UseStandardSystemAuthorizationService;

  Result :=
    UseEmployeeAccountsManagementService(
      TStandardEmployeeAccountsManagementService.Create(

        TFuelCharacteristicsAccountingRepositoryRegistry
          .Current
            .GetSessionManager,

        TStandardEmployeeAccountsAccessRightsService.Create(
          FSystemServiceRegistry.GetSystemAuthorizationService
        ),

        TStandardEmployeeAccountingAppService.Create(

          TStubSession.Create,

          TFuelCharacteristicsAccountingRepositoryRegistry
            .Current
              .GetEmployeeRepository

        ),

        FSystemServiceRegistry.GetEmployeeLogOnInfoService
      )
    );
  
end;

function TFuelCharacteristicsAccountingSystemServiceRegistryBuilder.
  UseStandardSystemAdministrationService(

    PresentationServiceRegistry:
      IFuelCharacteristicsAccountingPresentationServiceRegistry;

    BusinessServiceRegistry:
      IFuelCharacteristicsAccountingBusinessServiceRegistry

  ): TFuelCharacteristicsAccountingSystemServiceRegistryBuilder;
begin

  if not Assigned(FSystemServiceRegistry.GetSystemAuthorizationService)
  then UseStandardSystemAuthorizationService;

  Result :=
    UseSystemAdministrationService(

      TStandardFuelCharacteristicsAccountingAdministrationService.Create(

        FSystemServiceRegistry
          .GetSystemAuthorizationService,

        TStandardEmployeeAccountReferenceService.Create(

          TStandardEmployeeAccountsAccessRightsService.Create(
            FSystemServiceRegistry.GetSystemAuthorizationService
          ),

          PresentationServiceRegistry.GetEmployeeAccountSetReadService
        ),

        BusinessServiceRegistry.GetWorkingTimeConditionsAccountingAppService
      )
    );
  
end;

function TFuelCharacteristicsAccountingSystemServiceRegistryBuilder.
  UseStandardSystemAuthorizationService:
    TFuelCharacteristicsAccountingSystemServiceRegistryBuilder;
begin

  Result :=
    UseSystemAuthorizationService(

      TStandardFuelCharacteristicsAccountingSystemAuthorizationService.Create(

        TFuelCharacteristicsAccountingRepositoryRegistry
          .Current
            .GetSessionManager,

        TFuelCharacteristicsAccountingRepositoryRegistry
          .Current
            .GetEmployeeRepository,

        TFuelCharacteristicsAccountingRepositoryRegistry
          .Current
            .GetRoleRepository

      )
    );
  
end;

function TFuelCharacteristicsAccountingSystemServiceRegistryBuilder.
  UseSystemAdministrationService(
    SystemAdministrationService: ISystemAdministrationService
  ): TFuelCharacteristicsAccountingSystemServiceRegistryBuilder;
begin

  FSystemServiceRegistry.RegisterSystemAdministrationService(
    SystemAdministrationService
  );

  Result := Self;
  
end;

function TFuelCharacteristicsAccountingSystemServiceRegistryBuilder.
  UseSystemAuthentificationService(
    SystemAuthentificationService: ISystemAuthentificationService
  ): TFuelCharacteristicsAccountingSystemServiceRegistryBuilder;
begin

  FSystemServiceRegistry.RegisterSystemAuthentificationService(
    SystemAuthentificationService
  );

  Result := Self;

end;

function TFuelCharacteristicsAccountingSystemServiceRegistryBuilder.
  UseSystemAuthorizationService(
    SystemAuthorizationService:
      IFuelCharacteristicsAccountingSystemAuthorizationService
  ): TFuelCharacteristicsAccountingSystemServiceRegistryBuilder;
begin

  FSystemServiceRegistry.RegisterSystemAuthorizationService(
    SystemAuthorizationService
  );

  Result := Self;
  
end;

function TFuelCharacteristicsAccountingSystemServiceRegistryBuilder.
  UseBasedOnZeosPostgresRoleEmployeeLogOnInfoService(
    Connection: TZConnection;
    EmployeeLogOnInfoDbSchema: TEmployeeLogOnInfoDbSchema
  ): TFuelCharacteristicsAccountingSystemServiceRegistryBuilder;
begin

  if not Assigned(EmployeeLogOnInfoDbSchema) then begin

    EmployeeLogOnInfoDbSchema := TEmployeeLogOnInfoDbSchema.Create;

    with EmployeeLogOnInfoDbSchema do begin

      TableName := EMPLOYEE_LOGON_INFO_TABLE_NAME;

      EmployeeIdColumnName := EMPLOYEE_LOGON_INFO_TABLE_EMPLOYEE_ID_COLUMN_NAME;
      LoginColumnName := EMPLOYEE_LOGON_INFO_TABLE_LOGIN_COLUMN_NAME;
      PasswordColumnName := EMPLOYEE_LOGON_INFO_TABLE_PASSWORD_COLUMN_NAME;
      
    end;
    
  end;

  Result :=
    UseEmployeeLogOnInfoService(
      TBasedOnPostgresRoleEmployeeLogOnInfoService.Create(
        EmployeeLogOnInfoDbSchema,
        TZQueryExecutor.Create(Connection)
      )
    );

end;

function TFuelCharacteristicsAccountingSystemServiceRegistryBuilder.
  UseBasedOnZeosPostgresRoleAuthentificationService(

    FuelCharacteristicsAccountingSystemAuthentificationDbSchemaData:
      TFuelCharacteristicsAccountingSystemAuthentificationDbSchemaData

  ): TFuelCharacteristicsAccountingSystemServiceRegistryBuilder;
  
var
    QueryExecutorFactory: IQueryExecutorFactory;
    ConnectionFactory: IConnectionFactory;
    
    SystemAuthentificationService: ISystemAuthentificationService;
begin

  if not Assigned(FuelCharacteristicsAccountingSystemAuthentificationDbSchemaData) then begin

    FuelCharacteristicsAccountingSystemAuthentificationDbSchemaData :=
      TFuelCharacteristicsAccountingSystemAuthentificationDbSchemaData.Create;

    with FuelCharacteristicsAccountingSystemAuthentificationDbSchemaData
    do begin

      TableName := SCHEMA_NAME + '.' + 'v_employees';
      UserIdColumnName := EMPLOYEE_TABLE_ID_COLUMN_NAME;
      UserFriendlyNameColumnName := 'full_name';
      RoleIdForeignKeyColumnName := EMPLOYEE_TABLE_ROLE_ID_COLUMN_NAME;

      RoleTableName := ROLE_TABLE_NAME;
      RoleIdColumnName := ROLE_TABLE_ID_COLUMN_NAME;
      RoleFriendlyNameColumnName := ROLE_TABLE_DISPLAY_NAME_COLUMN_NAME;


      EmployeeLogOnInfosTableName := EMPLOYEE_LOGON_INFO_TABLE_NAME;
      UserLoginColumnName := EMPLOYEE_LOGON_INFO_TABLE_LOGIN_COLUMN_NAME;
      UserPasswordColumnName := EMPLOYEE_LOGON_INFO_TABLE_PASSWORD_COLUMN_NAME;
      EmployeeLogOnInfosTableEmployeeIdColumnName := EMPLOYEE_LOGON_INFO_TABLE_EMPLOYEE_ID_COLUMN_NAME;

    end;

  end;

  ConnectionFactory := TZConnectionFactory.Create('postgresql');
  QueryExecutorFactory := TZQueryExecutorFactory.Create(ConnectionFactory);

  SystemAuthentificationService :=
    TFuelCharacteristicsAccountingDBRoleAuthentificationService.Create(
      FuelCharacteristicsAccountingSystemAuthentificationDbSchemaData,
      QueryExecutorFactory
    );

  FSystemServiceRegistry.RegisterSystemAuthentificationService(
    SystemAuthentificationService
  );

  Result := Self;

end;

function TFuelCharacteristicsAccountingSystemServiceRegistryBuilder.
  UseEmployeeAccountsManagementService(
    EmployeeAccountsManagementService: IEmployeeAccountsManagementService
  ): TFuelCharacteristicsAccountingSystemServiceRegistryBuilder;
begin

  FSystemServiceRegistry.RegisterEmployeeAccountsManagementService(
    EmployeeAccountsManagementService
  );

  Result := Self;
  
end;

function TFuelCharacteristicsAccountingSystemServiceRegistryBuilder.
  UseEmployeeLogOnInfoService(
    EmployeeLogOnInfoService: IEmployeeLogOnInfoService
  ): TFuelCharacteristicsAccountingSystemServiceRegistryBuilder;
begin

  FSystemServiceRegistry.RegisterEmployeeLogOnInfoService(
    EmployeeLogOnInfoService
  );

  Result := Self;
  
end;

function TFuelCharacteristicsAccountingSystemServiceRegistryBuilder.
  Build: IFuelCharacteristicsAccountingSystemServiceRegistry;
begin

  Result := FSystemServiceRegistry;
  
end;

function TFuelCharacteristicsAccountingSystemServiceRegistryBuilder.
  ClearSystemServiceRegistry:
    TFuelCharacteristicsAccountingSystemServiceRegistryBuilder;
begin

  FSystemServiceRegistry.Clear;

  Result := Self;

end;

constructor TFuelCharacteristicsAccountingSystemServiceRegistryBuilder.Create;
begin

  inherited;

  FSystemServiceRegistry :=
    TInMemoryFuelCharacteristicsAccountingSystemServiceRegistry.Create;

end;

end.
