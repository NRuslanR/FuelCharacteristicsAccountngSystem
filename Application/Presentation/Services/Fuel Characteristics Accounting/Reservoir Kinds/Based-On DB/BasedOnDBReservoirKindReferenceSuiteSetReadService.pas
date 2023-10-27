unit BasedOnDBReservoirKindReferenceSuiteSetReadService;

interface

uses

  ReservoirKindReferenceSuiteSetReadService,
  ReservoirKindReferenceSuiteSetHolder,
  ReservoirKindReferenceSuiteDbSchema,
  ReservoirKindDbSchema,
  QueryExecutor,
  AbstractQueryExecutor,
  DataReader,
  AbstractDataReader,
  DB,
  SysUtils,
  Classes;

type

  TBasedOnDBReservoirKindReferenceSuiteSetReadService =
    class (TInterfacedObject, IReservoirKindReferenceSuiteSetReadService)

      protected

        FReservoirKindReferenceSuiteSetFetchingQueryPattern: String;
        
      protected

        FReservoirKindReferenceSuiteDbSchema: TReservoirKindReferenceSuiteDbSchema;
        FReservoirKindDbSchema: TReservoirKindDbSchema;
        FQueryExecutor: IQueryExecutor;

        function PrepareReservoirKindReferenceSuiteSetFetchingQueryPattern(
          ReservoirKindReferenceSuiteDbSchema: TReservoirKindReferenceSuiteDbSchema;
          ReservoirKindDbSchema: TReservoirKindDbSchema
        ): String; virtual;

        function ExecuteReservoirKindReferenceSuiteSetFetchingQuery(
          const ReservoirKindReferenceSuiteSetFetchingQueryPattern: String
        ): TDataSet; virtual;

        function CreateReservoirKindReferenceSuiteSetFieldDefsFrom(
          ReservoirKindReferenceSuiteSet: TDataSet;
          ReservoirKindReferenceSuiteDbSchema: TReservoirKindReferenceSuiteDbSchema;
          ReservoirKindDbSchema: TReservoirKindDbSchema
        ): TReservoirKindReferenceSuiteSetFieldDefs; virtual;

        procedure CustomizeReservoirKindReferenceSuiteSetHolder(
          ReferenceSuiteSetHolder: TReservoirKindReferenceSuiteSetHolder
        );
        
      public

        constructor Create(
          ReservoirKindReferenceSuiteDbSchema: TReservoirKindReferenceSuiteDbSchema;
          ReservoirKindDbSchema: TReservoirKindDbSchema;
          QueryExecutor: IQueryExecutor
        );

        function GetAllReservoirKindReferenceSuiteSet:
          TReservoirKindReferenceSuiteSetHolder; virtual;
          
    end;
      
implementation

{ TBasedOnDBReservoirKindReferenceSuiteSetReadService }

constructor TBasedOnDBReservoirKindReferenceSuiteSetReadService.Create(
  ReservoirKindReferenceSuiteDbSchema: TReservoirKindReferenceSuiteDbSchema;
  ReservoirKindDbSchema: TReservoirKindDbSchema;
  QueryExecutor: IQueryExecutor
);
begin

  inherited Create;

  FReservoirKindReferenceSuiteDbSchema := ReservoirKindReferenceSuiteDbSchema;
  FReservoirKindDbSchema := ReservoirKindDbSchema;
  FQueryExecutor := QueryExecutor;

  FReservoirKindReferenceSuiteSetFetchingQueryPattern :=
    PrepareReservoirKindReferenceSuiteSetFetchingQueryPattern(
      FReservoirKindReferenceSuiteDbSchema,
      FReservoirKindDbSchema
    );
    
end;

function TBasedOnDBReservoirKindReferenceSuiteSetReadService.
  CreateReservoirKindReferenceSuiteSetFieldDefsFrom(
    ReservoirKindReferenceSuiteSet: TDataSet;
    ReservoirKindReferenceSuiteDbSchema: TReservoirKindReferenceSuiteDbSchema;
    ReservoirKindDbSchema: TReservoirKindDbSchema
  ): TReservoirKindReferenceSuiteSetFieldDefs;
begin

  Result := TReservoirKindReferenceSuiteSetFieldDefs.Create;

  try

    Result.ReservoirKindNameFieldName :=
      ReservoirKindReferenceSuiteDbSchema.ReservoirKindNameColumnName;

    Result.AltitudinalConstantStencilFieldName :=
      ReservoirKindReferenceSuiteDbSchema.AltitudinalConstantStencilColumnName;

    Result.CalibrationChartLocationFieldName :=
      ReservoirKindReferenceSuiteDbSchema.CalibrationChartLocationColumnName;

    Result.CanBeChangedFieldName := 'can_be_changed';
    Result.CanBeRemovedFieldName := 'can_be_removed';
    
  except

    on e: Exception do begin

      FreeAndNil(Result);

      raise;
      
    end;

  end;

end;

procedure TBasedOnDBReservoirKindReferenceSuiteSetReadService.
  CustomizeReservoirKindReferenceSuiteSetHolder(
    ReferenceSuiteSetHolder: TReservoirKindReferenceSuiteSetHolder
  );
begin

  with ReferenceSuiteSetHolder.DataSet, ReferenceSuiteSetHolder.FieldDefs
  do begin

    FieldByName('can_be_changed').ReadOnly := False;
    FieldByName('can_be_removed').ReadOnly := False;
    
  end;

end;

function TBasedOnDBReservoirKindReferenceSuiteSetReadService.
  ExecuteReservoirKindReferenceSuiteSetFetchingQuery(
    const ReservoirKindReferenceSuiteSetFetchingQueryPattern: String
  ): TDataSet;
begin

  Result :=
    TAbstractDataReader(
      FQueryExecutor.ExecuteSelectionQuery(
        ReservoirKindReferenceSuiteSetFetchingQueryPattern
      ).Self
    ).ToDataSet;
    
end;

function TBasedOnDBReservoirKindReferenceSuiteSetReadService.
  GetAllReservoirKindReferenceSuiteSet: TReservoirKindReferenceSuiteSetHolder;
var DataSet: TDataSet;
    FieldDefs: TReservoirKindReferenceSuiteSetFieldDefs;
begin

  DataSet := nil;
  FieldDefs := nil;

  try

    DataSet :=
      ExecuteReservoirKindReferenceSuiteSetFetchingQuery(
        FReservoirKindReferenceSuiteSetFetchingQueryPattern
      );

    FieldDefs :=
      CreateReservoirKindReferenceSuiteSetFieldDefsFrom(
        DataSet,
        FReservoirKindReferenceSuiteDbSchema,
        FReservoirKindDbSchema
      );

    Result :=
      TReservoirKindReferenceSuiteSetHolder.CreateFrom(DataSet, FieldDefs);

    CustomizeReservoirKindReferenceSuiteSetHolder(Result);

  except

    on e: Exception do begin

      FreeAndNil(DataSet);
      FreeAndNil(FieldDefs);

      raise;
      
    end;

  end;

end;

function TBasedOnDBReservoirKindReferenceSuiteSetReadService.
  PrepareReservoirKindReferenceSuiteSetFetchingQueryPattern(
    ReservoirKindReferenceSuiteDbSchema: TReservoirKindReferenceSuiteDbSchema;
    ReservoirKindDbSchema: TReservoirKindDbSchema
  ): String;
begin

  Result :=
    Format(
      'SELECT ' +
      'A.%s,A.%s,A.%s,' +
      'null as can_be_changed,' +
      'null as can_be_removed ' +
      'FROM %s A ' +
      'JOIN %s B ON A.%s=B.%s',
      [
        ReservoirKindReferenceSuiteDbSchema.ReservoirKindNameColumnName,
        ReservoirKindReferenceSuiteDbSchema.AltitudinalConstantStencilColumnName,
        ReservoirKindReferenceSuiteDbSchema.CalibrationChartLocationColumnName,

        ReservoirKindReferenceSuiteDbSchema.TableName,
        ReservoirKindDbSchema.TableName,
        ReservoirKindReferenceSuiteDbSchema.ReservoirKindNameColumnName,
        ReservoirKindDbSchema.ReservoirKindNameColumnName
      ]
    );

end;

end.
