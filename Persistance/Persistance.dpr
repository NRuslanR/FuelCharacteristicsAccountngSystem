program Persistance;

uses
  Forms,
  unPersistanceForm in 'unPersistanceForm.pas' {RepositoryTestForm},
  AbstractRepositoryUnit in 'C:\Common Delphi Libs\u_59968 Delphi Modules\Repositories and Domain\Repositories\AbstractRepositoryUnit.pas',
  AbstractDBRepositoryUnit in 'C:\Common Delphi Libs\u_59968 Delphi Modules\Repositories and Domain\Repositories\AbstractDBRepositoryUnit.pas',
  ZQueryExecutor in 'C:\Common Delphi Libs\u_59968 Delphi Modules\Query Executors\DataSet-Based Executors\Zeos-Based\ZQueryExecutor.pas',
  ZQueryExecutorFactory in 'C:\Common Delphi Libs\u_59968 Delphi Modules\Query Executors\DataSet-Based Executors\Zeos-Based\ZQueryExecutorFactory.pas',
  DataSetDataReader in 'C:\Common Delphi Libs\u_59968 Delphi Modules\Query Executors\DataSet-Based Executors\DataSetDataReader.pas',
  AbstractDataReader in 'C:\Common Delphi Libs\u_59968 Delphi Modules\Query Executors\AbstractDataReader.pas',
  DataReader in 'C:\Common Delphi Libs\u_59968 Delphi Modules\Query Executors\Interfaces\DataReader.pas',
  QueryExecutor in 'C:\Common Delphi Libs\u_59968 Delphi Modules\Query Executors\Interfaces\QueryExecutor.pas',
  QueryExecutorFactory in 'C:\Common Delphi Libs\u_59968 Delphi Modules\Query Executors\Interfaces\QueryExecutorFactory.pas',
  DomainObjectCompiler in 'C:\Common Delphi Libs\u_59968 Delphi Modules\Repositories and Domain\Repositories\DomainObjectCompiler.pas',
  AbstractPostgresRepositoryUnit in 'C:\Common Delphi Libs\u_59968 Delphi Modules\Repositories and Domain\Repositories\AbstractPostgresRepositoryUnit.pas',
  EmployeePostgresRepository in 'Repositories\Personnel Management\SQL\Postgres\EmployeePostgresRepository.pas',
  RolePostgresRepository in 'Repositories\Personnel Management\SQL\Postgres\RolePostgresRepository.pas',
  RoleTableDefinition in 'Repositories\Personnel Management\SQL\Postgres\Schema\RoleTableDefinition.pas',
  SchemaDefinition in 'Repositories\Personnel Management\SQL\Postgres\Schema\SchemaDefinition.pas',
  EmployeeTableDefinition in 'Repositories\Personnel Management\SQL\Postgres\Schema\EmployeeTableDefinition.pas',
  DomainObjectRepository in 'C:\Common Delphi Libs\u_59968 Delphi Modules\Repositories and Domain\Repositories\Interfaces\DomainObjectRepository.pas',
  DomainObjectRepositoryRegistry in 'C:\Common Delphi Libs\u_59968 Delphi Modules\Repositories and Domain\Repositories\Interfaces\DomainObjectRepositoryRegistry.pas',
  StandardDomainObjectRepositoryRegistry in 'C:\Common Delphi Libs\u_59968 Delphi Modules\Repositories and Domain\Repositories\StandardDomainObjectRepositoryRegistry.pas',
  FuelCharacteristicsAccountingRepositoryRegistry in 'Repositories\Registries\FuelCharacteristicsAccountingRepositoryRegistry.pas',
  RoleRepository in 'Repositories\Personnel Management\Interfaces\RoleRepository.pas',
  EmployeeRepository in 'Repositories\Personnel Management\Interfaces\EmployeeRepository.pas',
  StandardFuelCharacteristicsAccountingRepositoryRegistry in 'Repositories\Registries\StandardFuelCharacteristicsAccountingRepositoryRegistry.pas',
  FuelCharacteristicsCalculationCardRepository in 'Repositories\Fuel Characteristics Accounting\Interfaces\FuelCharacteristicsCalculationCardRepository.pas',
  FuelCharacteristicsCalculationCardPostgresRepository in 'Repositories\Fuel Characteristics Accounting\SQL\Postgres\FuelCharacteristicsCalculationCardPostgresRepository.pas',
  FuelCharacteristicsCalculationCardTableDefinition in 'Repositories\Fuel Characteristics Accounting\SQL\Postgres\Schema\FuelCharacteristicsCalculationCardTableDefinition.pas',
  BasedOnRepositoryFuelCharacteristicsCalculationCardDirectory in 'Services\Fuel Characteristics Accounting\Cards\BasedOnRepositoryFuelCharacteristicsCalculationCardDirectory.pas',
  ReservoirKindReferenceSuiteRepository in 'Repositories\Fuel Characteristics Accounting\Interfaces\ReservoirKindReferenceSuiteRepository.pas',
  ReservoirKindReferenceSuitePostgresRepository in 'Repositories\Fuel Characteristics Accounting\SQL\Postgres\ReservoirKindReferenceSuitePostgresRepository.pas',
  ReservoirKindReferenceSuiteTableDefinition in 'Repositories\Fuel Characteristics Accounting\SQL\Postgres\Schema\ReservoirKindReferenceSuiteTableDefinition.pas',
  ReservoirKindRepository in 'Repositories\Fuel Characteristics Accounting\Interfaces\ReservoirKindRepository.pas',
  ReservoirKindPostgresRepository in 'Repositories\Fuel Characteristics Accounting\SQL\Postgres\ReservoirKindPostgresRepository.pas',
  ReservoirKindTableDefinition in 'Repositories\Fuel Characteristics Accounting\SQL\Postgres\Schema\ReservoirKindTableDefinition.pas',
  BasedOnRepositoryReservoirKindReferenceSuiteDirectory in 'Services\Fuel Characteristics Accounting\References\Reservoir Kinds\BasedOnRepositoryReservoirKindReferenceSuiteDirectory.pas',
  BasedOnRepositoryReservoirKindDirectory in 'Services\Fuel Characteristics Accounting\References\Reservoir Kinds\BasedOnRepositoryReservoirKindDirectory.pas',
  WorkingTimeConditionsRepository in 'Repositories\Personnel Management\Interfaces\WorkingTimeConditionsRepository.pas',
  WorkingTimeConditionsPostgresRepository in 'Repositories\Personnel Management\SQL\Postgres\WorkingTimeConditionsPostgresRepository.pas',
  WorkingTimeConditionsTableDefinition in 'Repositories\Personnel Management\SQL\Postgres\Schema\WorkingTimeConditionsTableDefinition.pas',
  BasedOnRepositoryWorkingTimeConditionsDirectory in 'Services\Personnel Management\BasedOnRepositoryWorkingTimeConditionsDirectory.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TRepositoryTestForm, RepositoryTestForm);
  Application.Run;
end.
