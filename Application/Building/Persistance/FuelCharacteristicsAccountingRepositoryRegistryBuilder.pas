unit FuelCharacteristicsAccountingRepositoryRegistryBuilder;

interface

uses

  FuelCharacteristicsAccountingRepositoryRegistry,
  StandardFuelCharacteristicsAccountingRepositoryRegistry,
  QueryExecutor,
  QueryExecutorFactory,
  ZQueryExecutor,
  ConnectionInfo,
  ZQueryExecutorFactory,
  ConnectionFactory,
  ZConnectionFactory,
  ZConnection,
  Classes;

type

  TFuelCharacteristicsAccountingRepositoryRegistryBuilder = class

    public

      function UseBasedOnZeosPostgresTransactionSessionManager(
        const Connection: TZConnection
      ): TFuelCharacteristicsAccountingRepositoryRegistryBuilder;
      
      function UsePostgresRepositoriesWithOneQueryExecutor(
        QueryExecutor: IQueryExecutor
      ): TFuelCharacteristicsAccountingRepositoryRegistryBuilder;

      function UsePostgresRepositoriesBasedOnQueryExecutorFactory(
        QueryExecutorFactory: IQueryExecutorFactory;
        const Connection: TComponent
      ): TFuelCharacteristicsAccountingRepositoryRegistryBuilder;

      function UsePostgresRepositoriesWithOneZQueryExecutor(
        const Connection: TZConnection;
        const ClientCodePage: String = ''
      ): TFuelCharacteristicsAccountingRepositoryRegistryBuilder;

      function UsePostgresRepositoriesBasedOnZQueryExecutorFactory(
        const Connection: TZConnection;
        const ClientCodePage: String = ''
      ): TFuelCharacteristicsAccountingRepositoryRegistryBuilder;

    public

      function ClearRepositoryRegistry:
        TFuelCharacteristicsAccountingRepositoryRegistryBuilder;
      
      function Build: IFuelCharacteristicsAccountingRepositoryRegistry;

  end;
  
implementation

uses

  StrUtils,
  ZeosPostgresTransactionUnit,
  AuxZeosFunctions,
  RolePostgresRepository,
  EmployeePostgresRepository,
  WorkingTimeConditionsPostgresRepository,
  FuelCharacteristicsCalculationCardPostgresRepository,
  ReservoirKindPostgresRepository,
  ReservoirKindReferenceSuitePostgresRepository;
  
{ TFuelCharacteristicsAccountingRepositoryRegistryBuilder }

function TFuelCharacteristicsAccountingRepositoryRegistryBuilder.
  Build: IFuelCharacteristicsAccountingRepositoryRegistry;
begin

  Result := TFuelCharacteristicsAccountingRepositoryRegistry.Current;
  
end;

function TFuelCharacteristicsAccountingRepositoryRegistryBuilder.
  ClearRepositoryRegistry: TFuelCharacteristicsAccountingRepositoryRegistryBuilder;
begin

  TFuelCharacteristicsAccountingRepositoryRegistry
    .Current
      .Clear;

  Result := Self;
  
end;

function TFuelCharacteristicsAccountingRepositoryRegistryBuilder.
  UseBasedOnZeosPostgresTransactionSessionManager(
    const Connection: TZConnection
  ): TFuelCharacteristicsAccountingRepositoryRegistryBuilder;
begin

  TFuelCharacteristicsAccountingRepositoryRegistry
    .Current
      .RegisterSessionManager(
        TZeosPostgresTransaction.Create(Connection)
      );
      
  Result := Self;
  
end;

function TFuelCharacteristicsAccountingRepositoryRegistryBuilder.
  UsePostgresRepositoriesBasedOnQueryExecutorFactory(
    QueryExecutorFactory: IQueryExecutorFactory;
    const Connection: TComponent
  ): TFuelCharacteristicsAccountingRepositoryRegistryBuilder;
begin


  TFuelCharacteristicsAccountingRepositoryRegistry
    .Current
      .RegisterRoleRepository(
        TRolePostgresRepository.Create(
          QueryExecutorFactory.CreateQueryExecutor(Connection)
        )
      );

  TFuelCharacteristicsAccountingRepositoryRegistry
    .Current
      .RegisterEmployeeRepository(
        TEmployeePostgresRepository.Create(
          QueryExecutorFactory.CreateQueryExecutor(Connection)
        )
      );

  TFuelCharacteristicsAccountingRepositoryRegistry
    .Current
      .RegisterFuelCharacteristicsCalculationCardRepository(
        TFuelCharacteristicsCalculationCardPostgresRepository.Create(
          QueryExecutorFactory.CreateQueryExecutor(Connection)
        )
      );

  TFuelCharacteristicsAccountingRepositoryRegistry
    .Current
      .RegisterReservoirKindRepository(
        TReservoirKindPostgresRepository.Create(
          QueryExecutorFactory.CreateQueryExecutor(Connection)
        )
      );

  TFuelCharacteristicsAccountingRepositoryRegistry
    .Current
      .RegisterReservoirKindReferenceSuiteRepository(
        TReservoirKindReferenceSuitePostgresRepository.Create(
          QueryExecutorFactory.CreateQueryExecutor(Connection)
        )
      );

  TFuelCharacteristicsAccountingRepositoryRegistry
    .Current
      .RegisterWorkingTimeConditionsRepository(
        TWorkingTimeConditionsPostgresRepository.Create(
          QueryExecutorFactory.CreateQueryExecutor(Connection)
        )
      );

  Result := Self;
      
end;

function TFuelCharacteristicsAccountingRepositoryRegistryBuilder.
  UsePostgresRepositoriesBasedOnZQueryExecutorFactory(
    const Connection: TZConnection;
    const ClientCodePage: String
  ): TFuelCharacteristicsAccountingRepositoryRegistryBuilder;
var QueryExecutorFactory: IQueryExecutorFactory;
    ConnectionFactory: IConnectionFactory;
begin

  ConnectionFactory := TZConnectionFactory.Create('postgresql', ClientCodePage);
  QueryExecutorFactory := TZQueryExecutorFactory.Create(ConnectionFactory);

  Result :=
    UsePostgresRepositoriesBasedOnQueryExecutorFactory(
      QueryExecutorFactory, Connection
    );

end;

function TFuelCharacteristicsAccountingRepositoryRegistryBuilder.
  UsePostgresRepositoriesWithOneQueryExecutor(
    QueryExecutor: IQueryExecutor
  ): TFuelCharacteristicsAccountingRepositoryRegistryBuilder;
begin

  TFuelCharacteristicsAccountingRepositoryRegistry
    .Current
      .RegisterRoleRepository(
        TRolePostgresRepository.Create(QueryExecutor)
      );

  TFuelCharacteristicsAccountingRepositoryRegistry
    .Current
      .RegisterEmployeeRepository(
        TEmployeePostgresRepository.Create(QueryExecutor)
      );

  TFuelCharacteristicsAccountingRepositoryRegistry
    .Current
      .RegisterFuelCharacteristicsCalculationCardRepository(
        TFuelCharacteristicsCalculationCardPostgresRepository.Create(
          QueryExecutor
        )
      );

  TFuelCharacteristicsAccountingRepositoryRegistry
    .Current
      .RegisterReservoirKindRepository(
        TReservoirKindPostgresRepository.Create(QueryExecutor)
      );

  TFuelCharacteristicsAccountingRepositoryRegistry
    .Current
      .RegisterReservoirKindReferenceSuiteRepository(
        TReservoirKindReferenceSuitePostgresRepository.Create(
          QueryExecutor
        )
      );

  TFuelCharacteristicsAccountingRepositoryRegistry
    .Current
      .RegisterWorkingTimeConditionsRepository(
        TWorkingTimeConditionsPostgresRepository.Create(
          QueryExecutor
        )
      );

  Result := Self;
      
end;


function TFuelCharacteristicsAccountingRepositoryRegistryBuilder.
  UsePostgresRepositoriesWithOneZQueryExecutor(
    const Connection: TZConnection;
    const ClientCodePage: String
  ): TFuelCharacteristicsAccountingRepositoryRegistryBuilder;
var QueryExecutorFactory: IQueryExecutorFactory;
    ConnectionFactory: IConnectionFactory;
begin

  ConnectionFactory := TZConnectionFactory.Create('postgresql', ClientCodePage);
  QueryExecutorFactory := TZQueryExecutorFactory.Create(ConnectionFactory);

  Result :=
    UsePostgresRepositoriesWithOneQueryExecutor(
      QueryExecutorFactory.CreateQueryExecutor(Connection)
    );
  
end;

end.
