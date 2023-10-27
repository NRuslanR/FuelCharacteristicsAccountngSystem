unit FuelCharacteristicsAccountingApplicationBuilder;

interface

uses

  Application,
  ApplicationBuilder,
  AuthentificationData,
  ClientAccount,
  FuelCharacteristicsAccountingApplication,
  FuelCharacteristicsAccountingDomainBuilder,
  FuelCharacteristicsAccountingDomainBuildingOptions,
  StandardFuelCharacteristicsAccountingApplication,
  FuelCharacteristicsAccountingSystemServiceRegistry,
  FuelCharacteristicsAccountingApplicationServiceRegistries,
  FuelCharacteristicsAccountingSystemServiceRegistryBuilder,
  FuelCharacteristicsAccountingRepositoryRegistryBuilder,
  FuelCharacteristicsAccountingPresentationServiceRegistryBuilder,
  FuelCharacteristicsAccountingBusinessServiceRegistryBuilder,
  ClientLogOnInfo,
  ConnectionInfo,
  SysUtils,
  Classes;

type

  TFuelCharacteristicsAccountingApplicationBuilder =
    class (TInterfacedObject, IApplicationBuilder)

      private

        FDatabaseConnection: TComponent;
        
        FUserRoleAccount: TUserRoleAccount;
        
        FApplicationServiceRegistries:
          IFuelCharacteristicsAccountingApplicationServiceRegistries;

        procedure SetUserRoleAccount(const Value: TUserRoleAccount);

        function CreateNullUserRoleAccount: TUserRoleAccount;
        
        property UserRoleAccount: TUserRoleAccount
        read FUserRoleAccount write SetUserRoleAccount;
        
      private

        FSystemServiceRegistryBuilder:
          TFuelCharacteristicsAccountingSystemServiceRegistryBuilder;

        procedure UseFullSuccessedStubSystemServiceRegistry;

        function SystemServiceRegistryBuilder:
          TFuelCharacteristicsAccountingSystemServiceRegistryBuilder;
          
      public

        function UseBasedOnZeosPostgresRoleAuthentificationServiceOnly:
          TFuelCharacteristicsAccountingApplicationBuilder;

        function UseFullSuccessedStubAuthentificationServiceOnly:
          TFuelCharacteristicsAccountingApplicationBuilder;

      private

        FDomainBuilder: TFuelCharacteristicsAccountingDomainBuilder;

        procedure SetDefaultDomainBuildingOptionsIfNecessary(
          DomainBuildingOptions:
            IFuelCharacteristicsAccountingDomainBuildingOptions
        );

      public

        function UseStandardDomain(
          DomainBuildingOptions: IFuelCharacteristicsAccountingDomainBuildingOptions = nil
        ): TFuelCharacteristicsAccountingApplicationBuilder;

        function DomainBuilder: TFuelCharacteristicsAccountingDomainBuilder;

      private

        FRepositoryRegistryBuilder:
          TFuelCharacteristicsAccountingRepositoryRegistryBuilder;

      public

        function UseBasedOnZeosPostgresDefaultRepositoryRegistry:
          TFuelCharacteristicsAccountingApplicationBuilder;

        function RepositoryRegistryBuilder:
          TFuelCharacteristicsAccountingRepositoryRegistryBuilder;

      private

        procedure EnsureZeosPostgresConnectionUsing;

      private

        FPresentationServiceRegistryBuilder:
          TFuelCharacteristicsAccountingPresentationServiceRegistryBuilder;

      public

        function PresentationServiceRegistryBuilder:
          TFuelCharacteristicsAccountingPresentationServiceRegistryBuilder;

      private

        FBusinessServiceRegistryBuilder:
          TFuelCharacteristicsAccountingBusinessServiceRegistryBuilder;

        function BusinessServiceRegistryBuilder:
          TFuelCharacteristicsAccountingBusinessServiceRegistryBuilder;

      public

        destructor Destroy; override;
        
        constructor Create;

        function Clear: TFuelCharacteristicsAccountingApplicationBuilder;

        function UseBasedOnZeosPostgresRoleDefaultAuthentificationService:
          TFuelCharacteristicsAccountingApplicationBuilder;

        function UseBasedOnZeosPostgresRoleDefaultLogOnInfoService:
          TFuelCharacteristicsAccountingApplicationBuilder;

        function UseZeosPostgresConnection(
          AuthentificationData: TUserDatabaseServerAuthentificationData
        ): TFuelCharacteristicsAccountingApplicationBuilder;
        
        function UseBasedOnZeosPostgresDefaultPresentationServices:
          TFuelCharacteristicsAccountingApplicationBuilder;

        function UseStandardBusinessServices:
          TFuelCharacteristicsAccountingApplicationBuilder;

        function UseFullSuccessedStubServices:
          TFuelCharacteristicsAccountingApplicationBuilder;

        function UseStandardSystemServices:
          TFuelCharacteristicsAccountingApplicationBuilder;
          
        function Build: IApplication;

        function BuildFuelCharacteristicsAccountingApplication:
          IFuelCharacteristicsAccountingApplication;

      public

        function GetSelf: TObject;

        property Self: TObject read GetSelf;
        
    end;

implementation

uses

  AuxDebugFunctionsUnit,
  ConnectionFactory,
  ZConnectionFactory,
  ZConnection,
  DatabaseServerAuthentificationService,
  SystemAuthentificationService,
  ZQueryExecutorFactory,
  QueryExecutorFactory,
  SystemAdministrationService,
  StandardEmployeeAccountReferenceService,
  SystemAuthorizationService,
  EmployeeAccountReferenceService,
  EmployeeAccountsAccessRightsService,
  MockRandomReservoirCalibrationChart,
  MockRandomCalculationElectronicMetroshtok,
  MockReservoirCalibrationChartRegistry,
  EmployeeAccountSetReadService,
  StubEmployeeAccountSetReadService,
  FuelCharacteristicsAccountingSystemAuthorizationService,
  FullSuccessedStubFuelCharacteristicsAccountingSystemAuthentificationService,
  FullSuccessedStubFuelCharacteristicsAccountingSystemAuthorizationService,
  StandardFuelCharacteristicsAccountingAdministrationService,
  StubEmployeeAccountsAccessRightsService,
  InMemoryFuelCharacteristicsAccountingSystemServiceRegistry,
  InMemoryFuelCharacteristicsAccountingApplicationServiceRegistries,
  InMemoryFuelCharacteristicsAccountingPresentationServiceRegistry;
  
{ TFuelCharacteristicsAccountingApplicationBuilder }

function TFuelCharacteristicsAccountingApplicationBuilder.Build: IApplication;
var UserRoleAccount: TUserRoleAccount;
begin

  if not Assigned(FUserRoleAccount) then
    UserRoleAccount := CreateNullUserRoleAccount

  else UserRoleAccount := FUserRoleAccount;
  
  Result :=
    TStandardFuelCharacteristicsAccountingApplication.Create(
      UserRoleAccount,
      FApplicationServiceRegistries
    );

  FUserRoleAccount := nil;

end;

function TFuelCharacteristicsAccountingApplicationBuilder.
  BuildFuelCharacteristicsAccountingApplication:
    IFuelCharacteristicsAccountingApplication;
begin

  Result := IFuelCharacteristicsAccountingApplication(Build);

end;

function TFuelCharacteristicsAccountingApplicationBuilder.
  BusinessServiceRegistryBuilder:
    TFuelCharacteristicsAccountingBusinessServiceRegistryBuilder;
begin

  Result := FBusinessServiceRegistryBuilder;

end;

function TFuelCharacteristicsAccountingApplicationBuilder.
  Clear: TFuelCharacteristicsAccountingApplicationBuilder;
begin

  FApplicationServiceRegistries.Clear;

  Result := Self;

end;

constructor TFuelCharacteristicsAccountingApplicationBuilder.Create;
begin

  inherited;

  FApplicationServiceRegistries :=
    TInMemoryFuelCharacteristicsAccountingApplicationServiceRegistries.Create;

  FDomainBuilder :=
    TFuelCharacteristicsAccountingDomainBuilder.Create;

  FRepositoryRegistryBuilder :=
    TFuelCharacteristicsAccountingRepositoryRegistryBuilder.Create;

  FSystemServiceRegistryBuilder :=
    TFuelCharacteristicsAccountingSystemServiceRegistryBuilder.Create;

  FPresentationServiceRegistryBuilder :=
    TFuelCharacteristicsAccountingPresentationServiceRegistryBuilder.Create;

  FBusinessServiceRegistryBuilder :=
    TFuelCharacteristicsAccountingBusinessServiceRegistryBuilder.Create;
    
end;

function TFuelCharacteristicsAccountingApplicationBuilder.
  CreateNullUserRoleAccount: TUserRoleAccount;
begin

  Result := TUserRoleAccount.Create;

  Result.UserFriendlyName := 'Тестовый пользователь';
  Result.RoleFriendlyName := 'Тестовая роль';
  
end;

destructor TFuelCharacteristicsAccountingApplicationBuilder.Destroy;
begin

  FreeAndNil(FDomainBuilder);
  FreeAndNil(FSystemServiceRegistryBuilder);
  FreeAndNil(FRepositoryRegistryBuilder);
  FreeAndNil(FPresentationServiceRegistryBuilder);

  inherited;

end;

function TFuelCharacteristicsAccountingApplicationBuilder.
  DomainBuilder: TFuelCharacteristicsAccountingDomainBuilder;
begin

  Result := FDomainBuilder;
  
end;

procedure TFuelCharacteristicsAccountingApplicationBuilder.
  EnsureZeosPostgresConnectionUsing;
begin

  if
    not Assigned(FDatabaseConnection) or
    not (FDatabaseConnection is TZConnection)
  then begin

    raise Exception.Create(
      'Программная ошибка. Не найдено ' +
      'соединение ZConnection'
    );

  end;

end;

function TFuelCharacteristicsAccountingApplicationBuilder.GetSelf: TObject;
begin

  Result := Self;
  
end;

function TFuelCharacteristicsAccountingApplicationBuilder.
  PresentationServiceRegistryBuilder:
    TFuelCharacteristicsAccountingPresentationServiceRegistryBuilder;
begin

  Result := FPresentationServiceRegistryBuilder;
  
end;

function TFuelCharacteristicsAccountingApplicationBuilder.
  RepositoryRegistryBuilder:
    TFuelCharacteristicsAccountingRepositoryRegistryBuilder;
begin

  Result := FRepositoryRegistryBuilder;
  
end;

procedure TFuelCharacteristicsAccountingApplicationBuilder.
  SetDefaultDomainBuildingOptionsIfNecessary(
    DomainBuildingOptions: IFuelCharacteristicsAccountingDomainBuildingOptions
  );
begin

  if not DomainBuildingOptions.Contains(TUseAbstractDirectoriesOption)
  then begin

    DomainBuildingOptions.Add(
      TUseDirectoriesBasedOnRepositoriesOption.Create
    );

  end;

  if not DomainBuildingOptions.Contains(TUseAbstractElectronicMetroshtokOption)
  then begin

    DomainBuildingOptions.Add(
      TUseMockRandomCalculationElectronicMetroshtokOption.Create(
        TFuelCharacteristicFloatValueRange.Create(
          -50, 70
        ),
        TFuelCharacteristicFloatValueRange.Create(
          700, 3050
        ),
        TFuelCharacteristicFloatValueRange.Create(
          530, 680
        ),
        TFuelCharacteristicFloatValueRange.Create(
          200, 600
        )
      )
    );
    
  end;
  
  if
    not
    DomainBuildingOptions.Contains(
      TUseAbstractReservoirCalibrationChartRegistryOption
    )
  then begin

    DomainBuildingOptions.Add(
      TUseMockReservoirCalibrationChartRegistryOption.Create(
        TVolumeRange.Create(35, 73135)
      )
    );
    
  end;

end;

procedure TFuelCharacteristicsAccountingApplicationBuilder.SetUserRoleAccount(
  const Value: TUserRoleAccount);
begin

  FreeAndNil(FUserRoleAccount);
  
  FUserRoleAccount := Value;

end;

function TFuelCharacteristicsAccountingApplicationBuilder.
  SystemServiceRegistryBuilder:
    TFuelCharacteristicsAccountingSystemServiceRegistryBuilder;
begin

  Result := FSystemServiceRegistryBuilder;
  
end;

function TFuelCharacteristicsAccountingApplicationBuilder.
  UseBasedOnZeosPostgresRoleDefaultAuthentificationService:
    TFuelCharacteristicsAccountingApplicationBuilder;
begin

  FSystemServiceRegistryBuilder.
    UseBasedOnZeosPostgresRoleAuthentificationService;

  Result := Self;

end;

function TFuelCharacteristicsAccountingApplicationBuilder.
  UseBasedOnZeosPostgresRoleDefaultLogOnInfoService:
    TFuelCharacteristicsAccountingApplicationBuilder;
begin

  EnsureZeosPostgresConnectionUsing;

  FSystemServiceRegistryBuilder
    .UseBasedOnZeosPostgresRoleEmployeeLogOnInfoService(
      TZConnection(FDatabaseConnection)
    );

  Result := Self;
  
end;

function TFuelCharacteristicsAccountingApplicationBuilder.
  UseBasedOnZeosPostgresRoleAuthentificationServiceOnly:
    TFuelCharacteristicsAccountingApplicationBuilder;

begin

  FApplicationServiceRegistries.Clear;

  FApplicationServiceRegistries.RegisterSystemServiceRegistry(
    FSystemServiceRegistryBuilder
      .ClearSystemServiceRegistry
      .UseBasedOnZeosPostgresRoleAuthentificationService
      .Build
  );

  Result := Self;

end;

function TFuelCharacteristicsAccountingApplicationBuilder.
  UseBasedOnZeosPostgresDefaultPresentationServices:
    TFuelCharacteristicsAccountingApplicationBuilder;
begin

  EnsureZeosPostgresConnectionUsing;

  FApplicationServiceRegistries.RegisterPresentationServiceRegistry(
    FPresentationServiceRegistryBuilder
      .ClearPresentationServiceRegistry
      .UseBasedOnZeosPostgresDefaultPresentationServices(
        TZConnection(FDatabaseConnection)
      ).Build
  );

  Result := Self;

end;

function TFuelCharacteristicsAccountingApplicationBuilder.
  UseBasedOnZeosPostgresDefaultRepositoryRegistry:
    TFuelCharacteristicsAccountingApplicationBuilder;
begin

  EnsureZeosPostgresConnectionUsing;

  FRepositoryRegistryBuilder
    .ClearRepositoryRegistry
    .UseBasedOnZeosPostgresTransactionSessionManager(
      TZConnection(FDatabaseConnection)
    )
    .UsePostgresRepositoriesWithOneZQueryExecutor(
      TZConnection(FDatabaseConnection)
    )
    .Build;

  Result := Self;

end;

function TFuelCharacteristicsAccountingApplicationBuilder.UseFullSuccessedStubAuthentificationServiceOnly: TFuelCharacteristicsAccountingApplicationBuilder;
begin

  FApplicationServiceRegistries.Clear;

  FApplicationServiceRegistries.RegisterSystemServiceRegistry(
    FSystemServiceRegistryBuilder
    .UseFullSuccessedStubSystemAuthentificationService
    .Build
  );

  Result := Self;
  
end;

function TFuelCharacteristicsAccountingApplicationBuilder.
  UseFullSuccessedStubServices: TFuelCharacteristicsAccountingApplicationBuilder;
begin

  FApplicationServiceRegistries.Clear;
  
  UseFullSuccessedStubSystemServiceRegistry;

  Result := Self;

end;

procedure TFuelCharacteristicsAccountingApplicationBuilder.UseFullSuccessedStubSystemServiceRegistry;
begin

  FApplicationServiceRegistries.RegisterSystemServiceRegistry(
    FSystemServiceRegistryBuilder
      .ClearSystemServiceRegistry
      .UseFullSuccessedStubSystemAuthentificationService
      .UseFullSuccessedStubSystemAuthorizationService
      .UseFullSuccessedStubSystemAdministrationService
      .Build
  );

end;

function TFuelCharacteristicsAccountingApplicationBuilder.
  UseStandardBusinessServices: TFuelCharacteristicsAccountingApplicationBuilder;
begin

  if not Assigned(FApplicationServiceRegistries.GetPresentationServiceRegistry)
  then begin

    raise Exception.Create(
      'Программная ошибка. Для использования ' +
      'стандартных бизнес-служб необходимо ' +
      'сформировать реестр служб представления'
    );
    
  end;
  
  FApplicationServiceRegistries.RegisterBusinessServiceRegistry(
    FBusinessServiceRegistryBuilder
      .ClearBusinessServiceRegistry
      .UseStandardBusinessServices(
        FApplicationServiceRegistries.GetPresentationServiceRegistry
      )
      .Build
  );

  Result := Self;

end;

function TFuelCharacteristicsAccountingApplicationBuilder.UseStandardDomain(
  DomainBuildingOptions: IFuelCharacteristicsAccountingDomainBuildingOptions
): TFuelCharacteristicsAccountingApplicationBuilder;
begin

  if not Assigned(DomainBuildingOptions) then begin

    DomainBuildingOptions :=
      TFuelCharacteristicsAccountingDomainBuildingOptions.Create;

  end;

  SetDefaultDomainBuildingOptionsIfNecessary(DomainBuildingOptions);

  FDomainBuilder
    .ClearDomain
    .BuildStandardDomain(DomainBuildingOptions);

  Result := Self;
  
end;

function TFuelCharacteristicsAccountingApplicationBuilder.
  UseStandardSystemServices: TFuelCharacteristicsAccountingApplicationBuilder;
begin

  if not Assigned(FApplicationServiceRegistries.GetPresentationServiceRegistry)
  then begin

    raise Exception.Create(
      'Программная ошибка. Для использования ' +
      'стандартных системных служб в приложении ' +
      'сначала необходимо сформировать реестр ' +
      'служб представления'
    );
    
  end;
  
  FApplicationServiceRegistries.RegisterSystemServiceRegistry(
    FSystemServiceRegistryBuilder
      .UseStandardSystemAuthorizationService
      .UseStandardSystemAdministrationService(
        FApplicationServiceRegistries.GetPresentationServiceRegistry,
        FApplicationServiceRegistries.GetBusinessServiceRegistry
      )
      .UseStandardEmployeeAccountsManagementService
      .Build
  );

  Result := Self;

end;

function TFuelCharacteristicsAccountingApplicationBuilder.
  UseZeosPostgresConnection(
    AuthentificationData: TUserDatabaseServerAuthentificationData
  ): TFuelCharacteristicsAccountingApplicationBuilder;
var ConnectionFactory: IConnectionFactory;
begin

  if Assigned(FDatabaseConnection) then
    FreeAndNil(FDatabaseConnection);
    
  ConnectionFactory := TZConnectionFactory.Create('postgresql');

  FDatabaseConnection :=
    TComponent(
      ConnectionFactory.CreateConnection(
        TConnectionInfo.Create(
          AuthentificationData.DatabaseServerInfo.Host,
          AuthentificationData.DatabaseServerInfo.Port,
          AuthentificationData.DatabaseServerInfo.Database,
          AuthentificationDAta.UserLogOnInfo.UserName,
          AuthentificationData.UserLogOnInfo.Password
        )
      )
    );

  Result := Self;

end;

end.
