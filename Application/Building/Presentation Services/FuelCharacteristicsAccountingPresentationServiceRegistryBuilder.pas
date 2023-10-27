unit FuelCharacteristicsAccountingPresentationServiceRegistryBuilder;

interface

uses

  FuelCharacteristicsAccountingPresentationServiceRegistry,
  FuelCharacteristicsCalculationCardSetReadService,
  ReservoirKindSetReadService,
  ReservoirKindReferenceSuiteSetReadService,
  EmployeeAccountSetReadService,
  FuelCharacteristicsAccountingRepositoryRegistry,
  FuelCharacteristicsCalculationCardDbSchema,
  ReservoirKindDbSchema,
  ReservoirKindReferenceSuiteDbSchema,
  EmployeeDbSchema,
  LogOnInfoDbSchema,
  RoleDbSchema,
  ZQueryExecutor,
  ZConnection,
  SysUtils,
  Classes;

type

  TFuelCharacteristicsAccountingPresentationServiceRegistryBuilder = class

    private

      FPresentationServiceRegistry:
        IFuelCharacteristicsAccountingPresentationServiceRegistry;

    private

      function CreateDefaultPostgresReservoirKindDbSchema:
        TReservoirKindDbSchema;
        
    public

      function UseFuelCharacteristicsCalculationCardSetReadService(
        FuelCharacteristicsCalculationCardSetReadService:
          IFuelCharacteristicsCalculationCardSetReadService
      ): TFuelCharacteristicsAccountingPresentationServiceRegistryBuilder;

      function UseReservoirKindSetReadService(
        ReservoirKindSetReadService: IReservoirKindSetReadService
      ): TFuelCharacteristicsAccountingPresentationServiceRegistryBuilder;

      function UseReservoirKindReferenceSuiteSetReadService(
        ReservoirKindReferenceSuiteSetReadService:
          IReservoirKindReferenceSuiteSetReadService
      ): TFuelCharacteristicsAccountingPresentationServiceRegistryBuilder;

      function UseEmployeeAccountSetReadService(
        EmployeeAccountSetReadService: IEmployeeAccountSetReadService
      ): TFuelCharacteristicsAccountingPresentationServiceRegistryBuilder;

    public

      function UseBasedOnZeosPostgresFuelCharacteristicsCalculationCardSetReadService(
        const Connection: TZConnection;

        FuelCharacteristicsCalculationCardDbSchema:
          TFuelCharacteristicsCalculationCardDbSchema = nil;

        EmployeeDbSchema: TEmployeeDbSchema = nil
          
      ): TFuelCharacteristicsAccountingPresentationServiceRegistryBuilder;

      function UseBasedOnZeosPostgresReservoirKindSetReadService(
        const Connection: TZConnection;
        ReservoirKindDbSchema: TReservoirKindDbSchema = nil
      ): TFuelCharacteristicsAccountingPresentationServiceRegistryBuilder;

      function UseBasedOnZeosPostgresReservoirKindReferenceSuiteSetReadService(
        const Connection: TZConnection;

        ReservoirKindReferenceSuiteDbSchema:
          TReservoirKindReferenceSuiteDbSchema = nil;

        ReservoirKindDbSchema: TReservoirKindDbSchema = nil

      ): TFuelCharacteristicsAccountingPresentationServiceRegistryBuilder;

      function UseBasedOnZeosPostgresEmployeeAccountSetReadService(
        const Connection: TZConnection;
        EmployeeDbSchema: TEmployeeDbSchema = nil;
        RoleDbSchema: TRoleDbSchema = nil;
        LogOnInfoDbSchema: TLogOnInfoDbSchema = nil
      ): TFuelCharacteristicsAccountingPresentationServiceRegistryBuilder;

    public

      constructor Create;

      function UseBasedOnZeosPostgresDefaultPresentationServices(
        const Connection: TZConnection
      ): TFuelCharacteristicsAccountingPresentationServiceRegistryBuilder;

      
      function ClearPresentationServiceRegistry:
        TFuelCharacteristicsAccountingPresentationServiceRegistryBuilder;

      function Build: IFuelCharacteristicsAccountingPresentationServiceRegistry;

  end;

implementation

uses

  StandardFuelCharacteristicsAccountingRepositoryRegistry,
  BasedOnDBFuelCharacteristicsCalculationCardSetReadService,
  BasedOnDBReservoirKindSetReadService,
  BasedOnDBReservoirKindReferenceSuiteSetReadService,
  BasedOnDBEmployeeAccountSetReadService,
  InMemoryFuelCharacteristicsAccountingPresentationServiceRegistry,

  EmployeeTableDefinition,
  EmployeeLogOnInfoTableDefinition,
  RoleTableDefinition,
  FuelCharacteristicsCalculationCardTableDefinition,
  ReservoirKindTableDefinition,
  StandardReservoirKindStorageServiceRegistry,
  StandardFuelCharacteristicsCalculationCardStorageServiceRegistry,
  ReservoirKindReferenceSuiteTableDefinition;

{ TFuelCharacteristicsAccountingPresentationServiceRegistryBuilder }

function TFuelCharacteristicsAccountingPresentationServiceRegistryBuilder.
  Build: IFuelCharacteristicsAccountingPresentationServiceRegistry;
begin

  Result := FPresentationServiceRegistry;
  
end;

function TFuelCharacteristicsAccountingPresentationServiceRegistryBuilder.
  ClearPresentationServiceRegistry:
    TFuelCharacteristicsAccountingPresentationServiceRegistryBuilder;
begin

  FPresentationServiceRegistry.Clear;

  Result := Self;
  
end;

constructor TFuelCharacteristicsAccountingPresentationServiceRegistryBuilder.
  Create;
begin

  FPresentationServiceRegistry :=
    TInMemoryFuelCharacteristicsAccountingPresentationServiceRegistry.Create;

end;

function TFuelCharacteristicsAccountingPresentationServiceRegistryBuilder.
  CreateDefaultPostgresReservoirKindDbSchema: TReservoirKindDbSchema;
begin

  Result := TReservoirKindDbSchema.Create;

  with Result do begin

    TableName := RESERVOIR_KIND_TABLE_NAME;

    ReservoirKindNameColumnName := RESERVOIR_KIND_TABLE_NAME_COLUMN_NAME;
    
  end;

end;

function TFuelCharacteristicsAccountingPresentationServiceRegistryBuilder.
  UseBasedOnZeosPostgresDefaultPresentationServices(
    const Connection: TZConnection
  ): TFuelCharacteristicsAccountingPresentationServiceRegistryBuilder;
begin

  UseBasedOnZeosPostgresFuelCharacteristicsCalculationCardSetReadService(
    Connection
  );

  UseBasedOnZeosPostgresReservoirKindSetReadService(Connection);
  UseBasedOnZeosPostgresReservoirKindReferenceSuiteSetReadService(Connection);
  UseBasedOnZeosPostgresEmployeeAccountSetReadService(Connection);

  Result := Self;
                 
end;

function TFuelCharacteristicsAccountingPresentationServiceRegistryBuilder.
  UseBasedOnZeosPostgresEmployeeAccountSetReadService(
    const Connection: TZConnection;
    EmployeeDbSchema: TEmployeeDbSchema;
    RoleDbSchema: TRoleDbSchema;
    LogOnInfoDbSchema: TLogOnInfoDbSchema
  ): TFuelCharacteristicsAccountingPresentationServiceRegistryBuilder;
begin

  if not Assigned(EmployeeDbSchema) then begin

    EmployeeDbSchema := TEmployeeDbSchema.Create;

    with EmployeeDbSchema do begin

      TableName := EMPLOYEE_TABLE_NAME;

      IdColumnName := EMPLOYEE_TABLE_ID_COLUMN_NAME;
      NameColumnName := EMPLOYEE_TABLE_NAME_COLUMN_NAME;
      SurnameColumnName := EMPLOYEE_TABLE_SURNAME_COLUMN_NAME;
      PatronymicColumnName := EMPLOYEE_TABLE_PATRONYMIC_COLUMN_NAME;
      SpecialityColumnName := EMPLOYEE_TABLE_SPECIALITY_COLUMN_NAME;
      BirthDateColumnName := EMPLOYEE_TABLE_BIRTH_DATE_COLUMN_NAME;
      RoleIdColumnName := EMPLOYEE_TABLE_ROLE_ID_COLUMN_NAME;

    end;

  end;

  if not Assigned(RoleDbSchema) then begin

    RoleDbSchema := TRoleDbSchema.Create;

    with RoleDbSchema do begin

      TableName := ROLE_TABLE_NAME;

      IdColumnName := ROLE_TABLE_ID_COLUMN_NAME;
      NameColumnName := ROLE_TABLE_NAME_COLUMN_NAME;
      DisplayColumnName := ROLE_TABLE_DISPLAY_NAME_COLUMN_NAME;

    end;
    
  end;

  if not Assigned(LogOnInfoDbSchema) then begin

    LogOnInfoDbSchema := TLogOnInfoDbSchema.Create;

    with LogOnInfoDbSchema do begin

      TableName := EMPLOYEE_LOGON_INFO_TABLE_NAME;

      EmployeeIdColumnName := EMPLOYEE_LOGON_INFO_TABLE_EMPLOYEE_ID_COLUMN_NAME;
      LoginColumnName := EMPLOYEE_LOGON_INFO_TABLE_LOGIN_COLUMN_NAME;
      PasswordColumnName := EMPLOYEE_LOGON_INFO_TABLE_PASSWORD_COLUMN_NAME;

    end;

  end;

  Result :=
    UseEmployeeAccountSetReadService(
      TBasedOnDBEmployeeAccountSetReadService.Create(
        EmployeeDbSchema,
        RoleDbSchema,
        LogOnInfoDbSchema,
        TZQueryExecutor.Create(Connection)
      )
    );

end;

function TFuelCharacteristicsAccountingPresentationServiceRegistryBuilder.
  UseBasedOnZeosPostgresFuelCharacteristicsCalculationCardSetReadService(
    const Connection: TZConnection;

    FuelCharacteristicsCalculationCardDbSchema:
      TFuelCharacteristicsCalculationCardDbSchema;

    EmployeeDbSchema: TEmployeeDbSchema
  ): TFuelCharacteristicsAccountingPresentationServiceRegistryBuilder;
begin

  if not Assigned(FuelCharacteristicsCalculationCardDbSchema) then begin

    FuelCharacteristicsCalculationCardDbSchema :=
      TFuelCharacteristicsCalculationCardDbSchema.Create;

    with FuelCharacteristicsCalculationCardDbSchema do begin

      TableName := FUEL_CHARACTERISTICS_CALCULATION_CARD_TABLE_NAME;
      
      IdColumnName := FUEL_CHARACTERISTICS_CALCULATION_CARD_TABLE_ID_COLUMN_NAME;
      TemperatureColumnName := FUEL_CHARACTERISTICS_CALCULATION_CARD_TABLE_TEMPERATURE_COLUMN_NAME;
      DensityColumnName := FUEL_CHARACTERISTICS_CALCULATION_CARD_TABLE_DENSITY_COLUMN_NAME;
      FuelRiseLevelColumnName := FUEL_CHARACTERISTICS_CALCULATION_CARD_TABLE_RISE_LEVEL_COLUMN_NAME;
      FuelMassColumnName := FUEL_CHARACTERISTICS_CALCULATION_CARD_TABLE_MASS_COLUMN_NAME;
      FuelKindColumnName := FUEL_CHARACTERISTICS_CALCULATION_CARD_TABLE_KIND_COLUMN_NAME;
      ReservoirNumberColumnName := FUEL_CHARACTERISTICS_CALCULATION_CARD_TABLE_RESERVOIR_NUMBER_COLUMN_NAME;
      PerformedCalculationEmployeeIdColumnName := FUEL_CHARACTERISTICS_CALCULATION_CARD_TABLE_CALCULATION_PERFORMER_ID_COLUMN_NAME;
      CalculationPerformingDateTimeColumnName := FUEL_CHARACTERISTICS_CALCULATION_CARD_TABLE_CALCULATION_PERFORMING_DATETIME_COLUMN_NAME;

    end;
    
  end;

  if not Assigned(EmployeeDbSchema) then begin

    EmployeeDbSchema := TEmployeeDbSchema.Create;

    with EmployeeDbSchema do begin

      TableName := EMPLOYEE_TABLE_NAME;

      IdColumnName := EMPLOYEE_TABLE_ID_COLUMN_NAME;
      NameColumnName := EMPLOYEE_TABLE_NAME_COLUMN_NAME;
      SurnameColumnName := EMPLOYEE_TABLE_SURNAME_COLUMN_NAME;
      PatronymicColumnName := EMPLOYEE_TABLE_PATRONYMIC_COLUMN_NAME;
      SpecialityColumnName := EMPLOYEE_TABLE_SPECIALITY_COLUMN_NAME;
      BirthDateColumnName := EMPLOYEE_TABLE_BIRTH_DATE_COLUMN_NAME;

    end;

  end;

  Result :=
    UseFuelCharacteristicsCalculationCardSetReadService(
      TBasedOnDBFuelCharacteristicsCalculationCardSetReadService.Create(

          TFuelCharacteristicsAccountingRepositoryRegistry
            .Current
              .GetEmployeeRepository,


          TFuelCharacteristicsCalculationCardStorageServiceRegistry
            .Current
              .GetFuelCharacteristicsCalculationCardDirectoryAccessService,

          FuelCharacteristicsCalculationCardDbSchema,
          EmployeeDbSchema,
          TZQueryExecutor.Create(Connection)

        )
    );

end;

function TFuelCharacteristicsAccountingPresentationServiceRegistryBuilder.
  UseBasedOnZeosPostgresReservoirKindReferenceSuiteSetReadService(
    const Connection: TZConnection;

    ReservoirKindReferenceSuiteDbSchema:
      TReservoirKindReferenceSuiteDbSchema;

    ReservoirKindDbSchema: TReservoirKindDbSchema
  ): TFuelCharacteristicsAccountingPresentationServiceRegistryBuilder;
begin

  if not Assigned(ReservoirKindDbSchema) then
    ReservoirKindDbSchema := CreateDefaultPostgresReservoirKindDbSchema;

  if not Assigned(ReservoirKindReferenceSuiteDbSchema) then begin

    ReservoirKindReferenceSuiteDbSchema :=
      TReservoirKindReferenceSuiteDbSchema.Create;

    with ReservoirKindReferenceSuiteDbSchema do begin

      TableName := RESERVOIR_KIND_REFERENCE_SUITE_TABLE_NAME;

      ReservoirKindNameColumnName :=
        RESERVOIR_KIND_REFERENCE_SUITE_TABLE_ID_COLUMN_NAME;

      AltitudinalConstantStencilColumnName :=
        RESERVOIR_KIND_REFERENCE_SUITE_TABLE_HSC_VALUE_COLUMN_NAME;

      CalibrationChartLocationColumnName :=
        RESERVOIR_KIND_REFERENCE_SUITE_TABLE_CALIBRATION_CHART_LOCATION;

    end;

  end;

  Result :=
    UseReservoirKindReferenceSuiteSetReadService(
      TBasedOnDBReservoirKindReferenceSuiteSetReadService.Create(
        ReservoirKindReferenceSuiteDbSchema,
        ReservoirKindDbSchema,
        TZQueryExecutor.Create(Connection)
      )
    );

end;

function TFuelCharacteristicsAccountingPresentationServiceRegistryBuilder.
  UseBasedOnZeosPostgresReservoirKindSetReadService(
    const Connection: TZConnection;
    ReservoirKindDbSchema: TReservoirKindDbSchema
  ): TFuelCharacteristicsAccountingPresentationServiceRegistryBuilder;
begin

  if not Assigned(ReservoirKindDbSchema) then
    ReservoirKindDbSchema := CreateDefaultPostgresReservoirKindDbSchema;

  Result :=
    UseReservoirKindSetReadService(
      TBasedOnDBReservoirKindSetReadService.Create(
        ReservoirKindDbSchema,
        TZQueryExecutor.Create(Connection)
      )
    );

end;

function TFuelCharacteristicsAccountingPresentationServiceRegistryBuilder.
  UseEmployeeAccountSetReadService(
    EmployeeAccountSetReadService: IEmployeeAccountSetReadService
  ): TFuelCharacteristicsAccountingPresentationServiceRegistryBuilder;
begin

  FPresentationServiceRegistry.RegisterEmployeeAccountSetReadService(
    EmployeeAccountSetReadService
  );

  Result := Self;
  
end;

function TFuelCharacteristicsAccountingPresentationServiceRegistryBuilder.
  UseFuelCharacteristicsCalculationCardSetReadService(
    FuelCharacteristicsCalculationCardSetReadService:
      IFuelCharacteristicsCalculationCardSetReadService
  ): TFuelCharacteristicsAccountingPresentationServiceRegistryBuilder;
begin

  FPresentationServiceRegistry.
    RegisterFuelCharacteristicsCalculationCardSetReadService(
      FuelCharacteristicsCalculationCardSetReadService
    );

  Result := Self;

end;

function TFuelCharacteristicsAccountingPresentationServiceRegistryBuilder.
  UseReservoirKindReferenceSuiteSetReadService(
    ReservoirKindReferenceSuiteSetReadService:
      IReservoirKindReferenceSuiteSetReadService
  ): TFuelCharacteristicsAccountingPresentationServiceRegistryBuilder;
begin

  FPresentationServiceRegistry.
    RegisterReservoirKindReferenceSuiteSetReadService(
      ReservoirKindReferenceSuiteSetReadService
    );

  Result := Self;

end;

function TFuelCharacteristicsAccountingPresentationServiceRegistryBuilder.
  UseReservoirKindSetReadService(
    ReservoirKindSetReadService: IReservoirKindSetReadService
  ): TFuelCharacteristicsAccountingPresentationServiceRegistryBuilder;
begin

  FPresentationServiceRegistry.RegisterReservoirKindSetReadService(
    ReservoirKindSetReadService
  );

  Result := Self;
  
end;

end.
