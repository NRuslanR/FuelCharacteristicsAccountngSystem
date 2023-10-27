unit BasedOnDBFuelCharacteristicsCalculationCardSetReadService;

interface

uses

  AbstractFuelCharacteristicsCalculationCardSetReadService,
  FuelCharacteristicsCalculationCardSetHolder,
  FuelCharacteristicsCalculationCardDbSchema,
  EmployeeDbSchema,
  AbstractQueryExecutor,
  QueryExecutor,
  VariantListUnit,
  DataReader,
  AbstractDataReader,
  EmployeeRepository,
  FuelCharacteristicsCalculationCardDirectoryAccessService,
  DB,
  SysUtils,
  Classes;

const

  PERFORMED_CALCULATION_EMPLOYEE_FULL_NAME_FIELD_NAME_ALIAS =
    'performer_full_name';

  CAN_BE_CHANGED_FIELD_NAME = 'can_be_changed';
  CAN_BE_REMOVED_FIELD_NAME = 'can_be_removed';
    
type

  TBasedOnDBFuelCharacteristicsCalculationCardSetReadService =
    class (TAbstractFuelCharacteristicsCalculationCardSetReadService)

      protected

        FFetchingFuelCharacteristicsCalculationCardSetQueryPattern: String;

      protected

        FFuelCharacteristicsCalculationCardDbSchema:
            TFuelCharacteristicsCalculationCardDbSchema;

        FEmployeeDbSchema: TEmployeeDbSchema;

        FQueryExecutor: TAbstractQueryExecutor;

      protected

        function InternalGetFuelCharacteristicsCalculationCardSetForEmployee(
          const AllowedPerformerIdentities: TVariantList
        ): TFuelCharacteristicsCalculationCardSetHolder; override;

        function PrepareFetchingFuelCharacteristicsCalculationCardSetQueryPattern(
          FuelCharacteristicsCalculationCardDbSchema:
            TFuelCharacteristicsCalculationCardDbSchema;

          EmployeeDbSchema: TEmployeeDbSchema
        ): String; virtual;

        function ExecuteFetchingFuelCharacteristicsCalculationCardSetQuery(
          const FetchingFuelCharacteristicsCalculationCardSetQueryPattern: String;
          const AllowedPerformerIdentities: TVariantList
        ): TDataSet; virtual;

        function CreateFuelCharacteristicsCalculationCardSetFieldDefsFrom(
          FuelCharacteristicsCalculationCardSet: TDataSet;

          FuelCharacteristicsCalculationCardDbSchema:
            TFuelCharacteristicsCalculationCardDbSchema;

          EmployeeDbSchema: TEmployeeDbSchema
        ): TFuelCharacteristicsCalculationCardSetFieldDefs; virtual;

        procedure CustomizeFuelCharacteristicsCalculationCardSetHolder(
          CardSetHolder: TFuelCharacteristicsCalculationCardSetHolder
        ); virtual;

      public

        constructor Create(

          EmployeeRepository: IEmployeeRepository;

          FuelCharacteristicsCalculationCardDirectoryAccessService:
            IFuelCharacteristicsCalculationCardDirectoryAccessService;
            
          FuelCharacteristicsCalculationCardDbSchema:
            TFuelCharacteristicsCalculationCardDbSchema;

          EmployeeDbSchema: TEmployeeDbSchema;

          QueryExecutor: TAbstractQueryExecutor
        );

    end;
  

implementation

uses

  AuxDebugFunctionsUnit,
  AuxiliaryStringFunctions;
  
{ TBasedOnDBFuelCharacteristicsCalculationCardSetReadService }

constructor TBasedOnDBFuelCharacteristicsCalculationCardSetReadService.Create(
  EmployeeRepository: IEmployeeRepository;

  FuelCharacteristicsCalculationCardDirectoryAccessService:
    IFuelCharacteristicsCalculationCardDirectoryAccessService;
            
  FuelCharacteristicsCalculationCardDbSchema:
    TFuelCharacteristicsCalculationCardDbSchema;

  EmployeeDbSchema: TEmployeeDbSchema;

  QueryExecutor: TAbstractQueryExecutor
);
begin

  inherited Create(
    EmployeeRepository,
    FuelCharacteristicsCalculationCardDirectoryAccessService
  );

  FFuelCharacteristicsCalculationCardDbSchema :=
    FuelCharacteristicsCalculationCardDbSchema;

  FEmployeeDbSchema := EmployeeDbSchema;

  FQueryExecutor := QueryExecutor;

  FFetchingFuelCharacteristicsCalculationCardSetQueryPattern :=
    PrepareFetchingFuelCharacteristicsCalculationCardSetQueryPattern(
      FFuelCharacteristicsCalculationCardDbSchema,
      FEmployeeDbSchema
    );
    
end;

function TBasedOnDBFuelCharacteristicsCalculationCardSetReadService.
  CreateFuelCharacteristicsCalculationCardSetFieldDefsFrom(
    FuelCharacteristicsCalculationCardSet: TDataSet;
    FuelCharacteristicsCalculationCardDbSchema: TFuelCharacteristicsCalculationCardDbSchema;
    EmployeeDbSchema: TEmployeeDbSchema
  ): TFuelCharacteristicsCalculationCardSetFieldDefs;
begin

  Result := TFuelCharacteristicsCalculationCardSetFieldDefs.Create;

  try

    Result.RecordIdFieldName :=
      FuelCharacteristicsCalculationCardDbSchema.IdColumnName;

    Result.TemperatureFieldName :=
      FuelCharacteristicsCalculationCardDbSchema.TemperatureColumnName;

    Result.DensityFieldName :=
      FuelCharacteristicsCalculationCardDbSchema.DensityColumnName;

    Result.FuelRiseLevelFieldName :=
      FuelCharacteristicsCalculationCardDbSchema.FuelRiseLevelColumnName;

    Result.FuelMassFieldName :=
      FuelCharacteristicsCalculationCardDbSchema.FuelMassColumnName;

    Result.FuelKindFieldName :=
      FuelCharacteristicsCalculationCardDbSchema.FuelKindColumnName;

    Result.ReservoirNumberFieldName :=
      FuelCharacteristicsCalculationCardDbSchema.ReservoirNumberColumnName;

    Result.PerformedCalculationEmployeeIdFieldName :=
      FuelCharacteristicsCalculationCardDbSchema
        .PerformedCalculationEmployeeIdColumnName;

    Result.CalculationPerformingDateTimeFieldName :=
      FuelCharacteristicsCalculationCardDbSchema
        .CalculationPerformingDateTimeColumnName;

    Result.PerformedCalculationEmployeeNameFieldName :=
      PERFORMED_CALCULATION_EMPLOYEE_FULL_NAME_FIELD_NAME_ALIAS;

    Result.CanBeChangedFieldName := CAN_BE_CHANGED_FIELD_NAME;
    Result.CanBeRemovedFieldName := CAN_BE_REMOVED_FIELD_NAME;
      
  except

    on e: Exception do begin

      FreeAndNil(Result);

      raise;
      
    end;

  end;

end;

procedure TBasedOnDBFuelCharacteristicsCalculationCardSetReadService.
  CustomizeFuelCharacteristicsCalculationCardSetHolder(
    CardSetHolder: TFuelCharacteristicsCalculationCardSetHolder
  );
begin

  with  CardSetHolder.DataSet, CardSetHolder.FieldDefs do begin

    FieldByName(CanBeChangedFieldName).ReadOnly := False;
    FieldByName(CanBeRemovedFieldName).ReadOnly := False;
    
  end;

end;

function TBasedOnDBFuelCharacteristicsCalculationCardSetReadService.
  ExecuteFetchingFuelCharacteristicsCalculationCardSetQuery(
    const FetchingFuelCharacteristicsCalculationCardSetQueryPattern: String;
    const AllowedPerformerIdentities: TVariantList
  ): TDataSet;
var QueryText: String;
    DataReader: IDataReader;
begin

  if not AllowedPerformerIdentities.IsEmpty then begin

    QueryText :=
      FetchingFuelCharacteristicsCalculationCardSetQueryPattern +
      ' WHERE A.' +

      FFuelCharacteristicsCalculationCardDbSchema
        .PerformedCalculationEmployeeIdColumnName +

      ' IN (' + CreateStringFromVariantList(AllowedPerformerIdentities) + ')';

  end

  else QueryText := FetchingFuelCharacteristicsCalculationCardSetQueryPattern;
    
  DataReader := FQueryExecutor.ExecuteSelectionQuery(QueryText);

  Result := TAbstractDataReader(DataReader.Self).ToDataSet;

end;

function TBasedOnDBFuelCharacteristicsCalculationCardSetReadService.
  InternalGetFuelCharacteristicsCalculationCardSetForEmployee(
    const AllowedPerformerIdentities: TVariantList
  ): TFuelCharacteristicsCalculationCardSetHolder;
var FieldDefs: TFuelCharacteristicsCalculationCardSetFieldDefs;
    DataSet: TDataSet;
begin

  FieldDefs := nil;
  DataSet := nil;

  try

    DataSet :=
      ExecuteFetchingFuelCharacteristicsCalculationCardSetQuery(
        FFetchingFuelCharacteristicsCalculationCardSetQueryPattern,
        AllowedPerformerIdentities
      );
    
    FieldDefs :=
      CreateFuelCharacteristicsCalculationCardSetFieldDefsFrom(
        DataSet,
        FFuelCharacteristicsCalculationCardDbSchema,
        FEmployeeDbSchema
      );

    Result :=
      TFuelCharacteristicsCalculationCardSetHolder.CreateFrom(
        DataSet, FieldDefs
      );

    CustomizeFuelCharacteristicsCalculationCardSetHolder(Result);

  except

    on e: Exception do begin

      FreeAndNil(DataSet);
      FreeAndNil(FieldDefs);

      raise;
      
    end;

  end;

end;

function TBasedOnDBFuelCharacteristicsCalculationCardSetReadService.
  PrepareFetchingFuelCharacteristicsCalculationCardSetQueryPattern(
    FuelCharacteristicsCalculationCardDbSchema: TFuelCharacteristicsCalculationCardDbSchema;
    EmployeeDbSchema: TEmployeeDbSchema
  ): String;
begin
                
  Result :=
    Format(
      'SELECT ' +
      'A.%s,A.%s,A.%s,A.%s,A.%s,A.%s,A.%s,A.%s,A.%s,' +
      '(%s || '' '' || %s || '' '' || %s) as ' +
      PERFORMED_CALCULATION_EMPLOYEE_FULL_NAME_FIELD_NAME_ALIAS + ',' +
      'null as ' + CAN_BE_CHANGED_FIELD_NAME + ',' +
      'null as ' + CAN_BE_REMOVED_FIELD_NAME + ' ' +
      'FROM %s A ' +
      'JOIN %s B ON A.%s=B.%s',
      [
        FuelCharacteristicsCalculationCardDbSchema.IdColumnName,
        FuelCharacteristicsCalculationCardDbSchema.TemperatureColumnName,
        FuelCharacteristicsCalculationCardDbSchema.DensityColumnName,
        FuelCharacteristicsCalculationCardDbSchema.FuelRiseLevelColumnName,
        FuelCharacteristicsCalculationCardDbSchema.FuelMassColumnName,
        FuelCharacteristicsCalculationCardDbSchema.FuelKindColumnName,
        FuelCharacteristicsCalculationCardDbSchema.ReservoirNumberColumnName,
        FuelCharacteristicsCalculationCardDbSchema.PerformedCalculationEmployeeIdColumnName,
        FuelCharacteristicsCalculationCardDbSchema.CalculationPerformingDateTimeColumnName,

        EmployeeDbSchema.SurnameColumnName,
        EmployeeDbSchema.NameColumnName,
        EmployeeDbSchema.PatronymicColumnName,

        FuelCharacteristicsCalculationCardDbSchema.TableName,
        EmployeeDbSchema.TableName,
        FuelCharacteristicsCalculationCardDbSchema.PerformedCalculationEmployeeIdColumnName,
        EmployeeDbSchema.IdColumnName
      ]
    );
    
end;

end.
