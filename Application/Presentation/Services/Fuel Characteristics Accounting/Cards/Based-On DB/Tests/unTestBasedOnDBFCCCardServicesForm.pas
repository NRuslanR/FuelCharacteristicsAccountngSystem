unit unTestBasedOnDBFCCCardServicesForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,
  FuelCharacteristicsCalculationCardSetReadService,
  BasedOnDBFuelCharacteristicsCalculationCardSetReadService,
  FuelCharacteristicsCalculationCardDbSchema,
  FuelCharacteristicsCalculationCardSetHolder,
  EmployeePostgresRepository,
  RolePostgresRepository,
  StandardFuelCharacteristicsCalculationCardDirectoryAccessService,
  EmployeeDbSchema,
  StandardFuelCharacteristicsAccountingRepositoryRegistry,
  QueryExecutor,
  AbstractQueryExecutor,
  ConnectionFactory,
  ZConnectionFactory,
  ConnectionInfo,
  QueryExecutorFactory,
  ZQueryExecutorFactory;

type
  TBasedOnDBFCCCardServices = class(TForm)
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);

  private

    FQueryExecutor: IQueryExecutor;
    
    procedure InitializeRepositoryRegistry(
      QueryExecutor: IQueryExecutor
    );
    
    function CreateFuelCharacteristicsCalculationCardSetReadService:
      IFuelCharacteristicsCalculationCardSetReadService;

  public

  end;

var
  BasedOnDBFCCCardServices: TBasedOnDBFCCCardServices;

implementation

uses

  AuxDebugFunctionsUnit;

{$R *.dfm}

procedure TBasedOnDBFCCCardServices.Button1Click(Sender: TObject);
var Service: IFuelCharacteristicsCalculationCardSetReadService;
    CardSetHolder: TFuelCharacteristicsCalculationCardSetHolder;
begin

  Service := CreateFuelCharacteristicsCalculationCardSetReadService;

  CardSetHolder :=
    Service.GetFuelCharacteristicsCalculationCardSetForEmployee(22);

  DebugOutput(CardSetHolder.RecordCount);
  
end;

function TBasedOnDBFCCCardServices.CreateFuelCharacteristicsCalculationCardSetReadService: IFuelCharacteristicsCalculationCardSetReadService;
var
    FCCCardDbSchema: TFuelCharacteristicsCalculationCardDbSchema;
    EmpDbSchema: TEmployeeDbSchema;
begin

  FCCCardDbSchema :=
    TFuelCharacteristicsCalculationCardDbSchema.Create;

  with FCCCardDbSchema do begin

    TableName := 'fca.fuel_characteristics_calculation_cards';
    IdColumnName := 'card_id';
    TemperatureColumnName := 'fuel_temperature';
    DensityColumnName := 'fuel_density';
    FuelRiseLevelColumnName := 'fuel_rise_level';
    FuelVolumeColumnName := 'fuel_volume';
    FuelKindColumnName := 'fuel_kind';
    ReservoirNumberColumnName := 'reservoir_number';
    PerformedCalculationEmployeeIdColumnName := 'calculation_performer_id';
    CalculationPerformingDateTimeColumnName := 'calculation_performing_datetime';
    
  end;

  EmpDbSchema := TEmployeeDbSchema.Create;

  with EmpDbSchema do begin

    TableName := 'fca.employees';
    IdColumnName := 'employee_id';
    NameColumnName := 'name';
    SurnameColumnName := 'surname';
    BirthDateColumnName := 'birth_date';
    PatronymicColumnName := 'patronymic';
    SpecialityColumnName := 'speciality';

  end;

  Result :=
    TBasedOnDBFuelCharacteristicsCalculationCardSetReadService.Create(

      TFuelCharacteristicsAccountingRepositoryRegistry
        .Current
          .GetEmployeeRepository,

      TStandardFuelCharacteristicsCalculationCardDirectoryAccessService.Create,
      FCCCardDbSchema,
      EmpDbSchema,
      TAbstractQueryExecutor(FQueryExecutor.Self)
    );
    
end;

procedure TBasedOnDBFCCCardServices.FormCreate(Sender: TObject);
var QueryExecutorFactory: IQueryExecutorFactory;
    ConnectionFactory: IConnectionFactory;
begin

  ConnectionFactory :=
    TZConnectionFactory.Create('pooled.postgresql');

  QueryExecutorFactory :=
    TZQueryExecutorFactory.Create(ConnectionFactory);

  FQueryExecutor :=
    QueryExecutorFactory.CreateQueryExecutor(
      TConnectionInfo.Create(
        'localhost',
        5432,
        'fca',
        'test_user',
        '123456'
      )
    );

  InitializeRepositoryRegistry(FQueryExecutor);

end;

procedure TBasedOnDBFCCCardServices.InitializeRepositoryRegistry(
  QueryExecutor: IQueryExecutor
);
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
      
end;

end.
